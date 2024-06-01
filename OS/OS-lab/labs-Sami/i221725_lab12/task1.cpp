#include <iostream>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
using namespace std;

int m = 3; 

sem_t bridgeSemaphore;

void* crossBridge(void* arg) {
    int carNumber = *(int *)arg;
    cout << "\nwaiting car: " << carNumber << endl;
    sem_wait(&bridgeSemaphore); 

    
    usleep(2000000); 

   
    cout << "\nCar that crossed bridge: " << carNumber << endl;

    sem_post(&bridgeSemaphore);

    pthread_exit(NULL);
}

int main() {
    sem_init(&bridgeSemaphore, 0, m);

    pthread_t cars[15]; 

    for (int i = 0; i < 15; i++) {
        int *p= (int *)malloc(sizeof(int));
        *p=i;
        pthread_create(&cars[i], NULL, crossBridge, p);
    }

   
    for (int i = 0; i < 15; i++) {
        pthread_join(cars[i], NULL);
    }

    sem_destroy(&bridgeSemaphore); 

    return 0;
}