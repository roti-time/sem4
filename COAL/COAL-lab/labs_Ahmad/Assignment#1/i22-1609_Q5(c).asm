; Ahmad Abdullah 
; i22-1609
; Q#5 part(c)

.model small
.stack 100h
.data
    rows dw 1
    msg1 db 'Enter rows: $'
.code 
    main proc 
        mov ax, @data
        mov ds, ax

        lea dx, msg1
        mov ah, 09h
        int 21h

        mov ah, 1
        int 21h
        sub al, 30h

        mov ah, 0
        mov cx, ax
        mov dl, 10
        mov ah, 02
        int 21h
        mov bx, cx
        loop1:

            loop2:
                mov dl, ' '
                mov ah, 02
                int 21h

                loop loop2
            mov cx, rows
            loop3:
                mov dl, '*'
                mov ah, 02
                int 21h
                mov dl, ' '
                mov ah, 02
                int 21h
                loop loop3
            inc rows
            mov dl, 10
            mov ah, 02
            int 21h
            mov cx, bx
            dec bx
            loop loop1

        mov ah, 4ch
        int 21h
    main endp
end main
