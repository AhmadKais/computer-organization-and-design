;AHMAD KAIS : 318212248 ,50%
;ROJEH SHALABI : 209243203 ,50%
;OUR CODE SUPPORTS THE BONUS REQUIREMENTS ; JUST SET THE PC TO X3000 AND  RUN 
.ORIG X3000
		
AND R3,R3,#0		;R3 = 0
AND R4,R4,#0		;R4 = 0
ADD R4,R4,#1
LEA R0,ENTER_STUDENTS_NUM 
PUTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	WHILE11: 	GETC
				OUT
				ADD R3,R0,#0				;R3 = R0 (THE ASCII VALUETHAT THE USER ENTERED
				LD R6,ASCII_END_LINE
				ADD R3,R3,R6				;check if we got to the end of a line 
				BRZ WHILE_ENDD
				ADD R3,R0,#0
				LD R6,ASCIIFORSPACE
				ADD R3,R3,R6				;check if we got a space 
				BRZ LASTINPUT
				BR ENTERGRADE			
			
	LASTINPUT: 	LD R6,ASCIIFORSPACE			;WE CHECK THE PREVIOUS INPUT IN CASE WE HAD A NUMMBER AND THEN WE GOT SPACE
			ADD R6, R1,R6					;THIS MEANS THAT WE ARE DONE RECEIVING THE NUMBER AND WE NEED TO START 
			BRz WHILE11						;RECEIVING THE NEXT NUMBER 
			ADD R4, R4, #1					;IN CASE WE GOT A SPACE AND PREVIOUSLY ANOOTHER SPACE WE SKIP IT
			ADD R1, R0, #0
			BR WHILE11
			   
			   		   
	ENTERGRADE:		LD R6,ASCII_FOR_ZERO
				ADD R3,R0,R6   			 	;CHANGE THE VALUE FROM ASCII TO NORMAL NUMBER 
				ADD R1, R0, #0				;SAVE LAST INPUT IN R1
				ADD R0,R4,#0				;R4 IS A COUNTER TO KNOW IN WHITCH ARRAY WE PUT THE RECEIVED INPUT
				ADD R0,R0,#-1											
				BRZ FILL_NUM_COURSE1
				ADD R0,R0,#1
				ADD R0,R0,#-2
				BRZ FILL_NUM_COURSE2
				ADD R0,R0,#2
				ADD R0,R0,#-3
				BRZ FILL_NUM_COURSE3
				ADD R0,R0,#4
				BR WHILE11
						
	
	FILL_NUM_COURSE1:	LEA R6,COURSE1_NUM_OF_STUDENTS			;in this label WE INSERT THE PROPER DIGIT IN THE PROPER ARRAY 	
		NEXT11:		LDR R5,R6,#0
					ADD R5,R5,#1
					BRNP NEXT_CELL1
					STR R3,R6,#0
					BR WHILE11
						
	NEXT_CELL1: ADD R6,R6,#1
				BR NEXT11
					
	FILL_NUM_COURSE2:	LEA R6,COURSE2_NUM_OF_STUDENTS				
		NEXT22:		LDR R5,R6,#0
					ADD R5,R5,#1
					BRNP NEXT_CELL2
					STR R3,R6,#0
					BR WHILE11
						
	NEXT_CELL2: ADD R6,R6,#1
				BR NEXT22
				
	FILL_NUM_COURSE3:	LEA R6,COURSE3_NUM_OF_STUDENTS				
		NEXT33:		LDR R5,R6,#0
					ADD R5,R5,#1
					BRNP NEXT_CELL3
					STR R3,R6,#0
					BR WHILE11
						
	NEXT_CELL3: ADD R6,R6,#1
				BR NEXT33

	
	WHILE_ENDD:	LEA R6,COURSE1_NUM_OF_STUDENTS
			JSR CONVERTE_ARRAY_NUMBER ;RETURNS IN R0 THE NUMBER 
			ST R0,NUM_OF_STUDENTS1   	; here we store the number of students whitch is returned in r0 in a label
			LEA R6,COURSE2_NUM_OF_STUDENTS
			JSR CONVERTE_ARRAY_NUMBER ;RETURNS IN R0 THE NUMBER 
			ST R0,NUM_OF_STUDENTS2
			LEA R6,COURSE3_NUM_OF_STUDENTS
			JSR CONVERTE_ARRAY_NUMBER ;RETURNS IN R0 THE NUMBER 
			ST R0,NUM_OF_STUDENTS3
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;NOW WE HAVE THE NUMBER OF STUDENTS IN EATCH COURSE
	LEA R0,ENTER_COURSE1
	PUTS 
	AND R0,R0,#0
	ADD R0,R0,#10
	OUT
	LEA R1,COURSE1
	LD R2,NUM_OF_STUDENTS1
	JSR GetStudentGrades		;IN THIS SUBROTINE WE INSERT THE RECIVED GRADES IN A LINKED LIST  
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LEA R0,ENTER_COURSE2
	PUTS 
	AND R0,R0,#0
	ADD R0,R0,#10
	OUT
	LEA R1,COURSE2
	LD R2,NUM_OF_STUDENTS2
	JSR GetStudentGrades
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LEA R0,ENTER_COURSE3
	PUTS 
	AND R0,R0,#0
	ADD R0,R0,#10
	OUT
	LEA R1,COURSE3
	LD R2,NUM_OF_STUDENTS3
	JSR GetStudentGrades
									;WE NEED TO CALCULATE THE AVERAGE OF THE LINKED LISTS
	LEA R1,COURSE1
	LD R2,NUM_OF_STUDENTS1			;AVERAGE CALC TAKED LINKED LIST FILLED WITH GRADES AND CALCULATES THE AVERAGE AND UPDATES IT
	JSR AverageCalculator
	;;;;;;;;;;;;;;;;;;;;;;
	LEA R1,COURSE2
	LD R2,NUM_OF_STUDENTS2
	JSR AverageCalculator
	;;;;;;;;;;;;;;;;;;;;;;
	LEA R1,COURSE3
	LD R2,NUM_OF_STUDENTS3
	JSR AverageCalculator
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LEA R0,THE_TOP_6
	PUTS
							;;;;we need to sort the lists
	LEA R1,COURSE1
	LD R2,NUM_OF_STUDENTS1
	JSR BubbleSort			;WE SORT THE LIST BASED ON THE AVERAGE OF EATCH STUDENT 
	LEA R1,COURSE2
	LD R2,NUM_OF_STUDENTS2
	JSR BubbleSort
	;;;;;
	LEA R1,COURSE3
	LD R2,NUM_OF_STUDENTS3
	JSR BubbleSort
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;JSR FILL_ARRAY
	LEA R2,TEMP_ARRAY1 	
	LEA R1,COURSE1
	JSR FILL_ARRAY		;GIVEN AN ARRAY AND LINKED LIST WE FINN THE ARRAY WITH THE AVERAGE (WE MAKE SURE WE HAVE NO REPEATED VALUES
	;;;;;;;;;;
	LEA R2,TEMP_ARRAY2
	LEA R1,COURSE2
	JSR FILL_ARRAY
	;;;;;;;;;;;;
	LEA R2,TEMP_ARRAY3
	LEA R1,COURSE3
	JSR FILL_ARRAY
	;;;;;;;;;;;;;
	LEA R1,TEMP_ARRAY1 ;R1 NOW IS A POINTER TO ARRAY1
	LEA R2,TEMP_ARRAY2
	LEA R3,TEMP_ARRAY3
	LEA R6, FINAL_ARRAY		
	
	JSR FILLFINALARRAY		;WE GOT THREE ARRAYS THAT CONTAINS THE TOP BEST 6 AVERAGE OF STUDENTS IN EATCH COURSE
							;WE FILL THE FINAL_ARRAY WITH TOP 6 AVERAGES IN THE THREE COURSES 
							;NOW WE NEED TO PRINT TOP 6 AVERAGES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;DELETED_CODE














;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
							
			;MAYBE WE NEED TO PUT -1 IN ALL THE LINKED LISTS AND THE ARRAYS
ENDPROGRAM: 		LEA R1,COURSE1
			JSR DESTROY_LIST
			LEA R1,COURSE2
			JSR DESTROY_LIST
			LEA R1,COURSE3
			JSR DESTROY_LIST
			AND R2,R2,#0
			ADD R2,R2,#3
			AND R3,R3,#0
			ADD R3,R3,#-1
			LEA R1,COURSE1_NUM_OF_STUDENTS
			JSR DESTROY_ARRAY
			LEA R1,COURSE2_NUM_OF_STUDENTS
			JSR DESTROY_ARRAY
			LEA R1,COURSE3_NUM_OF_STUDENTS
			JSR DESTROY_ARRAY
			ADD R2,R2,#4
			LEA R1,TEMP_ARRAY1
			JSR DESTROY_ARRAY
			LEA R1,TEMP_ARRAY2
			JSR DESTROY_ARRAY
			LEA R1,TEMP_ARRAY3
			JSR DESTROY_ARRAY
			ADD R2,R2,#-1
			AND R3,R3,#0
			LEA R1,FINAL_ARRAY
			JSR DESTROY_ARRAY
			
HALT
;-------------------------------------------------------------------------------------------------------------
ASCIIFORSPACE .fill #-32
ASCII_END_LINE .fill #-10
ASCII_FOR_ZERO .fill #-48
ENTER_COURSE3 .stringz "Enter the student grades in course 3:"

COURSE1_NUM_OF_STUDENTS .blkw #3 #-1

COURSE2_NUM_OF_STUDENTS .blkw #3 #-1

COURSE3_NUM_OF_STUDENTS .blkw #3 #-1

COURSE1 .fill Item_1
COURSE2 .fill Item_1_COURSE2
COURSE3 .fill Item_1_COURSE3
NUM_OF_STUDENTS1 .fill #-1
NUM_OF_STUDENTS2 .fill #-1
NUM_OF_STUDENTS3 .fill #-1
THE_TOP_6 .stringz "The six highest scores are:"
ENTER_STUDENTS_NUM .stringz "Enter the number of students in each course:"
ENTER_COURSE1 .stringz "Enter the student grades in course 1:"
ENTER_COURSE2 .stringz "Enter the student grades in course 2:"
TEMP_ARRAY1 .blkw #7 #-1
TEMP_ARRAY2 .blkw #7 #-1
TEMP_ARRAY3 .blkw #7 #-1
FINAL_ARRAY .blkw #6 #0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;DESTROY LIST GIVEN IN R1
DESTROY_LIST:
		ST R0,R0_DESTROY_LIST
		ST R1,R1_DESTROY_LIST
		ST R2,R2_DESTROY_LIST
		ST R3,R3_DESTROY_LIST
		ST R4,R4_DESTROY_LIST
		ST R5,R5_DESTROY_LIST
		ST R6,R6_DESTROY_LIST
		ST R7,R7_DESTROY_LIST
		LDR R1,R1,#0  ; R1 = ITEM1
		AND R6,R6,#0
		ADD R6,R6,#10 
		AND R5,R5,#0
		ADD R5,R5,#-1
			LOOP_OVER_LISTS:	STR R5,R1,#0
								STR R5,R1,#1
								STR R5,R1,#2
								STR R5,R1,#3
								STR R5,R1,#4
								LDR R1,R1,#6
								ADD R6,R6,#-1
								BRZ DONE_DESTROY
								BR LOOP_OVER_LISTS
								
			DONE_DESTROY:	LD R0,R0_DESTROY_LIST
							LD R1,R1_DESTROY_LIST
							LD R2,R2_DESTROY_LIST
							LD R3,R3_DESTROY_LIST
							LD R4,R4_DESTROY_LIST
							LD R5,R5_DESTROY_LIST
							LD R6,R6_DESTROY_LIST
							LD R7,R7_DESTROY_LIST
RET 
R0_DESTROY_LIST .fill #0
R1_DESTROY_LIST .fill #0
R2_DESTROY_LIST .fill #0
R3_DESTROY_LIST .fill #0
R4_DESTROY_LIST .fill #0
R5_DESTROY_LIST .fill #0
R6_DESTROY_LIST .fill #0
R7_DESTROY_LIST .fill #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;DESTROY ARRAY TAKES IN R1 ADRESS OF ARRAY IN R2 LENGTH OF IT AND IN R3, THE VALUE WE NEED TO INSERT IN IT
DESTROY_ARRAY:
			ST R0,R0_DESTROY_ARRAY
			ST R1,R1_DESTROY_ARRAY
			ST R2,R2_DESTROY_ARRAY
			ST R3,R3_DESTROY_ARRAY
			ST R4,R4_DESTROY_ARRAY
			ST R5,R5_DESTROY_ARRAY
			ST R6,R6_DESTROY_ARRAY
			ST R7,R7_DESTROY_ARRAY
			
			
			LOOP_OVER_THE_ARRAY:	STR R3,R1,#0
									ADD R2,R2,#-1
									BRZ DONE_DESTROYING_ARRAY
									ADD R1,R1,#1
									BR LOOP_OVER_THE_ARRAY
									
									
			DONE_DESTROYING_ARRAY:	LD R0,R0_DESTROY_ARRAY
									LD R1,R1_DESTROY_ARRAY
									LD R2,R2_DESTROY_ARRAY
									LD R3,R3_DESTROY_ARRAY
									LD R4,R5_DESTROY_ARRAY
									LD R6,R6_DESTROY_ARRAY
									LD R7,R7_DESTROY_ARRAY
RET
R0_DESTROY_ARRAY .fill #0
R1_DESTROY_ARRAY .fill #0
R2_DESTROY_ARRAY .fill #0
R3_DESTROY_ARRAY .fill #0
R4_DESTROY_ARRAY .fill #0
R5_DESTROY_ARRAY .fill #0
R6_DESTROY_ARRAY .fill #0
R7_DESTROY_ARRAY .fill #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;this subroutine receives in R1 the adress of the linked list(course) and in R2 the number of students in the course
AverageCalculator: 
	ST R0,R0_SAVE_AVERAGE_CALC
	ST R1,R1_SAVE_AVERAGE_CALC
	ST R2,R2_SAVE_AVERAGE_CALC		;REGISTERS BACK UP
	ST R3,R3_SAVE_AVERAGE_CALC
	ST R4,R4_SAVE_AVERAGE_CALC
	ST R5,R5_SAVE_AVERAGE_CALC
	ST R6,R6_SAVE_AVERAGE_CALC
	ST R7,R7_SAVE_AVERAGE_CALC
	
	ST R1,LIST_POINTER_FOR_ITERATION
	ST R2,NUMBER_OF_NODES
	LDR R6,R1,#0	;R6 = ITEM1	
	AND R0,R0,#0
	AND R1,R1,#0
	ADD R1,R1,#4
	ADD R4,R2,#0				;R4 IS THE COUNTER(STUDENT NUM)
	LOOP_OVER_THE_LIST:
			AND R0,R0,#0		; HERE WE DO (HW1+HW2+HW3+MIDTERM)/4 USING  
			LDR R5,R6,#0		; THE DIV SUBROUTINE FROM PREVIOUS HW AND THE VALUE WE STORE IN AVERAGE FEILD
			ADD R0,R0,R5
			LDR R5,R6,#1
			ADD R0,R0,R5
			LDR R5,R6,#2
			ADD R0,R0,R5
			LDR R5,R6,#3
			ADD R0,R0,R5
			JSR Div
			STR R2,R6,#4
			ADD R4,R4,#-1
			BRZ END_LOOP
			LDR R6,R6,#6
			BR LOOP_OVER_THE_LIST
			
	END_LOOP:	LD R0,R0_SAVE_AVERAGE_CALC
				LD R1,R1_SAVE_AVERAGE_CALC
				LD R2,R2_SAVE_AVERAGE_CALC
				LD R3,R3_SAVE_AVERAGE_CALC
				LD R4,R4_SAVE_AVERAGE_CALC
				LD R5,R5_SAVE_AVERAGE_CALC
				LD R6,R6_SAVE_AVERAGE_CALC
				LD R7,R7_SAVE_AVERAGE_CALC
	RET
;------------------------------------------------------------------------------------------;
R0_SAVE_AVERAGE_CALC .fill #0
R1_SAVE_AVERAGE_CALC .fill #0
R2_SAVE_AVERAGE_CALC .fill #0
R3_SAVE_AVERAGE_CALC .fill #0
R4_SAVE_AVERAGE_CALC .fill #0
R5_SAVE_AVERAGE_CALC .fill #0
R6_SAVE_AVERAGE_CALC .fill #0
R7_SAVE_AVERAGE_CALC .fill #0
LIST_POINTER_FOR_ITERATION .fill #-1
NUMBER_OF_NODES .fill #-1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 
				
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONVERTE_ARRAY_NUMBER: ; GETS ADDRESS OF (IN R6) ARRAY OF DIGITS AND RETURNS THE NUMBER IN R0		
			ST  R1, R1_CONVERTE_ARRAY_NUMBER
			ST  R2, R2_CONVERTE_ARRAY_NUMBER
			ST  R3, R3_CONVERTE_ARRAY_NUMBER
			ST  R4, R4_CONVERTE_ARRAY_NUMBER
			ST  R5, R5_CONVERTE_ARRAY_NUMBER
			ST  R6, R6_CONVERTE_ARRAY_NUMBER
			ST  R7, R7_CONVERTE_ARRAY_NUMBER
			
			AND R4, R4, #0
			AND R1, R1, #0
			ADD R4, R4, #0 
			ST R6, ARR_ADDRESS				;WE HAVE AN ARAY OF DIGITS WE CONVERTE THEM INTO A NUMBER IN R0
			ADD R1, R1, #10
			AND R0, R0, #0
			LDR R3, R6, #0
			ADD R3, R3, #1
			BRZ END_F
			ADD R3, R3, #-1
			
JMP_MUL:		JSR Mul
			ADD R0, R3, R2
			ADD R6, R6, #1
			ADD R4, R4, #1
			ADD R5, R4, #0
			ADD R5, R5, #-3   ; OUT OF RANGE 
			BRzp END_F
			LDR R3, R6, #0
			ADD R3, R3, #1
			BRZ END_F
			ADD R3, R3, #-1
			BR JMP_MUL	

END_F:			LD R6, ARR_ADDRESS ;RESET THE ARRAY
			AND R1, R1, #0
			ADD R1, R1, #-1
			STR R1, R6, #0
			ADD R6, R6, #1
			STR R1, R6, #0
			ADD R6, R6, #1
			STR R1, R6, #0
			
			

	LD  R1, R1_CONVERTE_ARRAY_NUMBER
	LD  R2, R2_CONVERTE_ARRAY_NUMBER
	LD  R3, R3_CONVERTE_ARRAY_NUMBER
	LD  R4, R4_CONVERTE_ARRAY_NUMBER
	LD  R5, R5_CONVERTE_ARRAY_NUMBER
	LD  R6, R6_CONVERTE_ARRAY_NUMBER
	LD  R7, R7_CONVERTE_ARRAY_NUMBER
					
	
RET

;CONVERTE_ARRAY_NUMBER -SAVE REGISTERS
R1_CONVERTE_ARRAY_NUMBER .fill #0
R2_CONVERTE_ARRAY_NUMBER .fill #0
R3_CONVERTE_ARRAY_NUMBER .fill #0
R4_CONVERTE_ARRAY_NUMBER .fill #0
R5_CONVERTE_ARRAY_NUMBER .fill #0
R6_CONVERTE_ARRAY_NUMBER .fill #0
R7_CONVERTE_ARRAY_NUMBER .fill #0
ARR_ADDRESS .fill #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Item_1 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill 	#-1
		.fill 	#-1
		.fill   #-1
		.fill Item_2
Item_2 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill Item_1
		.fill Item_3
Item_3 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill Item_2
		.fill Item_4
Item_4 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_3
		.fill Item_5
Item_5 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_4
		.fill Item_6
Item_6 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_5
		.fill Item_7
Item_7 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_6
		.fill Item_8		
Item_8 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill 	#-1
		.fill 	#-1
		.fill Item_7
		.fill Item_9
Item_9 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_8
		.fill Item_10
Item_10 .fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_9
		.fill 	#-1
;---------------------------------------------------------------------------------------------------------
Item_1_COURSE2 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill 	#-1
		.fill 	#-1
		.fill   #-1
		.fill Item_2_COURSE2
Item_2_COURSE2 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill Item_1_COURSE2
		.fill Item_3_COURSE2
Item_3_COURSE2 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill Item_2_COURSE2
		.fill Item_4_COURSE2
Item_4_COURSE2 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_3_COURSE2
		.fill Item_5_COURSE2
Item_5_COURSE2 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_4_COURSE2
		.fill Item_6_COURSE2
Item_6_COURSE2 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_5_COURSE2
		.fill Item_7_COURSE2
Item_7_COURSE2 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_6_COURSE2
		.fill Item_8_COURSE2		
Item_8_COURSE2 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill 	#-1
		.fill 	#-1
		.fill Item_7_COURSE2
		.fill Item_9_COURSE2
Item_9_COURSE2 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_8_COURSE2
		.fill Item_10_COURSE2
Item_10_COURSE2 .fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_9_COURSE2
		.fill 	#-1
;----------------------------------------------------------------------------------------------------------------
Item_1_COURSE3 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill 	#-1
		.fill 	#-1
		.fill   #-1
		.fill Item_2_COURSE3
Item_2_COURSE3 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill Item_1_COURSE3
		.fill Item_3_COURSE3
Item_3_COURSE3 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill Item_2_COURSE3
		.fill Item_4_COURSE3
Item_4_COURSE3 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_3_COURSE3
		.fill Item_5_COURSE3
Item_5_COURSE3 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_4_COURSE3
		.fill Item_6_COURSE3
Item_6_COURSE3 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_5_COURSE3
		.fill Item_7_COURSE3
Item_7_COURSE3 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_6_COURSE3
		.fill Item_8_COURSE3		
Item_8_COURSE3 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1	
		.fill 	#-1
		.fill 	#-1
		.fill Item_7_COURSE3
		.fill Item_9_COURSE3
Item_9_COURSE3 	.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_8_COURSE3
		.fill Item_10_COURSE3
Item_10_COURSE3 .fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill 	#-1
		.fill Item_9_COURSE3
		.fill 	#-1		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GetStudentGrades:	;given in R1 an adress of a linked list ,in R2 number of students 
ST R0,R0_GetStudentGrades
ST R1,R1_GetStudentGrades
ST R2,R2_GetStudentGrades
ST R3,R3_GetStudentGrades
ST R4,R4_GetStudentGrades
ST R5,R5_GetStudentGrades
ST R6,R6_GetStudentGrades
ST R7,R7_GetStudentGrades

AND R3,R3,#0
AND R4,R4,#0
ADD R4,R4,#1	;A COUNTER TO KNOW WHITCH GRADE WE ARE ENTERING FOR NOW 	
ST R2, STUDENT_NUMBERS
LDR R1,R1,#0	;R1 = ITEM1
ST R1,COURSE_LIST_ADRESS					
	FOR1:	AND R3,R3,#0
		AND R4,R4,#0
		ADD R4,R4,#1	;A COUNTER TO KNOW WHITCH GRADE WE ARE ENTERING FOR NOW 
		WHILE1:
			GETC
			OUT
			ADD R3,R0,#0
			LD R6,ASCIIFORENDLINE
			ADD R3,R3,R6				;check if we got to the end of a line 
			BRZ WHILE_END
			ADD R3,R0,#0
			LD R6,ASCIIFORSPACE32
			ADD R3,R3,R6				;check if we got a space 
			BRZ LASTINPUTTTT
			BR ENTERGRADE1211			
			
	LASTINPUTTTT: 	LD R6,ASCIIFORSPACE32			; IN CASE WE GOT ANOTHER SPACE WE CHECK PREVIOUS INPUT
			ADD R6, R1,R6							; BECAUSE THE USER CAN ENTER MORE THAN ONE SPACE 
			BRz WHILE1
			ADD R4, R4, #1
			ADD R1, R0, #0
			BR WHILE1
			   
			   		   
	ENTERGRADE1211:		AND R6,R6,#0
				LD R6,ASCII_ZERO
				AND R3,R3,#0
				ADD R3,R0,R6   			 	;CHANGE THE VALUE FROM ASCII TO NORMAL NUMBER 
				ADD R1, R0, #0							;SAVE LAST INPUT IN R1
				ADD R0,R4,#-1							; WE HAVE 4 DIFFERENT ARRAYS THAT WE SAVE THE DIGITS IN  				
				BRZ FILL_GRADE1							;THEN WE CONVERTE THE ARRAY TO NUMBER TO SAVE THEM IN THE LINKED LIST 
				ADD R0,R0,#1
				ADD R0,R0,#-2
				BRZ FILL_GRADE2
				ADD R0,R0,#2
				ADD R0,R0,#-3
				BRZ FILL_GRADE3
				ADD R0,R0,#3
				ADD R0,R0,#-4
				BRZ FILL_GRADE4
				ADD R0,R0,#4
				BR WHILE1
						
	
	FILL_GRADE1:	LEA R6,HW1_GRADE					; IN THIS LABEL WE STORE THE DIGITS 
		NEXT1:		LDR R5,R6,#0
					ADD R5,R5,#1
					BRNP NEXT_CELL11
					STR R3,R6,#0
					BR WHILE1
						
	NEXT_CELL11: ADD R6,R6,#1
				BR NEXT1
					
	FILL_GRADE2:	LEA R6,HW2_GRADE				
		NEXT2:		LDR R5,R6,#0
					ADD R5,R5,#1
					BRNP NEXT_CELL22
					STR R3,R6,#0
					BR WHILE1
						
	NEXT_CELL22: ADD R6,R6,#1
				BR NEXT2
				
	FILL_GRADE3:	LEA R6,HW3_GRADE				
		NEXT3:		LDR R5,R6,#0
					ADD R5,R5,#1
					BRNP NEXT_CELL33
					STR R3,R6,#0
					BR WHILE1
						
	NEXT_CELL33: ADD R6,R6,#1
				BR NEXT3
	
	FILL_GRADE4:	LEA R6,MIDTERM_GRADE				
		NEXT4:		LDR R5,R6,#0
					ADD R5,R5,#1
					BRNP NEXT_CELL4
					STR R3,R6,#0
					BR WHILE1
						
	NEXT_CELL4: ADD R6,R6,#1
				BR NEXT4
	
	WHILE_END:	


				; we get to this label when we are done receiving grades for one student
				LD R3, COURSE_LIST_ADRESS ;R3 = ITEM1
				LEA R6, HW1_GRADE			;
				JSR CONVERTE_ARRAY_NUMBER
				STR R0, R3, #0
			
				LEA R6, HW2_GRADE		;
				JSR CONVERTE_ARRAY_NUMBER
				STR R0, R3, #1
				
				LEA R6, HW3_GRADE		;
				JSR CONVERTE_ARRAY_NUMBER
				STR R0, R3, #2
				
				LEA R6, MIDTERM_GRADE			;
				JSR CONVERTE_ARRAY_NUMBER
				STR R0, R3, #3
				
				ADD R2,R2,#-1
				BRz END_FORR
				ADD R3, R3, #6  ;R3 = R3.NEXT
				LDR R3,R3,#0
				ST R3,COURSE_LIST_ADRESS
				AND R3,R3,#0
				ADD R3,R3,#-1
				LEA R6,HW1_GRADE  		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				STR R3,R6,#0
				STR R3,R6,#1
				STR R3,R6,#2
				LEA R6,HW2_GRADE
				STR R3,R6,#0			;RETURNING THE VALUES IN THE ARRAYS TO -1 SO THAT WE CAN USE THEM AGAIN 
				STR R3,R6,#1			; THE ARRAYS ARE USED TO STORE THE DIGITS FROM THE USER
				STR R3,R6,#2
				LEA R6,HW3_GRADE
				STR R3,R6,#0
				STR R3,R6,#1
				STR R3,R6,#2
				LEA R6,MIDTERM_GRADE	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				STR R3,R6,#0
				STR R3,R6,#1
				STR R3,R6,#2
				BR FOR1
				
	END_FORR: 	LD R0,R0_GetStudentGrades
			LD R1,R1_GetStudentGrades
			LD R2,R2_GetStudentGrades
			LD R3,R3_GetStudentGrades
			LD R4,R4_GetStudentGrades
			LD R5,R5_GetStudentGrades
			LD R6,R6_GetStudentGrades
			LD R7,R7_GetStudentGrades			
					
RET
ASCII_ZERO .fill #-48
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;COURSE1	.fill    Item_1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COURSE_LIST_ADRESS .fill #-1
INDEX .fill #-1

ASCIIFORNINE .fill #-57
ASCIIFORENDLINE .fill #-10
ASCIIFORSPACE32 .fill #-32
STUDENT_NUMBERS	.fill #-1
STUDENTNUM .fill #-1
R0_GetStudentGrades .fill #0
R1_GetStudentGrades .fill #0
R2_GetStudentGrades .fill #0
R3_GetStudentGrades .fill #0
R4_GetStudentGrades .fill #0
R5_GetStudentGrades .fill #0
R6_GetStudentGrades .fill #0
R7_GetStudentGrades .fill #0
R1_VALUE .fill #0
R2_VALUE .fill #0
HW1_GRADE .blkw	#3 #-1
HW2_GRADE .blkw	#3 #-1
HW3_GRADE .blkw	#3 #-1
MIDTERM_GRADE .blkw	#3 #-1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ASCIIFORZERO .fill #-48
R0_STOREPRINTNUM .fill #0
R1_STOREPRINTNUM .fill #0
R2_STOREPRINTNUM .fill #0
R3_STOREPRINTNUM .fill #0
R4_STOREPRINTNUM .fill #0
R5_STOREPRINTNUM .fill #0
R6_STOREPRINTNUM .fill #0
R7_STOREPRINTNUM .fill #0
HYPHEN .fill #-45
ARRAY2 .blkw #5 #-1
ORIGINALNUM .fill #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PrintNum:									; we have a number in R0 and we need ti print it
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



;STUDENTNUM .fill #-1

;ASCIIFORSPACE .fill #-32
;ASCII_END_LINE .fill #-10
;ASCII_FOR_ZERO .fill #-48

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BubbleSort:;R1 HAS THE ADRESS OF THE LINKED LIST ; R2 HAS THE NUMBER OF STUDENTS
	ST R0,R0_SORT_SAVE
	ST R1,R1_SORT_SAVE
	ST R2,R2_SORT_SAVE
	ST R3,R3_SORT_SAVE
	ST R4,R4_SORT_SAVE
	ST R5,R5_SORT_SAVE
	ST R6,R6_SORT_SAVE
	ST R7,R7_SORT_SAVE
	ST R1,HEAD
	ST R2,NUM_OF_STUDENTS	
	LD R6,NUM_OF_STUDENTS			; R6 HAS THE NUMBER OF STUDENTS	
		FOR_BUBBLESORT:	
		LD R1,HEAD
		LDR R1,R1,#0 					; R1 NOW HAS ITEM1		
		ADD R6,R6,#-1				
		BRZ END_SORTING
		ADD R3,R6,#0				;R3 is a counter for the inner loop |(R1 HAS THE NUMBER OF STUDENTS) 
			
			FOR_SWAPPING:                        
				LDR R2,R1,#6 		; NOW R2 IS A POINTER OVER THE R1.NEXT 
				LDR R4,R1,#4		;R4 HAS THE AVERAGE OF STUDENT THAT IS IN R1
				LDR R5,R2,#4		;R5 HAS THE AVERAGE OF THE NEXT STUDENT
				NOT R5,R5
				ADD R5,R5,#1		;R5 = -R5
				ADD R4,R4,R5 		;R4 = R4-R5 
				BRN SWAP_CELLS		;NEGATIVE CASE THIS MEANS THAT THE NEXT STUDENT HAS A GREATER AVERAGE AND WE NEED TO SWAP 
				LDR R1,R1,#6		;R1 = R1.NEXT ( R1 IS THE POINTER TO THE NEXT STUDENT)
	CONTINUE:		ADD R3,R3,#-1 		;check if R3 is zero 
					BRNZ FOR_BUBBLESORT
					BR FOR_SWAPPING
	SWAP_CELLS: 	ST R3,SAVE_INNER_LOOP_COUNTER		;WE NEED TO USE R3 SO WE STORE IT IN A LABEL 
					LD R3,HEAD							
					JSR Swap							;GIVEN TWO POINTERS TO A DIFFERENT NODE WE SWAP BETWEEN THEM 
					LD R3,SAVE_INNER_LOOP_COUNTER
					BR CONTINUE
	END_SORTING:		LD R0,R0_SORT_SAVE;
						LD R1,R1_SORT_SAVE
						LD R2,R2_SORT_SAVE
						LD R3,R3_SORT_SAVE
						LD R4,R4_SORT_SAVE
						LD R5,R5_SORT_SAVE
						LD R6,R6_SORT_SAVE
						LD R7,R7_SORT_SAVE
RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_INNER_LOOP_COUNTER .fill #-1
R0_SORT_SAVE .fill #0
R1_SORT_SAVE .fill #0
R2_SORT_SAVE .fill #0
R3_SORT_SAVE .fill #0
R4_SORT_SAVE .fill #0
R5_SORT_SAVE .fill #0
R6_SORT_SAVE .fill #0
R7_SORT_SAVE .fill #0

NUM_OF_STUDENTS .fill #0
HEAD .fill #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FILL_ARRAY:;TAKESIN R1 THE ADRESS OF LINKED LIST AND INSERTS THE AVERAGE IN ARRAY,R2 THE ADRESS OF THE ARRAY
	ST R0,R0_FILL_ARRAY_SAVE
	ST R1,R1_FILL_ARRAY_SAVE
	ST R2,R2_FILL_ARRAY_SAVE
	ST R3,R3_FILL_ARRAY_SAVE
	ST R4,R4_FILL_ARRAY_SAVE
	ST R5,R5_FILL_ARRAY_SAVE
	ST R6,R6_FILL_ARRAY_SAVE
	ST R7,R7_FILL_ARRAY_SAVE
													;WE NEED TO STORE ONLY ONE APEARENCES OF AVERAGES
		AND R6,R6,#0 	;R6 = 0
		ADD R6,R6,#6	;R6 = 6 NUMBER OF CELLS IN THE ARRAY
		LDR R1,R1,#0 	;R1 = ITEM1
		AND R0,R0,#0
		ADD R0,R0,#10	;R0 = 10 (THE NUMBER OF NODES )
		AND R4,R4,#0
		ADD R4,R4,#-1	;R4 WE SAVE PREVIOUS VALUSE IN IT SO WE INITIATE IT WITH -1 
		FOR_FILL:		ADD R0,R0,#0
						BRZ END_FOR_LOOP
						LDR R5,R1,#4 		;NOW R5 HAS THE AVERAGE
						NOT R4,R4
						ADD R4,R4,#1 		;R4 = -R4
						ADD R3,R4,R5 
						BRZ NEXT_NODE
						STR R5,R2,#0
						ADD R6,R6,#-1
						BRZ END_FOR_LOOP
						LDR R1,R1,#6 		; R1 = R1.NEXT
						ADD R0,R0,#-1
						LDR R4,R2,#0		;R4 =PREVIOUS VALUE SAVED IN THE ARRAY 
						ADD R2,R2,#1
						BR FOR_FILL
								
		NEXT_NODE: 		LDR R1,R1,#6  ;R1 = R1.NEXT
					ADD R0,R0,#-1
					NOT R4,R4
					ADD R4,R4,#1 ;R4 = -R4
					BR FOR_FILL
		
		END_FOR_LOOP:
			LD R0,R0_FILL_ARRAY_SAVE
			LD R1,R1_FILL_ARRAY_SAVE
			LD R2,R2_FILL_ARRAY_SAVE
			LD R3,R3_FILL_ARRAY_SAVE
			LD R4,R4_FILL_ARRAY_SAVE
			LD R5,R5_FILL_ARRAY_SAVE
			LD R6,R6_FILL_ARRAY_SAVE
			LD R7,R7_FILL_ARRAY_SAVE
RET
R0_FILL_ARRAY_SAVE .fill #0
R1_FILL_ARRAY_SAVE .fill #0
R2_FILL_ARRAY_SAVE .fill #0
R3_FILL_ARRAY_SAVE .fill #0
R4_FILL_ARRAY_SAVE .fill #0
R5_FILL_ARRAY_SAVE .fill #0
R6_FILL_ARRAY_SAVE .fill #0
R7_FILL_ARRAY_SAVE .fill #0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; THIS SUBROUTUNE TAKES IN R1 THE ADRESS OF TEMPARRAY1 ,R2 THE ADRESS OF TEMPARRAY2
				;R3 THE ADRESS OF TEMPARRAY3 , R6 THE ADRESS OF FINAL_ARRAY
FILLFINALARRAY:	ST R0,R0_SAVE_FILL_FINAL_ARRAY
				ST R1,R1_SAVE_FILL_FINAL_ARRAY	
				ST R2,R2_SAVE_FILL_FINAL_ARRAY	
				ST R3,R3_SAVE_FILL_FINAL_ARRAY	
				ST R4,R4_SAVE_FILL_FINAL_ARRAY	
				ST R5,R5_SAVE_FILL_FINAL_ARRAY	
				ST R6,R6_SAVE_FILL_FINAL_ARRAY	
				ST R7,R7_SAVE_FILL_FINAL_ARRAY	

	AND R7,R7,#0
	ADD R7,R7,#-1
FOR_FILL_FINAL:
	
	LDR R4, R1, #0
	LDR R5, R2, #0
	ADD R0, R5, #0
	NOT R0, R0
	ADD R0, R0, #1
    	ADD R0, R0, R4
	BRp ONE_BIGG
	; CHECK IF THE VALUE OF THE SECOND ARRAY BIGGER THAN THE VALUE OF THE THIRD ARRAY
	LDR R4, R3, #0
	ADD R0, R4, #0
	NOT R0, R0
	ADD R0, R0, #1
    	ADD R0, R0, R5 
	BRP TWO_BIGG
	
	;THE VALUE OF THE THIRD ARRAY IS THE BIGGER
THREE_BIGG:
	LDR R4, R3 ,#0
	ADD R3, R3, #1 
	ADD R0, R7, #0
	NOT R0, R0
	ADD R0, R0, #1
    	ADD R0, R0, R4
	BRZ FOR_FILL_FINAL
	ADD R4, R4, #1
	BRZ END_FOR_FILL_ARRAY
	ADD R4, R4, #-1
	STR R4, R6,#0
	LDR R7,R6,#0
	ADD R6, R6, #1
	BR FOR_FILL_FINAL
	



ONE_BIGG:
	LDR R5, R3, #0
	ADD R0, R5, #0
	NOT R0, R0
	ADD R0, R0, #1
    ADD R0, R0, R4
	BRp ONE_BIGG2
	BR THREE_BIGG

	
ONE_BIGG2:
	ADD R1, R1, #1 
	ADD R0, R7, #0
	NOT R0, R0
	ADD R0, R0, #1
    ADD R0, R0, R4
	BRZ FOR_FILL_FINAL
	ADD R4, R4, #1
	BRZ END_FOR_FILL_ARRAY
	ADD R4, R4, #-1
	STR R4, R6,#0
	LDR R7,R6,#0   ;
	ADD R6, R6, #1
	BR FOR_FILL_FINAL
	


TWO_BIGG: 
	ADD R2, R2, #1
	ADD R0, R7, #0
	NOT R0, R0
	ADD R0, R0, #1
    ADD R0, R0, R5
	BRZ FOR_FILL_FINAL
	ADD R5, R5 ,#1
	BRZ END_FOR_FILL_ARRAY
	ADD R5, R5, #-1
	STR R5, R6,#0
	LDR R7,R6,#0
	ADD R6, R6, #1
	BR FOR_FILL_FINAL
	
	
		
	END_FOR_FILL_ARRAY: 	LD R1,R6_SAVE_FILL_FINAL_ARRAY
				AND R6,R6,#0
				ADD R6,R6,#6
				LD R5,ASCIIFORSPACEPP
					PRINT_FINAL_ARRAY: 	ADD R6,R6,#0
								BRNZ ENDPROGRAM11
								LDR R0,R1,#0		;R0 = R1 
								JSR PrintNum
								ADD R0,R5,#0
								OUT
								ADD R1,R1,#1
								ADD R6,R6,#-1
								BR PRINT_FINAL_ARRAY
								

				ENDPROGRAM11:			LD R0,R0_SAVE_FILL_FINAL_ARRAY
								LD R1,R1_SAVE_FILL_FINAL_ARRAY	
								LD R2,R2_SAVE_FILL_FINAL_ARRAY	
								LD R3,R3_SAVE_FILL_FINAL_ARRAY	
								LD R4,R4_SAVE_FILL_FINAL_ARRAY	
								LD R5,R5_SAVE_FILL_FINAL_ARRAY	
								LD R6,R6_SAVE_FILL_FINAL_ARRAY	
								LD R7,R7_SAVE_FILL_FINAL_ARRAY

RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		ASCIIFORSPACEPP .fill #32
		R0_SAVE_FILL_FINAL_ARRAY .fill #0
		R1_SAVE_FILL_FINAL_ARRAY .fill #0
		R2_SAVE_FILL_FINAL_ARRAY .fill #0
		R3_SAVE_FILL_FINAL_ARRAY .fill #0
		R4_SAVE_FILL_FINAL_ARRAY .fill #0
		R5_SAVE_FILL_FINAL_ARRAY .fill #0
		R6_SAVE_FILL_FINAL_ARRAY .fill #0
		R7_SAVE_FILL_FINAL_ARRAY .fill #0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;GIVEN TWO POINTERS IN R1 AND R2 WE SWAP ;R2 = R1+6,IN R3 WE GET THE ADRESS OF THE HEAD 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;GIVEN TWO POINTERS IN R1 AND R2 WE SWAP ;R2 = R1+6,IN R3 WE GET THE ADRESS OF THE HEAD 
Swap:
	ST R0,SWAP_R0_SAVE 
	ST R1,SWAP_R1_SAVE
	ST R2,SWAP_R2_SAVE
	ST R3,SWAP_R3_SAVE
	ST R4,SWAP_R4_SAVE
	ST R5,SWAP_R5_SAVE
	ST R6,SWAP_R6_SAVE
	ST R7,SWAP_R7_SAVE
		LDR R0,R1,#6 	;R0 = R1.NEXT
		LDR R5,R2,#6	;R5 = R2.NEXT	
		ADD R6,R5,#0	;R6 = R2.NEXT 
		ADD R4,R0,#0	;R4 = R1.NEXT
		ADD R5,R4,#0	;R5 = R1.NEXT
		ADD R0,R6,#0	;R0 = R2.NEXT
		
		STR R0,R1,#6	;R1.NEXT = R2.NEXT 
		STR R1,R2,#6	;R2.NEXT = R1
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		LDR R0,R1,#5	;R0 = R1.PREV
		LDR R5,R2,#5	;R5 = R2.PREV ; R5 = R1
		
		ADD R6,R5,#0	;R6 = R2.PREV
		ADD R4,R0,#0	;R4 = R1.PREV
		ADD R5,R4,#0	;R5 = R1.PREV
		ADD R0,R6,#0	;R0 = R2.PREV
		
		STR R2,R1,#5
		STR R5,R2,#5
		
		
		LDR R6,R1,#6 	;R6 = R1.NEXT
		STR R1,R6,#5	;R1.NEXT.PREV = R6
		LDR R6,R2,#5  	;R6 = R2.PREV
		ADD R6,R6,#1	;
		BRZ CHECK_HEAD
		ADD R6,R6,#-1 	
		STR R2,R6,#6	;R2.PREV.NEXT = R2
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		; NOW WEW NEED TO CHECK WHETHER ONE OF THE NODES IS THE FIRST NODE
		CHECK_HEAD:	LDR R0,R2,#5 ;R0 = R2.PREV
				ADD R0,R0,#1
				BRZ FIRST_NODE
				BR END2
		
		FIRST_NODE:		STR R2,R3,#0	;NOW R3 HAS THE ADRESS OF THE FIRST NODE IN THE LIKED LIST
										;WE NEED TO STORE IT IN THE RELATED
		
	END2:	LD R0,SWAP_R0_SAVE 
			LD R1,SWAP_R1_SAVE
			LD R2,SWAP_R2_SAVE
			LD R4,SWAP_R4_SAVE
			LD R5,SWAP_R5_SAVE
			LD R6,SWAP_R6_SAVE
			LD R7,SWAP_R7_SAVE
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 SWAP_R0_SAVE .fill #0
 SWAP_R1_SAVE .fill #0
 SWAP_R2_SAVE .fill #0
 SWAP_R3_SAVE .fill #0
 SWAP_R4_SAVE .fill #0
 SWAP_R5_SAVE .fill #0
 SWAP_R6_SAVE .fill #0
 SWAP_R7_SAVE .fill #0


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
ILLEGAL .fill #-1
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;