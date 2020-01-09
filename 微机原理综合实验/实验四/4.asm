DATA SEGMENT    
    HOUR DB 0  
    MINUTE DB 0  
    SECOND DB 0  
    TIME DB "00:00:00$"    
    LEN EQU $-TIME  
    NUM DB 0      
    DATEDIS DB ' 0000-00-00', 0AH, '$'  
ENDS  
  
STACK SEGMENT  
    DW   128  DUP(0)  
ENDS  
  
CODE SEGMENT  
START:  
  
    MOV AX, DATA  
    MOV DS, AX  
    MOV ES, AX    
      
BEGIN:  
   CALL  SETSHOW1
   CALL  GET_SYSTEM_DATE
   CALL  SETSHOW2   
   CALL  GET_SYSTEM_TIME   
   JMP BEGIN  

GET_SYSTEM_DATE PROC
    MOV AH, 2AH            ;取当前系统日期
    INT 21H
    MOV AX, CX             ;送入AX作为被除数[年份存放在CX中]
    MOV BX, 10             ;设置除数
    LEA SI, DATEDIS+4      ;使SI指向年的最后一位 
    MOV CX, 4              ;设置循环次数
    PUSH DX
    TAB:
        XOR DX, DX
        DIV BX
        ADD DL, 30H
        MOV [SI], DL
        DEC SI
        LOOP TAB
     POP DX
     MOV AL, DL
     XOR AH, AH
     DIV BL
     ADD AX, 3030H
     LEA SI, DATEDIS+9  
     MOV [SI], AX
     MOV AL, DH
     XOR AH, AH
     DIV BL
     ADD AX, 3030H
     LEA SI, DATEDIS+6
     MOV [SI], AX
     LEA DX, DATEDIS
     MOV AH, 9     
     INT 21H    
     RET
GET_SYSTEM_DATE ENDP
        
     
GET_SYSTEM_TIME PROC   
  ;获取系统时间  
    MOV AH,2CH     ;CH=时,CL=分,DH=秒  
    INT 21H         ;获取时间  
    MOV HOUR,CH  
    MOV MINUTE,CL  
    MOV SECOND,DH  
   
    MOV AX,0        ;时间显示到字符串  
    MOV AL,HOUR     ;商:AL,余数:AH  
    MOV NUM,10  
    DIV NUM  
    ADD AL,30H  
    MOV TIME[0],AL  
    ADD AH,30H  
    MOV TIME[1],AH   
      
    MOV AX,0  
    MOV AL,MINUTE  
    MOV NUM,10  
    DIV NUM  
    ADD AL,30H  
    MOV TIME[3],AL  
    ADD AH,30H  
    MOV TIME[4],AH  
      
    MOV AX,0  
    MOV AL,SECOND  
    MOV NUM,10  
    DIV NUM  
    ADD AL,30H  
    MOV TIME[6],AL  
    ADD AH,30H  
    MOV TIME[7],AH  
      
 ;输出系统时间  
    LEA DX, TIME  
    MOV AH, 9     
    INT 21H    
    RET   
GET_SYSTEM_TIME  ENDP  
  
SETSHOW1 PROC     ;设置光标位置   
    MOV DH,10  ;行号      
    MOV DL,30  ;列号    
    MOV BH,0  
    MOV AH,2   
      
    INT 10H     
    RET  
SETSHOW1 ENDP 
SETSHOW2 PROC
    MOV DH, 13
    MOV DL, 32 
    MOV BH, 0
    MOV AH, 2
    INT 10H
    RET
SETSHOW2 ENDP
   
    MOV AX, 4C00H  
    INT 21H      
ENDS  
  
END START