#include <pthread.h>
#include <stdio.h>

int globalint[30];
int search=2;

void *multiply(void *arg){
    int sum=1;
    int* x= (int*) arg;
        for (int i=0;i<30;i++){
            sum*=x[i];
        }

printf("\nProduct of array is: %d\n", sum);
//pthread_exit ( (void*) sum );
}

void *add(void *arg){
    int sum=0;
    int* x= (int*) arg;
        for (int i=0;i<30;i++){
            sum+=x[i];
        }

printf("\nSum of array is: %d\n", sum);
//pthread_exit ( (void*) sum );
}

void *threadfun(void *arg)
{
    //int *search = (int *) arg;
    printf("Finding number given to me (number is: %d)", search);
    for(int i=0;i<30;i++){
        if(globalint[i]==search){
            printf("\nSearched num is at index %d", search);
        }

    }
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
    int pthread_attr_setdetachstate(pthread_attr_t* attr,int detachstate);

    printf("this is main funtion\n");

    
    pthread_create (&thread1 ,&thread_attr, multiply,NULL);

    pthread_create (&thread2 ,&thread_attr, add,NULL);


    void *status;

    
    
    int num1;
    printf("Enter a number: ");
        scanf("%d", &num1);
        pthread_create (&thread3 ,&thread_attr, threadfun,NULL);
    return 0;
}