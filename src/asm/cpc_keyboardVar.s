;--------------------------------------------------------------------------
;  cpc_keyboardVars
; 
; 2018-09-27 : original version - cpcrslib
; v1.0
;
;--------------------------------------------------------------------------

.module keyboard

.include "keyboard.s"


linea:
	.DB #0
bte:
	.DB #0

keymap:
	.DB #0
	.DB #0
	.DB #0
	.DB #0
	.DB #0
	.DB #0
	.DB #0
	.DB #0
	.DB #0
	.DB #0

tecla_0: .DW #0x0204
;teclado_usable					; teclas del cursor, cada tecla está definida por su bit y su línea.

tabla_teclas:
tecla_0_x: 	.DW #0x4002		; bit 0, línea 2
tecla_1_x: 	.DW #0x4101		; bit 1, línea 1
tecla_2_x: 	.DW #0x4001		; bit 0, línea 1
tecla_3_x: 	.DW #0x4004		; bit 0, línea 4
tecla_4_x:	.DW #0x4002		; bit 0, línea 2
tecla_5_x:  .DW #0x4101		; bit 1, línea 1
tecla_6_x:  .DW #0x4001		; bit 0, línea 1
tecla_7_x:  .DW #0x4004		; bit 0, línea 4
tecla_8_x:  .DW #0x4801		; bit 0, línea 4
tecla_9_x:  .DW #0x4802		; bit 0, línea 4
tecla_10_x:  .DW #0x4702		; bit 0, línea 4
tecla_11_x:  .DW #0x4204		; bit 0, línea 4
tecla_12_x:  .DW #0xffff		; bit 0, línea 4
tecla_13_x:  .DW #0x4204		; bit 0, línea 4
tecla_14_x:  .DW #0x4001		; bit 0, línea 4
tecla_15_x:  .DW #0x4004		; bit 0, línea 4
tecla_16_x:  .DW #0x4204		; bit 0, línea 4
tecla_17_x:  .DW #0x4001		; bit 0, línea 4
tecla_18_x:  .DW #0x4004		; bit 0, línea 4
tecla_19_x:  .DW #0x4802		; bit 0, línea 4
tecla_20_x:  .DW #0x4702		; bit 0, línea 4
tecla_21_x:  .DW #0x4204		; bit 0, línea 4
tecla_22_x:  .DW #0xffff		; bit 0, línea 4
tecla_23_x:  .DW #0xffff		; bit 0, línea 4
tecla_24_x:  .DW #0xffff		; bit 0, línea 4
tecla_25_x:  .DW #0xffff		; bit 0, línea 4
tecla_26_x:  .DW #0xffff		; bit 0, línea 4
tecla_27_x:  .DW #0xffff		; bit 0, línea 4
tecla_28_x:  .DW #0xffff		; bit 0, línea 4
; For increasing keys available just increase this word table
.DB #0