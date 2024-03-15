#include<stdio.h>
#include<unistd.h>
#include<iostream>
#include<sys/wait.h>
using namespace std;
int main(){
int A=0;                               //this will hold the final value required
int a=1,b=7,c=2,d=5;
int pipefd[2];
int expression1=0;
int expression2=0;
int expression3=0;
int status=0;

if(pipe(pipefd)==-1)
cout<<"error in pipe \n";

pid_t pid1;
pid1=fork();
if(pid1==0){                                    //solving d*a
    //cout<< "this is child 1\n";
    expression1=d*a;
    close(pipefd[0]);
    write(pipefd[1],&expression1,sizeof(expression1));
    close(pipefd[1]);
}

else if(pid1>0){                                    
    //cout<<"this is parent 1\n";
    expression1=0;
    close(pipefd[1]);
    ssize_t size_byte = read(pipefd[0],&expression1,sizeof(expression1));
    if (size_byte <=0) 
    //cout<< "error in reading"<<endl;
    //cout<<"recieved1 :"<<expression1<<"\n";
    close(pipefd[0]);
    wait(NULL);
}

pid_t pid2=fork();                          //making child to calculate second expression

if(pid2==0){
    //cout<< "this is child 2\n";
    pid_t pid3;
    pid3=fork();

    if(pid3==0){                                    //solving this is the nested 3rd child required
        //cout<< "this is child 3\n";
        expression3=c-a;                            //third expression (grandchild here)
        close(pipefd[0]);
        write(pipefd[1],&expression3,sizeof(expression3));
        close(pipefd[1]);
    }

    else if(pid3>0){                                    
        //cout<<"this is parent 3 (aka child 2)\n";
        expression3=0;
        close(pipefd[1]);
        ssize_t size_byte = read(pipefd[0],&expression3,sizeof(expression3));
        if (size_byte <=0) 
        //cout<< "error in reading"<<endl;
        //cout<<"recieved3 :"<<expression3<<"\n";
        close(pipefd[0]);
        wait(NULL);
    }

waitpid(pid3, &status, 0);
    expression2=(a+b)+ expression3;            //change from d*a into the third expression into second expression thing
    close(pipefd[0]);
    write(pipefd[1],&expression2,sizeof(expression2));
    close(pipefd[1]);
}

else if(pid2>0){
    //cout<<"this is parent 2\n";
    expression2=0;
    close(pipefd[1]);
    ssize_t size_byte = read(pipefd[0],&expression2,sizeof(expression2));
    if (size_byte <=0) 
    //cout<< "error in reading"<<endl;
    //cout<<"recieved2 :"<<expression2<<"\n";
    close(pipefd[0]);
    wait(NULL);
}
waitpid(pid1, &status, 0);
//waitpid(pid2, &status, 0);
if(pid1==0 && pid2==0){
cout<<"\nThe value of A = "<<(expression1) * (expression2)<<endl;       //(d*a) * [(a+b)+(c-a)] = (5*1) * [(1+7) + (2-1)] = 5*9
}

return 0;
}