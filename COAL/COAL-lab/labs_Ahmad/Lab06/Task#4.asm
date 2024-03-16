.model small
.stack 100h
.data
var1 db ?
var2 db ?
    msg db 10,13, "Enter a Number: $"
    msg1 db 10,13, "Enter Second Number: $"
    msg2 db 10,13, "Second Number is Greater: $"
    msg3 db 10,13, "First Number is Greater: $"
.code
main proc 
    mov ax, @data
    mov ds, ax
    
    mov dx, OFFSET msg
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, 30h
    mov var1, al
    mov bl, al

    mov dx, OFFSET msg1
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, 30h
    mov var2, al

    cmp al, bl
    jg greater
    jl lesser

    exit:
        mov ah, 4ch
        int 21h

    greater:
        mov dx, OFFSET msg2
        mov ah, 09h
        int 21h
        jmp exit

    lesser:
        mov dx, OFFSET msg3
        mov ah, 09h
        int 21h
        jmp exit

main endp
end main