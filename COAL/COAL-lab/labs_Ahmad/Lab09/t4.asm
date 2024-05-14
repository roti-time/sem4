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
int 10h


L1:
    dec cx
    int 10h
    cmp cx, 97
    jg L1 ; continue if CX > 97 (column < 97)

L2:
    inc dx
    int 10h
    cmp dx, 18
    jl L1 ; continue if DX   <= 18 (row < 18)

L3:
    dec cx
    int 10h
    cmp cx, 94
    jg L3 ; continue if CX > 97 (column < 97)

L4:
    inc dx
    int 10h
    cmp dx, 21
    jl L4 ; continue if DX   <= 18 (row < 18)

L5:
    dec cx
    int 10h
    cmp cx, 91
    jg L5 ; continue if CX > 97 (column < 97)

L6:
    inc dx
    int 10h
    cmp dx, 24
    jl L6 ; continue if DX   <= 18 (row < 18)

L7:
    dec cx
    int 10h
    cmp cx, 89
    jg L7 ; continue if CX > 97 (column < 97)

L8:
    inc dx
    int 10h
    cmp dx, 27
    jl L8 ; continue if DX   <= 18 (row < 18)



L1_2:
    inc cx
    int 10h
    cmp cx, 91
    jl L1_2 ; continue if CX > 97 (column < 97)

L2_2:
    inc dx
    int 10h
    cmp dx, 30
    jl L1_2 ; continue if DX   <= 18 (row < 18)

L3_2:
    inc cx
    int 10h
    cmp cx, 94
    jl L3_2 ; continue if CX > 97 (column < 97)

L4_2:
    inc dx
    int 10h
    cmp dx, 33
    jl L4_2 ; continue if DX   <= 18 (row < 18)

L5_2:
    inc cx
    int 10h
    cmp cx,97
    jl L5_2 ; continue if CX > 97 (column < 97)

L6_2:
    inc dx
    int 10h
    cmp dx, 36
    jl L6_2 ; continue if DX   <= 18 (row < 18)

L7_2:
    inc cx
    int 10h
    cmp cx, 100
    jl L7_2 ; continue if CX > 97 (column < 97)

L8_2:
    inc dx
    int 10h
    cmp dx, 39
    jl L8_2 ; continue if DX   <= 18 (row < 18)


mov cx, 100 ; column 0 to 639
mov dx, 15 ; row 0 to 199
int 10h
L1_1:
    inc cx
    int 10h
    cmp cx, 103
    jl L1_1 ; continue if CX > 97 (column < 97)

L2_1:
    inc dx
    int 10h
    cmp dx, 18
    jl L1_1 ; continue if DX   <= 18 (row < 18)

L3_1:
    inc cx
    int 10h
    cmp cx, 106
    jl L3_1 ; continue if CX > 97 (column < 97)

L4_1:
    inc dx
    int 10h
    cmp dx, 21
    jl L4_1 ; continue if DX   <= 18 (row < 18)

L5_1:
    inc cx
    int 10h
    cmp cx, 109
    jl L5_1 ; continue if CX > 97 (column < 97)

L6_1:
    inc dx
    int 10h
    cmp dx, 24
    jl L6_1 ; continue if DX   <= 18 (row < 18)

L7_1:
    inc cx
    int 10h
    cmp cx, 112
    jl L7_1 ; continue if CX > 97 (column < 97)

L8_1:
    inc dx
    int 10h
    cmp dx, 27
    jl L8_1 ; continue if DX   <= 18 (row < 18)


L1_3:
    dec cx
    int 10h
    cmp cx, 109
    jg L1_3 ; continue if CX > 97 (column < 97)

L2_3:
    inc dx
    int 10h
    cmp dx, 30
    jl L1_3 ; continue if DX   <= 18 (row < 18)

L3_3:
    dec cx
    int 10h
    cmp cx, 106
    jg L3_3 ; continue if CX > 97 (column < 97)

L4_3:
    inc dx
    int 10h
    cmp dx, 33
    jl L4_3 ; continue if DX   <= 18 (row < 18)

L5_3:
    dec cx
    int 10h
    cmp cx, 103
    jg L5_3 ; continue if CX > 97 (column < 97)

L6_3:
    inc dx
    int 10h
    cmp dx, 36
    jl L6_3 ; continue if DX   <= 18 (row < 18)

L7_3:
    dec cx
    int 10h
    cmp cx, 100
    jg L7_3 ; continue if CX > 97 (column < 97)

L8_3:
    inc dx
    int 10h
    cmp dx, 39
    jl L8_3 ; continue if DX   <= 18 (row < 18)

mov ah,4ch
int 21h

main endp

end main


;mov cx,99
;mov dx, 16
;int 10h

;mov cx,98
;mov dx,16
;int 10h;

;mov cx, 97
;mov dx,16
;int 10h

;mov cx, 96
;mov dx,16
;int 10h

;mov cx, 95
;mov dx,16
;int 10h

;mov cx, 94
;mov dx, 17
;int 10h

;mov cx, 94
;mov dx, 18
;int 10h

;mov cx, 94
;mov dx, 19
;int 10h