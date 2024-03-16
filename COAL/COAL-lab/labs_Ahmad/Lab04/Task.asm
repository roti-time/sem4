dosseg
.model small
.stack 100h
.data
    array1 db 1,2,3,4
    array1Size = ($-array1)


    num db 3

.code
main proc
    mov ax, @data
    mov ds, ax

    ;offset
    mov si, OFFSET array1
    mov cl,array1Size

    ;loop
    l1:
        mov dl, [si]     ; Load the value at current index
        add dl, num    
        mov [si], dl     ; Store the updated value back in the array
        mov dl, [si]     ; Load the updated value          ; Print the updated value
        add si, 2        ; Move to the next odd index
    loop l1

    mov dl,array1[0]
    add dl,'0'
    mov ah,02
    int 21h
    mov dl,array1[1]
    add dl,'0'
    mov ah,02
    int 21h
    mov dl,array1[2]
    add dl,'0'
    mov ah,02
    int 21h
    mov dl,array1[3]
    add dl,'0'
    mov ah,02
    int 21h


    mov dl,10
    mov ah,02
    int 21h
    
    mov ah,4ch
    int 21h

main endp
end main