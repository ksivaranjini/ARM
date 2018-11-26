;PRESERVE8
;thumb
	 AREA     code1, CODE, READONLY
		
decrypt function
	;r3 - starting addr, r4 - gets first block, r7 - previous cipher text, r5 - the value to be exor'd with, key = 1, r2 - destination address
		;MOV r3, #0x13;
	MOV r5, #0x000000ff; IV
	MOV r6, #0x0;
loop2 LDRB r4, [r3,#0x1]!; decryption
	;MOV r4, 0x12; = 0x99 encrypted.
	;MOV r4, r6;
	MOV r7, r4;
	SUB r4, r4, #1; key
	AND r4, r4, #0x000000ff; to remove all the excess bits
	EOR r4, r4, r5;
	STRB r4, [r2,#0x1]!;
	MOV r5, r7;
	ADD r6, r6, #1;
	CMP r6, #10; because image size = 5x5
	BLT loop2;
	BX lr
	endfunc
	
check function
	MOV r6, #0x1;
	MOV r7, 0x0;
loop_c	LDRB r4, [r0, #0x1]!
	CMP r4, r6;
	ADDEQ r7, r7,#1;
	ADD r6, r6, #1;
	CMP r6, #0x12;
	BLT loop_c;
	BX lr;
	endfunc
	
		EXPORT __main 
		ENTRY
__main function
	;BL store;
	MOV r3, #0x20000000; r2=0x20 is where the array begins
	SUB r3,r3,#1;
	MOV r1, #5; row
	MOV r0, #5; col
	ADD r2, r3, #21;
	MOV r0, r2;
	BL decrypt;	
	BL check;
	CMP r7, #10;
	MOVEQ r0, #0x1;
	;BL printMsg;
stop    B stop ; stop program
     ENDFUNC
     END 