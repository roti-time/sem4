#include <iostream>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include <cstdlib>
#include <ctime>
#include <random>
using namespace std;

int main()
{
    int votes[3] = {0, 0, 0};
    int pipfd[2];
    if (pipe(pipfd) == -1)
    {
        cout << "Error in pipe";
        return 1;
    }
    cout << "Enter Number of voters: ";
    int n;
    cin >> n;

    for (int i = 0; i < n; i++)
    {
        pid_t pid = fork();
        srand(time(0)+ getpid());
        if (pid == 0)
        {
            
            int x;
            x = rand()%3;
            close(pipfd[0]);
            write(pipfd[1], &x, sizeof(x));
            close(pipfd[1]);
            exit(0);
        }
        else if (pid < 0)
        {
            cout << "Error in fork";
            return 1;
        }
    }

    close(pipfd[1]);

    for (int i = 0; i < n; i++)
    {
        int y;
        ssize_t size_byte = read(pipfd[0], &y, sizeof(y));
        if (size_byte <= 0)
        {
            cout << "Error in reading" << endl;
            return 1;
        }
        votes[y]++;
    }

    close(pipfd[0]);

    cout << "Votes for candidate A: " << votes[0] << endl;
    cout << "Votes for candidate B: " << votes[1] << endl;
    cout<< "Votes for candidate C: " << votes[2] <<endl;


    if(votes[0]>votes[1] && votes[0]>votes[2])
    {
        cout << "Candidate A wins" << endl;
    }
    else if(votes[1]>votes[0] && votes[1]>votes[2])
    {
        cout << "Candidate B wins" << endl;
    }
    else if(votes[2]>votes[0] && votes[2]>votes[1])
    {
        cout << "Candidate C wins" << endl;
    }
    else
    {
        cout << "It's a tie" << endl;
    }

    return 0;
}