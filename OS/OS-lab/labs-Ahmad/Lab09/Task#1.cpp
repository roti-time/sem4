#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <iostream>
using namespace std;

int main() {
    char str[256] = "hello world";
    int fifo_write;

    // Open the named pipe with write-only mode
    fifo_write = open("pipe_one", O_WRONLY);
    int fifo_read = open("pipe_two", O_RDONLY);
    
    // Check if open call was successful
    if (fifo_write < 0) {
        cout << "Error opening file";
        return 1;
    }

    while (1) {
        // Prompt the user for input
        cout << "Enter text: ";
        cin >> str;

        // Write the input text to the named pipe
        write(fifo_write, str, sizeof(str));

        // Check if the input text is "quit"
        if (strcmp(str, "quit") == 0) {
            break;
        }
        read (fifo_read, str, sizeof(str));
        cout << str << endl;
    }

    // Close the file descriptor
    close(fifo_write);
    close(fifo_read);

    return 0;
}
