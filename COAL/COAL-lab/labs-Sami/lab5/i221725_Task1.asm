;code to compare two numbers
.model small
.stack 100h
.data
msg1 db 10,13, "Enter First number: $"
msg2 db 10,13, "Enter Second number: $"
msg3 db 10,13, "Numbers are equal $"
msg4 db 10,13, "Numbers are not equal $"
.code
main proc
    mov ax, @data
    mov ds, ax
    ; Display message to enter the first number
    mov dx, offset msg1
    mov ah, 09h
    int 21h
    ; Read the first number
    mov ah, 01h      ; Function to read a character from STDIN
    int 21h          ; Call DOS interrupt
    sub al, 30h      ; Convert ASCII to numeric value
    mov cl, al       ; Store the first number
    ; Display message to enter the second number
    mov dx, offset msg2
    mov ah, 09h
    int 21h
    ; Read the second number
    mov ah, 01h      ; Function to read a character from STDIN
    int 21h          ; Call DOS interrupt
    sub al, 30h      ; Convert ASCII to numeric value
    mov dl, al       ; Store the second number
    ; Compare the two numbers
    cmp dl, cl
    je equal        ; If equal, jump to label1
    ; If not equal, print the message
    mov dx, offset msg4
    mov ah, 09h
    int 21h
    jmp end_prog
equal:
    ; If equal, print the message
    mov dx, offset msg3
    mov ah, 09h
    int 21h
end_prog:
;end_prog: This is the end of the program. It terminates the program using DOS interrupt 4Ch.
    mov ah, 4ch
    int 21h
main endp
end main