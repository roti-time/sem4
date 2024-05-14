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

int main()
{
    char request[256];
    char encrypted[200], decrypted[200];
    char buf[200];
    // create the socket
    int sock;
    sock = socket(AF_INET, SOCK_STREAM, 0);
    // setup an address
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = inet_addr("172.16.51.247"); // Change to the desired server IP address
    server_address.sin_port = htons(3001);
    connect(sock, (struct sockaddr *)&server_address, sizeof(server_address));
    // Send and receive messages with the server

    while (true)
    {
        printf("\nEnter a message: ");
        fgets(decrypted, sizeof(decrypted), stdin);
        decrypted[strcspn(decrypted, "\n")] = '\0'; // Remove the newline character from input
        encrypt_rot3(decrypted, encrypted);
        write(sock, encrypted, sizeof(encrypted));
        if (strcmp(decrypted, "bye") == 0) // Use strcmp to compare strings
            break;
        read(sock, encrypted, sizeof(encrypted));
        decrypt_rot3(encrypted, decrypted);
        printf("\nMessage received: %s\n",decrypted);
        if (strcmp(decrypted, "bye") == 0) // Use strcmp to compare strings
            break;
    }
    // close the socket
    close(sock);
    return 0;
}


void encrypt_rot3(char *plaintext, char *ciphertext) {
    int i;
    for (i = 0; i < strlen(plaintext); i++) {
        if (isalpha(plaintext[i])) {
            char ascii_offset = isupper(plaintext[i]) ? 'A' : 'a';
            char encrypted_char = ((plaintext[i] - ascii_offset + 3) % 26) + ascii_offset;
            ciphertext[i] = encrypted_char;
        } else {
            ciphertext[i] = plaintext[i];
        }
    }
    ciphertext[i] = '\0';
}

void decrypt_rot3(char *ciphertext, char *plaintext) {
    int i;
    for (i = 0; i < strlen(ciphertext); i++) {
        if (isalpha(ciphertext[i])) {
            char ascii_offset = isupper(ciphertext[i]) ? 'A' : 'a';
            char decrypted_char = ((ciphertext[i] - ascii_offset - 3 + 26) % 26) + ascii_offset;
            plaintext[i] = decrypted_char;
        } else {
            plaintext[i] = ciphertext[i];
        }
    }
    plaintext[i] = '\0';
}