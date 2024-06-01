#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <sys/wait.h>
#include <sys/stat.h>
using namespace std;
int main()
{
    int f1, f2;
    // create a pipe with name " pipe_one " and set permissions to 0666
    f1 = mkfifo(" pipe_one ", 0666);
    // check if mkfifo call was successful
    if (f1 < 0)
        cout << " Pipe one not created " << endl;
    else
        cout << " Pipe one created " << endl;
    f2 = mkfifo("pipe_two", 0666);
    if (f2 < 0)
        cout << " Pipe two not created " << endl;
    else
        cout << " Pipe two created " << endl;
    return 0;
}