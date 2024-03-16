.model small
.stack 100h
.data
    num1 db ?
    num2 db ?
    msg1 db 10,13,"num1: $"
    msg2 db 10,13,"num2: $"
    bigmsg db 10,13,"larger number: $"
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Take input for num1
    mov dx, offset msg1
    mov ah, 09h
    int 21h
    mov ah, 01h ; Function to read character
    int 21h     ; Read character from standard input
    sub al, '0' ; Convert ASCII to binary
    mov num1, al

    mov dx, offset msg2
    mov ah, 09h
    int 21h
    mov ah, 01h ; Function to read character
    int 21h     ; Read character from standard input
    sub al, '0' ; Convert ASCII to binary
    mov num2, al

    mov al, num1
    cmp al, num2
    jbe secondnum

    mov dx, offset bigmsg
    mov ah, 09h
    int 21h
    mov al, num1
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    jmp endProgram

secondnum:
    mov dx, offset bigmsg
    mov ah, 09h
    int 21h
    mov al, num2
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

endProgram:
    mov ah, 4ch ; Exit program
    int 21h
main endp
end main