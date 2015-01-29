;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Mon Jan 26 17:10:37 2015
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _load_sector_into_memory
	.globl _print
	.globl _IO_PARAM2
	.globl _IO_PARAM1
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_USART_PORT	=	0x0000
_SDCARD_PORT	=	0x0002
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_IO_PARAM1	=	0x0050
_IO_PARAM2	=	0x0052
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:22: void print(const char* string) {
;	---------------------------------
; Function print
; ---------------------------------
_print_start::
_print:
;main.c:23: do {
	pop	bc
	pop	de
	push	de
	push	bc
00101$:
;main.c:24: USART_PORT = *string;
	ld	a,(de)
	out	(_USART_PORT),a
;main.c:25: string++;
	inc	de
;main.c:26: } while (*string != 0);
	ld	a,(de)
	or	a, a
	jr	NZ,00101$
	ret
_print_end::
;main.c:29: void load_sector_into_memory(void* memory, unsigned long sector_address) {
;	---------------------------------
; Function load_sector_into_memory
; ---------------------------------
_load_sector_into_memory_start::
_load_sector_into_memory:
;main.c:30: IO_PARAM1 = (unsigned int) memory;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	ld	(#_IO_PARAM1 + 0),a
	ld	hl, #2+1
	add	hl, sp
	ld	a, (hl)
	ld	(#_IO_PARAM1 + 1),a
;main.c:31: IO_PARAM2 = sector_address;
	ld	de, #_IO_PARAM2
	ld	hl, #4
	add	hl, sp
	ld	bc, #4
	ldir
;main.c:32: SDCARD_PORT = SDCARD_READ;
	ld	a,#0x00
	out	(_SDCARD_PORT),a
	ret
_load_sector_into_memory_end::
;main.c:35: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main_start::
_main:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
;main.c:43: print("\r\nBOOTSTRAP");
	ld	hl,#___str_0
	push	hl
	call	_print
	pop	af
;main.c:45: bootstrap_abs_first_sector = partition->firstPartitionSector + 1;
	ld	de,#0x12C6
	ld	hl, #0x0002
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	ld	a,-4 (ix)
	add	a, #0x01
	ld	c,a
	ld	a,-3 (ix)
	adc	a, #0x00
	ld	b,a
	ld	a,-2 (ix)
	adc	a, #0x00
	ld	a,-1 (ix)
	adc	a, #0x00
;main.c:46: bootstrap_abs_final_sector = partition->firstPartitionSector + bpb->BPB_RsvSecCnt;
	ld	hl,#0x130E
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0000
	ld	a,-4 (ix)
	add	a, e
	ld	e,a
	ld	a,-3 (ix)
	adc	a, d
	ld	d,a
	ld	a,-2 (ix)
	adc	a, l
	ld	a,-1 (ix)
	adc	a, h
	ld	-6 (ix),e
	ld	-5 (ix),d
;main.c:48: for (sector = bootstrap_abs_first_sector; sector < bootstrap_abs_final_sector; sector++, bootstrap+=512) {
	ld	de,#0x1500
00103$:
	ld	a,c
	sub	a, -6 (ix)
	ld	a,b
	sbc	a, -5 (ix)
	jr	NC,00105$
;main.c:49: load_sector_into_memory(bootstrap, sector);
	ld	-4 (ix),c
	ld	-3 (ix),b
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
	push	de
	pop	iy
	push	bc
	push	de
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	push	iy
	call	_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	de
	pop	bc
;main.c:48: for (sector = bootstrap_abs_first_sector; sector < bootstrap_abs_final_sector; sector++, bootstrap+=512) {
	inc	bc
	ld	hl,#0x0200
	add	hl,de
	ex	de,hl
	jr	00103$
00105$:
	ld	sp, ix
	pop	ix
	ret
_main_end::
___str_0:
	.db 0x0D
	.db 0x0A
	.ascii "BOOTSTRAP"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
