Linux processes expect three file descriptors to be open when they start.
These are known as
1. standard input(0)
2. standard output(1)
3. standard error(2)

```
#include<stdio.h>
#include<unistd.h>
#include<iostream>
#include<sys/wait.h>
using namespace std;

int main(){

int pipefd[2];

if(pipe(pipefd)==-1)
cout<<"error in pipe \n";

pid_t pid1;

pid1=fork();

if(pid1==0){


cout<< "this is child \n";
int x=5;

close(pipefd[0]);
write(pipefd[1],&x,sizeof(x));

close(pipefd[1]);

}

else if(pid1>0){


cout<<"this is parent \n";

int x=0;

close(pipefd[1]);
ssize_t size_byte = read(pipefd[0],&x,sizeof(x));
if (size_byte <=0) cout<< "error in reading"<<endl;
cout<<"recieved :"<<x<<"\n";
close(pipefd[0]);
wait(NULL);

}



return 0;
}
```

## Pipe between two different executable processes
### 1. Create FIFO
```
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
```

### 2. Write Codes for Both program 1 and 2
```
Reader.cpp
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
```

```
Writer.cpp
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
```




## Important Info

##### **OPEN() SYSTEM CALL**

An "open" system call or library function should be used to physically open up a channel to the pipe.

`int open(const char *pathname, int flags);`

Given a pathname for a file, open() returns a file descriptor.
The **argument flags** must include one of the following **access modes**: 
1. **O_RDONLY (read- only)**
2. **O_WRONLY (write-only)**
3. **O_RDWR (read/write)**

##### **CLOSE() SYSTEM CALL**

close() closes a file descriptor, so that it no longer refers to any file and may be reused.

`int close (int fd)`

close() returns zero on success. On error, -1 is returned. Not checking the return value
of close() is a common but nevertheless serious programming error.
