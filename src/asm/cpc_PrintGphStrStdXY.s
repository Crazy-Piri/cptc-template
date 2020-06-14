.module gphstrstd

.include  "cpc_gphstrstd.s"

.globl _cpc_GetScrAddress0


.globl _cpc_PrintGphStrStdXY

_cpc_PrintGphStrStdXY::
;preparación datos impresión. El ancho y alto son fijos!
	push ix
	ld ix,#4
	add ix,sp
	ld L,4 (ix)
	ld A,3 (ix)	;pantalla
	call _cpc_GetScrAddress0   
	ld e,1 (ix)
	ld d,2 (ix)	;texto origen
	ld a,0 (ix) ;color
	;ld (#_cpc_PrintGphStrStd0+1),a
	call _cpc_PrintGphStrStd0
	pop ix
	ret