.module gphstr

.include "cpc_gphstr.s"

.globl _cpc_GetScrAddress0

.globl _cpc_PrintGphStrXYM12X

_cpc_PrintGphStrXYM12X::
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
	push ix
	push iy
	call _cpc_PrintGphStr0M1
	pop iy
	pop ix
	ret