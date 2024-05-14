.model small
.stack 100h
.data
input dw ?
msg db 'Enter odd number$'
star dw 1
.code
main proc
start:
mov ax, @data
mov ds, ax

mov ah, 09h 
mov dx, offset msg
int 21h

mov ah, 01h 
int 21h
sub al, 30h 
mov input, ax

test al, 1
jz error 

mov cx, input 

mov bx, 0
outer_loop:
mov dx, 0 
inner_loop:
mov ah, 02h 
mov dl, '*' 
int 21h

inc dx
cmp dx, bx 
jbe inner_loop 

inc bx ; Increment loop counter
cmp bx, cx ; Compare loop counter with user input
jbe outer_loop ; Jump if loop counter is less than or equal to user input

jmp exit1

error:
mov dx, offset msg ; Display error message
mov ah, 09h
int 21h

exit1:
mov ah, 4Ch ; Exit program
int 21h
main endp
end start
