; Ahmad Abdullah 
; i22-1609
; Q#3

dosseg
.model small
.stack 100h
.data
    msg1 db 10,13, "Enter a number: $"
    msg2 db 10,13,"The sum:  $"
    msg3 db "numbers is: $"
    num db 0

    unit db 0
    ten db 0
    hundered db 0
    thousand db 0

    var1 db 0
    var2 db 0

    help1 db 0
    help2 db 0
.code
    main proc 
        mov ax, @data
        mov ds, ax

        mov ah, 09h
        lea dx, msg1
        int 21h

        mov ah, 01h
        int 21h

        sub al, '0'
        mov bl, 10
        mul bl

        mov num, al

        mov ah, 01h
        int 21h

        sub al, '0'
        add num, al

        mov bx, 0
        mov ax, 0
        mov bl, 10
        mov al, num
        div bl

        mov help1, ah
        mov help2, al

        mov ax, 0
        mov al, num
        add al, 1

        mov bl, num
        mul bl

        mov bx, 2
        div bx

        mov bl, 100
        div bl

        mov var1, al
        mov var2, ah

        mov ax, 0
        mov bx, 0
        mov al, var1
        mov bl, 10
        div bl

        mov thousand, al
        mov hundered, ah

        mov ax, 0
        mov bx, 0
        mov al, var2
        mov bl, 10
        div bl

        mov ten, al
        mov unit, ah

        mov ah, 09h
        lea dx, msg2
        int 21h

        mov dl, help2
        add dl, '0'
        mov ah, 02h
        int 21h

        mov dl, help1
        add dl, '0'
        mov ah, 02h
        int 21h

        mov ah, 09h
        lea dx, msg3
        int 21h

        mov dl, thousand
        add dl, '0'
        mov ah, 02h
        int 21h

        mov dl, hundered
        add dl, '0'
        mov ah, 02h
        int 21h

        mov dl, ten
        add dl, '0'
        mov ah, 02h
        int 21h

        mov dl, unit
        add dl, '0'
        mov ah, 02h
        int 21h

        mov ah, 4ch
        int 21h
    main endp
end main
