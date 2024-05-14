#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>
#include <stdbool.h>

#define SERVER_IP "10.0.2.15" // Change this to the IP address of the server
#define PORT 9001

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
    char request[256];
    char buf[256];
    // Create the socket
    int sock;
    sock = socket(AF_INET, SOCK_STREAM, 0);

    // Setup the server address
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = inet_addr(SERVER_IP);
    server_address.sin_port = htons(PORT);

    // Connect to the server
    connect(sock, (struct sockaddr *)&server_address, sizeof(server_address));
    printf("Connected to the server\n");

while (1)
    {   
        printf("Enter a message: ");
        fgets(request, sizeof(request), stdin);
        request[strcspn(request, "\n")] = '\0';


        send(sock, request, strlen(request), 0);
        if(strcmp(request, "bye") == 0)
        {
            printf("Server disconnected\n");
            break;
        }
        memset(buf, 0, sizeof(buf)); // Clear the buffer before receiving new data
        recv(sock, buf, sizeof(buf), 0);



        printf("Received: %s", buf);
    }

   /* while (1)
    {   
        printf("Enter a message: ");
        fgets(request, sizeof(request), stdin);
        request[strcspn(request, "\n")] = '\0';

        // Encrypt the request using ROT13
        char encryptedRequest[256];
        strcpy(encryptedRequest, encryptROT13(request));

        send(sock, encryptedRequest, strlen(encryptedRequest), 0);
        if(strcmp(request, "bye") == 0)
        {
            printf("Server disconnected\n");
            break;
        }
        memset(buf, 0, sizeof(buf)); // Clear the buffer before receiving new data
        recv(sock, buf, sizeof(buf), 0);

        // Decrypt the received data using ROT13
        char decryptedData[256];
        strcpy(decryptedData, encryptROT13(buf));

        printf("Received: %s", decryptedData);
    }*/

    close(sock);
    return 0;
}