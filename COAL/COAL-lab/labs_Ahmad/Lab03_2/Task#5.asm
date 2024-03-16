dosseg
.model small
.stack 100h
.data
var1 db 'justwow$'

.code
main proc 
mov ax,@data
mov ds,ax
mov al, TYPE var1
mov bl, LENGTH var1
mov cl, SIZE var1

;mov dl,al
mov ah,2
int 21h

;mov dl,bl
mov ah,2
int 21h

;mov dl,cl
mov ah,2
int 21h
main endp
end main 
