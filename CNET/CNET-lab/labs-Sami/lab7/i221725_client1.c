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