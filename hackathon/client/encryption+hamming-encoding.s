;PRESERVE8
;thumb
	 AREA     code1, CODE, READONLY
		 
encrypt function
	MOV r5, #0x000000ff; IV
	MOV r6, #0x0;
	;r2 - starting addr, r4 - gets first block, r5 - the value to be exor'd with, key = 1, r3 - destination address
loop1	LDRB r4, [r2,#0x1]!; encryption
;	MOV r4, 0xee; encrypted value = 0x12
	EOR r4, r4, r5;
	ADD r4, r4, #1; key
	AND r4, r4, #0x000000ff; to remove all the excess bits
	STR r4, [r3,#0x1]!;
	MOV r5, r4;
	ADD r6, r6, #1;
	CMP r6, #10; because image size = 5x5
	BLT loop1;
	BX lr;
	endfunc
	
store function
	MOV r2, #0x20000000;
	MOV r3, #0x1;
loop_s STR r3, [r2,#0x1]!;
	ADD r3,r3,#0x1;
	CMP r3, #10;
	BLT loop_s
	BX lr
	endfunc

		EXPORT __main 
		ENTRY
__main function
	BL store;
	; number - b8-b7-b6-b5-b4-b3-b2-b1, encoded data - d12-d11-d10-d9-d8-d7-d6-d5-d4-d3-d2-d1
	MOV r2, #0x20000000; start register.
	SUB r2,r2,#1;
	MOV r0, #0x0;
	ADD r1,r2,#51;
	;MOV r1, #0x20000000; end register
	SUB r1,r1,#1;
	;MOV r1, #5; row
	;MOV r0, #5; col
	ADD r3, r2, #21;
	;MOV r3, #0x20000000; destination address
	BL encrypt;
	MOV r2, #0x20000000; 
	ADD r3,r2,#21;
loop	LDRB r4, [r3,#0x1]!;
	;MOV r4, #0x99;  
	AND r5, r4, #0xf0; to get bits b8 to b5
	LSL r5, r5, #4; left shifting so that we can get the bits where we want them to be at. d12-d11-d10-d9
	
	AND r9, r4, #0x00000010;b5 - bit 5 
	LSR r9, #4; because we want b5 value to be at the position of b1;
	AND r10, r4, #0x00000020;b6
	LSR r10, #5;
	AND r11, r4, #0x00000040;b7
	LSR r11, #6;
	AND r12, r4, #0x00000080;b8
	LSR r12, #7;
	EOR r6, r9,r10; xor-ing the bits to get the value.
	EOR r6, r6, r11;
	EOR r6, r6, r12;
	LSL r6, #7;
	ADD r5,r5,r6; ; d12-d11-d10-d9-d8
	
	AND r6, r4, #0xe;
	LSL r6,r6, #4;
	ADD r5,r5,r6; d12-d11-d10-d9-d8-d7-d6-d5
	
	AND r9, r4, #0x00000002;b2
	LSR r9, #1;
	AND r10, r4, #0x00000004;b3
	LSR r10, #2;
	AND r11, r4, #0x00000008;b4
	LSR r11, #3;
	EOR r6, r9,r10;
	EOR r6, r6, r11;
	EOR r6, r6, r12;
	LSL r6, #3;
	ADD r5, r6, r5; d12-d11-d10-d9-d8-d7-d6-d5-d4
	
	AND r12, r4, #0x00000001; b1
	LSL r12, #2;
	ADD r5, r12, r5;
	LSR r12, #2; d12-d11-d10-d9-d8-d7-d6-d5-d4-d3
	
	AND r10, r4, #0x00000020;b6
	LSR r10, #5;
	AND r11, r4, #0x00000040;b7
	LSR r11, #6;
	AND r7, r4, #0x00000004;b3
	LSR r7, #2;
	AND r8, r4, #0x00000008;b4
	LSR r8, #3;
	EOR r6, r11,r10;
	EOR r6, r6, r7;
	EOR r6, r6, r8;
	EOR r6, r6, r12;
	LSL r6, #1;
	ADD r5, r6, r5; d12-d11-d10-d9-d8-d7-d6-d5-d4-d3-d2
	
	AND r10, r4, #0x00000002;b2
	LSR r10, #1;
	AND r9, r4, #0x00000010;b5
	LSR r9, #4;
	EOR r6, r12,r10;
	EOR r6, r6, r8;
	EOR r6, r6, r9;
	EOR r6, r6, r11;
	;LSL r6, #1;
	ADD r5, r6, r5; d12-d11-d10-d9-d8-d7-d6-d5-d4-d3-d2-d1
	STRB r5, [r1, #0x1]!;
	ADD r0, #1; to help with the loop count
	CMP r0, #10;
	BLT loop
	
stop    B stop ; stop program
     ENDFUNC
     END 