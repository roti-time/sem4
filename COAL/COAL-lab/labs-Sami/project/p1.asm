;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-------MACROS-----;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUSH_ALL MACRO 
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH DI
	PUSH SI
ENDM

POP_ALL MACRO
	POP SI
	POP DI
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

SHIFT MACRO reg,count,mode 
	PUSH BP
	PUSH DI
	MOV BP, count
	.WHILE BP>0
		MOV DI, mode
		.IF DI==1
			SHR reg,1
		.ELSEIF DI==2
			SHL reg,1
		.ENDIF
		DEC BP
	.ENDW
	POP DI
	POP BP
ENDM

GSHR MACRO reg, count
	SHIFT reg,count,1
ENDM

GSHL MACRO reg, count
	SHIFT reg,count,2
ENDM

DRAW_BOARD MACRO 
	;DRAW_RECT 10,10,350,175,07H
	;DRAW_RECT 10,10,1,175,0FH
	;DRAW_RECT 60,10,1,175,0FH
	;DRAW_RECT 110,10,1,175,0FH
	;DRAW_RECT 160,10,1,175,0FH
	;DRAW_RECT 210,10,1,175,0FH
	;DRAW_RECT 260,10,1,175,0FH
	;DRAW_RECT 310,10,1,175,0FH
	;DRAW_RECT 360,10,1,175,0FH
	;DRAW_RECT 10,10,350,1,0FH
	;DRAW_RECT 10,35,350,1,0FH
	;DRAW_RECT 10,60,350,1,0FH
	;DRAW_RECT 10,85,350,1,0FH
	;DRAW_RECT 10,110,350,1,0FH
	;DRAW_RECT 10,135,350,1,0FH
	;DRAW_RECT 10,160,350,1,0FH
	;DRAW_RECT 10,185,350,1,0FH
ENDM

DRAW_RECT MACRO x,y,xl,yl,color 
	PUSH_ALL
	PUSH BP
	SUB SP, 10
	MOV BP, SP
	MOV WORD PTR[BP+8], x
	MOV WORD PTR[BP+6], y
	MOV WORD PTR[BP+4], xl
	MOV WORD PTR[BP+2], yl
	MOV WORD PTR[BP+0], color
	CALL DRAW_RECT_FUNC
	POP BP
	POP_ALL
ENDM

DRAW_SELECT_BOX MACRO x,y
	PUSH_ALL
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-4],x
	MOV WORD PTR[BP-2],y
	MOV AX, WORD PTR[BP-4]
	MOV BX, 50
	MUL BX
	MOV CX, 10
	ADD CX, AX
			
	MOV AX, WORD PTR[BP-2]
	MOV BX, 25
	MUL BX
	MOV DX, 10
	ADD DX, AX

	DRAW_RECT CX, DX, 51,1,0H
	DRAW_RECT CX, DX, 1,26,0H
	ADD CX, 50
	DRAW_RECT CX, DX, 1,26,0H
	SUB CX, 50
	ADD DX, 25
	DRAW_RECT CX, DX, 51,1,0H
	
	ADD SP, 4
	POP BP
	POP_ALL
ENDM

DRAW_UNSELECT_BOX MACRO x,y
	PUSH_ALL
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-4],x
	MOV WORD PTR[BP-2],y
	MOV AX, WORD PTR[BP-4]
	MOV BX, 50
	MUL BX
	MOV CX, 10
	ADD CX, AX
			
	MOV AX, WORD PTR[BP-2]
	MOV BX, 25
	MUL BX
	MOV DX, 10
	ADD DX, AX

	DRAW_RECT CX, DX, 51,1,0FH
	DRAW_RECT CX, DX, 1,26,0FH
	ADD CX, 50
	DRAW_RECT CX, DX, 1,26,0FH
	SUB CX, 50
	ADD DX, 25
	DRAW_RECT CX, DX, 51,1,0FH
	
	ADD SP, 4
	POP BP
	POP_ALL
ENDM

DRAW_UNSELECT_ALL MACRO
	PUSH_ALL
	MOV AX, 7
	.REPEAT
		DEC AX
		MOV BX, 7
		.REPEAT
			DEC BX
			DRAW_UNSELECT_BOX AX,BX
		.UNTIL BX==0
	.UNTIL AX==0
	POP_ALL
ENDM

DRAW_BLOCK MACRO x,y
	PUSH_ALL
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-4],x
	MOV WORD PTR[BP-2],y
	MOV AX, WORD PTR[BP-4]
	MOV BX, 50
	MUL BX
	MOV CX, 11
	ADD CX, AX
			
	MOV AX, WORD PTR[BP-2]
	MOV BX, 25
	MUL BX
	MOV DX, 11
	ADD DX, AX

	DRAW_RECT CX, DX, 49,24,08H
	MOV AX, 12
	.WHILE AX>0
		DRAW_RECT CX, DX, 4,2,00H
		ADD CX, 4
		ADD DX, 2
		DEC AX
	.ENDW
	SUB CX, 48
	SUB DX, 2
	MOV AX, 12
	.WHILE AX>0
		DRAW_RECT CX, DX, 4,2,00H
		ADD CX, 4
		SUB DX, 2
		DEC AX
	.ENDW
	
	
	ADD SP, 4
	POP BP
	POP_ALL
ENDM 

CLEAR_BOX MACRO x,y
	PUSH_ALL
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-4],x
	MOV WORD PTR[BP-2],y
	MOV AX, WORD PTR[BP-4]
	MOV BX, 50
	MUL BX
	MOV CX, 12
	ADD CX, AX
			
	MOV AX, WORD PTR[BP-2]
	MOV BX, 25
	MUL BX
	MOV DX, 11
	ADD DX, AX

	DRAW_RECT CX, DX, 48,24,07H
	
	ADD SP, 4
	POP BP
	POP_ALL
ENDM

DRAW_BLUE MACRO x,y
	PUSH_ALL
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-4],x
	MOV WORD PTR[BP-2],y
	MOV AX, WORD PTR[BP-4]
	MOV BX, 50
	MUL BX
	MOV CX, 15
	ADD CX, AX
			
	MOV AX, WORD PTR[BP-2]
	MOV BX, 25
	MUL BX
	MOV DX, 13
	ADD DX, AX

	ADD DX, 6
	ADD CX, 10
	DRAW_RECT CX, DX, 20,7,09H

	ADD SP, 4
	POP BP
	POP_ALL
ENDM

DRAW_RED MACRO x,y
	PUSH_ALL
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-4],x
	MOV WORD PTR[BP-2],y
	MOV AX, WORD PTR[BP-4]
	MOV BX, 50
	MUL BX
	MOV CX, 15
	ADD CX, AX
			
	MOV AX, WORD PTR[BP-2]
	MOV BX, 25
	MUL BX
	MOV DX, 13
	ADD DX, AX

	ADD CX, 10
	ADD DX, 8
	DRAW_RECT CX, DX, 20,6,04H
	
	ADD SP, 4
	POP BP
	POP_ALL
ENDM

DRAW_YELLOW MACRO x,y
	PUSH_ALL
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-4],x
	MOV WORD PTR[BP-2],y
	MOV AX, WORD PTR[BP-4]
	MOV BX, 50
	MUL BX
	MOV CX, 15
	ADD CX, AX
			
	MOV AX, WORD PTR[BP-2]
	MOV BX, 25
	MUL BX
	MOV DX, 13
	ADD DX, AX

	DRAW_RECT CX, DX, 40,20,0EH   ;makes a block

	ADD SP, 4
	POP BP
	POP_ALL
ENDM

DRAW_GREEN MACRO x,y
	PUSH_ALL
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-4],x
	MOV WORD PTR[BP-2],y
	MOV AX, WORD PTR[BP-4]
	MOV BX, 50
	MUL BX
	MOV CX, 15
	ADD CX, AX
			
	MOV AX, WORD PTR[BP-2]
	MOV BX, 25
	MUL BX
	MOV DX, 13
	ADD DX, AX

	;DRAW_RECT CX, DX, 10,5,02H
	ADD CX, 10
	ADD DX, 5
	DRAW_RECT CX, DX, 20,10,02H
	ADD CX, 20
	ADD DX, 10
	;DRAW_RECT CX, DX, 10,5,02H
						
	ADD SP, 4
	POP BP
	POP_ALL
ENDM

DRAW_BROWN MACRO x,y
	PUSH_ALL
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-4],x
	MOV WORD PTR[BP-2],y
	MOV AX, WORD PTR[BP-4]
	MOV BX, 50
	MUL BX
	MOV CX, 15
	ADD CX, AX
			
	MOV AX, WORD PTR[BP-2]
	MOV BX, 25
	MUL BX
	MOV DX, 13
	ADD DX, AX
	
	MOV AX, 10
	.WHILE AX>0
		;DRAW_RECT CX, DX, 4,2,06H
		ADD CX, 4
		ADD DX, 2
		DEC AX
	.ENDW
	SUB CX, 40
	SUB DX, 2
	MOV AX, 10
	.WHILE AX>0
		;DRAW_RECT CX, DX, 4,2,06H
		ADD CX, 4
		SUB DX, 2
		DEC AX
	.ENDW
	SUB CX, 32
	ADD DX, 6
	DRAW_RECT CX, DX, 24,12,06H

						
	ADD SP, 4
	POP BP
	POP_ALL
ENDM

DRAW_BOMB MACRO x,y
	PUSH_ALL
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-4],x
	MOV WORD PTR[BP-2],y
	MOV AX, WORD PTR[BP-4]
	MOV BX, 50
	MUL BX
	MOV CX, 15
	ADD CX, AX
			
	MOV AX, WORD PTR[BP-2]
	MOV BX, 25
	MUL BX
	MOV DX, 13
	ADD DX, AX

	DRAW_RECT CX, DX, 40, 20, 00H
	ADD CX, 10
	ADD DX, 2
	;DRAW_RECT CX, DX, 20, 8, 0FH
	ADD CX, 2
	ADD DX, 1
	;DRAW_RECT CX, DX, 6, 3, 0H
	ADD CX, 10
	;DRAW_RECT CX, DX, 6, 3, 0H
	
	ADD DX, 7
	SUB CX, 13
	MOV AX, 3
	.WHILE AX>0
		ADD CX, 5
		;DRAW_RECT CX, DX, 2, 8, 0FH
		DEC AX
	.ENDW
			
	ADD SP, 4
	POP BP
	POP_ALL
ENDM

DRAW_CANDY MACRO x,y
	PUSH_ALL
	PUSH BP
	MOV BP,SP
	SUB SP, 4
	MOV WORD PTR[BP-4],x
	MOV WORD PTR[BP-2],y 
	MOV AX, y
	MOV BL, 7
	MUL BL
	ADD AX, WORD PTR[BP-4]
	MOV DI, AX
	MOV AX, WORD PTR[BP-4]
	MOV BX, WORD PTR[BP-2]
	.IF grid[DI]==0
		CLEAR_BOX AX,BX
	.ELSEIF grid[DI]==1
		DRAW_BLUE AX,BX
	.ELSEIF grid[DI]==2
		DRAW_BROWN AX,BX
	.ELSEIF grid[DI]==3
		DRAW_GREEN AX,BX
	.ELSEIF grid[DI]==4
		DRAW_RED AX,BX
	.ELSEIF grid[DI]==5
		DRAW_YELLOW AX,BX
	.ELSEIF grid[DI]==6
		DRAW_BOMB AX,BX
	.ELSEIF grid[DI]==0FFH
		DRAW_BLOCK AX,BX
	.ENDIF
	ADD SP, 4
	POP BP
	POP_ALL
ENDM

DRAW_ALL_CANDIES MACRO
	PUSH_ALL
	MOV AX, 0
	.REPEAT
		MOV BX, 0
		.REPEAT
			DRAW_CANDY AX,BX
			INC BX
		.UNTIL BX==7
		INC AX
	.UNTIL AX==7
	POP_ALL
ENDM

MOVE_CURSOR MACRO y,x
	PUSH AX
	PUSH DX
	MOV AH, 02H
	MOV DH, x
	MOV DL, y
	INT 10H
	POP DX
	POP AX
ENDM 

SET_MOUSE_LIMIT MACRO x1,x2,y1,y2
	;Setting horizontal limit to cursor
	PUSH_ALL
	MOV AX, 07H
	MOV CX, x1
	MOV DX, x2
	INT 33H
	;Setting vertical limit to cursor
	MOV AX, 08H
	MOV CX, y1
	MOV DX, y2
	INT 33H
	POP_ALL
ENDM

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-------MAIN-------;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.model small
.stack
.data
		 
	level1 db 0,0,0,0,0,0,0			;can change boxes in all levels
		   db 0,0,0,0,0,0,0
		   db 0,0,0,0,0,0,0
		   db 0,0,0,0,0,0,0
		   db 0,0,0,0,0,0,0
		   db 0,0,0,0,0,0,0
		   db 0,0,0,0,0,0,0
		 
	level2 db 0FFH,0,0,0FFH,0,0,0FFH		;0ffh blocked
		   db 0FFH,0,0,0,0,0,0FFH
		   db 0,0,0,0,0,0,0
		   db 0FFH,0,0,0,0,0,0FFH
		   db 0,0,0,0,0,0,0
		   db 0FFH,0,0,0,0,0,0FFH
		   db 0FFH,0,0,0FFH,0,0,0FFH

	level3 db 0,0,0FFH,0,0,0,0		;0ffh blocked
		 db 0,0,0FFH,0,0,0,0
		 db 0,0,0FFH,0,0,0,0
		 db 0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
		 db 0,0,0,0,0FFH,0,0
		 db 0,0,0,0,0FFH,0,0
		 db 0,0,0,0,0FFH,0,0
		   		 
	grid db 0,0,0,0,0,1,0
		   db 1,0,0,0,1,0,0
		   db 0,1,0,1,0,0,0
		   db 0,0,1,0,0,0,0
		   db 0,0,0,2,0,0,0
		   db 0,0,0,0,0,0,0
		   db 0,0,0,0,0,0,0
			
	pop_grid db 0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0

	;Printing strings

	gameName DB "CANDY CRUSH$"	
	RuleStr1 DB "RULES$"
	RuleStr2 DB "1) Swap Candies to make matches of 3 or$"
	RuleStr21 DB "   more candies.$"
	RuleStr3 DB "2) Bombs explode each instance of the$"
	RuleStr31 DB "   candy swapped with it.$"
	RuleStr4 DB "3) Score higher than the given threshold$"
	RuleStr41 DB "   to pass to next level.$"
	RuleStr5 DB "4) There are three levels in total.$"
	RuleStr6 DB "5) Have Fun!$"
	startGameStr DB "CLICK TO START GAME!$"
	enterNameStr DB "Type your Name and press ENTER:$"
	scoreStr DB "Score:$"
	playerStr DB "Player: $"
	levelStr DB "Level: $"
	movesLeftStr DB "Moves Left: $"
	scoreToReachStr DB "Score To Reach: $"
	poppingStr DB "CRUSHING!!$"
	noComboStr DB "$"
	bombedStr DB "EXPLOSION!!$"
	swapCandyStr DB "SWAP CANDIES.$"
	candyDroppingStr DB "CANDIES DROPPING!!$"
	levelFailedStr DB "!!LEVEL FAILED!!$"
	retryStr DB "Press ENTER to Try Again!$"
	stopPlayingStr DB "Press ESC to Exit!$"
	levelClearedStr DB "LEVEL CLEARED!!$"



	;fileWriting infos

	fileName DB "Scores.txt",0
	newLineStr DB 10,"$"
	level1Str DB "Level 1: $"
	level2Str DB "Level 2: $"
	level3Str DB "Level 3: $"
	highestScoreStr DB "Highest Score: $"
	writeBuffer DB 100 dup("$")
	writeBufferLen DW 0

	;Game info vars

	playerName DB 100 dup('$')
	playerNameLen DW 0
	gameStart DB 0H
	currentLevel DB 0H
	movesLeft DB 0H
	scoreToReach DW 0H
	level1Score DW 0
	level2Score DW 0
	level3Score DW 0
	
	mouseCoordX DW 0H
	mouseCoordY DW 0H
	
	selectBox1 DB 0FFH
	selectBox2 DB 0FFH
	
.code
MAIN PROC
	MOV DX, @DATA
	MOV DS, DX

	MOV AL, 00H
	MOV AH, 3CH
	LEA DX, fileName
	MOV CX, 0000H
	INT 21H

;	JMP EXIT
	CALL MAKE_SCREEN
	CALL DISP_TITLE_PAGE
	SET_MOUSE_LIMIT 0,635,0,195
	MOV mouseCoordX, 0
	MOV mouseCoordY, 0
	CALL SHOW_MOUSE
	
	CALL EXPECT_START_GAME_CLICK

	CALL REMOVE_MOUSE
	CALL DISP_GET_NAME_PAGE
	CALL SHOW_MOUSE
	CALL GET_NAME_INPUT
	
	MOV currentLevel, 1

	.WHILE currentLevel<4
		MOV AX, 0
		MOV AL, currentLevel
		CALL SETUP_LEVEL
		CALL START_LEVEL
	.ENDW
	CALL writeScoreToFile
	EXIT:
	CALL KILLP
MAIN ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;------FUNCTIONS-----;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KILLP PROC
	MOV AH,4CH
	INT 21H
	RET
KILLP ENDP

OUTPUT PROC uses AX BX CX DX ;outputs the number inside AX
	MOV BX, 0AH
	MOV DX, 0H
	MOV CX, 0 
	PRINT_LOOP1:
		DIV BX
		PUSH DX
		MOV DX, 0H
		INC CX
		CMP AX, 0H
		JNE PRINT_LOOP1
	
	PRINT_LOOP2:
		POP DX
		MOV AH, 02H
		ADD DL, '0'
		INT 21H
	LOOP PRINT_LOOP2			
	RET
OUTPUT ENDP

numToString PROC uses AX BX CX DX DI ;converts the number inside AX to string and saves in writeBuffer(also updates writeBufferLen)
	MOV CX, 100
	numToString_L:
		MOV DI, CX
		DEC DI
		MOV writeBuffer[DI], "$"
	LOOP numToString_L
	MOV BX, 0AH
	MOV DX, 0
	MOV CX, 0 
	numToString_L1:
		DIV BX
		PUSH DX
		MOV DX, 0H
		INC CX
		CMP AX, 0H
		JNE numToString_L1
	MOV DI, 0
	MOV writeBufferLen, CX
	numToString_L2:
		POP DX
		ADD DL, '0'
		MOV writeBuffer[DI], DL
		INC DI
	LOOP numToString_L2			
	RET
numToString ENDP

writeScoreToFile PROC ;function to write the scores and name to file in correct format
	;Opening file
	MOV DX, OFFSET fileName
	MOV AH, 3DH
	MOV AL, 2
	INT 21H
	MOV BX, AX ;move filehandle to BX
	
	;Move cursor to file end
	MOV CX, 0
	MOV DX, 0
	MOV AH, 42H
	MOV AL, 02H
	INT 21H
	
	;writing to file
	MOV AH, 40H
	MOV DX, OFFSET playerName
	MOV CX, playerNameLen
	INT 21H
	
	MOV AH, 40H
	MOV DX, OFFSET newLineStr
	MOV CX, LENGTHOF newLineStr - 1
	INT 21H
	
	MOV AH, 40H
	MOV DX, OFFSET level1Str
	MOV CX, LENGTHOF level1Str - 1
	INT 21H	
	PUSH AX
	MOV AX, level1Score
	CALL numToString
	POP AX
	MOV DX, OFFSET writeBuffer
	MOV CX, writeBufferLen
	MOV AH, 40H
	INT 21H
	MOV DX, OFFSET newLineStr
	MOV CX, LENGTHOF newLineStr - 1
	MOV AH, 40H
	INT 21H

	MOV DX, OFFSET level2Str
	MOV CX, LENGTHOF level2Str - 1
	MOV AH, 40H	
	INT 21H
	PUSH AX
	MOV AX, level2Score
	CALL numToString
	POP AX
	MOV DX, OFFSET writeBuffer
	MOV CX, writeBufferLen
	MOV AH, 40H	
	INT 21H
	MOV DX, OFFSET newLineStr
	MOV CX, LENGTHOF newLineStr - 1
	MOV AH, 40H	
	INT 21H
	
	MOV DX, OFFSET level3Str
	MOV CX, LENGTHOF level3Str - 1
	MOV AH, 40H	
	INT 21H	
	PUSH AX
	MOV AX, level3Score
	CALL numToString
	POP AX
	MOV DX, OFFSET writeBuffer
	MOV CX, writeBufferLen
	MOV AH, 40H	
	INT 21H
	MOV DX, OFFSET newLineStr
	MOV CX, LENGTHOF newLineStr - 1
	MOV AH, 40H	
	INT 21H
			
	MOV DX, OFFSET highestScoreStr
	MOV CX, LENGTHOF highestScoreStr-1
	MOV AH, 40H	
	INT 21H
	
	PUSH_ALL
	MOV AX, level1Score
	MOV BX, level2Score
	MOV CX, level3Score
	.IF AX > BX && AX > CX
		CALL numToString
	.ELSEIF BX > CX
		MOV AX, BX
		CALL numToString
	.ELSE
		MOV AX, CX
		CALL numToString
	.ENDIF
	POP_ALL
	MOV DX, OFFSET writeBuffer
	MOV CX, writeBufferLen
	MOV AH, 40H
	INT 21H
	
	MOV DX, OFFSET newLineStr
	MOV CX, LENGTHOF newLineStr - 1
	MOV AH, 40H
	INT 21H

	MOV DX, OFFSET newLineStr
	MOV CX, LENGTHOF newLineStr - 1
	MOV AH, 40H
	INT 21H
	
	RET
writeScoreToFile ENDP

MAKE_SCREEN PROC       ;board colour change
	MOV AX, 00EH
	INT 10H
	CALL CLEAR_SCREEN
	RET
MAKE_SCREEN ENDP

CLEAR_SCREEN PROC uses AX BX CX DX
	MOV AH, 06H
	MOV AL, 0H
	MOV CX, 0
	MOV DL, 100
	MOV DH, 30
	MOV BH, 020H
	INT 10H
	RET
CLEAR_SCREEN ENDP

COPY_ARRAY PROC uses CX BX SI DI;Gets input of array offsets in SI and DI and length in CX and copies SI array to DI
	.REPEAT
		MOV BL, [SI]
		MOV [DI], BL
		INC DI
		INC SI
		DEC CX
	.UNTIL CX==0
	RET
COPY_ARRAY ENDP

SETUP_LEVEL PROC uses AX BX DX DI SI CX;Gets input of level number in ax and sets up variables according to that level

	MOV DI, OFFSET grid
	MOV CX, 49
	.IF AX==1
		MOV SI, OFFSET level1
		CALL COPY_ARRAY
		MOV currentLevel, 1
		MOV level1Score, 0
		MOV scoreToReach, 10
	.ELSEIF AX==2
		MOV SI, OFFSET level2
		CALL COPY_ARRAY
		MOV currentLevel, 2
		MOV level2Score, 0
		MOV scoreToReach, 15
	.ELSEIF AX==3
		MOV SI, OFFSET level3
		CALL COPY_ARRAY
		MOV currentLevel, 3
		MOV level3Score, 0
		MOV scoreToReach, 20
	.ENDIF

	MOV movesLeft, 3

	CALL REMOVE_MOUSE
	CALL MAKE_SCREEN
	;DRAW_BOARD
	
	MOVE_CURSOR 207,1
	MOV AX, 0
	MOV DI, OFFSET playerStr
	CALL PRINT_STRING
	MOV DI, OFFSET playerName
	CALL PRINT_STRING

	MOVE_CURSOR 207,3
	MOV AX, 0
	MOV DI, OFFSET levelStr
	CALL PRINT_STRING
	MOV AX, 0
	MOV AL, currentLevel
	CALL OUTPUT
	
	MOVE_CURSOR 207,5
	MOV AX, 0
	MOV DI, OFFSET scoreToReachStr
	CALL PRINT_STRING
	MOV AX, scoreToReach
	CALL OUTPUT
	
	CALL DISPLAY_SCORE
	CALL DISPLAY_MOVES_LEFT
	MOV AX, 3
	CALL DISPLAY_EVENT
		
	DRAW_ALL_CANDIES
	
	CALL SHOW_MOUSE
	RET
SETUP_LEVEL ENDP

START_LEVEL PROC
	MOV gameStart, 0
	KEEP_POPPING1:
	CALL DO_POP
	CALL boardCompressor
	CALL boardFiller
	CALL GRID_COMBO_CHECKER
	CMP DI, 1
	JE KEEP_POPPING1
	MOV gameStart, 1

	CALL SHOW_MOUSE
	LO:
		MOV AX, 0
		CALL DISPLAY_EVENT
		CALL EXPECT_GAME_BOARD_CLICK
		CALL MAKE_SELECTION
		CMP AX, 0 ;Jump to next iter if two selections are not made
		JE LO
		CALL SWAP_CANDIES
		CALL BOMB_CHECKER
		.IF AX==1
			PUSH AX
			MOV AX,3
			CALL DISPLAY_EVENT
			MOV AX, 1000
			CALL SLEEP
			POP AX
		.ENDIF
		CALL GRID_COMBO_CHECKER
		.IF AX==0 && DI==0
			MOV AX, 2
			CALL DISPLAY_EVENT
			MOV AX, 1000
			CALL SLEEP
			CALL SWAP_CANDIES
			MOV selectBox1, 0
			MOV selectBox2, 0
			CALL REMOVE_MOUSE
			DRAW_UNSELECT_ALL
			CALL SHOW_MOUSE
			JMP LO
		.ENDIF
		DEC movesLeft
		CALL DISPLAY_MOVES_LEFT
		KEEP_POPPING:
		CALL DO_POP
		CALL boardCompressor
		CALL boardFiller
		CALL GRID_COMBO_CHECKER
		CMP DI, 1
		JE KEEP_POPPING
		CALL GET_CURRENT_SCORE
		.IF movesLeft == 0
			.IF AX >= scoreToReach
				MOVE_CURSOR 22,12
				MOV AX, 200
				MOV DI, OFFSET levelClearedStr
				CALL PRINT_STRING
				MOV AX, 1000
				CALL SLEEP
				INC currentLevel
				RET
			.ELSE
				CALL REMOVE_MOUSE
				MOVE_CURSOR 27,10
				MOV DI, OFFSET levelFailedStr
				MOV AX, 0
				CALL PRINT_STRING
				MOVE_CURSOR 22,12
				MOV DI, OFFSET retryStr
				CALL PRINT_STRING
				MOVE_CURSOR 26,14
				MOV DI, OFFSET stopPlayingStr
				CALL PRINT_STRING
				.REPEAT
					MOV AH, 0CH
					MOV AL, 0
					INT 21H
					MOV AX, 20
					CALL SLEEP
					MOV AH, 01H
					INT 16H	
					.IF AL == 27
						CALL KILLP
					.ELSEIF AL == 13
						RET
					.ENDIF
				.UNTIL AX<0
			.ENDIF
		.ENDIF
	JMP LO
	ENDLEVEL:
	RET
START_LEVEL ENDP

GET_CURRENT_SCORE PROC ;returns current level score in AX
	.IF currentLevel == 1
		MOV AX, level1Score
	.ELSEIF currentLevel == 2
		MOV AX, level2Score
	.ELSEIF currentLevel == 3
		MOV AX, level3Score
	.ENDIF
	RET
GET_CURRENT_SCORE ENDP

DISPLAY_SCORE PROC uses AX BX CX DX DI;Displays updated score of current level
	DRAW_RECT 375,57,90,10,010H
	MOVE_CURSOR 207,7
	MOV AX, 0
	MOV DI, OFFSET scoreStr
	CALL PRINT_STRING
	.IF currentLevel == 1
		MOV AX, level1Score
	.ELSEIF currentLevel == 2
		MOV AX, level2Score
	.ELSE 
		MOV AX, level3Score
	.ENDIF
	CALL OUTPUT
	RET
DISPLAY_SCORE ENDP

DISPLAY_MOVES_LEFT PROC uses AX BX CX DX DI;Displays updated score of current level
	DRAW_RECT 375,73,150,10,010H
	MOVE_CURSOR 207,9
	MOV AX, 0
	MOV DI, OFFSET movesLeftStr
	CALL PRINT_STRING
	MOV AL, movesLeft
	CALL OUTPUT
	RET
DISPLAY_MOVES_LEFT ENDP

DISPLAY_MOVES_LEFT_NO_STR PROC uses AX BX CX DX DI;Displays updated score of current level
	DRAW_RECT 375,73,150,10,010H
	MOVE_CURSOR 207,9
	MOV AX, 0
	MOV AL, movesLeft
	CALL OUTPUT
	RET
DISPLAY_MOVES_LEFT_NO_STR ENDP

DISPLAY_EVENT PROC uses AX BX CX DX DI;Displays an event statement according to value input in AX(0:do swap,1:popping,2:no combo,3:bombed,5:no event,4:candiesDroping)
	DRAW_RECT 375,89,150,10,010H
	MOVE_CURSOR 207, 11
	.IF AX==0
		MOV DI, OFFSET swapCandyStr
	.ELSEIF AX==1
		MOV DI, OFFSET poppingStr
	.ELSEIF AX==2												;dec moves
		DEC movesLeft
		CALL DISPLAY_MOVES_LEFT
		MOV DI, OFFSET noComboStr
		.IF movesLeft == 0
			.IF AX >= scoreToReach
				MOVE_CURSOR 22,12
				MOV AX, 200
				MOV DI, OFFSET levelClearedStr
				CALL PRINT_STRING
				MOV AX, 1000
				CALL SLEEP
				INC currentLevel
				RET
			.ELSE
				CALL REMOVE_MOUSE
				MOVE_CURSOR 27,10
				MOV DI, OFFSET levelFailedStr
				MOV AX, 0
				CALL PRINT_STRING
				
				MOVE_CURSOR 26,14
				MOV DI, OFFSET stopPlayingStr
				CALL PRINT_STRING
				CALL KILLP
				.REPEAT
					MOV AH, 0CH
					MOV AL, 0
					INT 21H
					MOV AX, 20
					CALL SLEEP
					MOV AH, 01H
					INT 16H	
					.IF AL == 27
						CALL KILLP
					.ELSEIF AL == 13
						RET
					.ENDIF
				.UNTIL AX<0
			.ENDIF
			.IF AX >= scoreToReach
				MOVE_CURSOR 22,12
				MOV AX, 200
				MOV DI, OFFSET levelClearedStr
				CALL PRINT_STRING
				MOV AX, 1000
				CALL SLEEP
				INC currentLevel
				RET
			.ENDIF
		.ENDIF
	ENDLEVEL1:
	
	RET
		
		
	.ELSEIF AX==3
		MOV DI, OFFSET bombedStr
	.ELSEIF AX==4
		MOV DI, OFFSET candyDroppingStr
	.ELSE
		RET
	.ENDIF
	MOV AX, 0H
	CALL PRINT_STRING
	RET
DISPLAY_EVENT ENDP

DISP_TITLE_PAGE PROC uses AX DI
	CALL CLEAR_SCREEN
	MOVE_CURSOR 35,1
	MOV DI, OFFSET gameName
	MOV AX, 100
	CALL PRINT_STRING
	MOVE_CURSOR 24, 4 ;
	MOV DI, OFFSET RuleStr1
	MOV AX, 10
	CALL PRINT_STRING
	MOVE_CURSOR 6, 6
	MOV DI, OFFSET RuleStr2
	CALL PRINT_STRING
	MOVE_CURSOR 6, 7
	MOV DI, OFFSET RuleStr21
	CALL PRINT_STRING
	MOVE_CURSOR 6, 9
	MOV DI, OFFSET RuleStr3
	CALL PRINT_STRING
	MOVE_CURSOR 6, 10
	MOV DI, OFFSET RuleStr31
	CALL PRINT_STRING
	MOVE_CURSOR 6, 12
	MOV DI, OFFSET RuleStr4
	CALL PRINT_STRING
	MOVE_CURSOR 6, 13
	MOV DI, OFFSET RuleStr41
	CALL PRINT_STRING
	MOVE_CURSOR 6, 15
	MOV DI, OFFSET RuleStr5
	CALL PRINT_STRING
	MOVE_CURSOR 6, 17
	MOV DI, OFFSET RuleStr6
	CALL PRINT_STRING
	MOVE_CURSOR 30, 21
	MOV DI, OFFSET startGameStr
	CALL PRINT_STRING
	RET
DISP_TITLE_PAGE ENDP

DISP_GET_NAME_PAGE PROC uses DI
	CALL CLEAR_SCREEN
	MOVE_CURSOR 100,10
	MOV DI, OFFSET enterNameStr
	CALL PRINT_STRING
	RET
DISP_GET_NAME_PAGE ENDP

GET_NAME_INPUT PROC uses AX DI
	MOVE_CURSOR 100, 12
	MOV DI, OFFSET playerName
	PUSH DI
	CALL GET_STRING_INPUT
	POP AX
	MOV playerNameLen, AX
	RET
GET_NAME_INPUT ENDP

REMOVE_MOUSE PROC uses AX BX CX DX
		MOV AX, 03H
		INT 33H
		MOV mouseCoordX, CX
		MOV mouseCoordY, DX
		MOV AX, 0000H;Hide mouse
		INT 33H	
		RET
REMOVE_MOUSE ENDP

SHOW_MOUSE PROC uses AX BX CX DX
		MOV AX, 04H
		MOV CX, mouseCoordX
		MOV DX, mouseCoordY
		INT 33H		
		MOV AX, 0001H;Show mouse
		INT 33H		
		RET 
SHOW_MOUSE ENDP

GET_BOX_VAL PROC uses BX CX DX DI;gets input of box coords in CX, DX and grid address in DI. Returns the value of that box(in global grid) in AX
	ADD DI, CX
	MOV AX, DX
	MOV BL, 7
	MUL BL
	ADD DI, AX
	MOV AX, 0
	MOV AL, [DI]
	RET
GET_BOX_VAL ENDP

CHECK_NEIGHBOUR PROC uses BX CX DX;gets input coords in BX(BH and BL seperate coords)returns 1 in AX if they're neighbours else 0
	MOV AX, BX
	GSHR AX, 8
	GSHL AX, 4 ;coord x1 is now in AH
	GSHR AL, 4 ;coord y1 is now in AL
	GSHL BX, 8 
	GSHR BX, 4 ;coord x2 is now in BH
	GSHR BL, 4 ;coord y2 is now in BL
	SUB AH, BH
	SUB AL, BL
	.IF ((AH==1 || AH==0FFH) && AL==0) || ((AL==1 || AL==0FFH) && AH==0)
		MOV AX, 1
	.ELSE 
		MOV AX, 0
	.ENDIF
	RET
CHECK_NEIGHBOUR ENDP

MAKE_SELECTION PROC uses BX CX DX;gets input of new possible selection in CX,DX (coords). Returns(in AX) 0 if 0 and 1 if two selections made
	CALL REMOVE_MOUSE
	MOV DI, OFFSET grid		
	CALL GET_BOX_VAL
	.IF AX==0FFH
		MOV AX,0 ;Returns 0 
	.ELSE
		MOV BL, CL
		GSHL BL, 4
		ADD BL, DL
		.IF selectBox1==0FFH || BL==selectBox1
			MOV selectBox1, BL 
			DRAW_SELECT_BOX CX, DX	
			MOV AX, 0 ;Returns 0
		.ELSE
			MOV BH, selectBox1
			DRAW_SELECT_BOX CX, DX
			CALL CHECK_NEIGHBOUR
			.IF AX==1
				MOV selectBox2, BL
				MOV AX, 1 ;Returns 1
			.ELSE 
				MOV CX, 0
				MOV DX, 0
				MOV DL, selectBox1
				GSHL DX, 4
				GSHR DL, 4
				MOV CL, DH
				MOV DH, 0
				DRAW_UNSELECT_BOX CX, DX
				MOV selectBox1, BL
				MOV AX, 0 ;Returns 0
			.ENDIF
		.ENDIF
	.ENDIF
	CALL SHOW_MOUSE
	RET
MAKE_SELECTION ENDP

EXPECT_GAME_BOARD_CLICK PROC uses AX BX ;Waits until a box in the grid is pressed and then returns its coords
	SET_MOUSE_LIMIT 10,360,10,185	
	EXPECT_GAME_BOARD_CLICK_L1:
		MOV AX, 20
		CALL SLEEP
		
		MOV AX, 05H;Get mouse click stats
		MOV BX, 00H
		INT 33H
		CMP BX, 0 ;Jump back if new click not registered
		JE EXPECT_GAME_BOARD_CLICK_L1

		MOV AX, CX
		SUB AX, 10
		MOV BL, 50
		DIV BL
		CMP AH,0 ;Jump back if x coordinate is on a white line
		JE EXPECT_GAME_BOARD_CLICK_L1
		MOV AH, 0
		MOV CX, AX

		MOV AX, DX
		SUB AX, 10
		MOV BL, 25
		DIV BL
		CMP AH,0 ;Jump back if x coordinate is on a white line
		JE EXPECT_GAME_BOARD_CLICK_L1
		MOV AH, 0
		MOV DX, AX
	RET
EXPECT_GAME_BOARD_CLICK ENDP

EXPECT_START_GAME_CLICK PROC uses AX BX CX DX
	
	EXPECT_START_GAME_CLICK_L1:
		MOV AX, 05H
		MOV BX, 0H
		INT 33H
		CMP BX,0 ;JUMP back if click not detected
		JE EXPECT_START_GAME_CLICK_L1 
		.IF CX>=240 && CX<=397 && DX>=168 && DX<=175
			JMP EXPECT_START_GAME_CLICK_L1_END
		.ENDIF
		MOV AX, 20
		CALL SLEEP
	JMP EXPECT_START_GAME_CLICK_L1
	EXPECT_START_GAME_CLICK_L1_END:
	RET
EXPECT_START_GAME_CLICK ENDP

PRINT_STRING PROC uses AX BX DX DI ;Prints a string. Takes input of string offset in DI and sleep time(after each character)in AX
	MOV BX, AX
	PRINT_STRING_L1:
		MOV AX, BX
		CALL SLEEP
		MOV DL, [DI]
		CMP DL, '$'
		JE PRINT_STRING_L1_END
		MOV AH, 02H
		INT 21H
		INC DI
		JMP PRINT_STRING_L1
	PRINT_STRING_L1_END:	
	RET
PRINT_STRING ENDP

C_COMBO_CHECKER PROC uses AX BX CX DX ;Checks for a combo in a specific column. Takes Column Number input in DI
	MOV DX, 0H						;returns 1 or 0 in DI if a combo is found or not, respectively
	MOV BX, 0H
	MOV CX, 6
	C_COMBO_CHECKER_L1:
		PUSH CX
		MOV AL, grid[DI]
		CMP AL, grid[DI+7]
		JNE C_COMBO_CHECKER_RESET
		CMP AL, 0FFH
		JE C_COMBO_CHECKER_RESET
		CMP AL, 0
		JE C_COMBO_CHECKER_RESET
		CMP AL, 06H
		JE C_COMBO_CHECKER_RESET
		INC BX
		CMP BX, 3
		JB C_COMBO_CHECKER_NEXT
		MOV DX, 1
		MOV pop_grid[DI], 1
		MOV pop_grid[DI+7], 1		
		MOV pop_grid[DI-7], 1		
		JMP C_COMBO_CHECKER_NEXT
		C_COMBO_CHECKER_RESET:
		MOV BX, 0
		C_COMBO_CHECKER_NEXT:
		ADD DI, 7
		INC BX
		POP CX
	LOOP C_COMBO_CHECKER_L1
	MOV DI, DX
	RET
C_COMBO_CHECKER ENDP

R_COMBO_CHECKER PROC uses AX BX CX DX ;Checks for a combo in a specific row. Takes Row Number input in DI
	MOV DX, 0							;returns 1 or 0 in DI if a combo is found or not, respectively
	MOV AX, DI
	MOV BL, 7
	MUL BL
	MOV DI, AX
	MOV BX, 0H
	MOV CX, 6
	R_COMBO_CHECKER_L1:
		PUSH CX
		MOV AL, grid[DI]
		CMP AL, grid[DI+1]
		JNE R_COMBO_CHECKER_RESET
		CMP AL, 0FFH
		JE R_COMBO_CHECKER_RESET
		CMP AL, 0
		JE R_COMBO_CHECKER_RESET
		CMP AL, 06H
		JE R_COMBO_CHECKER_RESET
		INC BX
		CMP BX, 3
		JB R_COMBO_CHECKER_NEXT
		MOV DX,1
		MOV pop_grid[DI], 1
		MOV pop_grid[DI+1], 1		
		MOV pop_grid[DI-1], 1		
		JMP R_COMBO_CHECKER_NEXT
		R_COMBO_CHECKER_RESET:
		MOV BX, 0
		R_COMBO_CHECKER_NEXT:
		INC DI
		INC BX
		POP CX
	LOOP R_COMBO_CHECKER_L1
	MOV DI, DX
	RET
R_COMBO_CHECKER ENDP


M_DIAG_COMBO_CHECKER PROC uses AX BX CX DX SI;gets input of main diagonal number in DI. returns 1 or 0 in DI if a combo is found or not
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-2], 0 ;flag to know if a combo is found
	MOV WORD PTR[BP-4], 1 ;count of consecutive candies
	MOV SI, DI

	MOV CX, 2
	M_DIAG_COMBO_CHECKER_OL:
		.IF CX==1
			MOV AX, SI
			MOV BL, 7
			MUL BL
			MOV DI, AX
		.ENDIF
		PUSH CX
		MOV CX, 7
		SUB CX, SI ;CX has the count of number of times you need to loop for finding diagonal combos
		DEC CX
		MOV WORD PTR[BP-4], 1
		.WHILE CX>0
			MOV BL, grid[DI+8]
			.IF grid[DI] == BL && grid[DI]!=0FFH && grid[DI]!=0H
				INC WORD PTR[BP-4]
			.ELSE
				MOV WORD PTR[BP-4],1
			.ENDIF
			.IF WORD PTR[BP-4]>=3
				MOV pop_grid[DI], 1
				MOV pop_grid[DI-8], 1
				MOV pop_grid[DI+8], 1
				MOV WORD PTR[BP-2], 1
			.ENDIF
			ADD DI, 8
			DEC CX
		.ENDW
		POP CX
	LOOP M_DIAG_COMBO_CHECKER_OL
	MOV DI, WORD PTR[BP-2]
	ADD SP, 4
	POP BP
	RET
M_DIAG_COMBO_CHECKER ENDP

S_DIAG_COMBO_CHECKER PROC uses AX BX CX DX SI
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-2], 0 ;flag to know if a combo is found
	MOV WORD PTR[BP-4], 1 ;count of consecutive candies
	MOV SI, DI

	MOV CX, 2
	S_DIAG_COMBO_CHECKER_OL:
		.IF CX == 2
			MOV AX, 6
			SUB AX, SI
			MOV DI, AX
		.ELSEIF CX==1
			MOV AX, SI
			MOV BL, 7
			MUL BL
			ADD AX, 6
			MOV DI, AX
		.ENDIF
		PUSH CX
		MOV CX, 7
		SUB CX, SI ;CX has the count of number of times you need to loop for finding diagonal combos
		DEC CX
		MOV WORD PTR[BP-4], 1
		.WHILE CX>0
			MOV BL, grid[DI+6]
			.IF grid[DI] == BL && grid[DI]!=0FFH && grid[DI]!=0H
				INC WORD PTR[BP-4]
			.ELSE
				MOV WORD PTR[BP-4],1
			.ENDIF
			.IF WORD PTR[BP-4]>=3
				MOV pop_grid[DI], 1
				MOV pop_grid[DI-6], 1
				MOV pop_grid[DI+6], 1
				MOV WORD PTR[BP-2], 1
			.ENDIF
			ADD DI, 6
			DEC CX
		.ENDW
		POP CX
	LOOP S_DIAG_COMBO_CHECKER_OL
	MOV DI, WORD PTR[BP-2]
	ADD SP, 4
	POP BP
	RET
S_DIAG_COMBO_CHECKER ENDP

GRID_COMBO_CHECKER PROC uses AX CX;Checks for a combo in the whole grid. Returns 1 in DI if found else 0. Also updates pop_grid
	MOV AX,0
	MOV CX, 7
	GRID_COMBO_CHECKER_L1:
		MOV DI, CX
		DEC DI
		CALL C_COMBO_CHECKER
		CMP DI, 1
		JNE GRID_COMBO_CHECKER_S1
		MOV AX, 1
		GRID_COMBO_CHECKER_S1:
		MOV DI, CX
		DEC DI
		CALL R_COMBO_CHECKER
		CMP DI, 1
		JNE GRID_COMBO_CHECKER_S2
		MOV AX, 1
		GRID_COMBO_CHECKER_S2:	;
		MOV DI, CX
		DEC DI
		CALL M_DIAG_COMBO_CHECKER
		CMP DI, 1
		JNE GRID_COMBO_CHECKER_S3
		MOV AX, 1
		GRID_COMBO_CHECKER_S3:	;
		MOV DI, CX
		DEC DI
		CALL S_DIAG_COMBO_CHECKER
		CMP DI, 1
		JNE GRID_COMBO_CHECKER_S4
		MOV AX, 1
		GRID_COMBO_CHECKER_S4:			
	LOOP GRID_COMBO_CHECKER_L1
	MOV DI, AX
	RET
GRID_COMBO_CHECKER ENDP

BOMB_CHECKER PROC uses BX CX DX DI SI;Checks if either of the selected boxes are bombs. returns(in AX) 1 if found else 0. updates pop grid 
	PUSH BP
	MOV BP, SP
	SUB SP, 8
	MOV DX, 0 
	MOV CX, 0
	MOV DI, OFFSET grid
	MOV DH, selectBox1
	GSHR DX, 4
	GSHR DL, 4
	MOV CL, DH
	MOV DH, 0
	MOV [BP-2], CX
	MOV [BP-4], DX
	CALL GET_BOX_VAL
	MOV BX, AX
	MOV DX, 0 
	MOV CX, 0
	MOV DH, selectBox2
	GSHR DX, 4
	GSHR DL, 4
	MOV CL, DH
	MOV DH, 0
	MOV [BP-6], CX
	MOV [BP-8], DX
	CALL GET_BOX_VAL
	MOV SI, OFFSET pop_grid
	.IF AX == 6 && BX ==6
		MOV CX, 49
		.WHILE CX>0
			PUSH_ALL
			MOV AX, SI
			SUB AX, OFFSET pop_grid
			MOV BL, 7
			DIV BL
			MOV BX, 0
			MOV BL, AH
			MOV AH, 0
			DRAW_SELECT_BOX BX,AX
			POP_ALL
			MOV BYTE PTR[SI], 1
			INC SI
			DEC CX
		.ENDW
		MOV AX, 1
	.ELSEIF AX==6 || BX==6
		MOV CX, 49
		.WHILE CX>0   
			.IF (BYTE PTR[DI] == BL && AX==6) || (BYTE PTR[DI] == AL && BX==6)
				PUSH_ALL
				MOV AX, DI
				SUB AX, OFFSET grid
				MOV BL, 7
				DIV BL
				MOV BX, 0
				MOV BL, AH
				MOV AH, 0
				DRAW_SELECT_BOX BX,AX
				POP_ALL
				MOV BYTE PTR[SI], 1
			.ENDIF
			INC DI
			INC SI
			DEC CX
		.ENDW
		.IF AX==6
			MOV AX, [BP-8]
			MOV CX, [BP-6]
		.ELSE
			MOV AX, [BP-4]
			MOV CX, [BP-2]
		.ENDIF
		MOV BL, 7
		MUL BL
		ADD AX, CX
		MOV DI, AX
		MOV pop_grid[DI], 1
		MOV AX, 1
	.ELSE
		MOV AX, 0
	.ENDIF
	ADD SP, 8
	POP BP
	RET
BOMB_CHECKER ENDP

SWAP_CANDIES PROC uses AX BX CX DX DI SI;Swaps the candies at the address given in global variables selectBox1, selectBox2
	CALL REMOVE_MOUSE
	MOV DX, 0
	MOV DH, selectBox1
	GSHR DX, 4
	GSHR DL, 4
	MOV CX, 0
	MOV CH, selectBox2
	GSHR CX, 4
	GSHR CL, 4
	MOV AL, CL
	MOV BL, 7
	MUL BL
	ADD AL, CH
	MOV DI, AX;
	MOV AL, DL
	MUL BL
	ADD AL, DH
	MOV SI, AX
	MOV AL, grid[DI]
	MOV AH, grid[SI]
	MOV grid[DI], AH
	MOV grid[SI], AL
	MOV AX, 0
	MOV AL, CH
	MOV CH, 0
	CLEAR_BOX AX, CX
	DRAW_CANDY AX, CX
	MOV AX, 0
	MOV AL, DH
	MOV DH, 0
	CLEAR_BOX AX, DX
	DRAW_CANDY AX, DX			
	CALL SHOW_MOUSE
	RET
SWAP_CANDIES ENDP

DO_POP PROC uses AX BX CX DX DI;pops the values according to the global array pop_grid
	MOV AX, 01H
	CALL DISPLAY_EVENT
	MOV BL, 7
	MOV DI, 0
	MOV DX, 0
	CALL REMOVE_MOUSE
	DRAW_UNSELECT_ALL
	MOV selectBox1, 0FFH
	MOV selectBox2, 0ffH
	.WHILE DI<49
		.IF pop_grid[DI]==1 && grid[DI]!=0FFH
			MOV grid[DI], 0
			MOV AX, DI
			DIV BL
			MOV DL, AH
			MOV AH, 0
			CLEAR_BOX DX, AX
			.IF gameStart == 1
				.IF currentLevel == 1
					INC level1Score
				.ELSEIF currentLevel == 2
					INC level2Score
				.ELSEIF currentLevel == 3
					INC level3Score
				.ENDIF
				CALL DISPLAY_SCORE
			.ENDIF
			MOV AX, 100
			CALL SLEEP
		.ENDIF
		INC DI
	.ENDW
	CALL SHOW_MOUSE
	MOV DI, OFFSET pop_grid
	MOV CX, 49
	CALL CLEAR_ARRAY
	MOV AX, 05H
	CALL DISPLAY_EVENT	
	RET
DO_POP ENDP

CLEAR_ARRAY PROC uses CX DI ;Changes values of an array to 0. Number of values are taken in CX and array offset in DI 
	CLEAR_ARRAY_L1:
		MOV BYTE PTR [DI], 0
		INC DI
	LOOP CLEAR_ARRAY_L1
	RET
CLEAR_ARRAY ENDP

SLEEP PROC uses AX BX CX DX ;Takes input of milliseconds in AX and creates delay of that time
	CMP AX, 0
	JE SLEEP_SKIP
	MOV BX, 150
	MUL BX
	MOV CX, DX
	MOV DX, AX
	MOV AH, 86H
	INT 15H
	SLEEP_SKIP:
	RET
SLEEP ENDP

DRAW_RECT_FUNC PROC
	PUSH BP
	MOV BP, SP
	SUB SP, 4
	MOV WORD PTR[BP-2],0
	MOV AX, [BP+8]
	.WHILE WORD PTR[BP-2]<AX
		MOV WORD PTR[BP-4], 0
		MOV AX, [BP+6]
		.WHILE WORD PTR[BP-4]<AX
			MOV AX, [BP+4]
			MOV AH, 0CH
			MOV CX, WORD PTR[BP-2]
			MOV DX, WORD PTR[BP-4]
			ADD CX, WORD PTR[BP+12]
			ADD DX, WORD PTR[BP+10]
			INT 10H
			INC WORD PTR[BP-4]
			MOV AX, WORD PTR[BP+6]
		.ENDW
		INC WORD PTR[BP-2]
		MOV AX, WORD PTR[BP+8]
	.ENDW	
	ADD SP, 4
	POP BP
	RET 10
DRAW_RECT_FUNC ENDP

; isBoardFilled proc
;returns 1 or 0 in ax
;1 means filled, 0 means there is an empty space
isBoardFilled proc uses bx
	mov bh,7
	mov ax,0
	.REPEAT
		push ax
		CALL colESchecker
		.IF ax==1	;if there is an empty space found then the grid is not filled
			pop ax
			mov ax,0 ;return 0 in ax because grid is not filled
			ret
		.ENDIF
		pop ax
		dec bh
		inc ax
	.UNTIL bh==0
	mov ax,1
	ret
isBoardFilled endp

;takes input of column number in ax
;returns in ax too
;returns 1 if there is an empty space(0), returns 0 if there is not any empty space
colESchecker proc uses si bx cx
	mov si,offset grid
	add si,ax
	;now si is pointing to the top of the column
	
	mov bh,7
	mov bl,7
	
	mov cx,0
	mov cl,bl
	;cx has the adding power tool
	
	mov ax,0
	.REPEAT
		.IF byte ptr[si]==0		
			mov ax,1
			ret
		.ENDIF
		add si,cx
		dec bh
	.UNTIL bh==0
	mov ax,0
	ret
colESchecker endp

boardFiller proc uses ax
	MOV AX, 4
	CALL DISPLAY_EVENT
	.REPEAT
		mov ax,0
		.REPEAT
			push ax
			Call colCandyDropper
			pop ax
			inc ax
		.UNTIL ax==7
		CALL isBoardFilled
		MOV BX, AX
		MOV AX, 300
		CALL SLEEP
		MOV AX, BX
	.UNTIL ax==1
	MOV AX, 5
	CALL DISPLAY_EVENT
	ret
boardFiller endp

colCandyDropper PROC ;takes input of a column in ax and drops a candy in it 
	push ax
	CALL colESchecker
	.IF ax==0
		pop ax
		ret
	.ENDIF
	pop ax
	CALL REMOVE_MOUSE
	.WHILE AX>=0
		MOV SI, OFFSET grid
		ADD SI, AX
		.WHILE BYTE PTR[SI]!=0
			ADD SI,7
		.ENDW
		MOV DI, SI ;DI has the address of top most box with 0 value 
		.WHILE (BYTE PTR[SI] == 0 || BYTE PTR[SI] == 0FFH) && SI >= OFFSET grid
			SUB SI, 7
		.ENDW
		;Now SI has the address of box first filled box above the top most 0
		.IF SI < OFFSET grid
			
			mov bh,3
			mov bl,19
			
			CALL randNum

			;generated a number from 3-18 and then divided by 3 so 6(bomb) has less chance to come then other number
			MOV AX, 0 
			MOV AL, dl
			MOV BL, 3
			DIV BL
			MOV DL, AL
			
			MOV BYTE PTR[DI], DL
			
			MOV AX, DI
			SUB AX, OFFSET grid
			MOV BL, 7
			DIV BL
			MOV BX, 0
			MOV BL, AH
			MOV AH, 0
			DRAW_CANDY BX, AX
		
			; generate randNum and move to address of DI
			JMP colCandyDropperENDLOOP ;Break loop when a new random candy has been inserted
		.ELSE
			;Moving candy downward to make space for a new random candy
			MOV BL, BYTE PTR [SI]
			MOV BYTE PTR[DI], BL
			MOV BYTE PTR[SI], 0
			PUSH AX
			
			;Redrawing candies that were changed
			MOV AX, SI
			SUB AX, OFFSET grid
			MOV BL, 7
			DIV BL
			MOV BX, 0
			MOV BL, AH
			MOV AH, 0
			CLEAR_BOX BX, AX
			
			MOV AX, DI
			SUB AX, OFFSET grid
			MOV BL, 7
			DIV BL
			MOV BX, 0
			MOV BL, AH
			MOV AH, 0
			DRAW_CANDY BX, AX

			POP AX
		.ENDIF
	.ENDW
	colCandyDropperENDLOOP:
	CALL SHOW_MOUSE
	RET
colCandyDropper ENDP

boardCompressor proc uses BX CX
	MOV CX, 7
	MOV BH, 7
	MOV BL, 7
	.WHILE CX>0
		MOV AL, CL
		DEC AL
		CALL colCompressor
		DEC CX
	.ENDW
	RET
boardCompressor endp 

;takes parameter of col number in al
;takes parameter rows and cols in bh and bl respectively
colCompressor proc uses ax bx cx dx si di
comment @
	si + al will give the top element of the column
	si + al + (bh - 1) x bl will give the last element of the column
	to go up an element just subtract bl

	1 go to the bottom of the column
	2 move up the column
		if you find an empty space:
			i. save the address of that space somewhere
			ii. keep moving up till you find a non empty space (1-6)
			iii. move the value into the empty space and make the non empty space the empty space
			iv. jump back to bottom
		else:
			the column is filled
	3 start again from step two till you reach the top of the column
@

	mov ah,0
	mov si, offset grid
	add si,ax
	;now you have the top element of the column in si
	
	mov al,bh
	sub al,1
	mul bl
	
	mov di,si
	add di,ax
	;now di is the last element of the column and si+ax will take you to the last element (top element + ax will take you to bottom)
	
	push si		;-----------------------------push1
	mov si,di
	pop di		;-----------------------------pop1
	;now di has the offset of the top element and si has the offset of the last element
	
	mov cx,0
	mov cl,bl
	;cx has the subtracting power tool
	
	.REPEAT
		.IF byte ptr[si]==0
			;empty space found
			push si			;-----------------------------push2
			.REPEAT
				sub si,cx
	;keep jumping up till you find a nonzero value or you get to the top of the column v
			.UNTIL (byte ptr[si]!=0 && byte ptr[si]!=0FFH) || si==di

			.IF si==di && (byte ptr[si]==0 || byte ptr[si]==0ffh);&& (byte ptr[si]==0 || byte ptr[si]==0ffh)
				pop si
				ret
			.ENDIF

			mov dl,[si]
			mov byte ptr[si],0
			
			CALL REMOVE_MOUSE
			PUSH_ALL
			MOV AX, SI
			SUB AX, OFFSET grid
			MOV BL, 7
			DIV BL
			MOV BX, 0
			MOV BL, AH
			MOV AH, 0
			CLEAR_BOX BX, AX
			POP_ALL
			CALL SHOW_MOUSE
			
			pop si		;-----------------------------pop2
			mov [si],dl

			CALL REMOVE_MOUSE
			PUSH_ALL
			MOV AX, SI
			SUB AX, offset grid
			MOV BL, 7
			DIV BL
			MOV BX, 0
			MOV BL, AH
			MOV AH, 0
			CLEAR_BOX BX, AX
			DRAW_CANDY BX, AX
			POP_ALL
			CALL SHOW_MOUSE
			mov si,di	;go to top element
			add si,ax	;go to bottom element
			
		.ENDIF
		sub si,cx
	.UNTIL si==di
	ret
colCompressor endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

waitRand proc uses ax
	
		add cx,dx
		add dx,cx
		mov ax,cx
		mul dx
		mov dx,ax
		mov ax,cx
		mul cx
		mov cx,ax
		add dx,ax
		mul dx
		mov dx,ax
		mov ax,500
		add dx,cx
		mov ax,cx
		mul dx
		mov ax,100
		call sleep
ret
waitRand endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;accepts parameters in bh and bl
;where bh is lower bound and bl is upper bound
; (rand() % (bl-bh)) + bh
;returns randum number in dx (from bh to bl)
randNum proc
	push ax
	push cx
	;create seed
	mov ah,00h
	int 1ah
call waitRand
	
	mov ax,dx
	mov dx,0
	;find moding value
	sub bl,bh
	;take mod
	mov cx,0
	mov cl,bl
	div cx
	;add lower bound
	add dl,bh
	pop cx
	pop ax
	ret
randNum endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GET_STRING_INPUT PROC uses AX BX CX DX DI
	SUB SP, 02H
	PUSH BP
	MOV BP, SP
	MOV WORD PTR[BP+2], 0H
	IL1:
		MOV AH, 01H
		INT 21H
		CMP AL, 13
		JE BREAK_IL1
		MOV DI, WORD PTR[BP+16]
		ADD DI, WORD PTR[BP+2]
		MOV BYTE PTR[DI], AL 
		INC WORD PTR[BP+2]
		JMP IL1
	BREAK_IL1:
	MOV AX, WORD PTR[BP+2]
	MOV WORD PTR[BP+16], AX
	POP BP
	ADD SP, 02H
	RET
GET_STRING_INPUT ENDP

END
