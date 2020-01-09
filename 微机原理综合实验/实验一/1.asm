STACK SEGMENT STACK
    DW 64 DUP(?)
STACK ENDS

DATA SEGMENT DATA
    STR  DB "This is my first ASM program-lixin"   
DATA ENDS


CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

START:  
        MOV BX, 0
                       
COPY1:
        MOV CX, DATA
        MOV DS, CX
        
        MOV AL, [BX]
        MOV CX, 1000H
        MOV DS, CX ;DS 1000H
        MOV [BX], AL
        INC BX
        CMP AL,0     ;字符串结尾，复制完毕
        JZ COPY11   ;0时跳转
        JMP COPY1        

COPY11:                
        MOV AX, 1000H
        MOV DS, AX 
        MOV SI, 0  
        MOV BX, 0100H
COPY2:        
        MOV AL, [SI]
        MOV [BX], AL
        INC SI
        INC BX          ;计算字符长度
        CMP AL,0
        JZ COPY22
        JMP COPY2             
        
COPY22: 
        MOV AX, 1000H
        MOV DS, AX
        MOV SI, 0

PRINT3:     
        MOV DL, [SI]
        CMP DL, 0
        JE  END4
        MOV AH, 02H
        INT 21H    ; output string at ds:dx
        INC SI
        JMP PRINT3
        
END4:
        JMP END4  
                
CODE  ENDS
END START

