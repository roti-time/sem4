#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <string.h>
void handle_client(int client_socket);
int main()
{
    int server_socket, client_socket;
    struct sockaddr_in server_address, client_address;
    socklen_t client_address_len = sizeof(client_address);
    pid_t pid;
    // Create the server socket
    server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket == -1)
    {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    // Configure server address
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = INADDR_ANY;
    server_address.sin_port = htons(9001);

    // Bind the socket to the specified IP and port
    if (bind(server_socket, (struct sockaddr *)&server_address, sizeof(server_address)) == -1)
    {
        perror("Bind failed");
        exit(EXIT_FAILURE);
    }

    // Listen for incoming connections
    if (listen(server_socket, 2) == -1)
    {
        perror("Listen failed");
        exit(EXIT_FAILURE);
    }
    printf("Server started. Listening on port %d...\n", 9001);
    while (1)
    {
        // Accept incoming connection
        client_socket = accept(server_socket, (struct sockaddr *)&client_address, &client_address_len);
        if (client_socket == -1)
        {
            perror("Accept failed");
            continue;
        }
        // Fork a new process to handle the client
        pid = fork();
        if (pid == -1)
        {
            perror("Fork failed");
            close(client_socket);
            continue;
        }
        else if (pid == 0)
        {                         // Child process
            close(server_socket); // Close the server socket in child process
            handle_client(client_socket);
            close(client_socket);
            exit(EXIT_SUCCESS);
        }
        else
        {                         // Parent process
            close(client_socket); // Close the client socket in parent process
            // Clean up terminated child processes to avoid zombie processes
            while (waitpid(-1, NULL, WNOHANG) > 0)
                ;
        }
    }
    // Close the server socket
    close(server_socket);
    return 0;
}
void handle_client(int client_socket)
{
    char buf[200];
    char num1[100];
    // Receive the first message (number) from the client
    read(client_socket, &num1, sizeof(num1));
    // Send the result back to the client
    printf("Received String is : %s\n", num1);
    fgets(buf, sizeof(buf), stdin);
    send(client_socket, buf, sizeof(buf), 0);
}