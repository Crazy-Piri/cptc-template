.module gphstr

.include "cpc_gphstr.s"

.globl _cpc_GetScrAddress0

.globl _cpc_PrintGphStrXY2X

_cpc_PrintGphStrXY2X::
;preparación datos impresión. El ancho y alto son fijos!
	pop af
	pop de
	pop hl
	push af

	push de
	ld a,L
	CALL _cpc_GetScrAddress0
	pop de

	LD A,#1
	push iy
 	call _cpc_PrintGphStr0
	pop iy
	ret
	