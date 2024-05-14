;AHMAD ABDULLAH
;i22-1609
;ASSIGNMENT 2
;QUESTION 3

.model small
.stack 100h
.data
    a db ?
    b db ?
    c db ?
    d db ?
    e db ?
    f db ?
    g db ?
    msg db 10,13, "There is nothing to print$" 

.code
main proc 
    mov ax, @data
    mov ds, ax

    mov ah, 01h
    int 21h
    mov a, al

    mov ah, 01h
    int 21h
    mov b, al

    mov ah, 01h
    int 21h
    mov c, al

    mov ah, 01h
    int 21h
    mov d, al

    mov ah, 01h
    int 21h
    mov e, al

    mov ah, 01h
    int 21h
    mov f, al

    mov ah, 01h
    int 21h
    mov g, al

    mov dl,g
    mov al,f

    cmp dl,al
    je gEQUf
    jne gNOTf

    gNOTf: ;g is not equal to f
        mov al,e
        mov dl,d

        cmp al,dl
        je exit ;e is equal to d

    gEQUf: ;g is equal to f
        mov al,g
        mov dl,d

        cmp al,dl
        je gEQUd ;g is equal to d
        jne gNOTd ;g is not equal to d

        gNOTd:
            mov al,f 
            mov dl,e
            cmp al,dl
            jg exit ;f is less than or equal to e

        gEQUd:
            mov al,a  
            mov dl,g  
            cmp al,dl
            jle exit ;a is less than or equal g

            mov al,b
            mov dl,e  
            cmp al,dl
            jg exit ;b is less than or equal to e

            mov al,c
            mov dl,a 
            cmp al,dl
            jle exit ;c is less than or equal to a

            mov al,e 
            mov dl,c 
            cmp al,dl
            jl exit ;e is less than c

            mov dl,a 
            mov ah, 02h
            int 21h
            jmp exit2


exit:
    mov ah, 09h
    lea dx, msg
    int 21h

exit2:
    mov ah, 4ch
    int 21h

main endp
end main