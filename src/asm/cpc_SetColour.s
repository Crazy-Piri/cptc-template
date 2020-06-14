.module video


.globl  _cpc_SetColour

_cpc_SetColour::		;El número de tinta 17 es el borde

	POP AF	;CALLEE, pasa parámetros en pila pero no haca falta reconstruirla
	pop hl
	push af

 	LD A,L
    LD E,H
  	LD BC,#0x7F00                     ;Gate Array
	OUT (C),A                       ;Número de tinta
	LD A,#64 	               	;Color (y Gate Array)
	ADD E
	OUT (C),A
	RET