; Ahmad Abdullah 
; i22-1609
; Q#5 part(a)

.model small
.stack 100h
.data
	msg1 db 'Enter: $'
.code  
	main proc 
		mov ax,@data
		mov ds,ax

		lea dx,msg1
		mov ah,09h
		int 21h

		mov ah,1
		int 21h
		sub al,'0'

		mov ah ,0
		mov cx ,ax
		mov dl,10
		mov ah,02
		int 21h

		mov bx ,cx
		loop1:
			loop2:
				mov dl,'*'
				mov ah,02
				int 21h
				loop loop2
			mov dl,10
			mov ah,02
			int 21h
			mov cx,bx
			dec bx
			loop loop1
		mov ah ,4ch
		int 21h
	main endp
end main

