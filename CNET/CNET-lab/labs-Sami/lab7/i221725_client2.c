#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <string.h>

int main()
{
    char request[256];
    char buf[200];

    // create the socket
    int sock;
    sock = socket(AF_INET, SOCK_STREAM, 0);

    // setup an address
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = INADDR_ANY;
    server_address.sin_port = htons(3001);

    // Check for successful connection
    if (connect(sock, (struct sockaddr *)&server_address, sizeof(server_address)) == -1){
        perror("Connection unsuccessful");
        close(sock);
        exit(EXIT_FAILURE);
    }

    recv(sock, buf, sizeof(buf), 0);
    printf("%s", buf);

    //for loop to send a string 5 times to the server
    char input[100];

    for (int i = 0; i < 5; i++) {
        input[0] = '\0';  // Clear the string
        printf("Enter a string: ");
        fgets(input, sizeof(input), stdin);
        //printf("input string about to be sent to the server: %s\n\n",input);
        
        //sending the input string to the server
        send(sock, input, strlen(input), 0);
        input[0] = '\0';  // Clear the string
        
        //receiving the reverse string and printing it
        recv(sock, buf, sizeof(buf), 0);
        printf("Received reversed string: %s\n\n", buf);
        buf[0] = '\0';  // Clear the string
    }




    // close the socket
    close(sock);
    return 0;
}