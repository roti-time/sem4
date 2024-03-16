.model small 
.stack 100h 
.data
msg1 db 10,13, "Enter First number: $" 
msg2 db 10,13, "Enter Second number: $" 
msg3 db 10,13, "Numbers are equal $" 
msg4 db 10,13, "Numbers are not equal $" 
.code
main proc
mov ax, @data
mov ds, ax

mov dx, offset msg1
mov ah, 09h

mov ah, 01h
int 21h
sub al, 30h
mov cl, al

mov dx, offset msg2
mov ah, 09h
int 21h

mov ah, 01h
int 21h
sub al, 30h

mov dl, al

cmp dl, cl
je equal

mov dx, offset msg4
mov ah, 09h
int 21h
jmp end_prog
equal:

mov dx, offset msg3
mov ah, 09h
int 21h
end_prog:

int 21h
main endp
end main