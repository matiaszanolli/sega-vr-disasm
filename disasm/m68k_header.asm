; ============================================================================
; Virtua Racing Deluxe (USA) - Sega 32X
; Disassembly by Claude Code
; ============================================================================
;
; Product: V.R.DX
; Serial: GM MK-84601-00
; Copyright: (C)SEGA 1994.SEP
; ROM Size: 3MB (3,145,728 bytes)
;
; ============================================================================

; ============================================================================
; 32X System Register Addresses
; ============================================================================
MARS_SYS_INTCTL         equ $A15100     ; Adapter Control Register
MARS_SYS_INTMASK        equ $A15102     ; Interrupt Control Register
MARS_SYS_H_INT          equ $A15104     ; H Interrupt Vector
MARS_SYS_DREQ_CTRL      equ $A15106     ; DREQ Control Register
MARS_SYS_DREQ_SRC       equ $A15108     ; DREQ Source Address
MARS_SYS_DREQ_DST       equ $A1510C     ; DREQ Destination Address
MARS_SYS_DREQ_LEN       equ $A15110     ; DREQ Length
MARS_SYS_FIFO           equ $A15112     ; FIFO Register
MARS_SYS_COMM_PORT      equ $A15120     ; Communication Port (8 words)
MARS_PWM_CTRL           equ $A15130     ; PWM Control
MARS_PWM_CYCLE          equ $A15132     ; PWM Cycle
MARS_PWM_LDATA          equ $A15134     ; PWM L Channel Data
MARS_PWM_RDATA          equ $A15136     ; PWM R Channel Data
MARS_PWM_MONO           equ $A15138     ; PWM Mono Data

; VDP Registers
MARS_VDP_MODE           equ $A15180     ; Bitmap Mode Register
MARS_VDP_SHIFT          equ $A15182     ; Screen Shift Control
MARS_VDP_FILLEN         equ $A15184     ; Auto Fill Length
MARS_VDP_FILLADR        equ $A15186     ; Auto Fill Start Address
MARS_VDP_FILLDATA       equ $A15188     ; Auto Fill Data
MARS_VDP_FBCTL          equ $A1518A     ; Frame Buffer Control

; Mega Drive I/O
MD_IO_VERSION           equ $A10001     ; Version register
MD_IO_DATA1             equ $A10003     ; Controller port 1 data
MD_IO_DATA2             equ $A10005     ; Controller port 2 data
MD_IO_CTRL1             equ $A10009     ; Controller port 1 control
MD_IO_CTRL2             equ $A1000B     ; Controller port 2 control

; Memory Locations
ROM_BASE                equ $000000     ; ROM start (mapped to $880000)
ROM_SIZE                equ $300000     ; 3MB
WORK_RAM                equ $FF0000     ; 64KB Work RAM
WORK_RAM_END            equ $FFFFFF

; SH2 Memory (from SH2 perspective, cache-through addresses)
SH2_SDRAM               equ $2200000    ; 2 Mbit SDRAM
SH2_FRAME_BUFFER        equ $2400000    ; Frame Buffer
SH2_OVERWRITE           equ $2402000    ; Overwrite Image

; ============================================================================
; ROM Header ($000000 - $0001FF)
; ============================================================================

; Initial Stack Pointer and Program Counter
InitialSP:      dc.l    $01000000       ; Initial Stack Pointer
InitialPC:      dc.l    $000003F0       ; Initial Program Counter (relocated)

; Exception Vectors ($008 - $0FF) - 62 vectors total
; Vectors 2-11: Exception handlers
    dc.l    $00880832       ; 02: Bus Error
    dc.l    $00880832       ; 03: Address Error
    dc.l    $00880832       ; 04: Illegal Instruction
    dc.l    $00880832       ; 05: Divide by Zero
    dc.l    $00880832       ; 06: CHK Exception
    dc.l    $00880832       ; 07: TRAPV Exception
    dc.l    $00880832       ; 08: Privilege Violation
    dc.l    $00880832       ; 09: Trace
    dc.l    $00880832       ; 10: Line 1010 Emulator
    dc.l    $00880832       ; 11: Line 1111 Emulator
; Vectors 12-23: Reserved (zeros)
    dcb.l   12, $00000000   ; 12-23: Reserved
; Vectors 24-31: Interrupts
    dc.l    $00880832       ; 24: Spurious Interrupt
    dc.l    $00880832       ; 25: Level 1 IRQ (External)
    dc.l    $00880832       ; 26: Level 2 IRQ
    dc.l    $00880832       ; 27: Level 3 IRQ
    dc.l    $0088170A       ; 28: Level 4 IRQ (H-INT)
    dc.l    $00880832       ; 29: Level 5 IRQ
    dc.l    $00881684       ; 30: Level 6 IRQ (V-INT)
    dc.l    $00880832       ; 31: Level 7 IRQ (NMI)
; Vectors 32-47: TRAP #0-15
    dcb.l   16, $00880832   ; 32-47: TRAP #0-15
; Vectors 48-63: Reserved (zeros)
    dcb.l   16, $00000000   ; 48-63: Reserved

; Sega Header ($000100 - $0001FF)
ConsoleID:      dc.b    'SEGA 32X U      '          ; Console name
Copyright:      dc.b    '(C)SEGA 1994.SEP'          ; Copyright
DomesticName:   dc.b    'V.R.DX                                          '
OverseasName:   dc.b    'V.R.DX                                          '
SerialNumber:   dc.b    'GM MK-84601-00'            ; Serial number
                dc.w    $1E4D                       ; Checksum
IOSupport:      dc.b    'J6              '          ; I/O Support (Joypad 6-button)
ROMStart:       dc.l    $00000000                   ; ROM Start
ROMEnd:         dc.l    $002FFFFF                   ; ROM End (3MB)
RAMStart:       dc.l    $00FF0000                   ; RAM Start
RAMEnd:         dc.l    $00FFFFFF                   ; RAM End
; Backup RAM, Modem, and Notes - all spaces (no backup RAM, no modem)
                dcb.b   64, $20                     ; 64 spaces ($1B0-$1EF)
Region:         dc.b    'U               '          ; Region (USA)

; ============================================================================
; Remainder of ROM - Binary Blob (from $200 onwards)
; ============================================================================
; Include the rest of the original ROM data from offset $200 onwards
; This contains:
;   - 32X Jump Table ($200-$3FF)
;   - MARS Security Code ($3C0-$512)
;   - 68000 executable code
;   - SH2 Master/Slave code
;   - Graphics data
;   - Sound data
;   - Track data
; TODO: Disassemble and replace sections incrementally

    org     $000200
    incbin  "disasm/rom_data_remainder.bin"

; End of ROM
; =============================================================================
