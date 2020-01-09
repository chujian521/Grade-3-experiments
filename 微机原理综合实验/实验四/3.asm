CODE SEGMENT
    ASSUME CS : CODE
DATA SEGMENT
    DIVISOR DW 10000,1000,100,10,1
    RESULT DB 0,0,0,0,0,"$"
    LETTER_NUM DB 'ZIMU: ','$'
    DIGIT_NUM DB 'SHUZI: ','$'  
    OTHER_NUM DB 'OTHERS: ','$'
DATA ENDS 
START:  XOR AX, AX
        MOV CX, 0000H
        MOV SI, 0000H
        MOV DI, 0100H
        MOV [DI], 0
        MOV [DI+1], 0
        MOV [DI+2], 0
        MOV BL, 00H
INPUT:  MOV AH, 01H
        INT 21H
        MOV [SI], AL
        INC SI
        CMP AL, 0DH
        JZ NEXT
        LOOP INPUT
        
NEXT:   MOV AH,2
        MOV DL,0AH
        INT 21H
        MOV DL,0DH
        INT 21H
        MOV SI, 0000H
        MOV CX, 0000H
        
ADD1:   CMP [SI], 0DH
        JZ END1
        CMP [SI], 60H 
        JA XZIMU
        CMP [SI], 40H
        JA DZIMU
        CMP [SI], 2FH
        JA SHUZI
        INC [DI]
        INC SI
        LOOP ADD1
        JMP END1
        
XZIMU:  CMP [SI], 7BH
        JB ZIMUADD
        INC [DI]
        INC SI
        LOOP ADD1
        
DZIMU:  CMP [SI], 5BH
        JB ZIMUADD
        INC [DI]
        INC SI
        LOOP ADD1
        
SHUZI:  CMP [SI], 3AH
        JB ADDSHUZI
        INC [DI]
        INC SI
        LOOP ADD1
        
ZIMUADD:INC [DI+1]
        INC SI
        LOOP ADD1
                    
ADDSHUZI:INC [DI+2]    

        INC SI
        LOOP ADD1
                       
END1:   MOV BL, [DI]
        MOV BH, [DI+2]
        MOV CL, [DI+1]
        MOV AH, 0
        
        MOV AX,DATA   
        MOV DS,AX
        LEA DX,LETTER_NUM
        MOV AH,9
        INT 21H
        
        MOV AL,CL
        MOV AH,0
               
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
        CMP BYTE PTR [DI],'0'
        JNE PRINT
        INC DI
        LOOP COM

PRINT:  
        MOV DX,DI
        MOV AH,09H
        INT 21H
        MOV AH,2
        MOV DL,0AH
        INT 21H
        MOV DL,0DH
        INT 21H        
        
        MOV AX,DATA   
        MOV DS,AX
        LEA DX,DIGIT_NUM
        MOV AH,9
        INT 21H        
        MOV AH,0
        MOV AL,BH
        MOV DX,DATA
        MOV DS,DX
        MOV SI,OFFSET DIVISOR
        MOV DI,OFFSET RESULT
        MOV CX,0005H

AA1: 
        MOV DX,0
        DIV WORD PTR [SI]
        ADD AL,30H
        MOV BYTE PTR [DI],AL
        INC DI
        ADD SI,2
        MOV AX,DX
        LOOP AA1
    
        MOV CX,0004H
        MOV DI,OFFSET RESULT
COM1:
        CMP BYTE PTR [DI],'0'
        JNE PRINT1
        INC DI
        LOOP COM1

PRINT1: 
        MOV DX,DI
        MOV AH,09H
        INT 21H
        MOV AH,2
        MOV DL,0AH
        INT 21H
        MOV DL,0DH
        INT 21H        
        
        MOV AX,DATA   
        MOV DS,AX
        LEA DX,OTHER_NUM
        MOV AH,9
        INT 21H        
        
        MOV AH,0
        MOV AL,BL
        MOV DX,DATA
        MOV DS,DX
        MOV SI,OFFSET DIVISOR
        MOV DI,OFFSET RESULT
        MOV CX,0005H

AA2: 
        MOV DX,0
        DIV WORD PTR [SI]
        ADD AL,30H
        MOV BYTE PTR [DI],AL
        INC DI
        ADD SI,2
        MOV AX,DX
        LOOP AA2
    
        MOV CX,0004H
        MOV DI,OFFSET RESULT
COM2:
        CMP BYTE PTR [DI],'0'
        JNE PRINT2
        INC DI
        LOOP COM2

PRINT2: 
        MOV DX,DI
        MOV AH,09H
        INT 21H
        
END2:   MOV AX,4C00H
		INT 21H
END START