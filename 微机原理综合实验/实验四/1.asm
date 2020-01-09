DATA SEGMENT
    DIVISOR DW 10000,1000,100,10,1
    RESULT DB 0,0,0,0,0,"$" 
DATA ENDS
CODE SEGMENT
    ASSUME CS : CODE
 
START:  MOV BH, 02H
        MOV BL, 03H
        MOV DX, 1
        MOV CX,00H
L:      MOV AL,BH
        MUL BL
        INC BH
        INC BL
        ADD DX,AX
        CMP AX,00C8H ;判断N(N+1)是否大于200
        JA NEXT
        LOOP L
        
NEXT:   
        MOV AX,DX
        MOV DX,DATA
        MOV DS,DX
        MOV SI,OFFSET DIVISOR
        MOV DI,OFFSET RESULT
        MOV CX,0005H
AA: 
        MOV DX,0
        DIV WORD PTR [SI]
        ADD AL,30H
        MOV BYTE PTR [DI],AL
        INC DI
        ADD SI,2
        MOV AX,DX
        LOOP AA
    
        MOV CX,0004H
        MOV DI,OFFSET RESULT
COM:
        CMP BYTE PTR [DI],'0' ;寻找输出起始位
        JNE PRINT
        INC DI
        LOOP COM

PRINT:  mov ah,02h
        mov dl,0Dh
        int 21h
        ;MOV DL,20H
        ;MOV AH,02H
        ;INT 21H 
        MOV DX,DI
        MOV AH,09H
        INT 21H
        MOV AX,4C00H
		INT 21H
CODE	ENDS
END START 