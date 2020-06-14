.module gphstrstd

.include  "cpc_gphstrstd.s"


_cpc_PrintGphStrStd0: 
; marcará el color con que se imprime
color_uso:
	;LD A,#1
	OR A 
	JP Z,color0
	CP #1
	JP Z,color1
	CP #2
	JP Z,color2
	CP #3
	JP Z,color3
sigue:

	;trabajo previo: Para tener una lista de trabajos de impresión. No se interrumpe
	;la impresión en curso.
	LD A,(#imprimiendo)
	CP #1
	JP Z,add_elemento
	LD (#direcc_destino),HL
	EX DE,HL
	CALL bucle_texto0

;antes de terminar, se mira si hay algo en cola.
bucle_cola_impresion:
	LD A,(#elementos_cola)
	OR A
	JP Z,terminar_impresion
	CALL leer_elemento
	JP bucle_cola_impresion
	
color0:
	XOR A
	CALL metecolor
	JP sigue
color1:
	LD A,#0B00001000
	CALL metecolor
	JP sigue
color2:
	LD A,#0B10000000
	CALL metecolor
	JP sigue
color3:
	LD A,#0b10001000
	CALL metecolor
	JP sigue
metecolor:
	LD (#cc0_gpstd-1),A
	LD (#cc4_gpstd-1),A
	SRL A
	LD (#cc1_gpstd-1),A
	LD (#cc5_gpstd-1),A
	SRL A
	LD (#cc2_gpstd-1),A
	LD (#cc6_gpstd-1),A
	SRL A
	LD (#cc3_gpstd-1),A
	LD (#cc7_gpstd-1),A
	RET	
	
	

terminar_impresion:
	XOR A
	LD (#imprimiendo),A
	RET
entrar_cola_impresion:
	;si se está imprimiendo se mete el valor en la cola
	RET
add_elemento:
	DI
	LD IX,(#pos_cola)
	LD 0 (IX),L
	LD 1 (IX),H
	LD 2 (IX),E
	LD 3 (IX),D
	INC IX
	INC IX
	INC IX
	INC IX
	Ld (#pos_cola),IX
	LD HL,#elementos_cola
	INC (HL)
	EI
	RET
leer_elemento:
	DI
	LD IX,(#pos_cola)
	LD L,0 (IX)
	LD H,1 (IX)
	LD E,2 (IX)
	LD D,3 (IX)
	DEC IX
	DEC IX
	DEC IX
	DEC IX
	LD (#pos_cola),IX
	LD HL,#elementos_cola
	DEC (HL)
	EI
	RET

elementos_cola: 
	.DW #0
pos_cola:
	.DW cola_impresion
cola_impresion:
	.DB #0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0 ; defs 12
bucle_texto0:
	LD A,#1
	LD (#imprimiendo),A
	LD A,(#first_char8)
	LD B,A		;resto 48 para saber el número del caracter (En ASCII 0=48)
	LD A,(HL)
	OR A ;CP 0
	RET Z
	SUB B
	LD BC,#cpc_Chars8	;apunto a la primera letra
	PUSH HL
	LD L,A		
	LD H,#0
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL	
	ADD HL,BC	
	CALL escribe_letra_gpstd
	LD HL,(#direcc_destino)
	
	LD DE,#letra_decodificada
	CALL cpc_PutSp0_gpstd
	LD HL,(#direcc_destino)
	INC HL
	INC HL
	LD (#direcc_destino),HL
	POP HL
	INC HL
	JP bucle_texto0

imprimiendo: 
	.db #0
direcc_destino:
	.dw #0


cpc_PutSp0_gpstd:
	.DB #0XFD
	LD H,#8	
	LD B,#7
	LD C,B
loop_alto_2_gpstd:
loop_ancho_2_gpstd:		
	EX DE,HL
	LDI
	LDI
	.DB #0XFD
	DEC H
	RET Z	
	EX DE,HL   	   
salto_linea_gpstd:
	LD C,#0XFE			
	ADD HL,BC
	JP NC,loop_alto_2_gpstd 
	LD BC,#0XC050
	ADD HL,BC
	LD B,#7	
	JP loop_alto_2_gpstd	
		
		
		
escribe_letra_gpstd:		;; lee el byte y lo interpreta
	LD IY,#letra_decodificada
	LD B,#8
bucle_alto_gpstd:
	PUSH BC 	;leo el byte... ahora se miran sus bits y se rellena el caracter a imprimir
	XOR A
	LD B,(HL)
	BIT 7,B
	JP Z,cc0_gpstd
	OR #0b10001000
cc0_gpstd:
	BIT 6,B
	JP Z,cc1_gpstd
	OR #0b01000100
cc1_gpstd:
	BIT 5,B
	JP Z,cc2_gpstd
	OR #0b00100010
cc2_gpstd:
	BIT 4,B
	JP Z,cc3_gpstd
	OR #0b00010001
cc3_gpstd:
	;primer byte
	LD 0 (IY),A
	INC IY
	XOR A
	BIT 3,B
	JP Z,cc4_gpstd
	OR #0b10001000
cc4_gpstd:
	BIT 2,B
	JP Z,cc5_gpstd
	OR #0b01000100
cc5_gpstd:
	BIT 1,B
	JP Z,cc6_gpstd
	OR #0b00100010
cc6_gpstd:
	BIT 0,B
	JP Z,cc7_gpstd
	OR #0b00010001
cc7_gpstd:
	;segundo byte
	LD 0 (IY),A
	INC IY
	INC HL
	POP BC
	DJNZ bucle_alto_gpstd
	RET



byte_tmp: ;DEFS 2
	.DB #0,#0
letra_decodificada:
	.DB #0,#0,#0,#0,#0,#0,#0,#0 		;DEFS 16	
	.DB #0,#0,#0,#0,#0,#0,#0,#0			;USO ESTE ESPACIO PARA GUARDAR LA LETRA QUE SE DECODIFICA	
