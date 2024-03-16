#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>

int main() {
    pid_t pid;
    char input[100];

    while (1) {
        printf("Enter a command (or 'Exit' to quit): ");
        fgets(input, sizeof(input), stdin);

        // Remove the trailing newline character, if present
        if (input[strlen(input) - 1] == '\n') {
            input[strlen(input) - 1] = '\0';
        }

        if (strcmp(input, "Exit") == 0) {
            break;
        }

        pid = fork();
        if (pid == -1) {
            perror("Fork error");
            exit(1);
        } else if (pid == 0) {
            // Child process
            char *args[3]; // Increase the array size to accommodate command and arguments
            char *token;
            int i = 0;

            token = strtok(input, " "); // Split the input into tokens
            while (token != NULL) {
                args[i] = token;
                token = strtok(NULL, " ");
                i++;
            }
            args[i] = NULL; // Terminate the array with a NULL pointer

            execvp(args[0], args);
            perror("Exec error");
            exit(1);
        } else {
            // Parent process
            wait(NULL);
        }
    }

    return 0;
}