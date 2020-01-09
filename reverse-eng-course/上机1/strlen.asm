;write by chujian
.386
.model flat, stdcall

include kernel32.inc
includelib kernel32.lib

include msvcrt.inc
includelib msvcrt.lib

.data
szText	db	"Reverse Engineering", 0
format	db	"length = %d", 0AH, 0

.code

main PROC
	LEA EDI, szText
	MOV ECX,0FFFFFFFFH
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;strlenÂß¼­
	XOR AL,AL
	MOV EBX,EDI
	REPNE SCASB
	SUB EDI,EBX
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INVOKE crt_printf, addr format, EDI

	INVOKE crt_getchar
	INVOKE ExitProcess, 0
main ENDP

END main