.model small
.stack 100h
.data
    prompt db 10, 13, "Enter a number: $"
    even_msg db 10, 13, "Input is even. $"
    odd_msg db 10, 13, "Input is odd. $"
.code
main proc
    mov ax, @data
    mov ds, ax

    mov dx, offset prompt
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h

    sub al, 30h  ; Convert ASCII digit to numeric value

    mov ah, 02h
    test al, 01b
    jz even_l

    mov dx, offset odd_msg
    mov ah, 09h
    int 21h
    jmp end_prog

even_l:
    mov dx, offset even_msg
    mov ah, 09h

end_prog:
    int 21h

    mov ah, 4ch
    int 21h
main endp
end main