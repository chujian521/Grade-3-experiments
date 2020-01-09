DATA SEGMENT    
    BUF1 DB 2,4,6,8,10,12  ;0710:0000
    BUF2 DB 1,3,5,7,8  
    BUF3 DB 20 DUP(0) ;0710:000B
    N1 DB 6
    N2 DB 5
ENDS

STACK SEGMENT
    DW   128  DUP(0)
ENDS
;排序结果在内存中0710:000B
CODE SEGMENT
START:

    MOV AX, DATA
    MOV DS, AX
    MOV ES, AX

    MOV AL, N1              
    MOV AH, N2              
    MOV DL, 00H             
    MOV DH, 00H             
    MOV CL, 00H             
    LEA SI, BUF1 
    LEA BX, BUF2
    LEA DI, BUF3
SORT:
    MOV CH, [BX] ;BUF2的第一位
    CMP [SI], CH ;与BUF1的第一位比较            
    JNZ NEXT1   ;不相等跳转
    ;BUF1 == BUF2 相等继续执行
    MOV [DI], CH            
    INC DL
    INC DH 
    INC CL
    INC SI
    INC BX
    INC DI
    JMP CHECK1
NEXT1:
    CMP [SI], CH  ;CF标志位 [SI]<CH 1  否则0
    JC NEXT2    ;[SI]<CH跳转
    ;BUF1 > BUF2
    MOV [DI], CH
    INC DH
    INC CL
    INC BX
    INC DI
    JMP CHECK2
NEXT2:
    ;BUF1 < BUF2 
    MOV CH, [SI]
    MOV [DI], CH
    INC DL
    INC CL
    INC SI
    INC DI
    JMP CHECK1
CHECK1:
    CMP DL, AL
    JC CHECK2 ;DL<AL 跳CHECK2 
    JMP S2    ;如果BUF1结尾，跳S2，复制S2后半段
CHECK2:
    CMP DH, AH          
    JC SORT      ;如果BUF2结尾，跳S1，复制S1后半段
    
S1:                    
    CMP DL, AL
    JNC OVER
    MOV CH, [SI]                    
    MOV [DI] ,CH
    INC DL
    INC CL
    INC SI
    INC DI
    JMP S1
S2:                       
    CMP DH,AH
    JNC OVER
    MOV CH, [BX]
    MOV [DI], CH
    INC DH
    INC DL
    INC BX
    INC DI 
    JMP S2
OVER:
    MOV AX, 4C00H
    INT 21H       
ENDS

END START