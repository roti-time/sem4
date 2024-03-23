#include <stdio.h>
#include <pthread.h>
#include <time.h>


long arr[30];
void initialize()
{
    for(long i=0;i<30;i++)
    {
        arr[i]=i;
    }
}

void *add()
{
    long sum=0;
    for(int i=0;i<30;i++)
    {
        
        sum+=arr[i];
    }
    printf("Sum of the array is: %ld \n",sum);
    
}
void *multiply()
{
    long product=1;
    for(int i=0;i<30;i++)
    {
        
        product*=(arr[i]+1);
    }
    printf("Product of the array is: %ld",product);
    
}

int main()
{


    initialize();
    pthread_t thread1,thread2;

        pthread_create(&thread1, NULL,add, NULL);
        pthread_create(&thread2,NULL ,multiply,NULL);
        pthread_join(thread1, NULL);
        pthread_join(thread2, NULL);


    return 0;
}