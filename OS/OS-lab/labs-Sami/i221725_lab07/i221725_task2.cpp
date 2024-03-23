#include <stdio.h>
#include<pthread.h>
using namespace std;
int globalint[30];

void *multiply(void *arg){
    int sum=1;
    int* x= (int*) arg;
        for (int i=0;i<30;i++){
            sum*=x[i];
        }


pthread_exit ( (void*) sum );
}

void *add(void *arg){
    int sum=0;
    int* x= (int*) arg;
        for (int i=0;i<30;i++){
            sum+=x[i];
        }


pthread_exit ( (void*) sum );
}

int main(){
    globalint[0]=1;
    for(int i=1;i<30;i++){
        globalint[i]=2;
    }

printf("this is main funtion\n");

pthread_t thread1,thread2;
pthread_create (&thread1,NULL,multiply, (void *) &globalint);

pthread_create (&thread2,NULL,add, (void *) &globalint);

void* status;
pthread_join (thread1,&status);
printf("Product of array is: %d\n",status);
pthread_join (thread2,&status);
printf("Sum of array is: %d\n",status);
return 0;
}