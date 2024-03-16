.model small
.stack 100h
.data
    var01 db 1,3,5,9,0,2,4,6,7,8 
.code
main proc 
    mov ax, @data
    mov ds, ax  

    mov cx, 10 
    mov si, offset var01 

print_loop:
    mov dl, [si] 
    add dl, '0'  
    mov ah, 02h   
    int 21h      

    inc si       
    loop print_loop 

    mov ax, 4c00h
    int 21h
main endp
end main
