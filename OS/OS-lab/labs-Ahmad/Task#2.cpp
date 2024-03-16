#include <iostream>
#include <sys/wait.h>
#include<unistd.h>
#include <string.h>
using namespace std;

//(d*a) * [ (a+b) + (c-a) ]

int main()
{
    int a=1;
    int b=6;
    int c=0;
    int d=9;

    int res;
    int res1;
    int res2;
    //int result=0;
    pid_t pid=fork();
    if(pid==0)
    {
        exit(d*a);
    }
    else
    {
        int status=0;
        waitpid(pid,&status,0);

         res=WEXITSTATUS(status);
         cout<<res<<endl;
        pid_t pid1=fork();
        if(pid1==0)
        {
            pid_t pid3 =fork();
            if(pid3==0)
            {
                exit(a+b);
            }
            else
            {
                int status1=0;
                waitpid(pid3,&status1,0);
                res1=WEXITSTATUS(status1);
                cout<<res1<<endl;
                pid_t pid4=fork();
                if(pid4==0)
                {
                    exit(c-a);
                }
                else
                {
                    int status2=0;
                    waitpid(pid4,&status2,0);
                    res2=WEXITSTATUS(status2);
                    //cout<<res2<<endl;
                    
                }
                
            }
            
        }
        
    }

    
    res1=res1+res2;
    res=res*res1;
    cout<<"Result: "<<res;
    
}

/*waitpid(pid,&status,0);

int res=WEXITSTATUS(status);*/