.model small
.stack 100h
.data
 arr1 db 1,2,3,4,5,6
 msg1 db 10,13,"Enter a number:$"
 msg2 db 10,13,"Number found$"
 msg3 db 10,13,"Number not found$"
 msg4 db 10,13,"Count: $"
 msg5 db 10,13,"Max number: $"
 msg6 db 10,13,"Min number: $"
.code
Main proc
 mov ax, @data
 mov ds, ax
 mov dx, offset msg1
 mov ah, 09h
 int 21h
 call Getnumber

 mov dx, offset msg4
 mov ah, 09h
 int 21h

 call getCount

 mov dx, offset msg5
 mov ah, 09h
 int 21h
 call getMax

 mov dx, offset msg6
 mov ah, 09h
 int 21h
 call getMin
 mov ah, 4ch
 int 21h
Main endp
Getnumber proc
 mov ah, 01h
 int 21h
 sub al, '0' 
 mov cx, 6
 mov si, offset arr1
Find:
 cmp al, [si]
 je Found
 
 inc si
 loop Find
 
 jmp NotFound
Found:
 mov dx, offset msg2
 mov ah, 09h
 int 21h
 jmp end_p
NotFound:
 mov dx, offset msg3
 mov ah, 09h
 int 21h
end_p:
 ret
Getnumber endp
getCount proc
 mov cx, 6
 mov si, offset arr1
 mov bl, 0 
CountLoop:
 cmp al, [si]
 je IncrementCounter
 
 inc si
 loop CountLoop
 

 mov ah, 02h 
 add bl, '0' 
 mov dl, bl
 int 21h
 ret
IncrementCounter:
 inc bl
 inc si
 loop CountLoop
 ret
getCount endp
getMax proc
 mov cx, 5 
 mov si, offset arr1
 mov dl, [si] 
MaxLoop:
 inc si
 cmp dl, [si]
 jge NotMax
 mov dl, [si]
NotMax:
 loop MaxLoop
 
 mov ah, 02h 
 add dl, '0' 
 int 21h
 ret
getMax endp
getMin proc
 mov cx, 5 
 mov si, offset arr1
 mov dl, [si]
MinLoop:
 inc si
 cmp dl, [si]
 jle NotMin
 mov dl, [si]
NotMin:
 loop MinLoop

 mov ah, 02h 
 add dl, '0' 
 int 21h
 ret
getMin endp
End main
