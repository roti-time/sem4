.model small

.stack 100h

.data

arr1 db 0, 1, 2, 3,4

arr2 db 5 dup(?)

.code

reverse proc

push bp

mov bp,sp

add bp,4

mov si,[bp]

add si, 5

sub si,1

mov di,offset arr2

mov cx,5

l1:

mov al,[si]

mov [di],al

add di,1

sub si,1

loop l1

pop bp

ret 2

reverse endp

main proc

mov ax, @data

mov ds, ax

mov si,OFFSET arr1

push si

call reverse

mov si,OFFSET arr2

mov cx,5

l2:

mov dl,[si]

add dl,30h

mov ah,02h

int 21h

add si,1

loop l2

mov ah,4ch

int 21h

main endp

end main