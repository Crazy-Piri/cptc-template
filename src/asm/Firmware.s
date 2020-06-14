.module utils

_backup_fw:: .DW  #0	

.globl _cpc_DisableFirmware

_cpc_DisableFirmware::
	DI
	
	LD HL,(#0X0038)
	LD (#_backup_fw),HL

	LD HL,#0XC9FB		;EI
	LD (#0X0038),HL

	EI
	RET
	

.globl 	_cpc_EnableFirmware

_cpc_EnableFirmware::
	DI
	LD HL,(_backup_fw)
	LD (#0X0038),HL			;EI
	;INC HL
	;LD (HL),D			;RET
	EI
	RET