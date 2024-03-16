.model small
.stack 100h
.data
    var0 db 6,9,3,6,7,2
    arr db 6 dup(?)
    newline db 0Dh, 0Ah, '$' 
.code
main proc 
    mov ax, @data
    mov ds, ax
    mov cx, 6

    lea si, var0
    lea di, arr
    call process_numbers 

    lea si, arr
    mov cx, 6
    call print_array      

    mov ah, 4ch
    int 21h
main endp


process_numbers proc
    mov cx, 6
    l1:
        mov al, [si]
        and al, 1
        jnz odd
        mov byte ptr [di], 'e' 
        jmp next
    odd:
        mov byte ptr [di], 'o' 
    next:
        inc di
        inc si
        loop l1
    ret
process_numbers endp


print_array proc
    l2:
        mov dl, [si]
        mov ah, 02h         
        int 21h            
        inc si              
        loop l2            
    mov dx, offset newline 
    mov ah, 09h            
    int 21h                
    ret
print_array endp

end main
