.model small
.stack 100h
.data 
    var01 db 1,1,1,1,1
.code
main proc 
    mov ax, @data
    mov ds, ax

    mov cx, 5           
    mov si, offset var01 
    mov al, 0           

l1:
    add al, [si]        
    inc si              
    loop l1 
    add al,30h            

    mov dl, al         

    mov ah, 02h        
    int 21h             

    mov ax, 4c00h
    int 21h
main endp
end main
