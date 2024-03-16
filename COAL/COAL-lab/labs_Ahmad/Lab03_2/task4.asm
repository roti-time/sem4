dosseg
.model small
.stack 100h
.data
    var1 db ?
    var2 db ?
    var3 db ?
    var4 db ?
.code
main proc
    mov ax,@data
    mov ds,ax
    
    
    mov ah,1
    int 21h
    sub al,48
    mov var1,al
    
    
    mov ah,1
    int 21h
    sub al,48
    mov var2,al
    

    mov al, var1  
    mov bl, var2   
    mov ah, 0      
    div bl         
    
   
    mov var3, al   
    mov var4, ah   
    

    mov dl, var3
    add dl, 48
    mov ah, 2
    int 21h
    
    mov dl, var4
    add dl, 48
    mov ah, 2
    int 21h
    
    mov ah, 4ch
    int 21h

main endp
end main
