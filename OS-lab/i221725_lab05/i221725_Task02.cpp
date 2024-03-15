#include<stdio.h>
#include<unistd.h>
#include<iostream>
#include<sys/wait.h>
#include <ctime>
using namespace std;
int main(){
int maxtimenum=0;
int temp=0;
int times=0;
int timestemp=0;
int status=0;
srand(time(NULL));
int random = rand();

int n=0;

cout<<"Enter the number of child processes to create: ";
cin>>n;
int* array=new int [n];

pid_t pid1;
for(int i=0; i<n; i++){
    random = rand();
    int pipefd[2];

    if(pipe(pipefd)==-1)
        cout<<"error in pipe \n";


        pid1=fork();

        if(pid1==0){


        cout<< "this is child \n";
        int x=random%10;

        close(pipefd[0]);
        write(pipefd[1],&x,sizeof(x));

        close(pipefd[1]);

    }

    else if(pid1>0){


        cout<<"this is parent \n";

        int x=0;

        close(pipefd[1]);
        ssize_t size_byte = read(pipefd[0],&x,sizeof(x));
        
        if (size_byte <=0){
            cout<< "error in reading"<<endl;
            break;
        } 
        cout<<"recieved :"<<x<<"\n";
        array[i]=x;
        close(pipefd[0]);
        waitpid(pid1,&status,0);

    }

}
if(pid1>0){
    for(int i=0;i<n;i++){
        temp=array[i];
        for(int j=0;j<n;j++){
            if(temp==array[j]){
                timestemp++;
            }
        }
        if(timestemp>times){
            times=timestemp;
            maxtimenum=temp;
        }
    }
    if(pid1>0)
    cout<<endl<<maxtimenum<<" occures "<<times<<" times."<<endl;
}
return 0;
}