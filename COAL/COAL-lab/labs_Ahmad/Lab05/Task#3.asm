.model small
.stack 100h
.data
    var01 db 'l','t','x','k','w','s','i','q','d','y','g','n','z','m','b','e','h','u','a','r','c','v','p','j','f','o' 
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
