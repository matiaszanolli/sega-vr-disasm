; ============================================================================
; VDP Operations ($0027F8 - $002900)
; ============================================================================
;
; PURPOSE
; -------
; VDP (Video Display Processor) access functions for the 32X. These functions
; use the MARS system registers at $A15100 to control the 32X VDP.
;
; 32X VDP REGISTERS (MARS)
; ------------------------
; | Address   | Name           | Purpose                              |
; |-----------|----------------|--------------------------------------|
; | $A15100   | MARS_SYS_BASE  | System register base                 |
; | $A15184   | +$84           | VDP fill length                      |
; | $A15186   | +$86           | VDP fill address                     |
; | $A15188   | +$88           | VDP fill data                        |
; | $A1518B   | +$8B           | VDP status (bit 1 = busy)            |
; | $A15200   | CRAM_BASE      | Color RAM base (palette)             |
;
; FILL OPERATION
; --------------
; VDP fill writes a pattern to VRAM. The process:
; 1. Set fill length at $A15184
; 2. Write address to $A15186
; 3. Write data to $A15188
; 4. Wait for busy bit to clear
; 5. Repeat for next address
;
; Dependencies: 32X adapter must be initialized
; Related: adapter_init.asm
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; 32X MARS VDP registers
MARS_SYS_BASE   equ     $A15100     ; MARS system register base
MARS_VDP_LEN    equ     $A15184     ; VDP fill length
MARS_VDP_ADDR   equ     $A15186     ; VDP fill address
MARS_VDP_DATA   equ     $A15188     ; VDP fill data
MARS_VDP_STAT   equ     $A1518B     ; VDP status register
MARS_CRAM       equ     $A15200     ; Color RAM (palette) base

; Status bits
VDP_BUSY_BIT    equ     1           ; VDP busy flag bit

; Fill constants
FILL_LEN_FF     equ     $00FF       ; Standard fill length
FILL_PATTERN    equ     $0101       ; Standard fill pattern
FILL_INCREMENT  equ     $0100       ; Address increment per line

        org     $0027F8

; ============================================================================
; VDPFill ($0027F8) - VDP Memory Fill with Loop
; Called by: Various display initialization
; Parameters:
;   A2 = VDP fill address register pointer
;   A3 = VDP fill data register pointer
;   A4 = MARS system base
;   D1 = Starting address
; Returns: Fills 16 lines of VRAM
;
; Fills 16 consecutive 256-byte blocks with pattern $0101
; ============================================================================

VDPFill:
        moveq   #15,d7                          ; $0027F8: $7E0F       - 16 iterations (0-15)
        move.w  #FILL_PATTERN,d0                ; $0027FC: $303C $0101 - Fill pattern
        move.w  #FILL_INCREMENT,d2              ; $002800: $343C $0100 - Address increment
        move.w  #FILL_LEN_FF,$0084(a4)          ; $002804: $397C $00FF $0084 - Set length
.fill_loop:
        move.w  d1,(a2)                         ; $00280A: $3481       - Set address
        move.w  d0,(a3)                         ; $00280C: $3680       - Set data (triggers fill)
.wait_vdp:
        btst    #VDP_BUSY_BIT,$008B(a4)         ; $00280E: $082C $0001 $008B - Check busy
        bne.s   .wait_vdp                       ; $002814: $66F8       - Loop until done
        add.w   d2,d1                           ; $002816: $D242       - Next address
        dbra    d7,.fill_loop                   ; $002818: $51CF $FFF0 - Loop 16 times
        rts                                     ; $00281C: $4E75

; ============================================================================
; VDPPrep ($00281E) - VDP Preparation/Single Fill
; Called by: Display initialization
; Parameters: None (uses fixed addresses)
; Returns: Fills single block at address $1F00
;
; Initializes MARS register pointers and performs a single VDP fill
; ============================================================================

VDPPrep:
        lea     MARS_SYS_BASE,a4                ; $00281E: $49F9 $00A1 $5100 - System base
        lea     MARS_VDP_ADDR,a2                ; $002824: $45F9 $00A1 $5186 - Address reg
        lea     MARS_VDP_DATA,a3                ; $00282A: $47F9 $00A1 $5188 - Data reg
        move.w  #$1F00,d1                       ; $002830: $323C $1F00 - Fill address
        move.w  #FILL_PATTERN,d0                ; $002834: $303C $0101 - Fill pattern
        move.w  #FILL_LEN_FF,$0084(a4)          ; $002838: $397C $00FF $0084 - Set length
        move.w  d1,(a2)                         ; $00283E: $3481       - Set address
        move.w  d0,(a3)                         ; $002840: $3680       - Set data
.wait_vdp:
        btst    #VDP_BUSY_BIT,$008B(a4)         ; $002842: $082C $0001 $008B - Check busy
        bne.s   .wait_vdp                       ; $002848: $66F8       - Loop until done
        rts                                     ; $00284A: $4E75

; ============================================================================
; PaletteRAMCopy ($00284C) - Copy Palette to Color RAM
; Called by: Palette initialization
; Parameters:
;   A2 = Source palette data pointer
; Returns: Copies 512 bytes (256 colors × 2 bytes) to CRAM
;
; Uses unrolled loop copying 16 bytes per iteration (4 longwords)
; 32 iterations × 16 bytes = 512 bytes total
; ============================================================================

PaletteRAMCopy:
        lea     MARS_CRAM,a3                    ; $00284C: $47F9 $00A1 $5200 - CRAM base
        moveq   #31,d7                          ; $002852: $7E1F       - 32 iterations
.copy_loop:
        move.l  (a2)+,(a3)+                     ; $002854: $26DA       - Copy 4 bytes
        move.l  (a2)+,(a3)+                     ; $002856: $26DA       - Copy 4 bytes
        move.l  (a2)+,(a3)+                     ; $002858: $26DA       - Copy 4 bytes
        move.l  (a2)+,(a3)+                     ; $00285A: $26DA       - Copy 4 bytes
        dbra    d7,.copy_loop                   ; $00285C: $51CF $FFF6 - Loop
        rts                                     ; $002860: $4E75

; ============================================================================
; SUMMARY
; ============================================================================
;
; Function       | Address | Purpose
; ---------------+---------+------------------------------------------
; VDPFill        | $0027F8 | Fill 16 VRAM blocks (256 bytes each)
; VDPPrep        | $00281E | Single VRAM fill at $1F00
; PaletteRAMCopy | $00284C | Copy 512-byte palette to CRAM
;
; Total VRAM filled by VDPFill: 4096 bytes (16 × 256)
; Palette size: 512 bytes (256 colors × 16-bit RGB)
;
; ============================================================================
