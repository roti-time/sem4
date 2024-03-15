#include <stdio.h>
#include <unistd.h>
#include <iostream>
#include <sys/wait.h>
#include <ctime>
using namespace std;
int main()
{

    int can1 = 0;
    int can2 = 0;
    int can3 = 0;
    int total = 0;
    int status=0;

    pid_t pid1;
    srand(time(NULL));

    int random = rand();
    int n = 0;
    int choice;

    cout << "Enter the number of voters: ";
    cin >> n;

    int pipefd[2];
    if (pipe(pipefd) == -1)
        cout << "error in pipe \n";

    for (int i = 0; i < n; i++)
    {
            //srand(time(0)+getpid());
        if (pipe(pipefd) == -1)
        cout << "error in pipe \n";
        
        pid1 = fork();
        random = rand();
        
        if (pid1 == 0)
        {
            //total+=1;
            choice = random % 3;
            close(pipefd[0]);
            write(pipefd[1], &choice, sizeof(choice));
            close(pipefd[1]);
            exit(0);
        }

        else if (pid1 > 0)
        {
            waitpid(pid1,&status, 0);   
            close(pipefd[1]);
            choice = 0;
            ssize_t size_byte = read(pipefd[0], &choice, sizeof(choice));
            if (size_byte <= 0)
            {
                cout << "error in reading" << endl;
                break;
            }

            
            close(pipefd[0]);
            

            //cout << "this is parent \n";

            

            

            switch (choice)
            {
            case 1:
                can1 += 1;
                total += 1;
                break;
            case 2:
                can2 += 1;
                total += 1;
                break;
            case 3:
                can3 += 1;
                total += 1;
                break;
            }
            
        }
    }

    cout<<"Total votes: "<<total<<endl<<endl;

            cout<<"Votes achieved by A: "<<can1<<endl;
            cout<<"Votes achieved by B: "<<can2<<endl;
            cout<<"Votes achieved by C: "<<can3<<endl;


            if((can1>can2)&&(can1>can3))
                cout<<"A won\n";
            else if((can2>can3)&&(can2>can1))
                cout<<"B won\n";
            else if((can3>can1)&&(can3>can2))
                cout<<"C won\n";
            else    
                cout<<"There is a tie"<<endl;
}