; ============================================================================
; VDP Register Write (Multi-Register Save)
; ROM Range: $001454-$001480 (46 bytes)
; ============================================================================
; Converts a linear VRAM address in D0 to VDP command format and
; writes it atomically to VDP control port (A5) with interrupts disabled.
; Saves/restores D0, D6, D7 via stack.
;
; VDP command format: bits 31-16 = address[13:0] | $4000, bits 15-0 = address[15:14]
;
; Entry: D0 = 24-bit VRAM address, A5 = VDP control port
; Uses: D0, D6, D7 (saved/restored)
; ============================================================================

vdp_reg_write_multi:
        movem.w d0/d6/d7,-(a7)          ; Save registers (word-size)
        andi.l  #$00FFFFFF,d0            ; Mask to 24-bit address
        move.w  d0,d6                   ; D6 = low 16 bits
        andi.l  #$00003FFF,d6            ; Mask to 14-bit VRAM address
        ori.w   #$4000,d6               ; Set VRAM write command bit
        swap    d6                      ; Move to high word
        moveq   #$0E,d7                 ; D7 = 14 (shift count)
        lsr.w   d7,d0                   ; D0 = address bits 15-14
        or.l    d6,d0                   ; Combine into VDP command
        move    sr,-(a7)                ; Save status register
        move.w  #$2700,sr               ; Disable all interrupts
        move.l  d0,(a5)                 ; Write VDP command
        move    (a7)+,sr                ; Restore interrupts
        movem.w (a7)+,d0/d6/d7          ; Restore registers (word-size)
        rts
