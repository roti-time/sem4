.dosseg
.model small

.stack 100h

.data

.code

main proc

mov dl ,'H'

mov ah,2

int 21h

mov dl,‘E'

mov ah,2

int 21h

mov dl,‘L'

mov ah,2

int 21h

mov dl,‘L'

mov ah,2

int 21h

mov dl,‘O'

mov ah,2

int 21h

mov dl,‘ '

mov ah,2

int 21h
mov dl,‘W'

mov ah,2

int 21h

mov dl,‘O'

mov ah,2

int 21h

mov dl,‘R'

mov ah,2

int 21h

mov dl,‘L'

mov ah,2

int 21h

mov dl,‘D'

mov ah,2

int 21h

mov ah,4ch

int 21h

main endp

end main
