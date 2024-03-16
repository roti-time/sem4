#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <iostream>

int main()
{
     pid_t pid;
     char *arr[]={}; // Array of strings
    
    pid = fork();
    if (pid < 0)
    {
        perror("fork");
        exit(1);
    }
    else if (pid == 0)
    {
        printf("Child process\n");
        char *args[] = {"./a.out", NULL};
        execv("/home/gnome/a.out", args); // execv()
    }
    else if(arr=="ls")
    {
        printf("Parent process\n");
        execlp("ls", "ls", "-l", "/home/gnome", NULL); // execlp()
    }
    else if(arr=="cat")
    {
        printf("Parent process\n");
        execlp("cat", "cat", "/home/gnome/text.txt", NULL); // execlp()
    }
    else
    {
        printf("Parent process\n");
        char* args[] = {"cat", "/home/gnome/text.txt", NULL};
        execvp("cat", args);

        // If execlp returns, it means an error occurred
        perror("execlp");
    }
}