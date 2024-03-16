#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <string.h>

void unoreverse(char* str) {
    int length = strlen(str);
    int i, j;
    char temp;

    for (i = 0, j = length - 1; i < j; i++, j--) {
        temp = str[i];
        str[i] = str[j];
        str[j] = temp;
    }
}

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

    char connect[] = "Hi, you have connected to the server!\n";
    send(client_socket, connect, sizeof(connect), 0);

    for (int i = 0; i < 5; i++) {
        memset(buf, 0, sizeof(buf));  // Clear the string

        // receiving the string
        recv(client_socket, buf, sizeof(buf), 0);
        printf("Received string to be reversed: %s\n", buf);

        unoreverse(buf);
        //printf("Reversed string about to be sent to the client: %s\n\n", buf);

        // sending the reversed string back to the client
        send(client_socket, buf, strlen(buf) + 1, 0);
    }

    // close the socket
    close(server_socket);
    return 0;
}