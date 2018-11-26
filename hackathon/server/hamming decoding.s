	 PRESERVE8
	 THUMB
	 AREA appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION 
		;MOV r3, #0x20000000;
		;LDRB r4, [r3,#0x1]!; corrupted data in r4
		;R8 stores the final 8 bit corrected data which is 0x99
		; This is the flow 0x99(8-bit data) -> 0x945(hamming encryption) -> 0x965(corruption at 6th bit) -> 0x99(finally recovered)
		;0x965 is corrupted data due to flipping of 6th bit in hamming encryption
		
		MOV r4, #0x965; test corrupted data to recover
		MOV r9, #0x965 ; copy of data for later use
		AND r5, r4, #0x1 ; first bit
		MOV r2,#0
LOOP	CMP r2,#5 ; XOR of 1,3,5,7,9,11th bits
		BEQ P1
		LSR r4, r4, #2
		AND r6, r4, #0x1
		EOR r5, r5, r6
		ADD r2,r2,#1
		B LOOP

P1		CMP r5, #1 ;R8 stores P1
		ITE LT
		MOVLT r8,#0
		MOVGE r8,#1
		B P2

P2		MOV r4, r9 ;XOR of 2,3,6,7,10,11 and R7 stores the P2
		LSR r4, r4, #1
		AND r5, r4, #0x1
		LSR r4, r4, #1
		AND r6, r4, #0x1
		EOR r5, r5, r6
		LSR r4, r4, #3
		AND r6, r4, #0x1
		LSR r4, r4, #1
		AND r7, r4, #0x1
		EOR r5,r5,r6
		EOR r5,r5,r7
		LSR r4, r4, #3
		AND r6, r4, #0x1
		LSR r4, r4, #1
		AND r7, r4, #0x1
		EOR r5,r5,r6
		EOR r5,r5,r7
		CMP r5, #1
		ITE LT
		MOVLT r7,#0
		MOVGE r7,#1
		B P3
		
P3		MOV r4, r9 ; XOR of 4,5,6,7,12 and R6 Stores the P3
		LSR r4, r4, #3
		AND r5, r4, #0x1
		LSR r4, r4, #1
		AND r6, r4, #0x1
		LSR r4, r4, #1
		AND r2, r4, #0x1
		LSR r4, r4, #1
		AND r1, r4, #0x1
		EOR r5, r5, r6
		EOR r5, r5, r2
		EOR r5, r5, r1
		LSR r4, r4, #5
		AND r6, r4, #0x1
		EOR r5, r5, r6
		CMP r5, #1
		ITE LT
		MOVLT r6,#0
		MOVGE r6,#1
		B P4

P4		MOV r4, r9  ; XOR of 8,9,10,11,12 and R5 stores the P4
		LSR r4, r4, #7
		AND r5, r4, #0x1
		LSR r4, r4, #1
		AND r2, r4, #0x1
		LSR r4, r4, #1
		AND r1, r4, #0x1
		LSR r4, r4, #1
		AND r0, r4, #0x1
		LSR r4, r4, #1
		AND r10, r4, #0x1
		EOR r5, r5, r2
		EOR r5, r5, r1
		EOR r5, r5, r0
		EOR r5, r5, r10
		CMP r5, #1
		ITE LT
		MOVLT r5,#0
		MOVGE r5,#1
		B ERRORBIT

ERRORBIT	LSL r5, r5, #1 ;getting the error bit by using R5,R6,R7,R8 and R5 stores the final error bit number
		ORR r5, r5, r6
		LSL r5, r5, #1
		ORR r5, r5, r7
		LSL r5, r5, #1
		ORR r5, r5, r8
		B CORRECTION

				
CORRECTION	MOV R8, #1 ; flip the error bit
		CMP R5,#0
		SUBGT R5, R5, #1
		LSL R8, R8, R5
		EOR R9, R9, R8
		B ORIGDATA

ORIGDATA AND R8, R9, #0xf00 ; getting back the original 8 bit data
		 LSR R8, R8, #4
		 LSR R7, R9, #4
		 AND R6, R7, #0x1
		 LSR R7, R7, #1
		 AND R5, R7, #0x1
		 LSR R7, R7, #1
		 AND R4, R7, #0x1
		 LSL R4, R4, #1
		 ORR R4, R4, R5
		 LSL R4, R4, #1
		 ORR R4, R4, R6
		 AND R6, R9, #0x1
		 LSL R4, R4, #1
		 ORR R4, R4, R6
		 ORR R8, R8, R4 ; R8 has the final data
		 
		 
		 

stop    B stop ; stop program
     ENDFUNC
     END 
 