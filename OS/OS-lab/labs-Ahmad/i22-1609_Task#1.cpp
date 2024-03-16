#include <iostream>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
using namespace std;

//(d*a) * [ (a+b) + (c-a) ]

int main()
{
    int pipefd[2];
    if (pipe(pipefd) == -1)
    {
        cout << "Error in pipe";
        return 1;
    }
    int a = 1;
    int b = 6;
    int c = 0;
    int d = 9;

    int res[3];

    // int result=0;
    pid_t pid = fork();
    if (pid == 0)
    {
        int x = d * a;
        close(pipefd[0]);
        write(pipefd[1], &x, sizeof(x));
    }
    else
    {
        pid_t pid1 = fork();
        if (pid1 == 0)
        {
            pid_t pid3 = fork();
            if (pid3 == 0)
            {
                int x = a + b;
                close(pipefd[0]);
                write(pipefd[1], &x, sizeof(x));
            }
            else
            {
                pid_t pid4 = fork();
                if (pid4 == 0)
                {
                    int x = c-a;
                    close(pipefd[0]);
                    write(pipefd[1], &x, sizeof(x));
                }
                else
                {   
                    close(pipefd[1]);
                    waitpid(pid4, nullptr, 0);
                    waitpid(pid3, nullptr, 0);
                   
                    waitpid(pid, nullptr, 0);

                    
                    
                ssize_t size_byte = read(pipefd[0], &res[0], sizeof(res[0]));
                if (size_byte <= 0)
                {
                    cout << "error in reading" << endl;
                    return 1;
                }
                cout << "res[0]: " << res[0] << endl;

                size_byte = read(pipefd[0], &res[1], sizeof(res[1]));
                if (size_byte <= 0)
                {
                    cout << "error in reading" << endl;
                    return 1;
                }
                cout << "res[1]: " << res[1] << endl;

                size_byte = read(pipefd[0], &res[2], sizeof(res[2]));
                if (size_byte <= 0)
                {
                    cout << "error in reading" << endl;
                    return 1;
                }
                cout << "res[2]: " << res[2] << endl;

                // Calculate the final result
                cout << "result: " << res[2] * (res[0] + res[1]) << endl;

                // Close the read end of the pipe
                close(pipefd[0]);

                    



                    
                    
                }
            }
        }
        
    }
    cout << "result: " << res[0] * (res[2] + res[1]) << endl;
    return 0;

}

/*waitpid(pid,&status,0);

int res=WEXITSTATUS(status);*/