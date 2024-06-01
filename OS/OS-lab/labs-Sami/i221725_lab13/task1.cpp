#include <iostream>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
using namespace std;

int m = 10; 

sem_t restaurant;

void* dinein(void* arg) {
    int person = *(int *)arg;
    cout << "\nPerson in queue to eat: " << person << endl;
    sem_wait(&restaurant); 

    
    usleep(2000000); 

   
    cout << "\nPerson that finished eating " << person << endl;

    sem_post(&restaurant);

    pthread_exit(NULL);
}

int main() {
    sem_init(&restaurant, 0, m);

    pthread_t people[20]; 

    for (int i = 0; i < 20; i++) {
        int *p= (int *)malloc(sizeof(int));
        *p=i+1;
        pthread_create(&people[i], NULL, dinein, p);
    }

   
    for (int i = 0; i < 20; i++) {
        pthread_join(people[i], NULL);
    }

    sem_destroy(&restaurant); 

    return 0;
}