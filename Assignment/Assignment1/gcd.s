 AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
;to find GCD of two numbers

__main  FUNCTION	
a RN 1;1st number
b RN 2;2nd number
	MOV a,#45
	MOV b,#15
	
loop
	CMP a,b;compare a and b
	BEQ stop;if equal break out of the loop
	
	SUBGT a,a,b;if a greater than b do a=a-b
	SUBLE b,b,a;else b=b-a
	B loop;back to loop
	
stop B stop ; stop program
     ENDFUNC
END
	END