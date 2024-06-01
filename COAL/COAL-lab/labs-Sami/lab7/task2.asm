.model small
.stack 100h
.data
    num1   dw 0
    num2   dw 0
    num3   dw 0
    result dw 0

.code
main proc
                   mov  ax, @data
                   mov  ds, ax

    ; Input numbers
                   mov  ax, 1
                   mov  num1, ax

                   mov  ax, 1
                   mov  num2, ax

                   mov  ax, 2
                   mov  num3, ax

    ; Call procedure to calculate sum of squares
                   push num3
                   push num2
                   push num1
                   call sum_of_squares

    ; Retrieve result
                   mov  ax, result
                   mov  ax, result
                   mov  dx, ax
                   add  dl,'0'
                   mov  ah,02h
                   int  21h
             


                   mov  ax, 4c00h
                   int  21h
main endp

sum_of_squares proc
                   push bp
                   mov  bp, sp

                   mov  ax, [bp+4]
                   mul  ax
                   Mov  result, ax
                   Mov  ax, [bp+6]
                   Mul  ax
                   Add  result, ax
                   Mov  ax, [bp+8]
                   Mul  ax
                   Add  result ,ax
     

                   pop  bp
                   ret  6
sum_of_squares endp

End main