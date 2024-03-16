dosseg
.model small
.stack 100h
.data

    var1 db ?
    var2 db ?

.code

main proc
    mov ax, @data
    mov dx, ax
    
    mov ah,01
    int 21h

    sub al, 48
    mov var1, al
    mov ah,01
    int 21h

    sub al,48
    mov var2,al

    sub var1,al
    add var1,48
    int 21h

    mov dl,var1
    mov ah,02
    int 21h

    mov ah,4ch
    int 21h
       

    main endp
end main