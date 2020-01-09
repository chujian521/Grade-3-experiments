DATA SEGMENT
SBCD1 DB 5, 6, 9, 2 ,0
SBCD2 DB 2, 3, 7 ,8 ,0
SSUM DB 5 DUP(0)
CONT DB 5
DATA ENDS
STACK SEGMENT PARA STACK 'STACK'
    DB 200 DUP(0)
STACK ENDS
CODE SEGMENT 
    ASSUME CS: CODE, DS: DATA, SS: STACK, ES: DATA
    
SBCDAD: MOV AX, DATA
        MOV DS, AX
        MOV ES, AX
        CLC
        CLD
        MOV SI, OFFSET SBCD1
        MOV DI, OFFSET SBCD2
        MOV BX, OFFSET SSUM
        MOV CL, CONT
        MOV CH, 0
SBCDAD1: LODSB
        ADC AL, [DI]
        AAA
        INC DI
        MOV BYTE PTR[BX], AL
        INC BX
        LOOP SBCDAD1
        HLT
CODE ENDS
     END SBCDAD
