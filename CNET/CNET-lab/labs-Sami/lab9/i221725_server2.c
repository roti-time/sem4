#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>

void handle_client(int server_socket);

int main()
{
    int server_socket;
    struct sockaddr_in server_address, client_address;
    socklen_t client_address_len = sizeof(client_address);
    pid_t pid;
    char message[200];

    // Create the server socket
    server_socket = socket(AF_INET, SOCK_DGRAM, 0);
    if (server_socket == -1)
    {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    // Configure server address
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = inet_addr("192.168.18.147");
    server_address.sin_port = htons(3001);

    // Bind the socket to the specified IP and port
    if (bind(server_socket, (struct sockaddr *)&server_address, sizeof(server_address)) == -1)
    {
        perror("Bind failed");
        exit(EXIT_FAILURE);
    }

    printf("Server started. Listening on port 3001 ...\n");

    handle_client(server_socket);

    // Close the server socket
    close(server_socket);

    return 0;
}

void handle_client(int server_socket)
{
    struct sockaddr_in client_address;
    socklen_t client_address_len = sizeof(client_address);
    char message[200];
    while (1)
    {
        memset(message, 0, sizeof(message));
        recvfrom(server_socket, message, sizeof(message), 0, (struct sockaddr *)&client_address, &client_address_len);

        printf("Received message: %s", &message);
        printf("Received message size: %ld\n", strlen(message));
        if (strcmp(message, "exit\n") == 0)
        {
            printf("Exiting...\n");
            break;
        }

        printf("Enter a message: ");
        fgets(message, sizeof(message), stdin);
        sendto(server_socket, message, strlen(message), 0, (struct sockaddr *)&client_address, client_address_len);
        if (strcmp(message, "exit\n") == 0)
        {
            printf("Exiting...\n");
            break;
        }
    }
}