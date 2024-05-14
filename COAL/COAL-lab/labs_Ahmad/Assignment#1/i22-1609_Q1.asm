; Ahmad Abdullah 
; i22-1609
; Q#1

.model small
.stack 100h
.data 
    var db 0
    var1 db 0
    var2 db 0
    msg db 10,13, "Enter price: $"
    msg2 db 10,13, "Total: $"
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

        mov al, var
        add al, bl
        cmp al, 9
        jg ifgreat
        jmp ngreat
    ifgreat:
        sub al, 10
        add bh, 1
    ngreat:
        mov var, al
        mov al, var1

        add al, bh
        cmp al, 9
        jg ifgreat2
        jmp ngreat2
    ifgreat2:
        sub al, 10
        mov dh, 1
        add var2, dh
    ngreat2:
        mov var1, al
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

        mov dl, var
        add dl, 30h
        mov ah, 02h
        int 21h

        mov ah, 4ch
        int 21h
    main endp
end main

