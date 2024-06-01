## Code for calculator
### Server Side
```
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>

int main() {
    char buf[200];

    // create the server socket
    int server_socket;
    server_socket = socket(AF_INET, SOCK_STREAM, 0);

    // define the server address
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(3001);
    server_address.sin_addr.s_addr = INADDR_ANY;

    // bind the socket to our specified IP and port
    bind(server_socket, (struct sockaddr*)&server_address, sizeof(server_address));
    listen(server_socket, 5);
    int client_socket;
    client_socket = accept(server_socket, NULL, NULL);

    // Connection successful message
    printf("Connection successful!\n");

    // Send a message to enter the first operand
    char request[] = "Enter first operand: ";
    send(client_socket, request, sizeof(request), 0);

    // Receive the number from the client
    recv(client_socket, buf, sizeof(buf), 0);
    int operand1 = atoi(buf);
    printf("This is the operand1: %d\n", operand1);

    // Send a message to enter the second operand
    char request1[] = "Enter second operand: ";
    send(client_socket, request1, sizeof(request1), 0);

    // Receive the number from the client
    recv(client_socket, buf, sizeof(buf), 0);
    int operand2 = atoi(buf);
    printf("This is the operand2: %d\n", operand2);

    // Send a message to choose an operation
    char request2[] = "Choose a number from 1 to 4 to select an operation:\n1-ADD\n2-SUB\n3-MUL\n4-DIV\n";
    send(client_socket, request2, sizeof(request2), 0);

    // Receive the number from the client
    recv(client_socket, buf, sizeof(buf), 0);
    int choice = atoi(buf);
    printf("This is the choice: %d\n", choice);
    int result;

    switch (choice) {
        case 1:
            printf("ADD function was chosen!!\n\n");
            result = operand1 + operand2;
            printf("This is the result: %d\n", result);
            break;
        case 2:
            printf("SUB function was chosen!!\n\n");
            result = operand1 - operand2;
            printf("This is the result: %d\n", result);
            break;
        case 3:
            printf("MUL function was chosen!!\n\n");
            result = operand1 * operand2;
            printf("This is the result: %d\n", result);
            break;
        case 4:
            printf("DIV function was chosen!!\n\n");
            result = operand1 / operand2;
            printf("This is the result: %d\n", result);
            break;
    }

    // close the socket
    close(server_socket);
    return 0;
}
```

### Client Side

```
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <string.h>

int main()
{
    char request[256];
    char buf[200];

    // create the socket
    int sock;
    sock = socket(AF_INET, SOCK_STREAM, 0);

    // setup an address
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = INADDR_ANY;
    server_address.sin_port = htons(3001);

    // Check for successful connection
    if (connect(sock, (struct sockaddr *)&server_address, sizeof(server_address)) == -1){
        perror("Connection unsuccessful");
        close(sock);
        exit(EXIT_FAILURE);
    }

    // Connection successful message
    printf("Connection successful!\n");

    // Receive the message to enter operand1
    recv(sock, buf, sizeof(buf), 0);
    printf("%s", buf);

    // Send a number to the server
    fgets(request, sizeof(request), stdin);
    send(sock, request, strlen(request), 0);

    // Receive the message to enter operand2
    recv(sock, buf, sizeof(buf), 0);
    printf("%s", buf);

    // Send a number to the server
    fgets(request, sizeof(request), stdin);
    send(sock, request, strlen(request), 0);

    // Receive the message to enter operation
    recv(sock, buf, sizeof(buf), 0);
    printf("%s", buf);

    // Send a number to the server
    fgets(request, sizeof(request), stdin);
    send(sock, request, strlen(request), 0);

    // close the socket
    close(sock);
    return 0;
}
```