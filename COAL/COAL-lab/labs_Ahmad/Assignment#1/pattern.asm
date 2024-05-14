.model small
.stack 100h
.data
    msg db 10,13,"Enter 5 double-digit numbers: $"
    sum db 0, 0, 0, 0, 0
.code
main proc
    mov ax, @data
    mov ds, ax
    mov cx, 5

    lea dx, msg
    mov ah, 9
    int 21h

    mov cx, 5
    mov bx, 10  ; base 10

    input_loop:
    mov ah, 01h  ; read character from input
    int 21h
    sub al, '0' ; convert character to numeric value
    mov dl, al  ; store the first digit

    mov ah, 01h  ; read second digit
    int 21h
    sub al, '0' ; convert character to numeric value

    add dl, al  ; add the second digit
    add dl, [sum + cx] ; add the current sum
    mov [sum + cx], dl ; store the updated sum

    loop input_loop

    lea dx, msg
    mov ah, 9
    int 21h

    mov cx, 5
    mov bx, 10   ; base 10
    xor ax, ax   ; clear AX register

    print_loop:
    mov dl, [sum + cx - 1] ; load the sum digit
    add dl, '0'  ; convert to ASCII character
    mov ah, 02h  ; display character function
    int 21h      ; display the character
    dec cx       ; decrement counter
    jnz print_loop ; if not zero, continue

    mov ax, 4C00h
    int 21h

main endp

end main