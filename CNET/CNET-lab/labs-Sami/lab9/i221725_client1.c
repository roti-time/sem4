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
    int num1, sock;
    struct sockaddr_in server_address;
    socklen_t server_address_len = sizeof(server_address);

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
        printf("Enter a number: ");
        scanf("%d", &num1);

        // Send the number to the server
        sendto(sock, &num1, sizeof(num1), 0, (struct sockaddr *)&server_address, server_address_len);
    }
    // Close the socket
    close(sock);

    return 0;
}