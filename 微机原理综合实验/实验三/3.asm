DATA SEGMENT
    D1 DB 'PLEASE INPUT A NUMBER ',0DH,0AH,'$'
    D2 DB ' It is odd ',0AH,'$'
    D3 DB ' It is even ',0AH,'$' 
    D4  DB 10
        DB 10 DUP(0)
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA

START:   MOV AX,DATA
         MOV DS,AX
         MOV DX,OFFSET D1
         MOV AH,9
         INT 21H 
         
         LEA DX, D4
         MOV AH,0AH
         INT 21H
         
         MOV SI,OFFSET D4
         MOV AL,[SI+10]
         
         MOV CL,7
         SHL AL,CL   ;左移7位然后右移7位就可以取出最后一位，
         SHR AL,CL   ;判断最后一位是不是0就可判断奇偶
         CMP AL,0
         JE A
         MOV DX,OFFSET D2
         MOV AH,9
         INT 21H
         JMP OVER   

A:       MOV DX,OFFSET D3
         MOV AH,9
         INT 21H
         JMP OVER   
         
OVER:    MOV AH,4CH
         INT 21H
         
CODE ENDS
   END START