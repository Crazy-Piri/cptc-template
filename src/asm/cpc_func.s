;--------------------------------------------------------------------------
;  cpc_funcs
; 
; 2018-09-27 : original version - cpcrslib
; v1.0
;
;--------------------------------------------------------------------------

.area _CODE

.globl _PLY_AKG_PLAY
.globl _PLY_AKG_PLAYSOUNDEFFECT
.globl _PLY_AKG_STOPSOUNDEFFECTFROMCHANNEL

_SetStack::
	pop hl ; preserve return address in main()
	ld sp, #0x01FF ; whatever address you want stack to start at
	jp (hl) ; return


_PlayZik::
;	push af
;	push bc
;	push de
;	push hl
;	push ix
;	push iy
	di
	call _PLY_AKG_PLAY
	ei
;	pop iy
;	pop ix
;	pop de
;	pop hl
;	pop bc
;	pop af
	ret

_PlaySfx::
;	push	af
;	push	bc
;	push	de
;	push    hl
;	push	ix
;	push	iy
	di
	ld	c, #2; Channel 1.
	ld	a, l ; #0x04; The selected sound effect(>= 1).
	ld	b, #0
	call	_PLY_AKG_PLAYSOUNDEFFECT
	ei
;	pop	iy
;	pop	ix
;	pop	de
;	pop hl
;	pop	bc
;	pop	af
	ret

_StopSfx::
;	push	af
;	push	bc
;	push	de
;	push    hl
;	push	ix
;	push	iy
	di
	ld	a, #2; Channel 1.
	call	_PLY_AKG_STOPSOUNDEFFECTFROMCHANNEL
	ei
;	pop	iy
;	pop	ix
;	pop	de
;	pop hl
;	pop	bc
;	pop	af
	ret
