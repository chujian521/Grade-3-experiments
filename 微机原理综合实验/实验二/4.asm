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
        MOV DI, OFFSET SADD1   ;�ҵ�SADD1��ƫ��
        
        MOV CX, 4   ;CX��ʼ��Ϊ4��LOOPѭ���Ĵ�
INPUT:
        MOV AH, 01H
        INT 21H     ;�������벢����,AL=�����ַ�
        MOV [DI], AL
        INC DI
        LOOP INPUT
        
        MOV SI, OFFSET SADD1  
        MOV DI, OFFSET ADD1
        
        MOV CX, 0002H

A1:     
        XOR AX, AX ;AX����       
        MOV BX, [SI] 
        AND BX, 000FH ;��ȡ��ASCII����������
        ADD AX, BX 
        
        MOV BX, AX
        SHL AX, 03H
        ADD AX, BX
        ADD AX, BX ;����8+�Լ�+�Լ�
                
        INC SI  ;SI������ȡ��һλ��λ 
        MOV BX, [SI]
        AND BX, 000FH  ;ȡ������λ����
        ADD AX, BX
        INC SI     
        
        MOV [DI], AL
        INC DI
        LOOP A1;ѭ������ȡ���������� ����DI  Ҳ����ADD1

        MOV SI, OFFSET ADD1
        MOV AX, [SI] 
        AND AX, 00FFH
        INC SI
        MOV BX, [SI] 
        AND BX, 00FFH ;��������λ���֣����ֻȡ����λ����
        
        MUL BX     ;�˷�����
        MOV SI, OFFSET MOUT
        MOV [SI], AX ;AXֵ���Ǽ�����

        
        MOV DI, OFFSET COUT  ;��ʼ��
        MOV AX, [SI] 
        MOV BX, 0AH
OUTP:   
        MOV DX, 0           
        DIV BX      ;AX����10����AX ����������DX
        
        AND DX, 00FFH ;ȡDX��Чλ
        ADD DL, 0030H ;ȡ��λASCII
        
        MOV [DI], DL
        INC DI            
                
        CMP AX, 0000H
        JE OUTP2
        JMP OUTP ;�ظ��������е��ַ� 

OUTP2:        
        MOV DI, OFFSET COUTEND
        MOV CX, 05H
AN:              
        MOV DL, [DI]
        DEC DI
        MOV AH, 02H
        INT 21H   ;DOS��������ַ����
        LOOP AN

A2:
        JMP A2       
          
CODE    ENDS
        END START


