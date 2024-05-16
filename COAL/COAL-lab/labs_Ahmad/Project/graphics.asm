.model small
.stack 100h
.data
    msg db 10,13, "Hello, World!$"

.code 
main proc
    ;graphics
    mov ah,6
    mov al,0
    mov bh,00111101b
    mov cx,0
    mov dh,30h
    mov dl,60h
    int 10h

 mov dx,offset msg
    mov ah,9
    int 21h

    mov ah,4ch
    int 21h
   
main endp
end main