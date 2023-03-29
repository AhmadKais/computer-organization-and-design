;Ahmad kais 318212248
;Rojeh shalabi 209243203
;Test program for integer multiplication
.ORIG x3000
LD R0, Test_Mul1 ; R0 = Test_Mul1
LD R1, Test_Mul2 ; R1 = Test_Mul2
JSR Mul ; R2 = Mul(R0, R1)
LD R1, Test_Res ; R1 = Test_Res
; At this point R1 holds the (-1) * correct answer
; While R2 holds the result that the function returned
ADD R2, R2, R1 ; testing R2 Vs R1
BRz RES_GOOD ; if all good then jump to Res_Good else continue to Res_Bad
RES_BAD:
LEA R0, TEST_ERR_STR
PUTS
BR DONE
RES_GOOD:
LEA R0, TEST_CORRECT_STR
PUTS
DONE:
HALT ; program is done here, control is handed
TEST_ERR_STR .STRINGZ "Result is wrong"
TEST_CORRECT_STR .STRINGZ "Result is correct "
Test_Mul1 .FILL #6
Test_Mul2 .FILL #70
Test_Res .FILL #-420 ; (-1)*6*70

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Mul: ; Mul subroutine : R2 <-- R0 * R1
ST R1,R1_STORE
ST R3,R3_STORE ; we store the values of R3,R4,R5, so that we dont lose the data
ST R4,R4_STORE
ST R5,R5_STORE
LD R2,ZERO     ;initiating the values of R2,R4,R5 with zero becaue we want to use them
LD R4,ZERO
LD R5,ZERO
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
LD R1,R1_STORE
LD R3,R3_STORE ; we load back tha values we saved in the start of mul subrotine 
LD R4,R4_STORE
LD R5,R5_STORE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; we need to calculate R0^R1
RET
Exp: 			; this subrotine uses the mul subrotine
ST R7,R7_STORE 	;we store the current value og R7 because we will ned to JSR to another subroutine
ST R0,R0_STORE
ST R1,R1_STORE
ST R3,R3_STORE
ST R4,R4_STORE
ST R5,R5_STORE
LD R2,ZERO		; initiateing the rigesters we want to use with 0
LD R3,ZERO
LD R4,ZERO
LD R5,ZERO

ADD R0,R0,#0 	;check if the value of R0 is zero then the result is zero 
BRn end1		;and if the value is negative then the result is not defined
BRz checkR1		
ADD R1,R1,#0	;in case R1 is negative the calculation is not defined	
BRn end1		
ADD R3,R0,#0	;R3 = R0 
NOT R3,R3
ADD R3,R3,#1	;R3 = -R3
ADD R3,R3,#1	; start couning how many tomes we will do R0*R0
BRz end2		;
ADD R4,R1, #0	; R4 = R1
AND R1,R1,#0	;R1 = 0
ADD R1,R0,#0	;R1 = R0
ADD R4,R4,#-1	;R4 = R4 -1 ;R4 IS THE COUNTER
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

end1:			; puts illegal = -1 in r2
LD R2 ,ILLEGAL
BR endfinal

end2:			;any number^0 = 1
ADD R2,R2,#1

endfinal:		;we reload the saved value and we are done
LD R7,R7_STORE
LD R0,R0_STORE
LD R1,R1_STORE
LD R3,R3_STORE
LD R4,R4_STORE
LD R5,R5_STORE
RET 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; explaining the Div subroutine we  need to calculate R2 = R0/R1 and the remaining division we load 
; in R3 , we calculate it by subtracting and counting so we save the values of r0,r1 in r4,r5
; and we make sure that r4 is positive and r5 is negative so that we can apply ADD on them 
; after we do that we have a problem whitch is when one of them is negative or both of them are negative 
; so in the end we chech the true values of r0 ,r1 and then we decide whether thehe value of r3
; must be nagative ( in case only one of the (r0,r1 ) is negative ) and must be positive 
; if they are both positive/negative  
Div:
ST R0,R0_STORE
ST R1,R1_STORE
ST R4,R4_STORE
ST R5,R5_STORE
LD R2,ZERO 		; initiating R2,R3,R4,R5 with 0 
LD R3,ZERO
LD R4,ZERO
LD R5,ZERO
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
BRz continue	
BRn negative3	

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
LD R0,R0_STORE
LD R1,R1_STORE
LD R4,R4_STORE
LD R5,R5_STORE
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TriangleInequality: 
ST R0,R0_STORE
ST R1,R1_STORE
ST R2,R2_STORE
ST R4,R4_STORE  ; we store the values in R4,R5, in labels 
ST R5,R5_STORE
LD R3, ZERO     ; we initiate R3,R4,R5 with 0 
LD R4, ZERO
LD R5, ZERO
ADD R0, R0, #0	;we need to check whether we got a negative number in R0
BRn return_illegal		; in case we do we branch to return_illegal we will explain later
ADD R1, R1, #0	;same here
BRn return_illegal
ADD R2, R2, #0	;same here
BRn return_illegal
ADD R4,R1,R2	;R4 contains R1+R2
ADD R5,R0, #0	;R5 contains R0 
NOT R5, R5		;we multiply 	R5 with -1 
ADD R5, R5, #1	
ADD R4, R4, R5	;now R4 = R4 +R5 = R1+R2-R0 in case we got a negative result this means that  
BRn return0		;R0 is bigger than R1+R2

ADD R4,R0,R2	; we repeat a similar process but we change the values 
ADD R5,R1, #0	; now R4 = R0+R2,and R5 = R1
NOT R5, R5
ADD R5, R5, #1
ADD R4, R4, R5
BRn return0

ADD R4,R1,R0	; we repeat a similar process but we change the values 
ADD R5,R2, #0	; now R4 = R0+R2,and R5 = R1
NOT R5, R5
ADD R5, R5, #1
ADD R4, R4, R5
BRn return0

ADD R3, R3,#1 	;we get to this label just in case all the conditions didnt true value whitch means that
BR end10		; R0+R1 > R2 AND R1+R2 > R0 AND R0+R2 > R1

return0: 		;we get to this label if the numbers we entered do not accomblish the triangleInequality
LD R3, ZERO		; therefore we put 0 in R3  
BR end10

return_illegal: ; if any of the rigesters is negative then we return -1 in R3
LD R3,ILLEGAL

end10:
LD R0,R0_STORE
LD R1,R1_STORE
LD R2,R2_STORE
LD R4,R4_STORE	;we reload R4,R5 with the values they had before entering the subrotine 
LD R5,R5_STORE
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ZERO .fill #0
ILLEGAL .fill #-1 
R0_STORE .fill #0
R1_STORE .fill #0
R2_STORE .fill #0
R3_STORE .fill #0
R4_STORE .fill #0
R5_STORE .fill #0
R7_STORE .fill #0

.END