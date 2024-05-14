; Ahmad Abdullah 
; i22-1609
; Q#5 part(b)

.model small
.stack 100h
.data
    row1 dw 0
    row2 dw 1
    msg1 db 'Enter: $'
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

        mov row1, cx
        mov bx, cx
        dec row1
        loop1:
            loop2:
                mov dl, ' '
                mov ah, 02
                int 21h

                loop loop2
            mov cx, row2
            loop3:
                mov dl, '*'
                mov ah, 02
                int 21h
                mov dl, ' '
                mov ah, 02
                int 21h
                loop loop3
            inc row2
            mov dl, 10
            mov ah, 02
            int 21h
            mov cx, bx
            dec bx
            loop loop1
        mov row2, 2
        inner1:
            mov cx, row2
            inner2:
                mov dl, ' '
                mov ah, 02
                int 21h

                loop inner2
            inc row2
            mov cx, row1
            inner3:
                mov dl, '*'
                mov ah, 02
                int 21h
                mov dl, ' '
                mov ah, 02
                int 21h
                loop inner3
            mov cx, row1
            dec row1
            mov dl, 10
            mov ah, 02
            int 21h
            loop inner1

        mov ah, 4ch
        int 21h
    main endp
end main
