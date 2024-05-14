#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <string.h>
#include <stdbool.h>

#define PORT 3001

char* encryptROT13(char* str) {
    int i = 0;
    while (str[i]) {
        if (isalpha(str[i])) {
            if ((str[i] >= 'a' && str[i] <= 'm') || (str[i] >= 'A' && str[i] <= 'M')) {
                str[i] += 13;
            } else {
                str[i] -= 13;
            }
        }
        i++;
    }
    return str;
}
int main()
{
    char buf[256];
    char request[256];

    // Create the server socket
    int server_socket;
    server_socket = socket(AF_INET, SOCK_STREAM, 0);

    // Define the server address
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(PORT);
    server_address.sin_addr.s_addr = INADDR_ANY;

    // Bind the socket to the specified IP and port
    bind(server_socket, (struct sockaddr *)&server_address, sizeof(server_address));

    // Listen for incoming connections
    listen(server_socket, 5);

    // Accept a client connection
    int client_socket;
    client_socket = accept(server_socket, NULL, NULL);
    printf("Client connected\n");
    printf("Waiting for client...\n");
    /*while (1){
    
        memset(buf, 0, sizeof(buf)); // Clear the buffer before receiving new data
        recv(client_socket, buf, sizeof(buf), 0);
        
        if(strcmp(buf, "bye") == 0)
        {
            printf("Client disconnected\n");
            break;
        }

        printf("Received: %s\n", buf);

        printf("Enter a message: ");
        fgets(request, sizeof(request), stdin);
        send(client_socket, request, strlen(request), 0);
    }*/
    while (1){
    
        memset(buf, 0, sizeof(buf)); // Clear the buffer before receiving new data
        recv(client_socket, buf, sizeof(buf), 0);
        // Encrypt the request using ROT13
        char encryptedRequest[256];
        strcpy(encryptedRequest, encryptROT13(buf));

        if(strcmp(encryptedRequest, "bye") == 0)
        {
            printf("Client disconnected\n");
            break;
        }

        printf("Received: %s\n", encryptedRequest);
        printf("Enter a message: ");
        fgets(request, sizeof(request), stdin);
        strcpy(encryptedRequest, encryptROT13(request));
        send(client_socket, encryptedRequest, strlen(encryptedRequest), 0);
    }

    // Close the sockets
    close(client_socket);
    close(server_socket);
    return 0;
}