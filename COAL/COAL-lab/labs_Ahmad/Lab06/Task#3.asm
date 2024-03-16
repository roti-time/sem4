model small
.data
num db 2,1,3,4,5,6,5,7,9,9
msg db "Enter First Number: $"
msg2 db "Enter Second Number: $"
msg1 db 10,13, "Both numbers are Found $"
msg3 db 10,13, "One of the numbers is Found $"
msg4 db 10,13, "Neither number is Found $"
value1 db ?
value2 db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Input first number
    lea dx, msg
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    sub al, '0'
    mov value1, al

    ; Input second number
    lea dx, msg2
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    sub al, '0'
    mov value2, al

    ; Compare both numbers with array elements
    lea si, num
    mov cx, 10

CheckNumbers:
    mov bl, [si]
    cmp al, bl
    jz CheckSecondNumber
    inc si
    loop CheckNumbers

    ; If first number not found, check second number
    mov al, value2
    lea si, num
    mov cx, 10

CheckSecondNumber:
    mov bl, [si]
    cmp al, bl
    jz BothNumbersFound
    inc si
    loop CheckSecondNumber

    ; Neither number found
    mov dx, offset msg4
    jmp DisplayMessage

BothNumbersFound:
    mov dx, offset msg1
    jmp DisplayMessage

DisplayMessage:
    mov ah, 09h
    int 21h

    ; Exit the program
    mov ah, 4ch
    int 21h
main endp
end main
