 AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
;program to calculate pow(e,x) using taylor's series expansion and result is in r3\

__main  FUNCTION	
x SN 1;power of e
result SN 3;result
temp SN 2;temporary var
n SN 4;no of iterations
count SN 5;loop counter
one SN 6

	VMOV.F32 x,#2;e^2
	VMOV.F32 n,#5;5 terms of taylor's series
	VMOV.F32 one,#1
	VMOV.F32 temp,#1;intermediate variable
	VMOV.F32 count,#1
	VMOV.F32 result,#1
	
	
loop
	VCMP.F32 n,count;loop till n reaches two accounting for initialisations
	VMRS.F32 APSR_nzcv,FPSCR;copy flags from fpscr to apsr before testing eq
	BEQ stop
	VMUL.F32 temp,temp,x;temp=temp*x/i
	VDIV.F32 temp,temp,count
	VADD.F32 result,result,temp;result+=temp
	VADD.F32 count,count,one;increase loop counter
	B loop
    
stop B stop ; stop program
     ENDFUNC
END