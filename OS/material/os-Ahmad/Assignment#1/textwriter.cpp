#include <iostream>
#include <string>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
using namespace std;

int main() {
    char sentence[100];
     cout << "Enter a sentence: ";
     cin.getline(sentence, sizeof(sentence)); // Read a sentence from the user to pass in child process

    int pipefd[2]; // Creating Pipe
    if (pipe(pipefd) == -1) {  // Check if pipe is created successfully
         cerr << "Error in pipe" <<  endl;
        return 1;
    }

    pid_t pid = fork();
    if (pid == -1) {
         cerr << "Error in fork" <<  endl;
        return 1;
    } else if (pid == 0) { // Child process
        // Close read end of the pipe
        close(pipefd[0]);

        // Redirect standard output to the write end of the pipe
        dup2(pipefd[1], STDOUT_FILENO);

        // Close write end of the pipe
        close(pipefd[1]);

        // Execute the bash script
        execl("/bin/bash", "bash", "/media/gnome/Local Disk/Sem4/OS/Assignment#1/exec.sh", sentence, NULL);

        // Exit if execl fails
        perror("execl");
        exit(1);
    } else { // Parent process
        // Close write end of the pipe
        close(pipefd[1]);

        // Read from the read end of the pipe
        char buffer[100];
        ssize_t size_byte = read(pipefd[0], buffer, sizeof(buffer));
        if (size_byte <= 0) {
             cerr << "Error in reading" << endl;
            return 1;
        }

        // Print the output obtained from the bash script
        cout << "Suggestions of the incorrect words: " << buffer << endl;
        waitpid(pid, NULL, 0);

        return 0;
    }
}
