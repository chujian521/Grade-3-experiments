DATA SEGMENT
    
ENDS

STACK SEGMENT
    DW   128  DUP(0)
ENDS

CODE SEGMENT
START:
    MOV AX, DATA
    MOV DS, AX
    MOV ES, AX

    MOV AH,1H
    INT 21H
    MOV AH, 00H
    SUB AL, 30H
    MOV CX, 0
    MOV CL, AL
    DEC CL
NEXT:                                                                                                       
    CMP CL, 1
    JNA INIT
    MUL CX
    DEC CL
    JMP NEXT 
INIT:    
    MOV BX, AX
    MOV CX, 0 
    MOV DI, 0AH
NEXT1:
    DIV DI
    PUSH DX
    INC CX
    CMP AX, 0
    JE NEXT2
    CWD
    JMP NEXT1
NEXT2:    
    MOV DL, 0AH
    MOV AH, 2 
    INT 21H 
    MOV DL, 0DH
    MOV AH, 2 
    INT 21H
OUTPUT:
    POP DX
    ADD DL, 30H
    MOV AH, 2
    INT 21H
    LOOP OUTPUT 
    
    MOV AX, 4C00H
    INT 21H
ENDS

END START