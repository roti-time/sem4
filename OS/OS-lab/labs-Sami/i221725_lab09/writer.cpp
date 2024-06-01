#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <iostream>
using namespace std;
int main()
{
    char str[256] = " hello world ";
    int fifo_write;
    int fifo_read;
    // open "pipe_one" with WRITE only mode
    // and return its file descriptor
    fifo_write = open("pipe_one", O_WRONLY);
    fifo_read = open("pipe_two", O_RDONLY);
    // check if open call was successful
    if (fifo_write < 1)
    {
        cout << " Error opening file";
    }
    else
    {
        while (1)
        {
            cout << " Enter text : " << endl;
            cin >> str;
            write(fifo_write, str, sizeof(str));

            read(fifo_read, str, sizeof(str));
            cout << "Text:" << str << endl;
        }
        close(fifo_write);
    }
    return 0;
}