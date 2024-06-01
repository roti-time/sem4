# Mutex

### Mutex System Calls
1. `pthread_mutex_init ()`
2. `pthread_mutex_destroy ()`
3. `pthread_mutex_lock ()`
4. `pthread_mutex_trylock ()`
5. `pthread_mutex_unlock ()`

### Mutex Variables
A typical sequence in the use of a mutex is as follows:
1. Create and initialize a mutex variable
2. Several threads attempt to lock the mutex
3. Only one succeeds and that thread owns the mutex
4. The owner thread performs some set of actions
5. The owner unlocks the mutex
6. Another thread acquires the mutex and repeats the process
7. Finally the mutex is destroyed

### Using Mutex
1. Declare an object of type pthread_mutex_t.
2. Initialize the object by calling pthread_mutex_init().
3. Call pthread_mutex_lock() to gain exclusive access to the shared data object.
4. Call pthread_mutex_unlock() to release the exclusive access and allow another thread to use the shared data object.
5. Get rid of the object by calling pthread_mutex_destroy().

### Examples

```
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>

int papers = 10000;
pthread_mutex_t mutex;
pthread_t Labour, Printer1, Printer2;
int printer1[10], printer2[10];
int printer1_size = 0, printer2_size = 0;

void* withdraw1(void* tid)
{
    int docsize = 0;
    int i = 1;
    for (int j = 0; j < 11; j++)
    {
        pthread_mutex_lock(&mutex); // Lock the mutex before accessing shared resources
        if (printer1_size == 0)
        {
            printf("\nAll documents have been printed!\n\n");
            pthread_mutex_unlock(&mutex); // Unlock the mutex before exiting
            pthread_exit(NULL);
        }

        docsize = printer1[0];
        printf("%d\n", docsize);

        for (int k = 1; k < printer1_size; k++) {
            printer1[k - 1] = printer1[k];
        }
        printer1_size--;

        if (papers < docsize)
        {
            printf("Insufficient papers!\n");
            pthread_mutex_unlock(&mutex); // Unlock the mutex before exiting
            pthread_exit(NULL);
        }

        printf("\nPrinting doc %d in first printer\n\n", i);
        i++;
        papers -= docsize;
        pthread_mutex_unlock(&mutex); // Unlock the mutex after accessing shared resources
    }

    pthread_exit(NULL);
}

void* withdraw2(void* tid)
{
    int docsize = 0;
    int i = 1;

    for (int j = 0; j < 11; j++)
    {
        pthread_mutex_lock(&mutex); // Lock the mutex before accessing shared resources
        if (printer2_size == 0)
        {
            printf("\nAll documents have been printed!\n\n");
            pthread_mutex_unlock(&mutex); // Unlock the mutex before exiting
            pthread_exit(NULL);
        }

        docsize = printer2[0];
        printf("%d\n", docsize);

        for (int k = 1; k < printer2_size; k++) {
            printer2[k - 1] = printer2[k];
        }
        printer2_size--;

        if (papers < docsize)
        {
            printf("Insufficient papers!\n");
            pthread_mutex_unlock(&mutex); // Unlock the mutex before exiting
            pthread_exit(NULL);
        }

        printf("\nPrinting doc %d in second printer\n\n", i);
        i++;
        papers -= docsize;
        pthread_mutex_unlock(&mutex); // Unlock the mutex after accessing shared resources
    }

    pthread_exit(NULL);
}

void* labour(void* tid)
{
    for (int i = 0; i < 10; i++)
    {
        pthread_mutex_lock(&mutex); // Lock the mutex before accessing shared resources
        papers += 5;
        pthread_mutex_unlock(&mutex); // Unlock the mutex after accessing shared resources
    }

    pthread_exit(NULL);
}

int main()
{
    srand(time(0));

    for (int i = 0; i < 10; i++)
    {
        printer1[i] = 10;
        printer2[i] = 10;
    }
    printf("This is the main function\n");

    pthread_mutex_init(&mutex, NULL);
    pthread_create(&Labour, NULL, labour, NULL);
    pthread_create(&Printer1, NULL, withdraw1, NULL);
    pthread_create(&Printer2, NULL, withdraw2, NULL);

    pthread_join(Labour, NULL);
    pthread_join(Printer1, NULL);
    pthread_join(Printer2, NULL);

    pthread_mutex_destroy(&mutex); // Destroy the mutex after use
    return 0;
}
```

# Semaphores

#### SEMAPHORE SYSTEM CALLS
`#include <semaphore.h>`
`int sem_init ();`
`int sem_wait ();`
`int sem_trywait ();`
`int sem_post ();`
`int sem_destroy ();`

#### CREATE A SEMAPHORE
`int sem_init (sem_t* sem, int pshared, unsigned int value)`

1. sem
	Target semaphore

2. pshared
	The pshared argument indicates whether this semaphore is to be shared between the threads of a process, or between processes.
	- 0: only threads of the creating process can use the semaphore.
	- Non-0: other processes can use the semaphore.
3. value
	Initial value of the semaphore.


EXAMPLE:
```
#include <semaphore.h>
sem_t s;`
sem_init (&s, 0, 1);
```

We declare a semaphore s and initialize it to the value 1 by passing 1 in as the third
argument. The second argument to sem init() will be set to 0 in all of the examples we’ll
see; this indicates t hat the semaphore is shared between threads in the same process.
#### SEMAPHORE OPERATIONS
1. sem_wait() 

	decrements (locks) the semaphore pointed to by sem.
	
	`int sem_wait (sem_t* sem)`
	
	- If the semaphore’s value is greater than zero, then the decrement proceeds, and the function returns( gets lock), immediately.
	
	- If the value of the semaphore is negative, the calling thread blocks; one of the blocked threads wakes up when another thread calls sem_post()

2. sem_post()
	does not wait for some particular condition to hold like sem_wait() does.
	`int sem_post (sem_t* sem)`
	
	Rather, it simply increments the value of the semaphore and then, if there is a
	thread waiting to be woken, wakes one of them up.
```
int sem_wait (sem_t* s){

decrement the value of semaphores by one wait if value of semaphores is negative
}
int sem_post (sem_t* s){

increment the value of semaphores by one if there are one or more threads waiting, wake one
}
```

3. sem_trywait()
	sem_trywait() is the version of of the sem_wait() which does not block.
	
	`int sem_trywait (sem_t* sem)`
	
	Decreases the semaphore by one if the semaphore does not equal to zero. If it is
	zero it does not block, returns zero with error code EAGAIN.

4. sem_destroy 
	releases the resources that semaphore has and destroys it
	`int sem_destroy (sem_t* sem)`


#### Example Codes

```
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
```

