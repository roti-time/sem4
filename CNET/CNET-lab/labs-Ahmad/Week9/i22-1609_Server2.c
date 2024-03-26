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
    // Create the server socket
    server_socket = socket(AF_INET, SOCK_DGRAM, 0);
    if (server_socket == -1)
    {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }
    // Configure server address
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = INADDR_ANY;
    server_address.sin_port = htons(3001);
    // Bind the socket to the specified IP and port
    if (bind(server_socket, (struct sockaddr *)&server_address, sizeof(server_address)) ==
        -1)
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
    char buffer[256];
    struct sockaddr_in client_address;
    socklen_t client_address_len = sizeof(client_address);
    while (1)
    {
        // Receive data from the client
        recvfrom(server_socket, buffer, sizeof(buffer), 0, (struct sockaddr *)&client_address,&client_address_len);
        int size = strlen(buffer);
        if(strcmp(buffer,"exit\n")==0)
        {
            printf("Client has exited\n");
            break;
        }

        //sscanf(buf, "%d %d", &num1, &num2);
        // Send the result back to the client
        sendto(server_socket, &size, sizeof(size), 0, (struct sockaddr *)&client_address,client_address_len);
    }
}