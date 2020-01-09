io equ 8800h
code segment
    assume cs:code
start:
    mov ax, 0030h
    mov ds, ax
    mov sp, 1998H;全部应为1998h ,ffffh / 0ah
    mov dx, 00h
    mov cx, 0ah
w_ram:
    out dx, al
    inc al
    inc dx 
    loop w_ram
endless1:
    cmp sp, 0
    je pre
    dec sp
    mov cx, 0ah
    mov al, 30h
    jmp w_ram
pre:
    mov sp, 1998H;全部应为1998h ,ffffh / 0ah
    mov cx, 0ah
	mov bx, 39h
	dec dx   
	;写入差错
	mov al, 34h
    out 0003h, al
	out 000ah, al  
	
r_ram:
    in al, dx
	cmp al, bl
	jz green
	jne red
green:
    mov al, 02h
	mov bp, dx
	mov dx, io
	out dx, al
	mov dx, bp 
	jmp finish
red:
    mov al, 01h
	mov bp, dx
	mov dx, io
	out dx, al
	mov dx, bp
	jmp finish
finish:
	dec bx
    dec dx
	mov bp, cx
    mov cx, 4000h
    loop $ 
    mov cx, bp
    loop r_ram
endless2:
    cmp sp, 0
    je halt
    dec sp
    mov cx, 0ah
	mov bx, 39h
    ;mov al, 00h
    jmp r_ram 
halt:
    hlt
code ends
     end start