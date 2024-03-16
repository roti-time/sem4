.model small 
.stack 100h
.data  
msg1 db 10,13,"It is Even $"
msg2 db 10,13,"It is Odd $"
var01 db 6

.code
main proc 
mov ax,@data
mov ds,ax

mov al,var01
and al,1
jnz odd
even:
mov ah,09h
lea dx,msg1
int 21h
jmp exit
odd:
mov ah,09h
lea dx,msg2
int 21h
exit:
mov ah,4ch
int 21h
main endp
end main


