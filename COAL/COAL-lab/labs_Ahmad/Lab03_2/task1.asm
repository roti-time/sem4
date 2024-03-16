.model small
.stack 100h
.data
var1 db ?
var2 db ?
result db ?
.code
main proc 
mov ax,@data
mov al,01
int 21h
mov dl,al
sub dl,48
mov var1,dl

mov al,01
int 21h
mov var2,al 
mov bl,var2
add bl,var1
mov result,bl
mov dl,result
;add dl,48
mov ah,2
int 21h

mov ah,4ch

main endp
end main 


