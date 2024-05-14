;AHMAD ABDULLAH
;i22-1609
;ASSIGNMENT 2
;QUESTION 2

.model small
.stack 100h
.data
    msg db "Enter a number between 1 to 100: $"
    msg1 db "Factors of the number are: $"
    num dw 0
    temp dw 0
    count db 0
.code

    Factors proc 
        mov bx, num
        mov temp, bx
        mov count, 0
    Loop1:
        mov ax, num
        mov cl, bl
        div cl
        cmp ah, 0
        jne NoPush
            push bx
            inc count
        NoPush:
        sub bx, 1
        cmp bx, 0
        jne Loop1
        ret
    Factors endp

    OutputFactors proc
        lea dx, msg1
        mov ah, 09h
        int 21h 

        mov ah, 02h
        mov dl, 10
        int 21h
        ret

        mov cx, 0
        mov bx, num
        pop ax
        mov cx, ax
    Loop2:
        pop ax
        mov cx, ax
        check:
        cmp cl, 10
        jb skip_inc
            sub cl, 10
            inc ch
            jmp check
        skip_inc:

        mov dl, ch       
        add dl, '0'      
        mov ah, 02h      
        int 21h

        mov dl, cl      
        add dl, '0'    
        mov ah, 02h     
        int 21h 

        mov ah, 02h
        mov dl, 10
        int 21h
        ret

        dec count
        mov bl, count
        cmp bl, 1
        jne Loop2
        ret
    OutputFactors endp

    main proc
        mov ax,@data
        mov ds,ax

        mov ah,09h
        lea dx,msg
        int 21h

        mov ah,01h
        int 21h
        sub al,30h
        mov ch,al
        mov ah,01h
        int 21h
        sub al,30h
        mov cl,al

        mov ax,0

        mov al,ch
        mov bl,10
        mul bl
        add al,cl
        mov num,ax

        ; Call Factors procedure
        call Factors

        mov ah, 02h
        mov dl, 10
        int 21h
        ret

        ; Call OutputFactors procedure
        call OutputFactors

        mov ah,4ch
        int 21h
    main endp
end main
