.model small
.stack 100h
.data
    arr db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
        db 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40
        db 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60
        db 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80
        db 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100
    msg db 10, 13, "Odd Numbers from 1 to 100: $"
.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 100 ; Number of elements in the array
    lea si, arr ; Load the address of the array into SI
    mov bx, 1   ; Starting number to check

    findOdds:
    mov ax, bx
    and ax, 1   ; Check the least significant bit of AX
    cmp ax, 1   ; Compare with 1 to check if odd
    jne notOdd  ; Jump if not equal (even number)

    mov [si], bl ; Store the odd number in the array
    inc si       ; Increment the array index

    notOdd:
    inc bx       ; Increment the number
    loop findOdds

    ; Print "Odd Numbers from 1 to 100:"
    mov dx, offset msg
    mov ah, 09h
    int 21h

    mov cx, 100 ; Number of elements in the array
    mov si, offset arr ; Load the offset of the array into SI

    printLoop:
    mov dl, [si] ; Load the current element from the array into DL
    add dl, 30h ; Convert the number to ASCII character
    mov ah, 02h ; Function to print character
    int 21h     ; Print the character

    inc si      ; Increment the array index
    loop printLoop

    mov ah, 4ch ; Exit program
    int 21h
main endp
end main