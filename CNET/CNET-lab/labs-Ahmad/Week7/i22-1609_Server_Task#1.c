#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>


void calculate_this_shi(int num1, int num2, char operator)
{
    long result=0;
    switch (operator)
    {
    case '+':
        result = num1 + num2;
        break;
    case '-':
        result = num1 - num2;
        break;
    case '*':
        result = num1 * num2;
        break;
    case '/':
        result = num1 / num2;
        break;
    case '%':
        result = num1 % num2;
        break;
    default:
        printf("Invalid operator\n");
        break;
    }
    printf("The result is: %d\n", result);
}

int main()
{
    char buf;
    char first_num[100], second_num[100];
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
   
    // Receive the number from the client

    recv(client_socket,&first_num, sizeof(first_num), 0);
    int num1 = atoi(first_num);
    // Generate the triangle and send it to the client
    recv(client_socket,&buf , sizeof(buf), 0);

    recv(client_socket,&second_num, sizeof(second_num), 0);
    int num2 = atoi(second_num);
    
    calculate_this_shi(num1, num2, buf);
    // close the socket
    close(server_socket);
    return 0;
}