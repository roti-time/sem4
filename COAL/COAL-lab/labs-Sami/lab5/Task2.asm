.model small
.stack 100h
.data
array1 db 10 dup(?),0
val1 db 0
.code
main proc
    mov ax, @data
    mov ds, ax
    mov si, 0
    mov cx,10
loop1:
mov al,val1
add al,048d
mov array1[si], al
inc val1
inc si
int 21h
loop loop1

mov si, offset array1
mov cx, 10



; loop
l1:
mov dx, [si]
;add dx, 30h
mov ah,2
int 21h
;mov dx, [si+1]
inc si
loop l1

mov ah, 4ch
int 21h
main endp
end main