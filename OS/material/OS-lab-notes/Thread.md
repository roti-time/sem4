
```
#include <stdio.h>
#include<pthread.h>


void *threadfun(void *arg){

int x =  * (int *) arg;
printf("this is thread and value recieved my main is  %ld\n",x);

printf("thread id returned by self is : %ld \n ", pthread_self() );

int res=9;



}

int main(){

printf("this is main funtion\n");

pthread_t thread1,thread2;
int y=5;
pthread_create (&thread1,NULL,threadfun, (void *) &y );

int z=6;
pthread_create (&thread2,NULL,threadfun, (void *) &z );


pthread_join (thread1,NULL);
pthread_join (thread2,NULL);

printf("In main thread1 value is %ld \n",thread1);

printf("In main thread2 value is %ld \n",thread2);



return 0;



}
```

In the above scenario, we aren't actually saving the return value res, to do that, change the code like this :
```
#include <stdio.h>
#include<pthread.h>


void *threadfun(void *arg){

int x =  * (int *) arg;
printf("this is thread and value recieved my main is  %ld\n",x);

printf("thread id returned by self is : %ld \n ", pthread_self() );

int res=9;

pthread_exit((void* res));

}

int main(){

printf("this is main funtion\n");

pthread_t thread1,thread2;
int y=5;
pthread_create (&thread1,NULL,threadfun, (void *) &y );

int z=6;
pthread_create (&thread2,NULL,threadfun, (void *) &z );

void* status;
pthread_join (thread1,&status);        //the value will be updated, now you can                                           do whatever you want with it
pthread_join (thread2,&status);

printf("In main thread1 value is %ld \n",thread1);

printf("In main thread2 value is %ld \n",thread2);



return 0;



}
```

Changes in the code
1. added ==pthread_exit((void* res))== in the function called via threads
2. made ==void* status== in main 
3. changed ==pthread_join(thread1, NULL)== to ==pthread_join(thread1, &status)==
4. changed ==pthread_join(thread2, NULL)== to ==pthread_join(thread2, &status)==

### Creating Detachable threads and other stuff

1. Make an attribute object from class pthread_attr_t
2. initialize said attribute via pthread_attr_init()
3. pthread_attr_setdetachstate(address of attr, PTHREAD_CREATE_DETACHED)
4. use the attribute when creating pthread

```
#include <pthread.h>
#include <stdio.h>

int globalint[30];
int search=2;

void *multiply(void *arg){
    int sum=1;
        for (int i=0;i<30;i++){
            sum*=globalint[i];
        }

printf("\nProduct of array is: %d\n", sum);
pthread_exit (NULL);
}

void *add(void *arg){
    int sum=0;
        for (int i=0;i<30;i++){
            sum+=globalint[i];
        }

printf("\nSum of array is: %d\n", sum);
pthread_exit (NULL);
}

void *threadfun(void *arg)
{
    //int *search = (int *) arg;
    printf("Finding number given to me (number is: %d)", search);
    for(int i=0;i<30;i++){
        if(globalint[i]==search){
            printf("\nSearched num is at index %d", i);
            break;
        }

    }
pthread_exit (NULL);
}

int main()
{
    globalint[0] = 1;
    for (int i = 1; i < 30; i++)
    {
        globalint[i] = 2;
    }
    pthread_t thread1, thread2, thread3;
    pthread_attr_t thread_attr;
    pthread_attr_init(&thread_attr);
    pthread_attr_setdetachstate(&thread_attr,PTHREAD_CREATE_DETACHED);

    printf("this is main funtion\n");

    
    pthread_create (&thread1 ,&thread_attr, multiply,NULL);
    pthread_attr_t thread_attr1;
    pthread_attr_init(&thread_attr1);
    pthread_attr_setdetachstate(&thread_attr1,PTHREAD_CREATE_DETACHED);



    pthread_create (&thread2 ,&thread_attr1, add,NULL);
    pthread_attr_t thread_attr2;
    pthread_attr_init(&thread_attr2);
    pthread_attr_setdetachstate(&thread_attr2,PTHREAD_CREATE_DETACHED);




    pthread_create (&thread3 ,&thread_attr2, threadfun,NULL);
   

    return 0;
}
```

