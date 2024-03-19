#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
int main()
{
    char request[200];
    char first_num[100];
    // create the socket for the client
    int sock;
    sock = socket(AF_INET, SOCK_STREAM, 0);

    // setup an address to connect to
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = INADDR_ANY;
    server_address.sin_port = htons(9001);
    // Check for successful connection
    if (connect(sock, (struct sockaddr *)&server_address, sizeof(server_address)) == -1)
    {
        perror("Connection unsuccessful");
        close(sock);
        exit(EXIT_FAILURE);
    }
    
    // Connection successful message
    printf("Connection successful!\n");

    printf("Enter a String: ");
    scanf("%s", &first_num);

    send(sock, first_num,sizeof(first_num), 0);

    read(sock, &request, sizeof(request));
    printf("Server: %s\n", request);


    // close the socket
    close(sock);
    return 0;
}