.model small
.stack 100h
.data
    msg db 'Enter the number in multi digits$', 0
    sum_msg db 'Sum of the first %d natural numbers is: %d$', 0
.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 09h       ; Display message to prompt user
    lea dx, msg
    int 21h

    ; Read input number from user
    mov ah, 01h       ; Read character from STDIN
    int 21h
    sub al, 30h       ; Convert ASCII character to integer
    movzx cx, al      ; Move input to CX

    ; Calculate the sum of first N natural numbers
    mov ax, cx
    mov bx, cx
    inc bx            ; N+1
    mul bx            ; N * (N+1)
    shr ax, 1         ; Divide by 2
    mov dx, 0         ; Clear DX for division
    div bx            ; Divide by 2
    mov si, ax        ; SI = sum

    ; Display the sum
    mov ah, 09h       ; Display message function
    lea dx, sum_msg   ; Load message offset
    push cx           ; Preserve CX
    push si           ; Preserve SI
    call print_sum    ; Display sum
    pop si            ; Restore SI
    pop cx            ; Restore CX

    mov ax, 4C00h     ; Exit program
    int 21h

main endp

print_sum proc
    pop ax            ; Pop the sum
    pop bx            ; Pop N
    push bx           ; Push N back to stack
    push ax           ; Push sum back to stack
    push ax           ; Push sum again
    push bx           ; Push N
    mov ah, 09h       ; Display message function
    int 21h
    ret
print_sum endp

end main
