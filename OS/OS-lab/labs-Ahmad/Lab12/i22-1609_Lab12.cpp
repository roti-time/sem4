#include <iostream>
#include <thread>
#include <unistd.h>
#include <semaphore.h>

using namespace std;

sem_t sem;
int car_count = 0;

void car(int id) {
    cout << "Car " << id << " is trying to cross the bridge.\n";
    sem_wait(&sem);
    if (car_count < 3) {
        car_count++;
        cout << "Now car " << id << " is crossing the bridge.\n";
        sleep(2);
        cout << "Car " << id << " has crossed the bridge.\n";
        car_count--;
    }
    sem_post(&sem);
}

int main() {
    sem_init(&sem, 0, 3);

    thread cars[15];

    for (int i = 1; i <= 15; i++) {
        cars[i-1] = thread(car, i);
    }

    for (int i = 0; i < 15; i++) {
        cars[i].join();
    }

    sem_destroy(&sem);

    return 0;
}