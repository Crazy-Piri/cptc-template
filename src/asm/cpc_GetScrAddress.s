.module video


.globl _cpc_GetScrAddress

_cpc_GetScrAddress::

;	LD IX,#2
;	ADD IX,SP
;	LD A,0 (IX)
;	LD L,1 (IX)	;pantalla

	pop af
	pop hl
	push af


	LD A,L

_cpc_GetScrAddress0::			;en HL están las coordenadas

	;LD A,H
	LD (#inc_ancho+1),A
	LD A,H
	SRL A
	SRL A
	SRL A
	; A indica el bloque a multiplicar x &50
	LD D,A						;D
	SLA A
	SLA A
	SLA A
	SUB H
	NEG
	; A indica el desplazamiento a multiplicar x &800
	LD E,A						;E
	LD L,D
	LD H,#0
	ADD HL,HL
	LD BC,#bloques
	ADD HL,BC
	;HL APUNTA AL BLOQUE BUSCADO
	LD C,(HL)
	INC HL
	LD H,(HL)
	LD L,C
	;HL TIENE EL VALOR DEL BLOQUE DE 8 BUSCADO
	PUSH HL
	LD D,#0
	LD HL,#sub_bloques
	ADD HL,DE
	LD A,(HL)
	POP HL
	ADD H
	LD H,A
inc_ancho:
	LD E,#0
	ADD HL,DE
	RET


bloques:
 .DW #0xc000, #0xc060, #0xc0c0, #0xc120, #0xc180, #0xc1e0, #0xc240, #0xc2a0, #0xc300, #0xc360, #0xc3c0, #0xc420, #0xc480, #0xc4e0, #0xc540, #0xc5a0, #0xc600, #0xc660, #0xc6c0, #0xc720, #0xc780, #0xc7e0, #0xc840, #0xc8a0, #0xc900, #0xc960, #0xc9c0, #0xca20, #0xca80, #0xcae0, #0xcb40
sub_bloques:
 .DB #0x00, #0x08, #0x10, #0x18, #0x20, #0x28, #0x30, #0x38