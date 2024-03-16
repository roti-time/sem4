
.model small

.stack 100h

.data

var1 db 'chachu kesa lga mera mazaaq$'
length1 db ?
size1 db ?
type1 db ?
.code

main proc
mov ax,@data
mov ds,ax
mov al,TYPE var1
mov type1, al

int 21h

mov al,size var1
mov cl,al
mov size1,cl
int 21h

mov al,length var1
mov length1,al
int 21h

mov dl,type1
mov ah,02
int 21h

mov dl,size1
mov ah,02
int 21h

mov dl,length1
mov ah,02
int 21h 

mov ah,4ch

int 21h

main endp

end main
