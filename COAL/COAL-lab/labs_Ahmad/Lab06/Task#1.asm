model small
.stack 100h
.data
    arr db 5 dup(?)
    msg1 db 10,13,"Enter 5 Numbers in Array:$"
    msg2 db 10,13,"After Sorting Array:$"
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Print "Enter 5 Numbers in Array:"
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    mov cx, 5
    lea bx, arr

inputs:
    mov ah, 01h
    int 21h
    mov [bx], al
    inc bx
    loop inputs

    mov cx, 5

OuterLoop:
    mov bx, cx
    xor si, si

CompLoop:
    mov al, [arr+si]
    mov dl, [arr+si-1]

    cmp si, 0
    je noSwap   ; Jump if equal (si == 0)

    cmp al, dl
    jnc noSwap  ; Jump if not carry (al >= dl)

    xchg al, dl
    mov [arr+si], al
    mov [arr+si-1], dl

noSwap:
    inc si
    dec bx
    jnz CompLoop

    loop OuterLoop

    ; Print "After Sorting Array:"
    mov dx, offset msg2
    mov ah, 09h
    int 21h

    mov cx, 5
    lea bx, arr

Outputs:
    mov dl, [bx]
    mov ah, 02h
    int 21h
    mov dl, ' '
    int 21h
    inc bx
    loop Outputs

    mov ah, 4ch
    int 21h
main endp
end main