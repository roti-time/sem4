#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    pid_t pid;
    char command[100]; 

    
    printf("Enter command (ls or cat): ");
    scanf("%s", command);

    pid = fork();
    if (pid < 0)
    {
        perror("fork");
        exit(1);
    }
    else if (pid == 0)
    {
        printf("Child process\n");
        if (strcmp(command, "ls") == 0)
        {
            execlp("ls", "ls", "-l", "/home/gnome", NULL);
        }
        else if (strcmp(command, "cat") == 0)
        {
            char* args[] = {"cat", "/home/gnome/text.txt", NULL};
            execvp("cat", args);
        }
        else
        {
            printf("Invalid command\n");
            exit(1);
        }
    }
    else
    {
        
        printf("Parent process\n");
        char *args[] = {"./a.out", NULL};
        execv("/home/gnome/a.out", args); // execv()
        wait(NULL); 
    }

    return 0;
}
