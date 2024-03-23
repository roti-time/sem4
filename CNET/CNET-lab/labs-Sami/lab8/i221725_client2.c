#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>
int main() {
char request[256];
char msg1[200], msg2[200];
char buf[200];
// create the socket
int sock;
sock = socket(AF_INET, SOCK_STREAM, 0);
// setup an address
struct sockaddr_in server_address;
server_address.sin_family = AF_INET;
server_address.sin_addr.s_addr = INADDR_ANY;
server_address.sin_port = htons(3001);
connect(sock, (struct sockaddr *) &server_address, sizeof(server_address));
// Send the first message (number) to the server
printf("Enter a message: ");
//scanf("%s", msg1);
fgets(msg1, sizeof(msg1), stdin);
write(sock, &msg1, sizeof(msg1));
// Send the second message (number) to the server
printf("Enter another message: ");
//scanf("%s", msg2);
fgets(msg2, sizeof(msg2), stdin);
write(sock, &msg2, sizeof(msg2));

// Receive the result from the server
//read(sock, &results, sizeof(results));
//printf("\nServer result: %d\n", results);
// close the socket
close(sock);
return 0;
}
