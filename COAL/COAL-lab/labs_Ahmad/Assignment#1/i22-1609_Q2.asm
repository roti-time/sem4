; Ahmad Abdullah 
; i22-1609
; Q#2

.model small
.stack 100h
.data 
    var1 db 0
    var2 db 0
    msg db 10,13, "Enter marks: $"
    msg2 db 10,13, "Total : $"
    msg3 db 10,13, "Percent: $"
    msg4 db 10,13, "Total marks exceed 100. $"
.code 
    main proc 
        mov ax,@data
        mov ds,ax
        
        mov cx, 5
        mov si, 0
    L1:
        mov ah, 09h
        lea dx, msg
        int 21h

        mov ah, 01h
        int 21h
        sub al, 30h
        mov bh, al

        mov ah, 01h
        int 21h
        sub al, 30h
        mov bl, al

        mov al, var1
        add al, bl
        cmp al, 9
        jg ifgreat
        jmp smaller
    ifgreat:
        sub al, 10
        add bh, 1
    smaller:
        mov var1, al
        mov al, var2

        add al, bh
        cmp al, 9
        jg ifgreat2
        jmp smaller2
    ifgreat2:
        mov ah, 09h
        lea dx, msg4
        int 21h

        jmp thanks
    smaller2:
        mov var2, al
        inc si
        loop L1

        mov ah, 09h
        lea dx, msg2
        int 21h

        mov dl, var2
        add dl, 30h
        mov ah, 02h
        int 21h

        mov dl, var1
        add dl, 30h
        mov ah, 02h
        int 21h

        mov bh, var2
        mov bl, var1

        mov cx, 100

        mov ax, bx 
        mul cx   

        mov cx, 100  
        div cx           

        mov bx, ax     

        mov ah, 09h
        lea dx, msg3
        int 21h

        mov dl, bh
        add dl, 30h
        mov ah, 02h
        int 21h

        mov dl, bl
        add dl, 30h
        mov ah, 02h
        int 21h

        mov ah, 4ch
        int 21h
    main endp
end main

