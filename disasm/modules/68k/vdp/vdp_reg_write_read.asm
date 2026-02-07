; ============================================================================
; VDP CRAM Read Setup
; ROM Range: $0014A2-$0014BC (28 bytes)
; ============================================================================
; Sets up VDP for CRAM read access. Masks address to 7 bits (CRAM
; has 128 bytes / 64 entries), adds $C000 read command prefix.
;
; Entry: D0 = CRAM address, A5 = VDP control port
; Uses: D0 (saved/restored)
; ============================================================================

vdp_reg_write_read:
        move.w  d0,-(a7)                ; Save D0
        andi.l  #$0000007F,d0            ; Mask to 7-bit CRAM address
        addi.w  #$C000,d0               ; Set CRAM read command
        swap    d0                      ; Move to high word
        move    sr,-(a7)                ; Save status register
        move.w  #$2700,sr               ; Disable interrupts
        move.l  d0,(a5)                 ; Write VDP command
        move    (a7)+,sr                ; Restore interrupts
        move.w  (a7)+,d0                ; Restore D0
        rts
