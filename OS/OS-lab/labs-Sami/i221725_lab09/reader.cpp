#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <iostream>
using namespace std;
int main()
{
    char str[256] = "hello world";
    // open "pipe_one" with READ only mode
    // and return its file descriptor
    int fifo_read = open("pipe_one", O_RDONLY);
    int fifo_write = open("pipe_two", O_WRONLY);
    // check if open call was successful
    if (fifo_read < 1)
    {
        cout << " Error opening file";
    }
    else
    {
        while (1)
        {
            read(fifo_read, str, sizeof(str));
            cout << "Text:" << str << endl;

            cout << " Enter text : " << endl;
            cin >> str;
            write(fifo_write, str, sizeof(str));

        }
        close(fifo_read);
    }
    return 0;
}