;display a pixel

;for video mode

dosseg

.model small

.stack 100h

.data

.code

main proc

;set graphic mode

mov ah, 0h ;set video mode

mov al, 6h ; resolution 200*640 B\W graphics

int 10h

;accessing and displaying pixel

mov ah, 0ch

mov al, 0fh ; white color

mov cx, 100 ; column 0 to 639
mov dx, 15 ; row 0 to 199
L1:
    int 10h
    inc dx ; next line
    dec cx ; decrement column counter
    cmp cx, 0
    jg L1 
    cmp  dx, 199
    jl L1

mov cx, 100 ; column 0 to 639
mov dx, 15 ; row 0 to 199
L2:
    int 10h
    inc dx
    inc cx
    cmp dx, 199
    jg L2
    cmp cx, 200
    jl L2
   

L3:
    int 10h
    dec cx
    loop L3


int 10h

mov ah, 4ch

int 21h

main endp

end main