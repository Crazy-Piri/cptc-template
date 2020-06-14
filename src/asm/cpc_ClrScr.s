.module video

.globl _cpc_ClrScr

_cpc_ClrScr::
	XOR A
	LD HL,#0x8000
	LD DE,#0x8001
	LD BC,#32767
	LD (HL),A
	LDIR

	
	RET