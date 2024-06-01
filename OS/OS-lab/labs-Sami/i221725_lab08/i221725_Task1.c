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