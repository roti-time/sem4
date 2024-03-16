#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <string.h>

int main()
{
    char str[100];
    
    char request[100];
    // create the socket for the client
    int sock;
    sock = socket(AF_INET, SOCK_STREAM, 0);

    // setup an address to connect to
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = INADDR_ANY;
    server_address.sin_port = htons(3001);

    // Check for successful connection
    if (connect(sock, (struct sockaddr *)&server_address, sizeof(server_address)) == -1)
    {
        perror("Connection unsuccessful");
        close(sock);
        exit(EXIT_FAILURE);
    }
    
    // Connection successful message
    printf("Connection successful!\n");

    for(int i = 0; i < 5; i++)
    {
        printf("Enter a string to reverse: ");
        fgets(str, sizeof(str), stdin);

        size_t len = strlen(str);
        if (len > 0 && str[len - 1] == '\n') {
            str[len - 1] = '\0';
        }
        send(sock, str, sizeof(str), 0);
        recv(sock, &request, sizeof(request), 0);
        printf("Reversed String is: %s",request);
        printf("\n");
    }
    

    // close the socket
    close(sock);
    return 0;
}
