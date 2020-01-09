STACK SEGMENT STACK
    DW 64 DUP(?)
STACK ENDS

DATA SEGMENT
m  DB 6
n  DB 4
w  DB 7
Q  DB 0
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

START:  MOV AX, DATA
        MOV DS, AX
        MOV AX, OFFSET m
        MOV SI, AX          
        MOV AL, [SI]
        MOV BL, [SI+1]
        MUL BL
        MOV BX, 0
        MOV BL, [SI+2]
        SUB AX, BX
        MOV [SI+3], AX
        
endloop:
        JMP endloop
CODE    ENDS
        END START