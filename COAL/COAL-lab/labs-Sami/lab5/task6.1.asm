.model small
.stack 100h
.data
    array1 db 1, 2, 3, 4, 5, 6
    even_char db 'e'
.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 6
    mov si, 0

loop1:
    test byte ptr array1[si], 01b
    jnz odd_l

    mov byte ptr array1[si], 'e'
    jmp next_element

odd_l:
    mov byte ptr array1[si], 'o'

next_element:
    inc si
    loop loop1

    ; Print the result
    mov cx, 6
    mov si, offset array1

print_loop:
    mov dl, [si]

    mov ah, 02h
    int 21h

    inc si
    loop print_loop

    mov ah, 4ch
    int 21h
main endp
end main