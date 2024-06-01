#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <iostream>
#include <unistd.h>
using namespace std;

int balance = 100;
pthread_mutex_t mutex;
pthread_t thread1, thread2, thread3, thread4;

void *withdraw(void *tid)
{
    for (int i = 0; i < 10; i++)
    {
        if(balance<10){
            cout<<"insufficient funds!"<<endl;
            pthread_mutex_lock(&mutex);
            pthread_exit(NULL);
        }
        
        cout << "\nAt time " << i << ", the balance for withdrawal thread " << pthread_self() << "is " << balance << endl;
        balance -= 10;
        cout << "\nAt time " << i << ", the balance after withdrawal thread " << pthread_self() << "is " << balance << endl;
        pthread_mutex_unlock(&mutex);
        
    }
}

void *deposit(void *tid)
{
    for (int i = 0; i < 10; i++)
    {
        cout << "\nAt time " << i << ", the balance before deposit thread " << pthread_self() << "is " << balance << endl;
        balance += 11;
        cout << "\nAt time " << i << ", the balance after deposit thread " << pthread_self() << "is " << balance << endl;
    }
}
int main()
{

    pthread_t thread1, thread2, thread3, thread4;
    int zero = 0;

    printf("this is main funtion\n");

    pthread_mutex_init (&mutex ,NULL) ;

    pthread_create(&thread1, NULL, withdraw, (void *)&zero);

    pthread_create(&thread2, NULL, withdraw, (void *)&zero);

    pthread_create(&thread3, NULL, deposit, (void *)&zero);

    pthread_create(&thread4, NULL, deposit, (void *)&zero);

   pthread_mutex_unlock(&mutex);
    return 0;
}