;--------------------------------------------------------------------------
;  arkoshook
; 
; 2020-06-02 : install arkos _PLY_AKG_PLAY in interruption
; v1.0
;
;--------------------------------------------------------------------------

.module interrupt

.globl _PLY_AKG_PLAY

.globl _installArkosHook


event_block::
	.ds 9

_installArkosHook::
  
    
    di

    LD HL,#0XC3C3
	LD (#0X0038),HL

    ld hl, #interrupt_callback
    ld ( #0x39 ), hl
    ei

    ret


 interrupt_callback:

    nop

	di

    ld(#interrupt_previous_stack), sp
    ld sp, #interrupt_stack_start

    push af
    push bc
    push de
    push hl
    push ix
    push iy
    exx
    ex af, af'
	push af
	push bc
	push de
	push hl
	push ix
	push iy

	ld b, #0xf5
	in a, ( c )
	rrca
	jr nc, skipInitFirst
	ld a, #-1
	ld ( #interrupt_index ), a
skipInitFirst:

	ld a, ( #interrupt_index )
	cp #-2
	jp z, skipInterrupt
	
	inc a
	cp #6
	jp nz, no_interrupt_reset
	xor a
no_interrupt_reset:
	ld ( #interrupt_index ), a

	add a, a
	ld c, a
	ld b, #0
	ld hl, #interrupts
	add hl, bc

	ld a, ( hl )
	inc hl
	ld h, ( hl )
	ld l, a
	ld ( #interrupt_call + 1 ), hl

interrupt_call:
	call 0

skipInterrupt:

	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ex af, af'
    exx
    pop iy
    pop ix
    pop hl
    pop de
    pop bc
    pop af

    ld sp, ( interrupt_previous_stack )

    ei
    ret

 interrupt_previous_stack:
    .dw #0
 interrupt_stack:
    .ds #256
 interrupt_stack_start:

 interrupt_index:
    .db #-2
 interrupts:
    .dw interrupt_0
    .dw interrupt_1
    .dw interrupt_2
    .dw interrupt_3
    .dw interrupt_4
    .dw interrupt_5



 interrupt_0:
	ret

 interrupt_1:
	ret

 interrupt_2:
 	ret

 interrupt_3:
 	ret

 interrupt_4:
 	ret

 interrupt_5:
	call _PLY_AKG_PLAY
	ret
