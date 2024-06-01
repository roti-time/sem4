
# Proper way to pass value of i to thread

```
#include <stdio.h>
#include<pthread.h>
#include<stdlib.h>


void *threadfun(void *arg){

int x =  * (int *) arg;
printf("value %ld\n",x);

}

int main(){

printf("this is main funtion\n");

pthread_t threadid[10];

for (int i=0;i<10;i++)
{
int * p= malloc(sizeof(int));
*p=i;
pthread_create (&threadid[i],NULL,threadfun, p);
}

for (int i=0;i<10;i++)
{
pthread_join (threadid[i],NULL);
}

return 0;
}
```
