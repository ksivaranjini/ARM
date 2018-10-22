 AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
;to find the first n fibonacci numbers, series stored in memory starting from address 0x3000000
__main  FUNCTION	
prev RN 1;pointer to 1st
current RN 2;pointer to 2nd

n RN 3;length of the series required
elt1 RN 4;1st element
elt2 RN 5;2nd element
newelt RN 6;new element 

	MOV prev,#0x3000000
	ADD current,prev,#4
	
	MOV n,#10;number of elements
	MOV elt1,#0;initial value-1st element
	MOV elt2,#1;initial value-2nd element
	
	STR elt1,[prev];store first 2 elements into memory
	STR elt2,[current]
	
loop
	CMP n,#2;loop till n reaches two accounting for initialisations
	BEQ stop
	ADD newelt,elt1,elt2;new=el1+el2
	ADD current,#4;update pointers
	ADD prev,#4
	STR newelt,[current];store the new element
	LDR elt1,[prev];update the contents of el1 and 2
	LDR elt2,[current]
	
	SUB n,#1;decrement loop counter
	B loop
    
stop B stop ; stop program
     ENDFUNC
END
	END