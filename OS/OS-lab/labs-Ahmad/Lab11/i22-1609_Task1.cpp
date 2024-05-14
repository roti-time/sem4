#include <pthread.h>
#include <unistd.h>
#include <stdio.h>
#include <iostream>
#include <queue>
#include <ctime>
#include <cstdlib>
using namespace std;

int pages1 = 1000;
queue<int> Documents;
pthread_mutex_t mutex1;

void *print(void *tid)
{

    while (!Documents.empty())
    {
        while(pages1 < Documents.front()){
        
        }

        pthread_mutex_lock(&mutex1);
            cout << "All Documents are Printed." << endl;
            pages1 -= Documents.front();
            Documents.pop();
            cout << "Printed the document " << tid << " with " << pages1 << " pages left." << endl;
            pthread_mutex_unlock(&mutex1);
            
    }
            pthread_exit(NULL);
}
void *pages(void *tid)
{
    while (!Documents.empty())
    {
        pages1 += 5;
        sleep(1);
    }
    pthread_exit(NULL);
}

int main()
{
    srand(time(0));
    for (int i = 0; i < 10; i++)
    {
        if ((rand() % 30) < 10)
        {
            Documents.push((rand() % 30) + 10);
        }
        else
        {
            Documents.push((rand() % 30));
        }
    }

    pthread_t printer1, printer2,pages2;
    pthread_mutex_init(&mutex1, NULL);
    pthread_create(&pages2, NULL, &pages, NULL);
    pthread_create(&printer1, NULL, &print, NULL);
    pthread_create(&printer2, NULL, &print, NULL);

    pthread_join(printer1, NULL);
    pthread_join(printer2, NULL);
    pthread_join(pages2, NULL);

    pthread_exit(NULL);
    return 0;
}