.model small
stack 100h
.data
    grid db 49 dup(?)
    randomNumber db 0 
    ENDL db 13,10,"$" ; New line character
    TAB db 10,13, "  $"
    count db 0
    delayCount dw 0
.code

; delay before generating a random number
delayFunction proc
delayLoop:
inc delayCount
cmp delayCount, 45000
jne delayLoop
ret
delayFunction endp

; random function to generate random number
randomFunction proc 
    mov count, 0 ; cleaing out cx register 
    mov count, 49     ; Initialize loop counter to 49, the number of iterations
    mov si, offset grid
L1:
    call delayFunction
    mov ah, 0h     ; Interrupt to get system time 
    int 1ah        ; Number of clock ticks saved in DX
    mov ax, dx     ; Save the number of clock ticks in AX
    xor dx, dx     ; Clear DX
    mov bx, 4      ; Generate numbers between 0 and 4
    div bx         ; AX = DX:AX / BX, DX = remainder
   
    add dl, '0'           ; Convert to ASCII
    mov bl, dl
    mov [si], bl
    
    inc si
    dec count
    cmp count, 0
    jne L1              ; Jump to L1 if CX is not zero

    ret                   ; Return from the procedure

randomFunction endp




DisplayGrid proc
    mov count, 49          ; Set loop counter to 49, the size of the grid
    mov si, OFFSET grid  ; Set SI to point to the beginning of the grid
    mov bl, 0            ; Initialize counter for characters printed in each row

L3:
    ; Print the current cell value
    mov al, [si]    ; Load the current cell value into AL
    mov dl, al
    ;add dl, 48     ; Convert the value to ASCII
    mov ah, 02h     ; AH = 02h for character output
    int 21h         ; Print the character
    mov ah, 02h     ; prints a tab
    mov dl, ' '
    int 21h
    ; Increment counter
    inc bl

    ; Check if it's the end of the row
    cmp bl, 7
    jne NotEndOfRow

    ; End of row reached, print newline
    mov dl, 13      ; ASCII code for Carriage Return
    mov ah, 02h     ; AH = 02h for character output
    int 21h

    mov dl, 10      ; ASCII code for Line Feed
    int 21h

    ; Reset counter
    mov bl, 0

    NotEndOfRow:
    
    inc si          ; Move to the next cell in the grid
    ; Check if it's the end of the grid
    cmp si, 49
    je exit
    dec count
    cmp count, 0
    jne L3
    exit:

    ret             ; Return from the procedure
DisplayGrid endp



; main function
main proc
mov ax, @data
mov ds, ax
call randomFunction

call DisplayGrid

mov ah, 02h
mov dl, ' '
int 21h

mov ah, 02h
mov dl, 10
int 21h
mov dl, 13

main endp

end main