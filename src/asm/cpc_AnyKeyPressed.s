.module keyboard

.include "keyboard.s"

.globl _cpc_AnyKeyPressed


_cpc_AnyKeyPressed::
    call hacer_tiempo
    call hacer_tiempo
    call hacer_tiempo



	LD A,#40
bucle_deteccion_tecla:
	PUSH AF
	CALL _cpc_TestKeyboard				;en A vuelve los valores de la linea
	OR A
	JP NZ, tecla_pulsada				; retorna si no se ha pulsado ninguna tecla
	POP AF
	INC A
	CP #0x4a
	JP NZ, bucle_deteccion_tecla
	LD HL,#0

	RET

tecla_pulsada:
	POP AF
	LD HL,#1
	RET
t_pulsada:
    POP AF
    JP _cpc_AnyKeyPressed

hacer_tiempo:
    LD A,#254
bucle_previo_deteccion_tecla:
	PUSH AF
	POP AF
	dec A
	Jr nZ, bucle_previo_deteccion_tecla
	ret