#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <string.h>


void reverse(int client_socket, char *buf, char *reversed)
{
    int len = strlen(buf);
    for (int i = 0; i < len; i++)
    {
        reversed[i] = buf[len - i - 1];
    }
    reversed[len] = '\0';
    send(client_socket, reversed, sizeof(reversed), 0);
}

int main()
{
    char buf[100];
    char reversed[100];
    // create the server socket
    int server_socket;
    server_socket = socket(AF_INET, SOCK_STREAM, 0);
    // define the server address

    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(3001);
    server_address.sin_addr.s_addr = INADDR_ANY;
    // bind the socket to our specified IP and port

    bind(server_socket, (struct sockaddr *)&server_address, sizeof(server_address));
    listen(server_socket, 5);
    int client_socket;
    client_socket = accept(server_socket, NULL, NULL);
    // Connection successful message

    printf("Connection successful!\n");

    for (int i = 0; i < 5; i++)
    {
        recv(client_socket, &buf, sizeof(buf), 0);
        reverse(client_socket,buf, reversed);
    }
    // close the socket
    close(server_socket);
    return 0;
}