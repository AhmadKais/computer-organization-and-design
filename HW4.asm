;AHMAD KAIS :  ,50%
;ROJEH SHALABI : ,50%
;CONVENTION : HAIFA.
.ORIG X3000
AND R0, R0, #0		;intialize registers
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
ST R1, SULTIONS_COUNT
LD R6, STACK
LEA R0, OPEN_MESSAGE
PUTS

; GET NUMBER
LEA R1, ARRAY_INPUT
STR R1, R6, #-1
ADD R6, R6, #-1
JSR GetNum 
ADD R6, R6, #1

AND R1, R1, #0
AND R3, R3, #0
LEA R2, ARRAY
ADD R4, R0, #0

STR R1, R6, #-4 ; K
STR R2, R6, #-3 ; ADDRESS OF ARRAY
STR R3, R6, #-2 ; SULTIONS_COUNT
STR R4, R6, #-1 ; N
ADD R6, R6, #-4
JSR NQueenSolver
ADD R6, R6, #4
LEA R0, CNT_SOL_MESSAGE
PUTS
LD R3, SULTIONS_COUNT			;This label holds the number of solutions
ADD R3,R3,#0
BRZ NO_SOLUTION	
	
STR R3, R6, #-1
ADD R6, R6, #-1
JSR PrintNum				;printing the number of solutions
ADD R6, R6, #1
ADD R1, R1, #1
ADD R2, R2, #-1
BR END_PROGRAM


NO_SOLUTION:
		LD R0,ASCII_F_ZER
		OUT

END_PROGRAM:	
HALT


ASCII_F_ZER .fill #48

OPEN_MESSAGE .stringz "Enter N, i.e., number between 1 to 30: "
ARRAY_INPUT .blkw #2 #-1
STACK 		.fill XBFFF
ARRAY .blkw #30 #-1
CNT_SOL_MESSAGE .stringz "Number of possible solutions: "
POS_ASCII_FOR_ZERO1 .fill #48





NQueenSolver:		;This Function is a maa'tefet for ther recursive function 
ADD R6, R6, #-6	
STR R1, R6, #0
STR R2, R6, #1
STR R3, R6, #2
STR R4, R6, #3
STR R5, R6, #4
STR R7, R6, #5


LDR R1, R6, #6	;R1 = K 
LDR R2, R6, #7  ;R2 = ADDRESS OF ARRAY 
LDR R3, R6, #8	;R3 = X
LDR R4, R6, #9  ;R4 = N



AND R1, R1, #0
AND R3, R3, #0					
STR R1, R6, #-4			;RET NQueenSolver(0, ARRAY, 0, N)
STR R2, R6, #-3
STR R3, R6, #-2
STR R4, R6, #-1
ADD R6, R6, #-4
JSR SOLVER_NQUEEN
ADD R6, R6, #4


; PRINT Number of possible solutions


LDR R1, R6, #0
LDR R2, R6, #1
LDR R3, R6, #2
LDR R4, R6, #3
LDR R5, R6, #4
LDR R7, R6, #5
ADD R6, R6, #6

RET


SOLVER_NQUEEN:		;The recursive function where we get the solutions
ADD R6, R6, #-6
STR R1, R6, #0
STR R2, R6, #1
STR R3, R6, #2
STR R4, R6, #3
STR R5, R6, #4
STR R7, R6, #5

LDR R1, R6, #6 ; R1 = K
LDR R2, R6, #7 ; R2 = ARRAY
LDR R3, R6, #8 ; R3 = NUM OF SULTIONS
LDR R4, R6, #9 ; R4 = N -> NUM OF QUEENS 


AND R5, R5, #0				
ADD R5, R4, #0
NOT R5, R5
ADD R5, R5, #1 ; R5 = -N
ADD R5, R1, R5 ; R5 = K - N
BRN WHILE_LOOP_OUT				;Tnaai a'tsera


; PRINT ARRAY
LEA R0, SOL_MESSAGE
PUTS

STR R2, R6, #-2
STR R4, R6, #-1
ADD R6, R6, #-2
JSR printQueensPositions
ADD R6, R6, #2
LD R5, SULTIONS_COUNT
ADD R5, R5, #1
ST R5, SULTIONS_COUNT
BR END_SOLVER_NQUEEN 


WHILE_LOOP_OUT: 
AND R5, R5, #0 ; R5 IS A COUNTER  

WHILE_LOOP:

STR R1, R6, #-3
STR R2, R6, #-2
STR R5, R6, #-1
ADD R6, R6, #-3
JSR isLegal
ADD R6, R6, #3
ADD R0, R0, #0
BRz CONT_LOOP		;if its 0 then its legal
ADD R5, R5, #1	
ADD R7, R4, #0
NOT R7, R7
ADD R7, R7, #1
ADD R7, R7, R5 		;N-counter
BRz END_SOLVER_NQUEEN
BR WHILE_LOOP

CONT_LOOP:

ADD R7, R1, #1 ; K++
STR R7, R6, #-4
STR R2, R6, #-3
STR R3, R6, #-2
STR R4, R6, #-1
ADD R6, R6, #-4
JSR SOLVER_NQUEEN
ADD R6, R6, #4

ADD R5, R5, #1
ADD R7, R4, #0
NOT R7, R7
ADD R7, R7, #1
ADD R7, R7, R5 		;N-counter
BRz END_SOLVER_NQUEEN
BR WHILE_LOOP

	
END_SOLVER_NQUEEN:
LDR R1, R6, #0
LDR R2, R6, #1
LDR R3, R6, #2
LDR R4, R6, #3
LDR R5, R6, #4
LDR R7, R6, #5
ADD R6, R6, #6

RET
SULTIONS_COUNT .fill #0
SOL_MESSAGE .stringz "Solution: "

Mul: ; Mul subroutine : R2 <-- R0 * R1

ADD R6, R6, #-6
STR R1, R6, #0
STR R2, R6, #1
STR R3, R6, #2
STR R4, R6, #3
STR R5, R6, #4
STR R7, R6, #5

LDR R0, R6, #6
LDR R1, R6, #7

AND R2,R2,#0     ;initiating the values of R2,R4,R5 with zero becaue we want to use them
AND R4,R4,#0 
AND R5,R5,#0
 
ADD R0, R0, #0 ; we are given the values in R0 and R1 so we check , in case we have 0 0*any num is  0
BRz End
ADD R1, R1, #0 ; same here 
BRz End
AND R3, R3, #0     
ADD R0,R0,#0 ; in case we got a negative number in R0 go to negative else go to the loop  
BRn Negative
Br While
Negative: ; in case we got a negative number we take it in abstract value (we mul in -1) 
NOT R0,R0
ADD R0,R0,#1
NOT R1,R1
ADD R1,R1,#1
While:
ADD R5,R3,#0 ;R3 is the counter at the end of the loop we add 1 in R3 
NOT R5,R5    ;then we put he value in R5 and multiply it in -1 we do it in two's compliment    
ADD R5,R5,#1 
ADD R4,R5,R0 ; then we add r0 to r5 in case we got 0 we are finished because we add R1+R1... R0 TIMES
BRz End
ADD R2, R2, R1
ADD R3, R3, #1
Br While
End:

ADD R0, R2, #0
LDR R1, R6, #0
LDR R2, R6, #1
LDR R3, R6, #2
LDR R4, R6, #3
LDR R5, R6, #4
LDR R7, R6, #5
ADD R6, R6, #6
RET


; R0 - UP, R1 - DOWN, R2 - RESULT, R3 - SHAERET  
Div:
ADD R6, R6, #-6
STR R1, R6, #0
STR R2, R6, #1
STR R3, R6, #2
STR R4, R6, #3
STR R5, R6, #4
STR R7, R6, #5


LDR R0, R6, #6
LDR R1, R6, #7


AND R2,R2,#0 		; initiating R2,R3,R4,R5 with 0 
AND R3,R3,#0
AND R4,R4,#0
AND R5,R5,#0


ADD R4,R4,R0 	;now R4 has the value of R0
BRn negative4	;in case r4 is negative we branch to negative 4
CHECK:
ADD R5,R5,R1	;now R5 has the value of R1
BRn LOOP		;in case R5 is negative no need to multiply it with -1 so we skip to LOOP

NOT R5,R5 		;we multiply R5 with -1 in TWO'S compliment
ADD R5,R5,#1


LOOP:			; in this LOOP we subtract the value of R1 from R1 iterativly
ADD R4,R4,R5	; R4 = R4 - R5 = R0 -R1	 
BRp counter	
BRz COUNTER2	
BRn negative3	

COUNTER2: 	ADD R2,R2,#1
		BR continue



counter:		;in this branch we count the number of subtractions 
ADD R2,R2,#1	;we have made and restore it iN R2
BR LOOP

negative3:		;in case we got a negative value this means that we are finished division
NOT R5,R5		; we return R5 to a positive value
ADD R5,R5,#1	
ADD R3,R4,R5	;R3 = sha'reet R3 = R4%R5
ADD R1,R1,#0	;to check whether R1 is negaive or positive
BRn negative1	
BRp positive1
BR end			; in case there is no sha'reet :Remaining division 

negative4:		; in case we got a negative number we turn it to positive
NOT R4,R4
ADD R4,R4,#1
BR CHECK

continue: 		;in case there is no remaining division
ADD R1,R1,#0	;we check whether R1 is negative or positive to know what value should be in R2
BRn negative1	
BRp positive1
BR end 

positive1:		;in case R1 in positive
ADD R0,R0,#0
BRn negative2
BR end

negative1:		; in case R1 is negaive
ADD R0,R0,#0
BRp negative2
BR end 

negative2:		;in case one of the rigesters R0 or R1 is negative the result must be a negative
NOT R2,R2		; more explaination before this subroutine
ADD R2,R2,#1
BR end


end:
ADD R0, R2, #0
LDR R1, R6, #0
LDR R2, R6, #1
LDR R3, R6, #2
LDR R4, R6, #3
LDR R5, R6, #4
LDR R7, R6, #5
ADD R6, R6, #6
 
RET







GetNum:

ADD R6, R6, #-6
STR R1, R6, #0
STR R2, R6, #1
STR R3, R6, #2
STR R4, R6, #3
STR R5, R6, #4
STR R7, R6, #5

LDR R5, R6, #6 ; R5 = ADDRESS OF ARRAY
LD R3, ASCII_FOR_ZERO

GETC
OUT
ADD R0, R0, R3
STR R0, R5, #0

GETC
OUT
ADD R0, R0, #-10		;Check if we got 'Enter', if so then its a one digit Dimension
BRZ ONE_DIGIT
ADD R0, R0, #10
ADD R0, R0, R3
STR R0, R5, #1

LDR R0, R5, #0
AND R1, R1, #0
ADD R1, R1, #10			

STR R0, R6, #-2			
STR R1, R6, #-1
ADD R6, R6, #-2
JSR Mul					;in order to get the number we multiply the second digit by 10 and add to it the first one
ADD R6, R6, #2

LDR R1, R5, #1
ADD R0, R0, R1
ADD R3, R0, #0
GETC				;Here we get the enter and proceed
OUT
ADD R0, R3, #0
BR END_GETNUM

ONE_DIGIT:
LDR R0, R5, #0

END_GETNUM:
LDR R1, R6, #0
LDR R2, R6, #1
LDR R3, R6, #2
LDR R4, R6, #3
LDR R5, R6, #4
LDR R7, R6, #5
ADD R6, R6, #6

RET

ASCII_FOR_ZERO .fill #-48

PrintNum:		;gets a number and prints it in a recursive way

ADD R6, R6, #-6
STR R1, R6, #0
STR R2, R6, #1
STR R3, R6, #2
STR R4, R6, #3
STR R5, R6, #4
STR R7, R6, #5
LDR R5, R6, #6 	;R5 = NUMBER TO PRINT
AND R1, R1, #0
ADD R1, R1, #10
LD R3, POS_ASCII_FOR_ZERO
ADD R5,R5,#0		;if the number is zero return
BRZ RETURN
ADD R2,R5,#0 ; R2 = R5
STR R5, R6, #-2
STR R1, R6, #-1
ADD R6, R6, #-2
JSR Div				;R0=R5/10
ADD R6, R6, #2
ADD R5,R0,#0    ; R5 = R5/10 (AFTER DIVISION)
STR R5, R6, #-1
ADD R6, R6, #-1
JSR PrintNum
ADD R6, R6, #1

STR R5, R6, #-2
STR R1, R6, #-1
ADD R6, R6, #-2
JSR Mul				
ADD R6, R6, #2
ADD R5,R0,#0		
NOT R5,R5	
ADD R5,R5,#1
ADD R0,R2,R5			;in order to get the shereet we subtract R5-((R5/10)*10) and then we print it
LD R3,POS_ASCII_FOR_ZERO
ADD R0,R3,R0
OUT

RETURN:
LDR R1, R6, #0
LDR R2, R6, #1
LDR R3, R6, #2
LDR R4, R6, #3
LDR R5, R6, #4
LDR R7, R6, #5
ADD R6, R6, #6
RET
POS_ASCII_FOR_ZERO .fill #48

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printQueensPositions:
ADD R6, R6, #-6
STR R1, R6, #0
STR R2, R6, #1
STR R3, R6, #2
STR R4, R6, #3
STR R5, R6, #4
STR R7, R6, #5

LDR R1, R6, #6 ; R1 = ADDRESS OF ARRAY
LDR R2, R6, #7 ; R2 = N


PRINT_ARRAY_LOOP:
	LDR R3, R1, #0 ; R3 = ARRAY[R1]
	ADD R3,R3,0
	BRZ PRINTZERO
	STR R3, R6, #-1
	ADD R6, R6, #-1
	JSR PrintNum
	ADD R6, R6, #1
	ADD R1, R1, #1
	ADD R2, R2, #-1
	BRZ END_LOOP

CONTI: 	ADD R3, R3, #1
	LD R0, ASCII_FOR_SPACE ; PRINT SPACE
	OUT

BR PRINT_ARRAY_LOOP

PRINTZERO:
	LD R0,ASCII_FOR_ZE
	OUT
	ADD R1, R1, #1
	ADD R2, R2, #-1
	BRZ END_LOOP
	BR CONTI	

END_LOOP:
	LD R0, ASCII_FOR_SPACE ; PRINT SPACE
	OUT
	LD R0, ASCII_FOR_ENTER
	OUT
	LDR R1, R6, #0
	LDR R2, R6, #1
	LDR R3, R6, #2
	LDR R4, R6, #3
	LDR R5, R6, #4
	LDR R7, R6, #5
	ADD R6, R6, #6
	RET

ASCII_FOR_SPACE .fill #32
ASCII_FOR_ENTER .fill #10
ASCII_FOR_ZE .fill #48
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

isLegal:
ADD R6, R6, #-6
STR R1, R6, #0
STR R2, R6, #1
STR R3, R6, #2
STR R4, R6, #3
STR R5, R6, #4
STR R7, R6, #5

LDR R1, R6, #6 ; R1 = QUEEN_NUMBER
LDR R2, R6, #7 ; R2 = ADDRESS OF ARRAY - POSITIONS
LDR R3, R6, #8 ; R3 = COL POSITIONS

AND R0, R0, #0 ; R0 = RESULT 0- TRUE
ADD R4, R1, #0 ; R4 = QUEEN_NUMBER 
ADD R4,R4,#0
BRZ COLS_LEGAL

ISLEGAL_LOOP:
	LDR R5, R2, #0 ; R5 HAS THE VALUE OF THE FIRST CELL 
	NOT R5, R5
	ADD R5, R5, #1 ; R5 = -R5
	ADD R5, R5, R3 ;
	BRZ ILLEGAL
	ADD R4, R4, #-1
	BRZ COLS_LEGAL
	ADD R2, R2, #1
	BR ISLEGAL_LOOP

COLS_LEGAL:   ; CONTINUE
	LDR R2, R6, #7 ; R2 = ADDRESS OF ARRAY - POSITIONS
	ADD R4, R1, #0 ; R4 = COUNTER
	AND R1, R1, #0 


CHECK_DAIGONAL_LOOP:
								;positions [i] != col_position - (queen_number - i) 
	ADD R5, R4, #0
	BRZ STORE_COL
	ADD R5, R1, #0 ; R5 = i
	NOT R5, R5
	ADD R5, R5, #1 ; R5 = -i
	ADD R5, R4, R5 ; R5 = R4-R5 = queen_number - i
	ADD R7, R5, #0 ; R7 = R4-R5 = queen_number - i
	NOT R5, R5
	ADD R5, R5, #1 ; R5 = - (queen_number - i)
	ADD R5, R3, R5 ; R5 = col_position - (queen_number - i) 
	NOT R5, R5
	ADD R5, R5, #1 ; - (col_position - (queen_number - i) )
	LDR R2, R6, #7 ; R2 = ADDRESS OF ARRAY (POSITIONS)
	ADD R2, R2, R1
	LDR R2, R2, #0 ; R2 = POSITIONS[i]   
	ADD R2, R2, R5 ; R2 = POSITIONS[I] - (col_position - (queen_number - i) )
	BRZ ILLEGAL
											;positions [i] != col_position + (queen_number - i) 
	ADD R5, R3, R7 ; col_position + (queen_number - i) 
	NOT R5, R5
	ADD R5, R5, #1 ; - (col_position + (queen_number - i) )
	LDR R2, R6, #7 ; R2 = ADDRESS OF ARRAY (POSITIONS)
	ADD R2, R2, R1
	LDR R2, R2, #0 ; R2 = POSITIONS[I]
	ADD R2, R2, R5 ; R2 = POSITIONS[I] - (col_position + (queen_number - i) )
	BRZ ILLEGAL

	ADD  R1, R1, #1
	ADD R5, R1, #0
	NOT R5, R5
	ADD R5, R5, #1
	ADD R5, R5, R4 ; R5 = COUNTER - QUEEN_NUMBER
	BRNP CHECK_DAIGONAL_LOOP

STORE_COL:
	LDR R2, R6, #7 
	ADD R2, R2, R1 ; POSITIONS[i]
	STR R3, R2, #0 ; POSITIONS[i] = COL_POSITIONS
	BR END_ISLEGAL

ILLEGAL:
	ADD R0, R0, #1 ; FALSE
	BR END_ISLEGAL 

END_ISLEGAL:
LDR R1, R6, #0
LDR R2, R6, #1
LDR R3, R6, #2
LDR R4, R6, #3
LDR R5, R6, #4
LDR R7, R6, #5
ADD R6, R6, #6
RET

.END
