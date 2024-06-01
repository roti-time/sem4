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