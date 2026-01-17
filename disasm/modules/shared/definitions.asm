; ============================================================================
; MARS (32X) Hardware Register Definitions
; ============================================================================
; These equates define the memory-mapped registers for the Sega 32X
; Used by the disassembled code for symbolic access to hardware
;
; This file must be included before any org directives in the main assembly
; ============================================================================

; 32X System Registers
MARS_SYS_BASE       equ $A15100        ; 32X System Register Base
MARS_SYS_INTCTL     equ $A15100        ; Adapter Control (FM, REN, RES, ADEN)
MARS_SYS_INTMASK    equ $A15102        ; Interrupt Control (INTS, INTM)
MARS_SYS_HCOUNT     equ $A15104        ; H Interrupt Vector / Bank Set

; 32X DREQ (DMA Request) Registers
MARS_DREQ_CTRL      equ $A15106        ; DREQ Control Register
MARS_DREQ_LEN       equ $A15110        ; DREQ Length
MARS_FIFO           equ $A15112        ; FIFO Data Register

; 32X Communication Ports (68K <-> SH2)
COMM0               equ $A15120        ; Communication Port 0
COMM1               equ $A15122        ; Communication Port 1
COMM2               equ $A15124        ; Communication Port 2
COMM3               equ $A15126        ; Communication Port 3
COMM4               equ $A15128        ; Communication Port 4
COMM5               equ $A1512A        ; Communication Port 5
COMM6               equ $A1512C        ; Communication Port 6
COMM7               equ $A1512E        ; Communication Port 7

; 32X VDP Registers
MARS_VDP_MODE       equ $A15180        ; Bitmap Mode Register
MARS_VDP_FILLADR    equ $A15186        ; Auto Fill Start Address
MARS_VDP_FILLDATA   equ $A15188        ; Auto Fill Data
MARS_VDP_FBCTL      equ $A1518A        ; Frame Buffer Control

; Bank Switching Registers
SRAM_BANK0          equ $A130F1        ; SRAM Enable / Bank 0

; Mega Drive VDP
VDP_DATA            equ $C00000        ; VDP Data Port
VDP_CTRL            equ $C00004        ; VDP Control Port
PSG                 equ $C00011        ; PSG Sound

; Mega Drive I/O Ports
MD_DATA1            equ $A10003        ; Controller Port 1 Data
MD_CTRL1            equ $A10009        ; Controller Port 1 Control
MD_IO_BASE          equ $A10000        ; MD I/O Base

; Z80 Control
Z80_RAM             equ $A00000        ; Z80 RAM start
Z80_BUSREQ          equ $A11100        ; Z80 Bus Request
Z80_RESET           equ $A11200        ; Z80 Reset

; Common Memory Regions
WORK_RAM            equ $FF0000        ; Main Work RAM start

; ============================================================================
