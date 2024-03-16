#include <iostream>
#include <unistd.h>
#include <sys/wait.h>
using namespace std;

int main() {
    int count = 0;

    for (int i = 0; i < 64; i++) {
        pid_t pid = fork();

        if (pid == 0) {
            // Child process
            cout << "Hello" << endl;
            exit(0);
        }
    }

    // Parent process
    for (int i = 0; i < 64; i++) {
        wait(NULL); // Wait for child processes to finish
        count++;
    }

    cout << "All processes completed. Printed " << count << " times." << endl;
    return 0;
}