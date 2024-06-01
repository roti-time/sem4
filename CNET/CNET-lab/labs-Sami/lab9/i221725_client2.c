#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>

#define SERVER_IP "192.168.18.147" // Change this to the IP address of the server

int main()
{
    int sock;
    struct sockaddr_in server_address;
    socklen_t server_address_len = sizeof(server_address);
    char message[200];

    // Create the socket
    sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock == -1)
    {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    // Configure server address
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = inet_addr(SERVER_IP);
    server_address.sin_port = htons(3001);

    while (1)
    {
        printf("Enter a message: ");
        fgets(message, sizeof(message), stdin);

        sendto(sock, message, strlen(message), 0, (struct sockaddr *)&server_address, server_address_len);

        if (strcmp(message, "exit\n") == 0)
        {
            printf("Exiting...\n");
            break;
        }

        memset(message, 0, sizeof(message));
        recvfrom(sock, message, sizeof(message), 0, NULL, NULL);

        printf("Received message: %s", &message);
        printf("Received message size: %ld\n", strlen(message));
        if (strcmp(message, "exit\n") == 0)
        {
            printf("Exiting...\n");
            break;
        }
    }

    close(sock);

    return 0;
}