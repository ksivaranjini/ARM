 AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
;to find the largest of three numbers, stored in result

__main  FUNCTION	
input1 RN 1;1st number
input2 RN 2;2nd number
input3 RN 3;3rd number
result RN 4;result-largest

	MOV input1,#2
	MOV input2,#6
	MOV input3,#3
	
    CMP input1,input2;compare the 2
	BGT one;if greater branch one
	BLE two;if lesser branch two
	
one
	CMP input1,input3;compare 1 and 3
	ITE GT
	MOVGT result,input1;1 is the largest
	MOVLE result,input3;3 is the largest
	B stop
	
two 
	CMP input2,input3;compare 2 and 3
	ITE GT
	MOVGT result,input2;2 is the largest
	MOVLE result,input3;3 is the largest
	B stop
	
stop B stop ; stop program
     ENDFUNC
END
	END