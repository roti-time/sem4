/*Write a program where root parent will be ‘A’.Parent will create first child
    which
    returns(d *a)
        .Then parent will create second child.This child will
    calculate(a + b)
        .Moreover,
    this child will create grandchild which will return

    (c - a)
        .After receiving value from grandchild,
    this child will return [(a + b) + (c -a)] ((8)+(-3))to the parent A.Parent A will display the end result of the equation.*/
#include <iostream>
#include <unistd.h>
#include <sys/wait.h>
    using namespace std;
int main()
{
    int d = 5;
    int a = 1;
    int c = 2;
    int b = 7;
    int res=0;
    int res1=0;
    int res2=0;

    pid_t pid = fork();
    if (pid == 0)
    {
        // return d*a
        
        exit(d * a);
    }
    else
    {

        int status = 0;
        waitpid(pid, &status, 0);

        res = WEXITSTATUS(status);                                                  //res stores d*a
        cout << "this is parent and recieved : " << res << endl;
    }

    pid=fork();
    if(pid==0){
        /*pid=fork();
        if(pid==0){
            exit(c-a);
        }
        else{
            int status = 0;
            waitpid(pid, &status ,0);
            res1=(a+b)+WEXITSTATUS(status);
            cout<<endl<<"res1= "<<res1<<endl;

        }*/
        exit(a+b);
    }
    else{
        int status = 0;
        waitpid(pid,&status,0);
        res2=res*((WEXITSTATUS(status))+(c-a));
        cout<<endl<<"res1 is "<<res1<<endl;
        cout<<endl<<"res2 is "<<res2<<endl;
        cout<<endl<<"a+b is "<<a+b<<endl;
        cout<<endl<<"d*a is "<<d*a<<endl;
        cout<<endl<<" c-a is "<<c-a<<endl;
        cout<<endl<<"new res= "<<res2<<endl;
    }
cout<<res;
    return 0;
}