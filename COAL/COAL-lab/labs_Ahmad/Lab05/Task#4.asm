.model small
.stack 100h
.data
    var01 db 'N','B','V','G','Y','F','X','P','Z','R','W','U','C','I','Q','J','H','T','O','A','K','L','S','D','E','M'
.code
main proc 
    mov ax, @data
    mov ds, ax 

    
    mov cx, 26  
    mov si, offset var01

print_loop:
    mov dl, [si]  
    mov ah, 02h  
    int 21h     

    inc si        
    loop print_loop 

    mov ax, 4c00h
    int 21h
main endp
end main
