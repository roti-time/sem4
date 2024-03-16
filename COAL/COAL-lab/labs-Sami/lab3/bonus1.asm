.model small
.stack 100H

.data
    myString DB 'Hello, World!', '$'
    stringLength DW ?
    stringSize DW ?
    stringType DB ?

.code
main proc
   

    ; Calculate string size
    mov ax, OFFSET myString
    sub ax, esi
    mov stringSize, ax

    ; Store string type
    mov stringType, BYTE PTR 0 ; Assuming ASCII character set

    ; Display the variables
    mov ah, 02h
    mov dl, stringLength
    add dl, 30h
    int 21h

    mov dl, stringSize
    add dl, 30h
    int 21h

    mov dl, stringType
    add dl, 30h
    int 21h

    mov ah, 4ch
    int 21h
main endp
end main