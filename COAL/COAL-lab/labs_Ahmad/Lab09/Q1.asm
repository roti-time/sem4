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

mov cx, 600 ; column 0 to 639

mov dx, 150 ; row 0 to 199

int 10h

mov ah, 4ch

int 21h

main endp

end main

