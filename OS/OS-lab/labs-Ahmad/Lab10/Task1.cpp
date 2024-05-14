#include <pthread.h>
#include <unistd.h>
#include <stdio.h>
#include <iostream>
using namespace std;

int balance = 10;
pthread_mutex_t mutex1;
int counter = 0;


void *withdraw(void *tid)
{
    
    for(int i = 0; i < 10; i++)
    {
      
        pthread_mutex_lock ( &mutex1 ) ;
    if(balance < 10)
    {
        cout<<"Insufficient balance"<<endl;
        //pthread_exit(NULL);
        pthread_mutex_unlock ( &mutex1 ) ;
    }
    else
    {
        //counter ++;
            balance -= 10;
            cout<<"At time"<<i<<", the balance for withdrawal thread " <<tid<<" is "<<balance<<endl;
            pthread_mutex_unlock ( &mutex1 ) ;
    }
    }
    pthread_exit(NULL);
}
void *deposit(void *tid)
{
    for (int i = 0; i < 10; i++)
    {   
        pthread_mutex_lock ( &mutex1 ) ;
        //counter ++;
        balance += 11;
        cout<<"At time"<<i<<", the balance for deposit thread " <<tid<<" is "<<balance<<endl;
        pthread_mutex_unlock ( &mutex1 ) ;
    }
    
    pthread_exit(NULL);
}

int main()
{

    pthread_t thread1, thread2,thread3,thread4;
    pthread_mutex_init(&mutex1, NULL);
    pthread_create(&thread1, NULL, &withdraw,NULL);
    pthread_create(&thread2, NULL, &deposit,NULL);
    pthread_create(&thread3, NULL, &withdraw, NULL);
    pthread_create(&thread4, NULL, &deposit, NULL);
    
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    pthread_join(thread3, NULL);
    pthread_join(thread4, NULL);
    
    pthread_exit(NULL);
    return 0;
}