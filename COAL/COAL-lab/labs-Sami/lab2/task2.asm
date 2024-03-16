.model small

.stack 100H

.data

.code

main proc
mov dl,al

mov ah, 01h

int 21h

mov ah,4ch

int 21h

main endp

end main