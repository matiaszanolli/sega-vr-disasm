; ============================================================================
; Z80 Sound Write
; ROM Range: $030DF4-$030E1E (44 bytes)
; ============================================================================
; Requests Z80 bus, waits for grant, reads channel volume from A5+$09,
; shifts right 3 and masks to 4 bits, writes to Z80 RAM at $A00FFD,
; then releases the bus.
;
; Entry: A5 = channel state pointer
; Uses: D0
; Hardware: $A11100 (Z80 bus request), $A00FFD (Z80 sound parameter)
; Fields accessed: A5+$09 (channel volume)
; ============================================================================

z80_sound_write:
        move.w  #$0100,Z80_BUSREQ        ; Request Z80 bus
.wait_grant:
        btst    #0,Z80_BUSREQ            ; Check bus grant status
        bne.s   .wait_grant             ; Loop until bus granted
        move.b  $0009(a5),d0            ; D0 = channel volume
        lsr.b   #3,d0                   ; Shift right 3 (divide by 8)
        andi.b  #$0F,d0                 ; Mask to 4 bits (0-15)
        move.b  d0,$00A00FFD            ; Write to Z80 sound RAM
        move.w  #$0000,Z80_BUSREQ        ; Release Z80 bus
        rts
