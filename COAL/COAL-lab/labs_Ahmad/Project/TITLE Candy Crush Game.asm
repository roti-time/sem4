.model small
.stack 100h

;First of all, a title page should appear that displays the name of the game. It 
;must also take the name of the user and name is to be display on the screen.

.data
    titlemsg1 db "  ____                _          ____                _     $"
    titlemsg2 db " / ___|__ _ _ __   __| |_   _   / ___|_ __ _   _ ___| |__  $"
    titlemsg3 db "| |   / _` | '_ \ / _` | | | | | |   | '__| | | / __| '_ \ $"
    titlemsg4 db "| |__| (_| | | | | (_| | |_| | | |___| |  | |_| \__ \ | | |$"
    titlemsg5 db " \____\__,_|_| |_|\__,_|\__, |  \____|_|   \__,_|___/_| |_|$"
    titlemsg6 db "                        |___/                              $"

    rulesmsg1 db " ___   _   _   _      ___   ___ $"
    rulesmsg2 db "| _ \ | | | | | |    | __| / __|$"
    rulesmsg3 db "|   / | |_| | | |__  | _|  \__ \$"
    rulesmsg4 db "|_|_\  \___/  |____| |___| |___/$"

gOmsg1         db"_____                         ____                          $"
gOmsg2  db    "  / ____|                       / __ \                         $"
gOmsg3     db " | |  __  __ _ _ __ ___   ___  | |  | |_   _____ _ __          $"
gOmsg4     db " | | |_ |/ _` | '_ ` _ \ / _ \ | |  | \ \ / / _ \ '__|         $"
gOmsg5     db " | |__| | (_| | | | | | |  __/ | |__| |\ V /  __/ |            $"
gOmsg6     db "  \_____|\__,_|_| |_| |_|\___|  \____/  \_/ \___|_|            $"
gOmsg7     db "                                                               $"

restart db "RETRY? (y/n): $"

msg3 db 10,13, "Player Name?  $"
userName db 20 dup (?) ; Buffer to store user's name
ENDL db 13,10,"$" ; New line character
moves db "Moves: $"
gameovermsg db "GAME OVER"
exitmsg2 db 10,13, "Thank You For Playing!$"


;After the title page, the game should display the rules of the game. 
;The rules should be displayed in a separate window. 


; Display the rules of the game
                ;"INTRUCTION TO PLAY THE GAME$"
                ;Candy Crush Rules 
                msg4 db 10,13, "1. The game is played on a grid filled with different colored candies.$"
                msg5 db 10,13, "2. The player swaps candies to create a match of three or more candies of the same color.$"
                msg6 db 10,13, "3. When a match is made, the matched candies disappear and new candies fall into the board.$"
                msg7 db 10,13, "4. The player must match three or more candies of the same color to score points.$"
                msg8 db 10,13, "5. The player must score a certain number of points to advance to the next level.$"
                ;we will clear the screen before and after displaying the rules
                ContMsg db 10,13, "Press any key to continue: $"
                ExitMsg db 10,13, "Press any key to exit$"
            

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Make a procedure to first clear screen and then output game name
    call Cls
    call displayGame
    call askUser
    ;call displayUserName
    call Instructions
    call GameOver  ;both this and retry may be used somewhere else but for now putting here
    call retry

    mov ah,4ch
    int 21h
main endp 

;code to clear screen (chat used)
cls proc
    mov ah, 06h
    mov al, 0
    mov bh, 07h ; Text attribute (default color)
    mov cx, 0
    mov dx, 184fh ; Upper-left corner coordinates
    int 10h
    ret 
cls endp

;procedure to output game name
displayGame proc

    mov ah, 02h
    mov bh, 0
    mov dh, 4 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset titlemsg1
    mov ah, 09
    int 21h
    
    ;titlemsg2 
    mov ah, 02h
    mov bh, 0
    mov dh, 5 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset titlemsg2
    mov ah, 09
    int 21h

    ;titlemsg3
    mov ah, 02h
    mov bh, 0
    mov dh, 6 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset titlemsg3
    mov ah, 09
    int 21h

    ;titlemsg4
    mov ah, 02h
    mov bh, 0
    mov dh, 7 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset titlemsg4
    mov ah, 09
    int 21h

    ;titlemsg5
    mov ah, 02h
    mov bh, 0
    mov dh, 8 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset titlemsg5
    mov ah, 09
    int 21h

    ;titlemsg6
    mov ah, 02h
    mov bh, 0
    mov dh, 9 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset titlemsg6
    mov ah, 09
    int 21h
    ret 
displayGame endp

;procedure to ask user for input
askUser proc

    call NextLine
    call NextLine 
    call NextLine

    mov dx, offset msg3 
    mov ah, 09
    int 21h

    mov si, offset userName 
inputLoop:
    mov ah, 01h 
    int 21h      
    cmp al, 0Dh ; Check if Enter key is pressed
    je doneInput ; If Enter key is pressed, exit the loop
    mov [si], al 
    inc si      
    jmp inputLoop 

doneInput:
    mov byte ptr [si], 0 ; Null-terminate the string in the buffer
    ret
askUser endp

;display the name entered by the user
displayUserName proc
    mov si, offset userName ; Initialize SI to point to the start of userName buffer
printLoop:
    mov al, [si] ; Load the character from memory pointed by SI into AL
    cmp al, 0 ; Check if it's the null terminator
    je donePrinting ; If it's the null terminator, exit the loop
    mov ah, 0Eh ; Function to print character
    int 10h ; BIOS interrupt to print character
    inc si ; Move to the next character
    jmp printLoop ; Repeat until null terminator is found

donePrinting:
    ret
displayUserName endp

Instructions proc
    call Cls

    ;rulesmsg1
    mov ah, 02h
    mov bh, 0
    mov dh, 4 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov ah, 09h
    lea dx, rulesmsg1
    int 21h

    ;rulesmsg2
    mov ah, 02h
    mov bh, 0
    mov dh, 5 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov ah, 09h
    lea dx, rulesmsg2
    int 21h

    ;rulesmsg3
    mov ah, 02h
    mov bh, 0
    mov dh, 6 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov ah, 09h
    lea dx, rulesmsg3
    int 21h

    ;rulesmsg4
     mov ah, 02h
    mov bh, 0
    mov dh, 7 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov ah, 09h
    lea dx, rulesmsg4
    int 21h

    call NextLine
    call NextLine
    call NextLine
    call NextLine

    lea dx, msg4
    mov ah,09h
    int 21h 
    call NextLine

    lea dx, msg5
    mov ah,09h
    int 21h
    call NextLine

    lea dx, msg6
    mov ah,09h
    int 21h
    call NextLine

    lea dx, msg7
    mov ah,09h
    int 21h
    call NextLine

    lea dx, msg8
    mov ah,09h
    int 21h
    call NextLine

    lea dx, ContMsg
    mov ah, 09h
    int 21h

    call WaitForKeypress   

    lea dx, ExitMsg
    mov ah, 09h
    int 21h
    ret
Instructions endp


NextLine proc
    mov dx, offset ENDL
    mov ah, 09h
    int 21h
    ret
NextLine endp

WaitForKeypress proc
    mov ah, 00h                                                                         
    int 16h          
    ret              
WaitForKeypress endp

GameOver proc

    call Cls

    mov ah, 02h
    mov bh, 0
    mov dh, 5 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset gOmsg1
    mov ah, 09
    int 21h
    
    ;game over msg2 
    mov ah, 02h
    mov bh, 0
    mov dh, 5 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset gOmsg2
    mov ah, 09
    int 21h

    ;game over msg3
    mov ah, 02h
    mov bh, 0
    mov dh, 6 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset gOmsg3
    mov ah, 09
    int 21h

    ;game over msg4
    mov ah, 02h
    mov bh, 0
    mov dh, 7 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset gOmsg4
    mov ah, 09
    int 21h

    ;game over msg5
    mov ah, 02h
    mov bh, 0
    mov dh, 8 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset gOmsg5
    mov ah, 09
    int 21h

    ;game over msg6
    mov ah, 02h
    mov bh, 0
    mov dh, 9 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset gOmsg6
    mov ah, 09
    int 21h

    mov ah, 02h
    mov bh, 0
    mov dh, 10 ;Row Number 
    mov dl, 10 ;Column Number 
    int 10h

    mov dx, offset gOmsg7
    mov ah, 09
    int 21h

    call NextLine
    call NextLine
    ret 
GameOver endp

retry proc
mov dx, offset restart
mov ah,9
int 21h

mov ah,1
int 21h

cmp al, 'y'
mov ah, 00h                                                                         
int 16h  
je wannaPlay
jne notWannaPlay

wannaPlay:
call Instructions
ret

notWannaPlay:
mov dx, offset exitmsg2
mov ah,9
int 21h

mov ah,4Ch
int 21h

retry endp

end main
