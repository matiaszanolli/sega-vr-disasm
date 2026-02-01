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
; unpack_tiles_vdp ($00247C) - Unpack Nibbles to VDP
; Called by: 24 locations per frame
; Parameters:
;   A0 = Source packed data pointer (advances by 2)
;   A6 = VDP data port (fixed address)
; Returns: Writes 4 words to VDP (2 packed bytes -> 4 tile indices)
;
; Expands packed nibbles to VDP tile indices:
;   Input: 2 bytes from (A0)+ where each byte = 2 nibbles
;   Output: 4 words to (A6) = nibble + palette base ($E001)
;
; Algorithm per byte:
;   high_nibble = byte >> 4
;   low_nibble = byte & $0F
;   VDP_write(high_nibble + $E001)
;   VDP_write(low_nibble + $E001)
; ============================================================================

; Tile palette base (tile index + $E001 = final VDP value)
TILE_PALETTE_BASE   equ     $E001

        org     $00247C

unpack_tiles_vdp:
        move.w  #TILE_PALETTE_BASE,d6           ; $00247C: $3C3C $E001 - Palette base
; Process first packed byte
        moveq   #0,d0                           ; $002480: $7000       - Clear D0
        moveq   #0,d1                           ; $002482: $7200       - Clear D1
        move.b  (a0)+,d0                        ; $002484: $1018       - Get packed byte
        move.b  d0,d1                           ; $002486: $1200       - Copy to D1
        lsr.b   #4,d0                           ; $002488: $E808       - Get high nibble
        andi.b  #$0F,d1                         ; $00248A: $0201 $000F - Get low nibble
        add.w   d6,d0                           ; $00248E: $D046       - Add palette base
        add.w   d6,d1                           ; $002490: $D246       - Add palette base
        move.w  d0,(a6)                         ; $002492: $3C80       - Write high nibble tile
        move.w  d1,(a6)                         ; $002494: $3C81       - Write low nibble tile
; Process second packed byte
        moveq   #0,d0                           ; $002496: $7000       - Clear D0
        moveq   #0,d1                           ; $002498: $7200       - Clear D1
        move.b  (a0)+,d0                        ; $00249A: $1018       - Get packed byte
        move.b  d0,d1                           ; $00249C: $1200       - Copy to D1
        lsr.b   #4,d0                           ; $00249E: $E808       - Get high nibble
        andi.b  #$0F,d1                         ; $0024A0: $0201 $000F - Get low nibble
        add.w   d6,d0                           ; $0024A4: $D046       - Add palette base
        add.w   d6,d1                           ; $0024A6: $D246       - Add palette base
        move.w  d0,(a6)                         ; $0024A8: $3C80       - Write high nibble tile
        move.w  d1,(a6)                         ; $0024AA: $3C81       - Write low nibble tile
        rts                                     ; $0024AC: $4E75

; ============================================================================
; tile_index_expand ($0024AE) - Alternate Nibble Expansion
; Called by: Graphics functions
; Parameters: Same as unpack_tiles_vdp
; Returns: Same expansion with different loop count
;
; Multiple entry points for different expansion counts
; ============================================================================

        org     $0024AE

tile_index_expand:
        move.w  #TILE_PALETTE_BASE,d6           ; $0024AE: $3C3C $E001 - Palette base
        moveq   #0,d0                           ; $0024B2: $7000
        moveq   #0,d1                           ; $0024B4: $7200
        move.b  (a0)+,d0                        ; $0024B6: $1018
        ; (continues with same pattern...)

; ============================================================================
; sh2_comm_sync ($002890) - SH2 Communication Sync
; Called by: 3 locations per frame
; Parameters: None (uses work RAM at $C8A8/$C8A9)
; Returns: Nothing
;
; Synchronizes communication with SH2 via MARS COMM registers.
; Waits for SH2 ready bit, then sends data from work RAM.
;
; Protocol:
;   1. Wait for bit 0 at $A15123 to be set (SH2 ready)
;   2. Clear bit 0 (acknowledge)
;   3. Clear local data buffer
;   4. Send data bytes to COMM0/COMM1
;   5. Clear control register
; ============================================================================

; Additional MARS registers for comm sync
MARS_COMM0      equ     $A15120     ; COMM register 0
MARS_COMM1      equ     $A15121     ; COMM register 1
MARS_COMM_CTRL  equ     $A15123     ; COMM control/status

; Work RAM for COMM data (sign-extended for .w addressing)
COMM_DATA_LO    equ     $FFFFC8A8   ; COMM data low byte
COMM_DATA_HI    equ     $FFFFC8A9   ; COMM data high byte

        org     $002890

sh2_comm_sync:
; Wait for SH2 ready (bit 0 set)
.wait_ready:
        btst    #0,MARS_COMM_CTRL               ; $002890: $0839 $0000 $00A1 $5123
        beq.s   .wait_ready                     ; $002898: $67F6
; Clear handshake bit
        bclr    #0,MARS_COMM_CTRL               ; $00289A: $08B9 $0000 $00A1 $5123
; Clear local data and send to SH2
        move.w  #$0000,COMM_DATA_LO.w           ; $0028A2: $31FC $0000 $C8A8
        move.b  COMM_DATA_HI.w,MARS_COMM1       ; $0028A8: $13F8 $C8A9 $00A1 $5121
        move.b  COMM_DATA_LO.w,MARS_COMM0       ; $0028B0: $13F8 $C8A8 $00A1 $5120
        move.b  #$00,MARS_COMM_CTRL             ; $0028B8: $13FC $0000 $00A1 $5123
        rts                                     ; $0028C0: $4E75

; ============================================================================
; SUMMARY
; ============================================================================
;
; Function         | Address | Purpose
; -----------------+---------+------------------------------------------
; unpack_tiles_vdp | $00247C | Expand 2 packed bytes to 4 VDP tiles
; tile_index_expand| $0024AE | Alternate expansion entry
; VDPFill          | $0027F8 | Fill 16 VRAM blocks (256 bytes each)
; VDPPrep          | $00281E | Single VRAM fill at $1F00
; PaletteRAMCopy   | $00284C | Copy 512-byte palette to CRAM
; sh2_comm_sync    | $002890 | SH2 communication handshake
;
; Total VRAM filled by VDPFill: 4096 bytes (16 × 256)
; Palette size: 512 bytes (256 colors × 16-bit RGB)
; Tile expansion: $E001 base = palette 14, priority bit set
;
; ============================================================================
