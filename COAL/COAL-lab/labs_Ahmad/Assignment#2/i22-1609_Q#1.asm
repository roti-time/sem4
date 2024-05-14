;AHMAD ABDULLAH
;i22-1609
;ASSIGNMENT 2
;QUESTION 1
.model small
.stack 100h
.data
    var db ?
    var1 db ?
    var2 db ?
    var3 db ?
    var4 db ?
    var5 db ?
    var6 db ?
    var7 db ?

    sum db ?
    subt db ?
    mult db 0
    mult2 db 0
    divi db ?

    msg1 db "Results: $"
    msg2 db " SUM: $"
    msg3 db " Subtrated: $"
    msg4 db " Multiplied: $"
    msg5 db " Divided: $"

.code
    main proc 
    mov ax, @data
    mov ds, ax

    mov ah, 01h
    int 21h
    mov var, al
    

    mov ah, 01h
    int 21h
    mov var1, al
    
    
    mov ah, 01h
    int 21h
    mov var2, al
    
    mov ah, 01h
    int 21h
    mov var3, al
    
    
    mov ah, 01h
    int 21h
    mov var4, al
    
    
    mov ah, 01h
    int 21h
    mov var5, al
    
    
    mov ah, 01h
    int 21h
    mov var6, al
    
    
    mov ah, 01h
    int 21h
    mov var7, al
    

    mov al, var
    mov dl, var1

    add al,dl
    mov sum, al

    mov al, var2
    mov dl, var3
    sub al,dl
    mov subt, al

    mov al, var4
    mov bl, var5
    mul bl
    AAM
    mov mult, al
    mov mult2, ah

    mov al, var6
    mov bl, var7
    div bl
    mov divi, al

    mov ah, 09h
    lea dx, msg1
    int 21h

    mov ah, 09h
    lea dx, msg2
    int 21h

    mov dl, sum
    sub dl, 30h
    mov ah, 02h
    int 21h

    mov ah, 09h
    lea dx, msg3
    int 21h

    mov dl, subt
    add dl, 30h
    mov ah, 02h
    int 21h

    mov ah, 09h
    lea dx, msg4
    int 21h

    mov dl, mult
    add dl, 30h
    mov ah, 02h
    int 21h
    mov dl, mult2
    add dl, 30h
    mov ah, 02h
    int 21h

    mov ah, 09h
    lea dx, msg5
    int 21h

    mov dl, divi
    sub dl, '0'
    mov ah, 02h
    int 21h

    mov ah, 4ch
    int 21h

    main endp
end main



    
