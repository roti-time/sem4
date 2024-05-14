#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

void sum(int *a)
{
    int result = 0;
    for (int i = 0; i < 20; i++)
    {
        result += a[i];
    }
    printf("Sum of array is %d\n", result);
}

void mul(int *a)
{
    int result = 1;
    for (int i = 0; i < 20; i++)
    {
        result *= a[i];
    }
    printf("Multiplication of array is %ld\n", result);
}
void search(int *a)
{
    int search;
    printf("Enter the element to search: ");
    scanf("%d", &search);
    for (int i = 0; i < 20; i++)
    {
        if (a[i] == search)
        {
            printf("Element found at index %d\n", i);
            return i;
        }
    }
    printf("Element not found\n");
    return 0;
}


int main() {
    int array[20]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20};
    //int n = 20;
    pthread_t thread;
    pthread_attr_t thread_attr;
    pthread_attr_init(&thread_attr);
    pthread_attr_setdetachstate(&thread_attr, PTHREAD_CREATE_DETACHED);

    pthread_create(&thread, &thread_attr,sum, (void *)array);

    pthread_t thread1;
    pthread_attr_t thread_attr1;
    pthread_attr_init(&thread_attr1);
    pthread_attr_setdetachstate(&thread_attr1, PTHREAD_CREATE_DETACHED);

    pthread_create(&thread1, &thread_attr1,mul, (void *)array);
    

    
    pthread_t thread2;
    pthread_attr_t thread_attr2;
    pthread_attr_init(&thread_attr2);
    pthread_attr_setdetachstate(&thread_attr2, PTHREAD_CREATE_DETACHED);

    pthread_create(&thread2, &thread_attr2,search, (void *)array);

    pthread_exit(NULL);
}
