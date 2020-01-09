STACK SEGMENT STACK
    DW 64 DUP(?)
STACK ENDS

DATA SEGMENT DATA
SADD1 DB 2 DUP(0)
SADD2 DB 2 DUP(0)
ADD1 DB 1 DUP(0)
ADD2 DB 1 DUP(0) 
MOUT DW 1 DUP(0)
COUT DB 4 DUP(0) 
COUTEND DB 00H
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

START:  
        MOV AX, STACK
        MOV SS, AX
        MOV SP, 0
                    
        MOV AX, DATA
        MOV DS, AX
        MOV DI, OFFSET SADD1   ;找到SADD1的偏移
        
        MOV CX, 4   ;CX初始化为4，LOOP循环四次
INPUT:
        MOV AH, 01H
        INT 21H     ;键盘输入并回显,AL=输入字符
        MOV [DI], AL
        INC DI
        LOOP INPUT
        
        MOV SI, OFFSET SADD1  
        MOV DI, OFFSET ADD1
        
        MOV CX, 0002H

A1:     
        XOR AX, AX ;AX置零       
        MOV BX, [SI] 
        AND BX, 000FH ;提取出ASCII码代表的数字
        ADD AX, BX 
        
        MOV BX, AX
        SHL AX, 03H
        ADD AX, BX
        ADD AX, BX ;乘以8+自己+自己
                
        INC SI  ;SI自增，取下一位个位 
        MOV BX, [SI]
        AND BX, 000FH  ;取出来个位数字
        ADD AX, BX
        INC SI     
        
        MOV [DI], AL
        INC DI
        LOOP A1;循环两次取出两个数字 放入DI  也就是ADD1

        MOV SI, OFFSET ADD1
        MOV AX, [SI] 
        AND AX, 00FFH
        INC SI
        MOV BX, [SI] 
        AND BX, 00FFH ;由于是两位数字，因此只取后两位即可
        
        MUL BX     ;乘法运算
        MOV SI, OFFSET MOUT
        MOV [SI], AX ;AX值就是计算结果

        
        MOV DI, OFFSET COUT  ;初始化
        MOV AX, [SI] 
        MOV BX, 0AH
OUTP:   
        MOV DX, 0           
        DIV BX      ;AX除以10存入AX ，余数放入DX
        
        AND DX, 00FFH ;取DX有效位
        ADD DL, 0030H ;取个位ASCII
        
        MOV [DI], DL
        INC DI            
                
        CMP AX, 0000H
        JE OUTP2
        JMP OUTP ;重复计算所有的字符 

OUTP2:        
        MOV DI, OFFSET COUTEND
        MOV CX, 05H
AN:              
        MOV DL, [DI]
        DEC DI
        MOV AH, 02H
        INT 21H   ;DOS调用输出字符结果
        LOOP AN

A2:
        JMP A2       
          
CODE    ENDS
        END START


