;write by chujian
.386
.model flat, stdcall

include kernel32.inc
includelib kernel32.lib

include msvcrt.inc
includelib msvcrt.lib

.data
szText	db	"Reverse Engineering", 0
chr		db	'i'
format	db	"%d", 0AH, 0

.code

main PROC
	LEA EDI, szText
	MOV ECX,0FFFFFFFFH
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;strchrÂß¼­
	MOV EBX,EDI
	MOV AL,[chr]
	REPNE SCASB
	INVOKE crt_printf, addr format, EDI
	SUB EDI,EBX
	INVOKE crt_printf, addr format, EDI
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INVOKE crt_getchar
	INVOKE ExitProcess, 0
main ENDP

END main