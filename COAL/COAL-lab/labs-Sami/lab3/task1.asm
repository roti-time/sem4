.dosseg
.model small

.stack 100h

.data
var1 db ?
var2 db ?
.code

main proc
mov ax,@data
mov dx,ax

mov ah,01
int 21h

sub al,30h
mov var1,al

mov ah,01
int 21h

sub al,30h
mov var2,al

add var1,al
add var1,30h
int 21h

mov dl,var1
mov ah,02
int 21h

mov ah,4ch

int 21h

main endp

end main