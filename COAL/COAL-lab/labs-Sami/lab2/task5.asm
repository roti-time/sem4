.model small

.stack 100H

.data

.code

main proc
mov al,08
mov ah,08
int 21h
mov dl,al
sub dl,32
int 21h
mov ah,02
int 21h


mov ah,4ch

int 21h

main endp

end main