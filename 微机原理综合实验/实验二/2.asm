SSTACK	SEGMENT STACK
		DW 64 DUP(?)
SSTACK	ENDS
CODE		SEGMENT
		ASSUME CS:CODE
START:	XOR AX, AX
		MOV CX, 0004H
		MOV SI, 3500H
		MOV DI, 3510H  
		;初始化数据
        MOV AX, 0201H
        MOV [SI],AX
        INC SI
        INC SI  
        MOV AX, 0403H
        MOV [SI],AX 
        INC SI
        INC SI 
        MOV AX, 0605H
        MOV [SI],AX 
        INC SI
        INC SI 
        MOV AX, 0807H
        MOV [SI],AX
        MOV SI, 3500H   
        
A1:		MOV AL, [SI]
		ADD AL, AL
		MOV BL, AL
		ADD AL, AL
		ADD AL, AL
		ADD AL, BL
		INC SI
		ADD AL, [SI]
		MOV [DI], AL
		INC SI
		INC DI
		LOOP A1
		MOV AX,4C00H
		INT 21H				;程序终止
CODE		ENDS
		END START

