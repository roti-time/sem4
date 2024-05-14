#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <iostream>
using namespace std;

int main() {
    char str[256] = "hello world";

    // Open the named pipe with read/write mode
    int fifo_read = open ( "pipe_one" , O_RDONLY) ;
    int fifo_write= open ( "pipe_two" , O_WRONLY) ;
    
    // Check if open call was successful
    if (fifo_read < 1) {
        cout << "Error opening file";
        return 1;
    }

    while (1) {
        sleep(1);
        read(fifo_read, str, sizeof(str));
        cout << str << endl;
        if (strcmp(str, "quit") == 0) {
            break;
        }
        cout << "Enter text: ";
        cin >> str;

        write(fifo_write, str, sizeof(str));

        
    }

    // Close the file descriptor
    close(fifo_write);
    close(fifo_read);   

    return 0;
}
