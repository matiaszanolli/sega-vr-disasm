; ============================================================================
; MARS (32X) Hardware Register Definitions
; ============================================================================
; Canonical hardware register equates for the Sega 32X.
; Included globally from vrd.asm — do NOT redefine these in section files.
;
; Reference: docs/32x-hardware-manual.md, analysis/architecture/32X_REGISTERS.md
; ============================================================================

; ============================================================================
; 32X System Registers ($A15100-$A1511F)
; ============================================================================
MARS_SYS_BASE       equ $A15100        ; 32X System Register Base
MARS_SYS_INTCTL     equ $A15100        ; Adapter Control (FM, REN, RES, ADEN)
MARS_SYS_INTMASK    equ $A15102        ; Interrupt Control (INTS, INTM)
MARS_SYS_HCOUNT     equ $A15104        ; H Interrupt Vector / Bank Set Register

; ============================================================================
; 32X DREQ (DMA Request) Registers ($A15106-$A15112)
; ============================================================================
MARS_DREQ_CTRL      equ $A15106        ; DREQ Control (RV, 68S, DMA, FULL)
MARS_DREQ_SRC_H     equ $A15108        ; DREQ Source Address High
MARS_DREQ_SRC_L     equ $A1510A        ; DREQ Source Address Low
MARS_DREQ_DST_H     equ $A1510C        ; DREQ Destination Address High
MARS_DREQ_DST_L     equ $A1510E        ; DREQ Destination Address Low
MARS_DREQ_LEN       equ $A15110        ; DREQ Length (4-word units)
MARS_FIFO           equ $A15112        ; FIFO Data Register

; ============================================================================
; 32X Communication Ports ($A15120-$A1512F)
; ============================================================================
; 8 word-width registers. Both 68K and SH2 can read/write.
;
; RACE CONDITION WARNING (per hardware manual):
;   Writing the same register from both CPUs simultaneously = UNDEFINED value.
;   Partition registers by ownership to prevent this.
;
; VRD OWNERSHIP PROTOCOL:
;   68K WRITES:  COMM0 (command flag+code), COMM4/5 (data pointer), COMM6 (handshake)
;   SH2 WRITES:  COMM0 (clear flag), COMM6 (clear handshake), COMM7 (Master→Slave)
;   CONVENTION:  68K sets → SH2 clears (never both writing simultaneously)
;
; Word-level access (canonical register names):
COMM0               equ $A15120        ; Command flag (hi) + code (lo)
COMM1               equ $A15122        ; Status/reserved
COMM2               equ $A15124        ; Parameter word
COMM3               equ $A15126        ; Parameter word
COMM4               equ $A15128        ; Data pointer (hi word) / longword base
COMM5               equ $A1512A        ; Data pointer (lo word)
COMM6               equ $A1512C        ; Handshake flag
COMM7               equ $A1512E        ; Master→Slave signal (expansion ROM)

; Byte-level access aliases (VRD uses TST.B / MOVE.B within words):
COMM0_HI            equ $A15120        ; COMM0 high byte — command flag (68K→SH2)
COMM0_LO            equ $A15121        ; COMM0 low byte — command code ($21/$22/$25/$27/$2F)
COMM1_HI            equ $A15122        ; COMM1 high byte — Slave SH2 polls this for work cmds!
COMM1_LO            equ $A15123        ; COMM1 low byte (VRD: cleared at $00EEFA)
COMM6_HI            equ $A1512C        ; COMM6 high byte (B-004: D1 height)
COMM6_LO            equ $A1512D        ; COMM6 low byte  (B-004: D0/2 words/row)

; ============================================================================
; SH2 Address Space
; ============================================================================
SH2_ADDR_OFFSET     equ $02000000      ; Add to 68K address → SH2 ROM address

; ============================================================================
; SH2 Command Codes (68K→SH2 via COMM0_LO)
; ============================================================================
CMD_21              equ $21             ; Secondary pointer command
CMD_DIRECT          equ $22             ; Direct command send
CMD_WAIT_SEND       equ $25             ; Wait and send command
CMD_27              equ $27             ; High-frequency command (21 calls/frame)
CMD_EXTENDED        equ $2F             ; Extended command (4 parameters)

; Handshake protocol
HANDSHAKE_READY     equ $0101           ; Ready for next phase

; ============================================================================
; 32X VDP Registers ($A15180-$A1518A)
; ============================================================================
MARS_VDP_MODE       equ $A15180        ; Bitmap Mode Register
MARS_VDP_SHIFT      equ $A15182        ; Screen Shift Register
MARS_VDP_FILLADR    equ $A15186        ; Auto Fill Start Address
MARS_VDP_FILLDATA   equ $A15188        ; Auto Fill Data
MARS_VDP_FBCTL      equ $A1518A        ; Frame Buffer Control (FS, VBLK, HBLK, PEN, FEN)

; 32X Palette
MARS_CRAM           equ $A15200        ; Color RAM base (256 words)
MARS_CRAM_LAST2     equ $A153FC        ; CRAM[254] (used by FPS counter)
MARS_CRAM_LAST1     equ $A153FE        ; CRAM[255] (used by FPS counter)

; 32X Frame Buffer (68K side)
MARS_FRAMEBUFFER    equ $840000        ; Frame buffer base (128 KB)
MARS_OVERWRITE      equ $860000        ; Overwrite image base (128 KB)

; ============================================================================
; Bank Switching
; ============================================================================
SRAM_BANK0          equ $A130F1        ; Genesis SRAM Enable / Bank 0
MARS_BANKSET        equ $A15104        ; 32X Bank Set Register (bits 0-1)

; ============================================================================
; Mega Drive VDP ($C00000-$C00011)
; ============================================================================
VDP_DATA            equ $C00000        ; VDP Data Port
VDP_CTRL            equ $C00004        ; VDP Control Port
VDP_HVCOUNTER       equ $C00008        ; H/V Counter
PSG                 equ $C00011        ; PSG Sound

; ============================================================================
; Mega Drive I/O ($A10000-$A1001F)
; ============================================================================
MD_IO_BASE          equ $A10000        ; MD I/O Base
MD_DATA1            equ $A10003        ; Controller Port 1 Data
MD_DATA2            equ $A10005        ; Controller Port 2 Data
MD_CTRL1            equ $A10009        ; Controller Port 1 Control
MD_CTRL2            equ $A1000B        ; Controller Port 2 Control

; ============================================================================
; Z80 Control
; ============================================================================
Z80_RAM             equ $A00000        ; Z80 RAM start
Z80_BUSREQ          equ $A11100        ; Z80 Bus Request
Z80_RESET           equ $A11200        ; Z80 Reset

; ============================================================================
; Work RAM Locations (VRD game-specific)
; ============================================================================
; NOTE: Work RAM addresses use full $FFFFxxxx form so vasm accepts
; them in absolute short (.w) addressing mode (sign-extended 16-bit).
WORK_RAM            equ $FF0000        ; Main Work RAM start
VINT_STATE          equ $FFFFC87A      ; V-INT state machine flag
VINT_FLAG2          equ $FFFFC87C      ; Secondary V-INT flag

; ============================================================================
