	 PRESERVE8
	 THUMB
	 AREA appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION ;cross wire of length 100 is drawn from the origin
	MOV R0, #160 ;X
	MOV R1, #120 ;Y
	MOV R6, #0x20000000 ;start address of array
	STR R0,[R6] ; Storing values of Y for fixed X
	MOV R7, #1 ; Array Index
	MOV R8,#70 ; Value counter for Y -> 70 to 170
YLOOP	CMP R7, #102 ; 
		BEQ STOREY
		STR R8, [R6,R7] ; storing values of Y
		ADD R8, R8, #1; increment R8
		ADD R7, R7, #1; increment R7
		B YLOOP

STOREY	STR R1,[R6,R7] ; Store Y coordinate after Y for fixed X are stored
			B XINC

XINC	MOV R8,#110; Value counter for X -> 110 to 210
		ADD R7,R7,#1
XLOOP	CMP R7, #205
		BEQ DRAWCROSSWIRE
		STR R8, [R6,R7] ; Storing values of X for fixed Y
		ADD R8, R8, #1 ; increment R8
		ADD R7, R7, #1 ; increment R7
		B XLOOP
	

DRAWCROSSWIRE NOP

stop B stop ; stop program
     ENDFUNC
     END