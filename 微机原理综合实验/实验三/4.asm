DATA SEGMENT
    D1 DB "please input a string:$"
    D2 DB 0AH,0DH,"number of A:$"
    STR DB 16
        DB 0
        DB 16 DUP(0)
ENDS

STACK SEGMENT
    DW   128  DUP(0)
ENDS

CODE SEGMENT
START:
; SET SEGMENT REGISTERS:
    MOV AX, DATA
    MOV DS, AX
    MOV ES, AX

    LEA DX, D1
    MOV AH, 9
    INT 21H
    
    LEA DX, STR             
    MOV AH, 0AH
    INT 21H     ;0AHϵͳ���������ַ������ַ������ȷ���[STR+1]
    
    LEA SI, STR  
    MOV CH, 00H
    MOV CL, [SI+1]  ; ��ʼ��ѭ������       
    MOV AL, 00H             
    ADD SI, 2
NEXT:
    CMP [SI], 'A'    ;�жϵ�ǰ�ַ��ǲ���A       
    JZ E
    JMP OVER
E:
    INC AL
OVER:  
    INC SI
    LOOP NEXT
    MOV BL, AL              
    ADD BL, 30H             
    
    LEA DX, D2
    MOV AH, 9
    INT 21H
    
    MOV DL, BL
    MOV AH, 02H
    INT 21H     ;������
                
    MOV AX, 4C00H 
    INT 21H    
ENDS

END START