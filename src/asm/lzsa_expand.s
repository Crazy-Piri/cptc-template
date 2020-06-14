;--------------------------------------------------------------------------
;  _lzsa_expand
; 
; 2018-09-27 : original version - cpcrslib
; v1.0
;
;--------------------------------------------------------------------------

.area _CODE



_lzsa_expand::
	; Entradas	bc-> Alto Ancho
		;			de-> origen
		;			hl-> destino
		; Se alteran hl, bc, de, af

	pop af
	
	pop hl
	pop de
	
	push af



	;  ver.07 by spke for LZSA 1.1.1
	;  https://github.com/emmanuel-marty/lzsa/blob/master/asm/z80/unlzsa2_fast.asm
	;  ld hl,FirstByteOfCompressedData
;  ld de,FirstByteOfMemoryForDecompressedData
;  call DecompressLZSA2  

ld b,#0
    scf
    ex af,af'
    jr READTOKEN
MANYLITERALS: ld a,#18
    add a,(hl)
    inc hl
    jr nc,COPYLITERALS
    ld c,(hl)
    inc hl
    ld a,b
    ld b,(hl)
    jr READTOKENNEXTHLUSEBC
MORELITERALS: ld b,(hl)
    inc hl
    scf
    ex af,af'
    jr nc,MORELITERALSNOUPDATE
    ld a,(hl)
    or #240
    ex af,af'
    ld a,(hl)
    inc hl
    or #15
    rrca 
    rrca 
    rrca 
    rrca 
MORELITERALSNOUPDATE: inc a
    jr z,MANYLITERALS
    sub #238
COPYLITERALS: ld c,a
    ld a,b
    ld b,#0
    ldir
    push de
    or a
    jp p,CASE0XX
    cp #192
    jr c,CASE10X
CASE11X: cp #224
    jr c,CASE110
CASE111:     .db #0XDD, #0X5D ;  ld e,ixl   
    .db #0XDD, #0X54  ; ld d,ixh

    jr MATCHLEN
LITERALS0011: jr nz,MORELITERALS
NOLITERALS: or (hl)
    inc hl
    push de
    jp m,CASE1XX
CASE0XX: ld d,#255
    cp #64
    jr c,CASE00X
CASE01X: cp #96
    rl d
READOFFSETE: ld e,(hl)
    inc hl
SAVEOFFSET: .db 221
    .db 107
    .db 221
    .db 98
MATCHLEN: inc a
    and #7
    jr z,LONGERMATCH
    inc a
COPYMATCH: ld c,a
COPYMATCHUSEC: ex (sp),hl
    ex de,hl
    add hl,de
    ldi
    ldir
COPYMATCHPOPSRC: pop hl
READTOKEN: ld a,(hl)
    and #24
    jp pe,LITERALS0011
    rrca 
    rrca 
    rrca 
    ld c,a
    ld a,(hl)
READTOKENNEXTHLUSEBC: inc hl
    ldir
    push de
    or a
    jp p,CASE0XX
CASE1XX: cp #192
    jr nc,CASE11X
CASE10X: ld c,a
    ex af,af'
    jr nc,CASE10XNOUPDATE
    ld a,(hl)
    or #240
    ex af,af'
    ld a,(hl)
    inc hl
    or #15
    rrca 
    rrca 
    rrca 
    rrca 
CASE10XNOUPDATE: ld d,a
    ld a,c
    cp #160
    dec d
    rl d
    jr READOFFSETE
CASE110: ld d,(hl)
    inc hl
    jr READOFFSETE
CASE00X: ld c,a
    ex af,af'
    jr nc,CASE00XNOUPDATE
    ld a,(hl)
    or #240
    ex af,af'
    ld a,(hl)
    inc hl
    or #15
    rrca 
    rrca 
    rrca 
    rrca 
CASE00XNOUPDATE: ld e,a
    ld a,c
    cp #32
    rl e
    jp SAVEOFFSET
LONGERMATCH: scf
    ex af,af'
    jr nc,LONGERMATCHNOUPDATE
    ld a,(hl)
    or #240
    ex af,af'
    ld a,(hl)
    inc hl
    or #15
    rrca 
    rrca 
    rrca 
    rrca 
LONGERMATCHNOUPDATE: sub #231
    cp #24
    jr c,COPYMATCH
LONGMATCH: add a,(hl)
    inc hl
    jr nc,COPYMATCH
    ld c,(hl)
    inc hl
    ld b,(hl)
    inc hl
    jr nz,COPYMATCHUSEC
    pop de

   

;; end of DecompressLZSA2


	ret
