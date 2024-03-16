.model small
.stack 100h
.data
    array db 1, 2, 3, 4, 5
    sum db ?
.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 5 ; Number of elements in the array
    mov si, offset array ; Point SI to the array
    ; Clear AX to store the sum

sum_loop:
    add ax, [si] ; Add the current element to the sum
    inc si ; Move to the next element (2 bytes for each element)

    loop sum_loop ; Repeat the loop for the remaining elements

AAM
mov ch,ah
mov cl,al

mov dl,ch
add dl, 48
mov ah,2
int 21h
mov dl,cl
add dl, 48
mov ah, 2
int 21h
main endp
end main