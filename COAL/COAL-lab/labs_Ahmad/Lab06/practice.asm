.model small
.stack 100h
.data
    arr db 1, 1, 3, 1, 5, 6, 7, 1, 9, 0 ; Array of 10 elements
    num1 db ?
    num2 db ?
    result db 10 dup('$') ; Variable to store the result
    msg1 db 10,13,"num1: $"
    msg2 db 10,13,"num2: $"
    foundMsg db 10,13,"FOUND$"
    notFoundMsg db 10,13,"NOT FOUND$"
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Take input for num1
    mov dx, offset msg1
    mov ah, 09h
    int 21h
    mov ah, 01h ; Function to read character
    int 21h     ; Read character from standard input
    sub al,'0' ; Convert ASCII to binary
    mov num1, al
    mov cx, 10 ; Number of elements in the array
    lea si, arr ; Load the address of the array into SI

    checkNum1:
    cmp al, [si] ; Compare current element with num1
    je num1Found ; Jump if equal (num1 is found)
    inc si       ; Increment the array index
    loop checkNum1

    num1Found:
    mov dx, offset foundMsg ; Load the offset of "FOUND" message into DX
    mov ah, 09h ; Function to print string
    int 21h



    ; Take input for num2
    mov dx, offset msg2
    mov ah, 09h
    int 21h
    mov ah, 01h ; Function to read character
    int 21h     ; Read character from standard input
    sub al, 30h ; Convert ASCII to binary
    mov num2, al


    
    

    ; Check if num2 is in the array
    mov cx, 10 ; Number of elements in the array
    lea si, arr ; Load the address of the array into SI
    xor bl,bl
    mov bl, num2 ; Load num2 into BL

    checkNum2:
    cmp bl, [si] ; Compare current element with num2
    je num2Found ; Jump if equal (num2 is found)
    inc si       ; Increment the array index
    loop checkNum2

    ; If execution reaches here, both numbers are not found
    mov dx, offset notFoundMsg ; Load the offset of "NOT FOUND" message into DX
    mov ah, 09h ; Function to print string
    int 21h
    jmp endProgram

    

    num2Found:
    mov dx, offset foundMsg ; Load the offset of "FOUND" message into DX
    mov ah, 09h ; Function to print string
    int 21h
    
    
    endProgram:
    mov ah, 4ch ; Exit program
    int 21h
main endp
end main