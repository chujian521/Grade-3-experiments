;write by chujian
.386
.model flat, stdcall

include kernel32.inc
includelib kernel32.lib

include msvcrt.inc
includelib msvcrt.lib

.data
szText	db	"Reverse Engineering", 0
chr		db	'j'

.code

main PROC
	LEA EDI, szText
	MOV ECX,0FFFFFFFFH
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;strsetÂß¼­
	PUSH 'j'
	POP EAX
	PUSH 19
	POP ECX
	REP STOSB
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INVOKE crt_printf, addr szText

	INVOKE crt_getchar
	INVOKE ExitProcess, 0
main ENDP

END main