.ORIG X3000
;318212248,209243203

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ASTERISK .fill #42
PLUSSIGN .fill #43
HYPHENTOPRINT .fill #45
SLASH .fill #47
CARET .fill #94
EQUAL .fill #61
FIRST .fill #0
SEC .fill #0
SKIPLINE .fill #10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	AND R0,R0,#0
	AND R1,R1,#0
	AND R2,R2,#0              ;initialize all the rigeters woth zero
	AND R3,R3,#0
	AND R4,R4,#0
	AND R5,R5,#0
	AND R6,R6,#0
	
	JSR GETNUM				; jsr to GETNUM SUBROUTINE
	ADD R1,R1,#10			
	LEA R6,ARRAY        	; R6 HOLDS THE ADRESS OF ARRAY 
	LDR R0,R6,#0			
	LD R3,HYPHEN
	ADD R0,R0,R3
	BRNP WHILE4
	ADD R6,R6,#1			;; CHECK IF THE FIRST CELL IN ARRAY HAS HYPHN IF SO MOVE TO THE NEXT CELL
	WHILE4: LDR R3,R6,#0	
			AND R0,R0,#0
			ADD R0,R3,R0
	WHILESUM:		JSR Mul 	;WE TRANSFORM THE ARRAY INTO A NUMBER BY MILTIPLYING EVERY CELL WITH 10^...
				ADD R6,R6,#1
				LDR R3,R6,#0	
				ADD R3,R3,#1
				BRZ ENDWHILE4
				ADD R3,R3,#-1
				ADD R0,R2,R3
				LDR R3,R6,#1
				ADD R3,R3,#1
				BRZ ENDWHILE4
				BR WHILESUM
												;NOW R0 HAS THE NUMBER 	
	ENDWHILE4:		LD R3,HYPHEN 				;WE CHECK IF THE FIRST PLACE HAS HYPHEN THEN WE MULTYPLY WITH -1
				LEA R6,ARRAY
				LDR R2,R6,#0
				ADD R2,R2,R3
				BRNP SECONDNUM
				NOT R0,R0
				ADD R0,R0,#1
				
				
	SECONDNUM:			ST R0,FIRST   		;WE STORE THE FORST NUMBER 
						AND R3,R3,#0		;WE INITIALIZE R6 BACK TO THE ADRESS OF THE ARRAY 
						ADD R3,R3,#-1		;WE PUT -1 IN ALL THE ECELLS OF THE ARRAY 
						AND R4,R4,#0		;SO THAT WE CAN RECEIVE THE NEXT NUMBER 
						LEA R6,ARRAY  		;put -1 in the array to recive the next number  
	WHILE6: 			STR R3,R6,#0		
						ADD R6,R6,#1
						ADD R4,R4,#1
						ADD R5,R4,#-6
						BRN WHILE6
									
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;						
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				JSR GETNUM					; NOW JUMP TO THE NEXT NUM SUBROUTINE TO GET THE SECOND NUM
				LEA R6,ARRAY
				LDR R0,R6,#0				
				LD R3,HYPHEN
				ADD R0,R0,R3
				BRNP WHILE77
				ADD R6,R6,#1
	WHILE77: 	LDR R3,R6,#0				
				AND R0,R0,#0
				ADD R0,R3,R0
	WHILESUM1:	JSR Mul
				ADD R6,R6,#1
				LDR R3,R6,#0
				ADD R3,R3,#1
				BRZ ENDWHILE77
				ADD R3,R3,#-1
				ADD R0,R2,R3
				LDR R3,R6,#1
				ADD R3,R3,#1
				BRZ ENDWHILE77
				BR WHILESUM1
													
	ENDWHILE77:	LD R3,HYPHEN 
				LEA R6,ARRAY
				LDR R2,R6,#0
				ADD R2,R2,R3
				BRNP CONTINUE4
				NOT R0,R0
				ADD R0,R0,#1
				
	CONTINUE4:	ST R0,SEC
				LD R5,FIRST
				LD R6,SEC				; R5 CONTAINS THE FIRST NUMBER AND R6 
									; CONTAINS THE SECOND NUMBER THE USER ENTERED 
	ADD R0,R5,#0					;PRINTING THE ARETHMETICAL OPERATIONS 
	JSR PrintNum					; WE USE THE MUL/DIV/EXP/ SUBROUTINES
	LD R0,ASTERISK 
	OUT
	ADD R0,R6,#0
	JSR PrintNum
	LD R0,EQUAL
	OUT
	ADD R0,R5,#0
	ADD R1,R6,#0
	JSR Mul
	ADD R0,R2,#0
	JSR PrintNum
	LD R0,SKIPLINE
	OUT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ADD R0,R5,#0
	JSR PrintNum
	LD R0,SLASH 
	OUT
	ADD R0,R6,#0
	JSR PrintNum
	LD R0,EQUAL
	OUT
	ADD R0,R5,#0
	ADD R1,R6,#0
	JSR Div
	ADD R0,R2,#0
	JSR PrintNum
	LD R0,SKIPLINE
	OUT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ADD R0,R5,#0
	JSR PrintNum
	LD R0,CARET 
	OUT
	ADD R0,R6,#0
	JSR PrintNum
	LD R0,EQUAL
	OUT
	ADD R0,R5,#0
	ADD R1,R6,#0
	JSR Exp
	ADD R0,R2,#0
	JSR PrintNum
	LD R0,SKIPLINE
	OUT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ADD R0,R5,#0
	JSR PrintNum
	LD R0,PLUSSIGN
	OUT
	ADD R0,R6,#0
	JSR PrintNum
	LD R0,EQUAL
	OUT
	ADD R0,R5,R6
	JSR PrintNum
	LD R0,SKIPLINE
	OUT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ADD R0,R5,#0
	JSR PrintNum
	LD R0,HYPHENTOPRINT
	OUT
	ADD R0,R6,#0
	JSR PrintNum
	LD R0,EQUAL
	OUT
	NOT R6,R6
	ADD R6,R6,#1
	ADD R0,R5,R6
	JSR PrintNum	
	LD R0,SKIPLINE
	OUT	
		
HALT		


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ARRAY .blkw #6 #-1
ENTERNUM .stringz "Enter an integer number:"
ERROR11 .stringz "Error! You didn’t enter a number. Please enter again:"
HYPHEN .fill #-45
ERROR22 .stringz "Error! Number overflowed! Please enter again:"
COUNTERINPUT .fill #0
INPUTERROR .fill #-1
LIMIT .fill #-5
LIMITPOS .fill #-4
MAXPOS .fill #-3
	   .fill #-2
	   .fill #-7
	   .fill #-6
	   .fill #-7
MINNEGA .fill #-3
	    .fill #-2
	    .fill #-7
	    .fill #-6
	    .fill #-7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GETNUM: 

		ST R0,R0_SAVEGETNUM
		ST R1,R1_SAVEGETNUM 
		ST R2,R2_SAVEGETNUM 
		ST R3,R3_SAVEGETNUM 
		ST R4,R4_SAVEGETNUM 
		ST R5,R5_SAVEGETNUM 
		ST R6,R6_SAVEGETNUM 
		ST R7,R7_SAVEGETNUM 
		
		AND R2,R2,#0
		AND R4,R4,#0
		LEA R0, ENTERNUM
		PUTS
		BEFOREWHILE:	LEA R3,ARRAY			;R3 IS THE POINTER OF ARRAY R3 = ADRESS OF ARRAY
						AND R1,R1,#0
						AND R4,R4,#0
						AND R5,R5,#0 			;ANOTHER COUNTER THAT COUNTS OFF LIMIT  


		WHILE:		
					GETC					;GET CHAR 
					OUT
					
					ADD R2,R0,#-10  		;CHECK IF INPUT IS END OF LINE( -10 is ascii for END OF LINE)	
					BRz WHILEND		
					LD R6,HYPHEN 
					ADD R2,R0,R6			;CHECK IF WE GOT A HYPHEN
					BRz CHECKHYPHEN	
					ADD R5,R5,#1			;INCREASE COUNTER BY 1			
					BR CONTINUE1
	CHECKHYPHEN:	ADD R2,R5,#0			;CHECK WHETHER THE HYPHEN IS IN THE FIRST PLACE
					BRnp ERROR1
					STR R0,R3,#0			; SAVING VALUES			
					ADD R3,R3,#1
 					ADD R5,R5, #1			;R1 COUNTER
					BR WHILE
	

	CONTINUE1:		LD R6,ASCIIFORZERO 
					ADD R2,R0,R6			;CHECK IF LESS THAN 0 IN ASCII is -48
					BRn ERROR1
					LD R6,ASCIIFORNINE
					ADD R2,R0,R6			;CHECK IF MORE THAN NINE IN ASCII is -57
					BRp ERROR1
					ADD R2,R1,#-5			;CHECK WHETHER WE ARE STILL IN RANGE OF 5 DIGITS		
					BRn INLIMIT
					BR WHILE
					
					
	INLIMIT:		LD R6,ASCIIFORZERO		;CONVERTE FROM ASCII TO NUMERICAL
					ADD R0,R0,R6
					STR R0,R3,#0			;SAVING VALUES	
					ADD R3,R3,#1			;POINT TO THE NEXT CELL IN THE ARRAY 
					ADD R1,R1,#1 			;R1 COUNTER
					BR WHILE
					
					

	WHILEND: 			ADD R1, R1, #0
					BRz PRINTINPUTERROR	
					NOT R5,R5				
					ADD R5,R5,#1
					ADD R5,R5,R1			;CHECK WHETHER WE GOT MORE THATN 5 DIGITS
					BRn CHECK_R4			
					BR CONTINUE2

	CHECK_R4:		ADD R4, R4, #1
					BRz PRINTINPUTERROR
					LD R2, ARRAY
					LD R6, HYPHEN
					ADD R2, R2, R6
					BRnp CONTCHECK
					ADD R5, R5, #1
					BRz CONTINUE2
	CONTCHECK:		ADD R4,R4,#-1			;CHECK THE KIND OF ERROR (INDEED WE GOT MORE THAN 5 DIGITS) 
					BRz PRINTOVERFLOW
					BR PRINTINPUTERROR
					
	PRINTOVERFLOW: 	LEA R0,ERROR22
					PUTS
					AND R3,R3,#0
					ADD R3,R3,#-1
					AND R4,R4,#0
					LEA R6,ARRAY  			;put -1 in the array to recive the next number  
	WHILE88: 		STR R3,R6,#0
					ADD R6,R6,#1
					ADD R4,R4,#1
					ADD R5,R4,#-6
					BRN WHILE88
					BR BEFOREWHILE
					
	PRINTINPUTERROR: LEA R0,ERROR11			
					 PUTS
					 BR BEFOREWHILE
				

	ERROR1:				
					LD R4,INPUTERROR   				; R4 HAS THE KIND OF ERROR
					BR WHILE
					
					
	CONTINUE2:		
					ST R1,COUNTERINPUT				;R1 IS A COUNTER
					LEA R0,ARRAY					;VALID INPUT (NEED TO CHECK DIGITS)
					;----------------------------------------------------------------------------------
					LDR R1,R0,#0
					LD R6,HYPHEN
					ADD R2,R1,R6
					BRz MINUSNUMBER
					BR POSITIVENUMBER
	MINUSNUMBER:	ADD R0,R0,#1					;BECAUSE IN THE FIRST CELL WE HAVE "-" 
					LD R1,COUNTERINPUT				; NUMBER OF DIGITS THE USER ENTERED
					ADD R1,R1,#-5					;CHECK IF WE HAVE LESS THAN 5 DIGITS		
					BRn EXITLOOP			
					LEA R1,MINNEGA   				; min negative (no racism) POINTER R1
					LD R5,COUNTERINPUT
					ADD R5,R5,#-1					;NOW R5 IS THE COUNTER 
	WHILE1:			LDR R3,R0,#0
					LDR R4,R1,#0	
					ADD R2,R3,R4
					BRp OVERFLOW
					BRn EXITLOOP
					ADD R0,R0,#1
					ADD R1,R1,#1
					ADD R5,R5,#-1
					BRzp WHILE1
					BR EXITLOOP
					
					
					
	POSITIVENUMBER:	LD R1,COUNTERINPUT
					ADD R1,R1,#-5 					; POSITIVE NUMBER NO HYPHEN 0 - 4 == 5
					BRn EXITLOOP
					LEA R1,MAXPOS   
					LD R5,COUNTERINPUT
	WHILE2:			LDR R3,R0,#0
					LDR R4,R1,#0
					ADD R2,R3,R4
					BRp OVERFLOW
					BRn EXITLOOP
					ADD R0,R0,#1
					ADD R1,R1,#1
					ADD	R5,R5,#-1
					BRzp WHILE2
					BR EXITLOOP
					
					
	OVERFLOW:		BR PRINTOVERFLOW
	EXITLOOP:
	
	LD R0,R0_SAVEGETNUM
	LD R1,R1_SAVEGETNUM
	LD R2,R2_SAVEGETNUM
	LD R3,R3_SAVEGETNUM
	LD R4,R4_SAVEGETNUM
	LD R5,R5_SAVEGETNUM
	LD R6,R6_SAVEGETNUM
	LD R7,R7_SAVEGETNUM
	
	
RET 
R0_SAVEGETNUM .fill #0
R1_SAVEGETNUM .fill #0
R2_SAVEGETNUM .fill #0
R3_SAVEGETNUM .fill #0
R4_SAVEGETNUM .fill #0
R5_SAVEGETNUM .fill #0
R6_SAVEGETNUM .fill #0
R7_SAVEGETNUM .fill #0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ASCIIFORZERO .fill #-48
ASCIIFORNINE .fill #-57
ASCIIFORENDLINE .fill #-10

R0_STOREPRINTNUM .fill #0
R1_STOREPRINTNUM .fill #0
R2_STOREPRINTNUM .fill #0
R3_STOREPRINTNUM .fill #0
R4_STOREPRINTNUM .fill #0
R5_STOREPRINTNUM .fill #0
R6_STOREPRINTNUM .fill #0
R7_STOREPRINTNUM .fill #0

ARRAY2 .blkw #5 #-1
ORIGINALNUM .fill #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PrintNum:									; we have a number in R0 and we need tO print it
				ST R0,R0_STOREPRINTNUM 
				ST R1,R1_STOREPRINTNUM 
				ST R2,R2_STOREPRINTNUM 
				ST R3,R3_STOREPRINTNUM 		
				ST R4,R4_STOREPRINTNUM 
				ST R5,R5_STOREPRINTNUM 
				ST R6,R6_STOREPRINTNUM
				ST R7,R7_STOREPRINTNUM
				
				ADD R0, R0 #0				;CHECCK IF THE NUMBER WE GOT IS ZERO 
				BRz PRINTZERO
				
				AND R1,R1,#0				;WE INITIALIZE R1 TO ZERO 
				ST R0,ORIGINALNUM           ;WE STORE THE ORIGINAL NUM AN ADRESS                              
				ADD R1,R1,#10				;R1 HOLDS 10
				LEA R6,ARRAY2				;R6 IS A POINTER TO ARRAY2
WHILE3:			ADD R0,R0,#0				;WE KEEP DIV BY 10 SO WE NEED TO CHECK IF WE DONE DIVIDING
				BRZ ENDWHILE
				JSR Div						;R3 has THE shareet		 
				STR R3,R6,#0				;WE TAKE EVERY DIGIT AND STORE IT IN THE ARRAY2
				ADD R6,R6,#1
				ADD R0,R2,#0                                                                    
				BRnp WHILE3       
			
				AND R3, R3, #0				;R3 = 0
				LEA R6, ARRAY2				;R6 POINTS TO ARRAY2
ENDWHILE:		LDR R2, R6, #0				;MEM[R6]-> R2
				ADD R2, R2, #1				; WE NEED TO CHECK WHETHER WE GOT -1 (THIS MEANS THAT WE ARE DONE WITH THE DIGITS)
				BRz CONTINUE3				
				ADD R6, R6, #1				;R6=R6+1
				ADD R3, R3, #1				;R3 IS A COUNTER
				ADD R2, R3, #-5				;CHECK IF WE GOT TO LIMIT OF DIGITS
				BRz CONTINUE3
				Br ENDWHILE
			

CONTINUE3:  	AND R0,R0,#0				;WE SEPERATED  THE NUMBER INTO DIGITS 
				LD R1, ORIGINALNUM			;BUT IT MIGHT BE NEGATIVE NUM 
				ADD R1, R1, #0				;SO WE NEED TO CHECK THE ORIGINAL NUM 
				BRzp POSITIVECASE
				LD R1,HYPHEN				;IN CASE WE GOT A NEGATIVE NUM 
				ADD R0, R0,R1				; WE PRINT HYPHEN 
				NOT R0, R0
				ADD R0, R0, #1
				OUT
			
			
POSITIVECASE:	LEA R6, ARRAY2				;WE NEED TO PRINT THE DIGITS
				ADD R6, R6, R3				;BUT BEFORE THAT WE NEED TO CONVERTE THE DIGITS INTO THEIR 
				ADD R6,R6,#-1				;ASCII VALUE 
				LDR R0, R6, #0				
				LD R1 ASCIIFORZERO
				NOT R1,R1
				ADD R1,R1,#1
				ADD R0, R0, R1
				OUT
				ADD R3, R3, #-1			;R3 IS A ACOUNTER WE NEED TO NOT PRINT OTHER VALUES
				BRp POSITIVECASE
				Br RELOAD

PRINTZERO:		LD R1 ASCIIFORZERO		;PRINT ZERO 
				NOT R1,R1
				ADD R1,R1,#1
				ADD R0, R0, R1
				OUT

RELOAD:			LEA R6, ARRAY2		;R6 = ARRAY2
				AND R4, R4, #0		;R4 =0
				AND R3, R3, #0		;R3 = 0
				ADD R3, R3, #-1		;R3 = -1				WE PUT -1 IN THE ARRAY CELLS IN CASE WE NEED TO USE IT AGAIN
INNERRELOAD:	STR R3, R6, #0		;R3 = MEM[R6]
				ADD R6, R6, #1		;R6=R6+1
				ADD R4, R4, #1		;R4=R4+1
				ADD R5, R4, #-5		;
				BRz ENDRELOAD
				Br INNERRELOAD				
ENDRELOAD:				
				LD R0,R0_STOREPRINTNUM 
				LD R1,R1_STOREPRINTNUM 
				LD R2,R2_STOREPRINTNUM 
				LD R3,R3_STOREPRINTNUM 
				LD R4,R4_STOREPRINTNUM 
				LD R5,R5_STOREPRINTNUM 
				LD R6,R6_STOREPRINTNUM
				LD R7,R7_STOREPRINTNUM 
				
				
				
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
R0_STOREMUL .fill #0
R1_STOREMUL .fill #0
R3_STOREMUL .fill #0
R4_STOREMUL .fill #0
R5_STOREMUL .fill #0
R6_STOREMUL .fill #0
R7_STOREMUL .fill #0
ZERO .fill #0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Mul: ; Mul subroutine : R2 <-- R0 * R1
ST R0,R0_STOREMUL
ST R1,R1_STOREMUL
ST R3,R3_STOREMUL ; we store the values of R3,R4,R5, so that we dont lose the data
ST R4,R4_STOREMUL
ST R5,R5_STOREMUL
ST R6,R6_STOREMUL
ST R7,R7_STOREMUL


AND R2,R2,#0     ;initiating the values of R2,R4,R5 with zero becaue we want to use them
AND R4,R4,#0 
AND R5,R5,#0
 
ADD R0, R0, #0 ; we are given the values in R0 and R1 so we check , in case we have 0 0*any num is  0
BRz End
ADD R1, R1, #0 ; same here 
BRz End
LD R3,ZERO     
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
LD R0,R0_STOREMUL
LD R1,R1_STOREMUL
LD R3,R3_STOREMUL ; we load back tha values we saved in the start of mul subrotine 
LD R4,R4_STOREMUL
LD R5,R5_STOREMUL
LD R6,R6_STOREMUL
LD R7,R7_STOREMUL

RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; we need to calculate R0^R1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ILLEGAL .fill #-1 

R0_STOREEXP .fill #0
R1_STOREEXP .fill #0
R3_STOREEXP .fill #0
R4_STOREEXP .fill #0
R5_STOREEXP .fill #0
R6_STOREEXP .fill #0
R7_STOREEXP .fill #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Exp: 			; this subrotine uses the mul subrotine
ST R0,R0_STOREEXP 	;we store the current value og R7 because we will ned to JSR to another subroutine
ST R1,R1_STOREEXP
ST R3,R3_STOREEXP
ST R4,R4_STOREEXP
ST R5,R5_STOREEXP
ST R6,R6_STOREEXP
ST R7,R7_STOREEXP

AND R2,R2,#0	; initiateing the rigesters we want to use with 0
AND R3,R3,#0
AND R4,R4,#0
AND R5,R5,#0

ADD R0,R0,#0 	;check if the value of R0 is zero then the result is zero 
BRn end1		;and if the value is negative then the result is not defined
BRz checkR1		
ADD R1,R1,#0	;in case R1 is negative the calculation is not defined	
BRn end1		
ADD R3,R0,#0	;R3 = R0 
NOT R3,R3
ADD R3,R3,#1	;R3 = -R3
ADD R3,R3,#1	; start counting how many times we will do R0*R0
BRz end2		;
ADD R4,R1, #0	; R4 = R1
AND R1,R1,#0	;R1 = 0
ADD R1,R0,#0	;R1 = R0
ADD R4,R4,#-1	;R4 = R4 -1 ;R4 IS THE COUNTER
BRZ R1ISONE
BR loop

R1ISONE: ADD R2,R0,#0
BR endfinal

loop:			; LOOP 
ADD R4,R4, #0	; in case we are finished caclculating
Brz endfinal	
JSR Mul			; we jump to the mul subroutine 
AND R0,R0, #0	;R0 = 0
ADD R0, R2, #0 	;R0 = R2 ; because mul clculates R2 = R0*R1
ADD R4,R4,#-1	; we decrease the counter by one 
BR loop			; go back to the loop
	
checkR1:		;this branch we get into to check if R1 is zero or negative			
ADD R1,R1,#0
BRnz end1
AND R2,R2,#0
BR endfinal

end1:			; puts illegal = -1 in r2
LD R2 ,ILLEGAL
BR endfinal

end2:			;any number^0 = 1
ADD R2,R2,#1

endfinal:		;we reload the saved value and we are done
LD R0,R0_STOREEXP
LD R1,R1_STOREEXP
LD R3,R3_STOREEXP
LD R4,R4_STOREEXP
LD R5,R5_STOREEXP
LD R6,R6_STOREEXP
LD R7,R7_STOREEXP
RET 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; explaining the Div subroutine we  need to calculate R2 = R0/R1 and the remaining division we load 
; in R3 , we calculate it by subtracting and counting so we save the values of r0,r1 in r4,r5
; and we make sure that r4 is positive and r5 is negative so that we can apply ADD on them 
; after we do that we have a problem whitch is when one of them is negative or both of them are negative 
; so in the end we chech the true values of r0 ,r1 and then we decide whether thehe value of r3
; must be nagative ( in case only one of the (r0,r1 ) is negative ) and must be positive 
; if they are both positive/negative 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
R0_STOREDIV .fill #0
R1_STOREDIV .fill #0
R4_STOREDIV .fill #0
R5_STOREDIV .fill #0
R6_STOREDIV .fill #0
R7_STOREDIV .fill #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
Div:
ST R0,R0_STOREDIV
ST R1,R1_STOREDIV
ST R4,R4_STOREDIV
ST R5,R5_STOREDIV
ST R6,R6_STOREDIV
ST R7,R7_STOREDIV


AND R2,R2,#0 		; initiating R2,R3,R4,R5 with 0 
AND R3,R3,#0
AND R4,R4,#0
AND R5,R5,#0

ADD R1,R1,#0 	;check whether R1 IS ZERO becaues dividing by zero is not defined
BRz resultill 
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

resultill:    	; result is illegal illegal vlue is -1 
LD R2,ILLEGAL
LD R3,ILLEGAL
end:
LD R0,R0_STOREDIV
LD R1,R1_STOREDIV
LD R4,R4_STOREDIV
LD R5,R5_STOREDIV
LD R6,R6_STOREDIV
LD R7,R7_STOREDIV
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;