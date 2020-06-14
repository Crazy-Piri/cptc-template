.module keyboard


_cpc_TestKeyboard::	;Tomado de las rutinas básicas que aparecen
					;en los documentos de  Kevin Thacker
					; Devuelve A

	DI
	LD BC, #0XF40E
	OUT (C), C
	LD BC, #0XF6C0
	OUT (C), C
	.DB #0XED,#0X71        ;    OUT (C),0
	LD BC, #0XF792
	OUT (C), C
	DEC B
	OUT (C), A
	LD B, #0XF4
	IN A, (C)
	LD BC, #0XF782
	OUT (C), C
	DEC B
	.DB #0XED,#0X71        ;    OUT (C),0
	CPL
	EI
	RET