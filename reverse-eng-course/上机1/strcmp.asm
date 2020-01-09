;write by chujian
.386
.model flat, stdcall

include kernel32.inc
includelib kernel32.lib

include msvcrt.inc
includelib msvcrt.lib

.data
format		db	"%d", 0AH, 0
szText		db	"Reverse Engineering", 0
szText2		db	"Reverse Engineering", 0	;szText==szText2
szText3		db	"Reverse Eng", 0			;szText>szText3
szText4		db	"Reverse Engj", 0			;szText<szText4
szText5		db	"Reverse Engh", 0			;szText>szText5

.code

main PROC
	LEA ESI, szText
	LEA EDI, szText2	;result=0
	;LEA EDI, szText3	;result=1
	;LEA EDI, szText4	;result=-1
	;LEA EDI, szText5	;result=1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;strcmpÂß¼­
	MOV ECX,20
	REPE CMPSB
	CMP ECX,0
	Jecxz equal
	MOV ECX,1
equal:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INVOKE crt_printf, addr format, ECX

	INVOKE crt_getchar
	INVOKE ExitProcess, 0
main ENDP

END main