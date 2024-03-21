#include <pthread.h>
#include <iostream>
using namespace std;



void *threadfun(void *){
printf("Hello I am thread and my ID is %ld \n", pthread_self() );
return 0;
}

int main(){

printf("this is main funtion\n");
int n;
cout<<"Enter number of threads to create: ";
cin>>n;

pthread_t *thread1 = new pthread_t [n];
int y=5;
for(int i=0;i<n;i++){
pthread_create (&thread1[i],NULL,threadfun,NULL);
}
for(int i=0;i<n;i++){
pthread_join (thread1[i],NULL);
}
//printf("In main thread1 value is %ld \n",pthread_self());



return 0;



}