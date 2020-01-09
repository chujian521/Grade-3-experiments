IO1  EQU   0C400H     
IO2  EQU   0C440H     

a8255_1_A  EQU    IO1+00*2   ;第一片8255的地址的A口
a8255_1_B  EQU    IO1+01*2   ;第一片8255的地址的B口
a8255_1_MODE  EQU IO1+11*2   ;第一片8255的地址的控制字寄存器

b8255_2_A  EQU    IO2+00*2   ;第二片8255的地址的A口
b8255_2_B  EQU    IO2+01*2   ;第二片8255的地址的B口
b8255_2_MODE  EQU IO2+11*2   ;第二片8255的地址的控制字寄存器

DATAS  SEGMENT
  COUNT1  DB    00H
  COUNT2  DB    01H 
; 以横向8个连续点构成一个字节,最左边的点为字节的最低位,即BIT0,最右边的点为BIT7。 16×16汉字按每行2字节,共16行取字模,每个汉字共32字节,点阵四个角取字顺序为左上角→右上角→左下角→右下角。    
TAB DB  00H, 00H, 01H, 20H,0FFH, 7FH, 20H, 02H,20H, 02H, 20H, 22H,0FEH, 7FH, 22H, 22H
	DB  22H, 22H, 22H, 22H, 22H, 22H, 12H, 2CH,0AH, 20H, 02H, 20H,0FEH, 3FH, 02H, 20H;"西"     
	   
	DB  40H, 00H, 80H, 00H,0FEH, 7FH, 02H, 40H,41H, 20H, 40H, 00H, 40H, 20H,0FFH, 7FH
	DB  20H, 04H, 10H, 04H, 18H, 04H, 60H, 02H,80H, 01H, 40H, 02H, 30H, 0CH, 0CH, 08H;"安" 

	DB  40H, 00H, 40H, 00H, 40H, 08H,0FEH, 1FH,42H, 08H, 42H, 08H,0FEH, 0FH, 42H, 08H
	DB	42H, 08H,0FEH, 0FH, 42H, 08H, 40H, 00H,40H, 20H, 40H, 20H, 80H, 3FH, 00H, 00H;"电"

	DB  00H, 00H,0FCH, 0FH, 00H, 08H, 00H, 04H,00H, 02H, 80H, 01H, 80H, 20H,0FFH, 7FH
	DB	80H, 00H, 80H, 00H, 80H, 00H, 80H, 00H,80H, 00H, 80H, 00H,0A0H, 00H, 40H, 00H;"子"
    
    DB  20H, 08H, 70H, 08H, 1FH, 09H, 10H, 0AH,10H, 08H, 7FH, 09H, 10H, 0AH, 38H, 28H
	DB	58H, 78H, 94H, 0FH, 14H, 08H, 12H, 08H,11H, 08H, 10H, 08H, 10H, 08H, 10H, 08H;"科"

	DB  08H, 02H, 08H, 02H, 08H, 12H,0C8H, 3FH,3FH, 02H, 08H, 02H, 08H, 02H,0C8H, 1FH
	DB	58H, 10H, 8CH, 08H, 8BH, 08H, 08H, 05H,08H, 02H, 08H, 0DH, 8AH, 70H, 64H, 20H;"技"

	DB  80H, 00H, 80H, 00H, 80H, 00H, 80H, 00H,80H, 20H,0FFH, 7FH, 80H, 00H, 40H, 01H
	DB	40H, 01H, 40H, 02H, 20H, 02H, 20H, 04H,10H, 08H, 08H, 70H, 06H, 20H, 00H, 00H;"大"

	DB  44H, 10H, 88H, 10H, 88H, 08H, 00H, 04H,0FEH, 7FH, 02H, 40H, 01H, 20H,0F8H, 07H
	DB	00H, 02H, 80H, 21H,0FFH, 7FH, 80H, 00H,80H, 00H, 80H, 00H,0A0H, 00H, 40H, 00H;"学"

	DB  00H, 01H, 00H, 01H, 3FH, 01H, 20H, 3FH,0A2H, 20H, 62H, 12H, 14H, 02H, 14H, 02H
	DB	08H, 02H, 14H, 02H, 24H, 05H, 22H, 05H,81H, 08H, 80H, 10H, 40H, 70H, 30H, 20H;"欢"

	DB  00H, 00H, 82H, 21H, 64H, 7EH, 28H, 22H,20H, 22H, 20H, 22H, 2FH, 22H, 28H, 23H
	DB	0A8H, 22H, 68H, 2AH, 28H, 12H, 08H, 02H,08H, 02H, 14H, 62H,0E2H, 3FH, 00H, 00H;"迎"

	DB  90H, 00H, 90H, 00H,0C8H, 3FH, 48H, 20H,2CH, 12H, 9AH, 02H, 89H, 0AH, 48H, 32H
	DB	28H, 22H, 88H, 02H, 08H, 01H, 40H, 00H,8AH, 21H, 0AH, 49H, 09H, 48H,0F0H, 0FH;"您"

	DB  00H, 00H, 80H, 01H,0C0H, 03H,0C0H, 03H,0C0H, 03H,0C0H, 03H,0C0H, 03H, 80H, 01H
	DB  80H, 01H, 80H, 01H, 00H, 00H, 80H, 01H,0C0H, 03H, 80H, 01H, 00H, 00H, 00H, 00H;"！" 

	DB  00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H,00H, 00H, 00H, 00H, 00H, 00H,0FEH, 7FH
	DB	00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H,00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H;"—""     
   	                                                                                       
    DB 080H,000H,080H,000H,0FEH,03FH,0C0H,001H,0A0H,002H,090H,004H,08CH,018H,083H,060H
    DB 0F0H,007H,000H,002H,000H,001H,0FFH,07FH,080H,000H,080H,000H,0A0H,000H,040H,000H;"李"

    DB 040H,004H,0E0H,004H,01CH,004H,004H,07EH,004H,042H,004H,021H,0FCH,008H,024H,008H
    DB 024H,008H,024H,008H,024H,014H,024H,014H,024H,012H,022H,022H,022H,021H,081H,040H;"欣"	                                                                                       

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
    OUT DX,AL       ;第一片8255方式选择
    MOV DX,b8255_2_MODE
    MOV AL,80H
    OUT DX,AL       ;第二片8255方式选择
    MOV CX,0
    JMP STEP0
    
STEP0:  
    MOV SI,0000H    ;指针赋值0
    MOV AH,17        ;显示字符数量
    JMP STEP1

STEP1: 
    PUSH CX
    MOV BX,1024     ;整体循环1024次
    
STEP_BACK:  
    PUSH BX
    MOV BH,COUNT1   ;初始化
    MOV BL,COUNT2
    CLC                   ;CF位清零;;;;;;;
RER:  
    MOV CX,16       
    MOV SI,DI       ;指向原来的位置
LOOP1:
    MOV DX,b8255_2_A  ;清除列
    MOV AL,00H
    OUT DX,AL
    MOV DX,b8255_2_B
    MOV AL,00H
    OUT DX,AL
     CALL FI
    INC SI          ;指针再次加1
    RCL BL,1        ;每次循环向左移动1位
    RCL BH,1        ;连带CF位一同左移1位
    DEC CX          ;循环次数减1
    CMP CX,0        ;循环次数大于0，就继续循环
     JNZ LOOP1
    POP BX          ;第二重循环计数
    DEC BX
    CMP BX,0
     JNZ STEP_BACK
LOOP3:
    POP CX          ;第三重循环，控制显示哪些字
    INC CX
    MOV DI,SI
    CMP CL,AH
    JNZ STEP1          ;显示程序结束
    MOV DI,0000H
    MOV AH,0
    MOV CX,0
    JMP STEP0

FI:  
    MOV DX,a8255_1_A  ;循环行扫描
    MOV AL,BL
    OUT DX,AL
    MOV DX,a8255_1_B
    MOV AL,BH
    OUT DX,AL
LOOP2:
    MOV DX,b8255_2_A  ;循环列扫描
    MOV AL,TAB[SI]
    OUT DX,AL
    INC SI          ;指针加1，指向下一个数据
    MOV DX,b8255_2_B
    MOV AL,TAB[SI]
    OUT DX,AL
    RET
  CODES ENDS
END START




