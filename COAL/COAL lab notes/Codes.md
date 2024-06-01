## To compare two numbers

```
.model small  
.stack 100h  
.data  
msg1 db 10,13, "Enter First number: $"  
msg2 db 10,13, "Enter Second number: $"  
msg3 db 10,13, "Numbers are equal $"  
msg4 db 10,13, "Numbers are not equal $"  
.code  
main proc  
    mov ax, @data  
    mov ds, ax  
    ; Display message to enter the first number  
    mov dx, offset msg1  
    mov ah, 09h  
    int 21h  
    ; Read the first number  
    mov ah, 01h      ; Function to read a character from STDIN  
    int 21h          ; Call DOS interrupt  
    sub al, 30h      ; Convert ASCII to numeric value  
    mov cl, al       ; Store the first number  
    ; Display message to enter the second number  
    mov dx, offset msg2  
    mov ah, 09h  
    int 21h  
    ; Read the second number  
    mov ah, 01h      ; Function to read a character from STDIN  
    int 21h          ; Call DOS interrupt  
    sub al, 30h      ; Convert ASCII to numeric value  
    mov dl, al       ; Store the second number  
    ; Compare the two numbers  
    cmp dl, cl  
    je equal        ; If equal, jump to label1  
    ; If not equal, print the message  
    mov dx, offset msg4  
    mov ah, 09h  
    int 21h  
    jmp end_prog  
equal:  
    ; If equal, print the message  
    mov dx, offset msg3  
    mov ah, 09h  
    int 21h  
end_prog:  
;end_prog: This is the end of the program. It terminates the program using DOS interrupt 4Ch.  
    mov ah, 4ch  
    int 21h  
main endp  
end main
```

## Sort an array in ascending or descending order

```
model small  
.stack 100h  
.data  
    msg1 db 10,13, "Please entre the array for sorting:$"      
    msg2 db 10,13, "Sorted array is:$"  
    array db  5 dup(?)  
.code  
  
main proc  
mov ax, @data  
mov ds, ax  
  
;to display the message  
mov dx, offset msg1  
mov ah, 09h  
int 21h  
  
;general register for loop  
mov cx, 5  
mov bx, offset array  
  
mov ah,1  
  
;loop to take 5 numbers from the user  
takeinput:  
int 21h  
mov [bx], al  
inc bx  
loop takeinput  
  
mov cx, 5  
dec cx  
  
  
outerloop:  
mov bx, cx  
mov si, 0  
  
;this loop used to compare the values  
compareloop:  
mov al, array[si]  
mov dl, array[si+1]  
cmp al, dl  
  
;jnc -> jump no carry is used for descending order  
;jnc noswap  
  
jc noswap  
; jc -> jump carry  
  
mov array[si], dl  
mov array[si+1], al  
  
noswap:  
  
;if carry is 1 so no swaping its mean value in [si] is already smaller  
  
inc si  
dec bx  
; no si value is inc from 0 to 1 and bx is decremented by 1 which is 4  
jnz compareloop  
  
loop outerloop  
  
  
;new line  
  
mov ah, 2  
mov dl,10  
int 21h  
mov dl, 13  
int 21h  
  
;print after sorting array  
  
mov cx, 5  
mov bx, offset array  
  
;loop to display the array element on screen  
  
;to display the message  
mov dx, offset msg2  
mov ah, 09h  
int 21h  
  
;this loop is used to display the value on the screen  
loopforoutput:  
mov dl, [bx]  
mov ah, 2  
int 21h  
  
;used these lines to add the space between the numbers  
mov dl, 32  
mov ah, 2  
int 21h  
  
inc bx  
loop loopforoutput  
  
  
mov ah, 4ch  
int 21h  
  
main endp  
end main
```


## Code for sum of squares

```
.model small  
  
.stack 100h  
  
.data  
msg db "The sum of sqaue is : $"  
var1 dw 2  
var2 dw 3  
var3 dw 4  
  
result dw ?  
  
.code  
  
square proc  
mov ax,var1  
mov bx,var1  
mul bx  
mov cx,ax  
  
mov ax,var2  
mov bx,var2  
mul bx  
  
add cx,ax  
mov ax,cx  
mov bl,10  ; to get correct answer  
div bl  
mov cl,ah  
mov ch,al  
mov ax,var3  
mov bx,var3  
mul bx  
AAM  
add cx,ax  
AAA  
  
  
  
PUSH cx  
POP cx  
  
  
  
ret  
  
square endp  
  
main proc  
  
mov ax, @data  
  
mov ds, ax  
  
mov dx,OFFSET msg  
mov ah,09  
int 21h  
  
  
  
  
call square  
  
mov result,cx  
  
;display the result  
 ; Display the result using AAM  
    mov dl, ch       ; Move the tens place to DL  
    add dl, '0'      ; Convert to ASCII  
    mov ah, 02h      ; Print character function  
    int 21h  
  
    mov dl, cl       ; Move the ones place to DL  
    add dl, '0'      ; Convert to ASCII  
    mov ah, 02h      ; Print character function  
    int 21h  
  
mov ah,4ch  
  
int 21h  
  
main endp  
  
end main
```


## Uppercase to Lowercase

```
.MODEL SMALL

.STACK 100H

.DATA

.CODE

MAIN PROC

MOV AH,1

INT 21h

mov dl,al

add dl,32

mov ah,2

int 21h

MOV AH,4CH

INT 21h

MAIN ENDP

END MAIN

```


## Division

```
.model small
.stack 10h
.data

q db ?
r db ?

.code
Main proc
mov ax,26
mov bl, 5
div bl
mov q, al
mov r, ah
mov dl, q
add dl, 48
mov ah, 2
int 21h

mov dl, r
add dl, 48
mov ah, 2
int 21h

mov ah, 4ch
int 21h
main endp
end main
```


## Array Printing
```
dosseg

.model small

.stack 100h

.data

array db 'a','b','c','e','f','g'

.code

main proc

mov ax, @data

mov ds, ax

mov si, offset array

mov cx, 6

; loop

l1:

mov dx, [si]

mov ah,2

int 21h

;mov dx, [si+1]

inc si

loop l1

mov ah, 4ch

int 21h

main endp

end main
```


## Stack code
```
dosseg

.model small

.stack 100h

.data

.code

main proc

mov AX, 2

PUSH AX

POP AX

mov DX, AX

mov ah, 2

int 21h

mov ah, 4ch

int 21h

main endp

end main
```

## Newline Procedure
```
.model small

.stack 100h

.data

msg1 db "Please entre the Message1:$"

msg2 db "Please entre the Message2:$"

msg3 db "Please entre the Message3:$"

.code

Newline proc

mov dx, 10

mov ah,2

int 21h

mov dx,13

mov ah,2

int 21h

ret 2

Newline endp

main proc

mov ax, @data

mov ds, ax

mov dx, offset msg1

mov ah,9

int 21h

call Newline

mov dx, offset msg2

mov ah,9

int 21h

call Newline

mov dx, offset msg3

mov ah,9

int 21h

call Newline

mov ah,4ch

int 21h

main endp

end main
```

## String reverse using stack

```
.model small
.stack 100h
.data

arr1 db 0, 1, 2, 3,4
arr2 db 5 dup(?)

.code

reverse proc
	
	push bp
	mov bp,sp
	add bp,4
	mov si,[bp]
	add si,sizeof arr1
	sub si,1
	mov di,offset arr2
	mov cx,5
	
	l1:
		mov al,[si]
		mov [di],al
		add di,1
		sub si,1
		loop l1
	
	pop bp
	ret 2
	reverse endp

main proc
	mov ax, @data
	mov ds, ax
	
	mov si,OFFSET arr1
	push si
	
	call reverse
	
	mov si,OFFSET arr2
	mov cx,5
	
	l2:
		mov dl,[si]
		add dl,30h
		mov ah,02h
		int 21h
		
		add si,1
		loop l2
	
	mov ah,4ch
	int 21h
	main endp
	end main

```

## Pixel Printing

```
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
```
