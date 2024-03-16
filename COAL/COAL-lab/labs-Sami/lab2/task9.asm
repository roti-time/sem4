
.model small
.stack 100H
.data
.code
main proc
mov ah,01h        ; Input first number
int 21h
sub al, 30h       ; Convert ASCII to numeric value
mov bl, al
mov ah,01h        ; Input second number
int 21h
sub al, 30h       ; Convert ASCII to numeric value
sub al, bl        ; Subtract the two numbers
add al, 30h       ; Convert numeric value to ASCII
mov dl, al
mov ah,02h        ; Output the result
int 21h
mov ah,4ch        ; Exit the program
int 21h
main endp
end main