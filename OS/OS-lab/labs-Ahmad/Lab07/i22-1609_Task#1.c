#include <stdio.h>
#include <pthread.h>

void *threadfun()
{

    printf("Hello, I'm a thread and my ID is : %ld \n ", pthread_self());
}

int main()
{

    printf("this is main funtion\n");

    pthread_t thread1;
    int y;
    printf("Enter Number of Threads: ");
    scanf("%d", &y);
    for (int i = 0; i < y; i++)
    {
        pthread_create(&thread1, NULL, threadfun, NULL);
    }
    pthread_join(thread1, NULL);

    return 0;
}