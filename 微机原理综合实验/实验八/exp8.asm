IO1  EQU   0C400H     
IO2  EQU   0C440H     

a8255_1_A  EQU    IO1+00*2   ;��һƬ8255�ĵ�ַ��A��
a8255_1_B  EQU    IO1+01*2   ;��һƬ8255�ĵ�ַ��B��
a8255_1_MODE  EQU IO1+11*2   ;��һƬ8255�ĵ�ַ�Ŀ����ּĴ���

b8255_2_A  EQU    IO2+00*2   ;�ڶ�Ƭ8255�ĵ�ַ��A��
b8255_2_B  EQU    IO2+01*2   ;�ڶ�Ƭ8255�ĵ�ַ��B��
b8255_2_MODE  EQU IO2+11*2   ;�ڶ�Ƭ8255�ĵ�ַ�Ŀ����ּĴ���

DATAS  SEGMENT
  COUNT1  DB    00H
  COUNT2  DB    01H 
; �Ժ���8�������㹹��һ���ֽ�,����ߵĵ�Ϊ�ֽڵ����λ,��BIT0,���ұߵĵ�ΪBIT7�� 16��16���ְ�ÿ��2�ֽ�,��16��ȡ��ģ,ÿ�����ֹ�32�ֽ�,�����ĸ���ȡ��˳��Ϊ���Ͻǡ����Ͻǡ����½ǡ����½ǡ�    
TAB DB  00H, 00H, 01H, 20H,0FFH, 7FH, 20H, 02H,20H, 02H, 20H, 22H,0FEH, 7FH, 22H, 22H
	DB  22H, 22H, 22H, 22H, 22H, 22H, 12H, 2CH,0AH, 20H, 02H, 20H,0FEH, 3FH, 02H, 20H;"��"     
	   
	DB  40H, 00H, 80H, 00H,0FEH, 7FH, 02H, 40H,41H, 20H, 40H, 00H, 40H, 20H,0FFH, 7FH
	DB  20H, 04H, 10H, 04H, 18H, 04H, 60H, 02H,80H, 01H, 40H, 02H, 30H, 0CH, 0CH, 08H;"��" 

	DB  40H, 00H, 40H, 00H, 40H, 08H,0FEH, 1FH,42H, 08H, 42H, 08H,0FEH, 0FH, 42H, 08H
	DB	42H, 08H,0FEH, 0FH, 42H, 08H, 40H, 00H,40H, 20H, 40H, 20H, 80H, 3FH, 00H, 00H;"��"

	DB  00H, 00H,0FCH, 0FH, 00H, 08H, 00H, 04H,00H, 02H, 80H, 01H, 80H, 20H,0FFH, 7FH
	DB	80H, 00H, 80H, 00H, 80H, 00H, 80H, 00H,80H, 00H, 80H, 00H,0A0H, 00H, 40H, 00H;"��"
    
    DB  20H, 08H, 70H, 08H, 1FH, 09H, 10H, 0AH,10H, 08H, 7FH, 09H, 10H, 0AH, 38H, 28H
	DB	58H, 78H, 94H, 0FH, 14H, 08H, 12H, 08H,11H, 08H, 10H, 08H, 10H, 08H, 10H, 08H;"��"

	DB  08H, 02H, 08H, 02H, 08H, 12H,0C8H, 3FH,3FH, 02H, 08H, 02H, 08H, 02H,0C8H, 1FH
	DB	58H, 10H, 8CH, 08H, 8BH, 08H, 08H, 05H,08H, 02H, 08H, 0DH, 8AH, 70H, 64H, 20H;"��"

	DB  80H, 00H, 80H, 00H, 80H, 00H, 80H, 00H,80H, 20H,0FFH, 7FH, 80H, 00H, 40H, 01H
	DB	40H, 01H, 40H, 02H, 20H, 02H, 20H, 04H,10H, 08H, 08H, 70H, 06H, 20H, 00H, 00H;"��"

	DB  44H, 10H, 88H, 10H, 88H, 08H, 00H, 04H,0FEH, 7FH, 02H, 40H, 01H, 20H,0F8H, 07H
	DB	00H, 02H, 80H, 21H,0FFH, 7FH, 80H, 00H,80H, 00H, 80H, 00H,0A0H, 00H, 40H, 00H;"ѧ"

	DB  00H, 01H, 00H, 01H, 3FH, 01H, 20H, 3FH,0A2H, 20H, 62H, 12H, 14H, 02H, 14H, 02H
	DB	08H, 02H, 14H, 02H, 24H, 05H, 22H, 05H,81H, 08H, 80H, 10H, 40H, 70H, 30H, 20H;"��"

	DB  00H, 00H, 82H, 21H, 64H, 7EH, 28H, 22H,20H, 22H, 20H, 22H, 2FH, 22H, 28H, 23H
	DB	0A8H, 22H, 68H, 2AH, 28H, 12H, 08H, 02H,08H, 02H, 14H, 62H,0E2H, 3FH, 00H, 00H;"ӭ"

	DB  90H, 00H, 90H, 00H,0C8H, 3FH, 48H, 20H,2CH, 12H, 9AH, 02H, 89H, 0AH, 48H, 32H
	DB	28H, 22H, 88H, 02H, 08H, 01H, 40H, 00H,8AH, 21H, 0AH, 49H, 09H, 48H,0F0H, 0FH;"��"

	DB  00H, 00H, 80H, 01H,0C0H, 03H,0C0H, 03H,0C0H, 03H,0C0H, 03H,0C0H, 03H, 80H, 01H
	DB  80H, 01H, 80H, 01H, 00H, 00H, 80H, 01H,0C0H, 03H, 80H, 01H, 00H, 00H, 00H, 00H;"��" 

	DB  00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H,00H, 00H, 00H, 00H, 00H, 00H,0FEH, 7FH
	DB	00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H,00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H;"��""     
   	                                                                                       
    DB 080H,000H,080H,000H,0FEH,03FH,0C0H,001H,0A0H,002H,090H,004H,08CH,018H,083H,060H
    DB 0F0H,007H,000H,002H,000H,001H,0FFH,07FH,080H,000H,080H,000H,0A0H,000H,040H,000H;"��"

    DB 040H,004H,0E0H,004H,01CH,004H,004H,07EH,004H,042H,004H,021H,0FCH,008H,024H,008H
    DB 024H,008H,024H,008H,024H,014H,024H,014H,024H,012H,022H,022H,022H,021H,081H,040H;"��"	                                                                                       

DATAS  ENDS

STACKS  SEGMENT
    N1  DB  100 DUP(0)
STACKS  ENDS

CODES  SEGMENT
    ASSUME    CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV DX,a8255_1_MODE
    MOV AL,81H
    OUT DX,AL       ;��һƬ8255��ʽѡ��
    MOV DX,b8255_2_MODE
    MOV AL,80H
    OUT DX,AL       ;�ڶ�Ƭ8255��ʽѡ��
    MOV CX,0
    JMP STEP0
    
STEP0:  
    MOV SI,0000H    ;ָ�븳ֵ0
    MOV AH,17        ;��ʾ�ַ�����
    JMP STEP1

STEP1: 
    PUSH CX
    MOV BX,1024     ;����ѭ��1024��
    
STEP_BACK:  
    PUSH BX
    MOV BH,COUNT1   ;��ʼ��
    MOV BL,COUNT2
    CLC                   ;CFλ����;;;;;;;
RER:  
    MOV CX,16       
    MOV SI,DI       ;ָ��ԭ����λ��
LOOP1:
    MOV DX,b8255_2_A  ;�����
    MOV AL,00H
    OUT DX,AL
    MOV DX,b8255_2_B
    MOV AL,00H
    OUT DX,AL
     CALL FI
    INC SI          ;ָ���ٴμ�1
    RCL BL,1        ;ÿ��ѭ�������ƶ�1λ
    RCL BH,1        ;����CFλһͬ����1λ
    DEC CX          ;ѭ��������1
    CMP CX,0        ;ѭ����������0���ͼ���ѭ��
     JNZ LOOP1
    POP BX          ;�ڶ���ѭ������
    DEC BX
    CMP BX,0
     JNZ STEP_BACK
LOOP3:
    POP CX          ;������ѭ����������ʾ��Щ��
    INC CX
    MOV DI,SI
    CMP CL,AH
    JNZ STEP1          ;��ʾ�������
    MOV DI,0000H
    MOV AH,0
    MOV CX,0
    JMP STEP0

FI:  
    MOV DX,a8255_1_A  ;ѭ����ɨ��
    MOV AL,BL
    OUT DX,AL
    MOV DX,a8255_1_B
    MOV AL,BH
    OUT DX,AL
LOOP2:
    MOV DX,b8255_2_A  ;ѭ����ɨ��
    MOV AL,TAB[SI]
    OUT DX,AL
    INC SI          ;ָ���1��ָ����һ������
    MOV DX,b8255_2_B
    MOV AL,TAB[SI]
    OUT DX,AL
    RET
  CODES ENDS
END START




