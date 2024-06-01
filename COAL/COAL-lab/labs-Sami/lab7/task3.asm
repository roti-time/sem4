.model small
.stack 100h

.data
    inputString db "man i dont wanna do dis no mo$"

.code

convertToUpper proc
    push bp
    mov bp, sp

    mov si, [bp+4]  ; Load the address of the input string from the stack

convertLoop:
    mov al, [si]    ; Load a character from the input string
    cmp al, '$'     ; Check if it's the end of the string
    je convertEnd

    cmp al, 'a'     ; Check if the character is lowercase
    jb convertNext
    cmp al, 'z'
    ja convertNext

    sub al, 32      ; Convert lowercase to uppercase by subtracting 32
    mov [si], al    ; Store the uppercase character back in the input string

convertNext:
    inc si          ; Move to the next character
    jmp convertLoop ; Repeat the loop

convertEnd:
    pop bp
    ret 2           ; Remove the return address and input string address from the stack

convertToUpper endp

main proc
    mov ax, @data
    mov ds, ax

    lea si, inputString

    push si         ; Push the address of the input string onto the stack
    call convertToUpper
    pop si          ; Remove the input string address from the stack

    ; Print the converted string
    mov ah, 09h
    mov dx, offset inputString
    int 21h

    mov ah, 4ch
    int 21h

main endp

end main