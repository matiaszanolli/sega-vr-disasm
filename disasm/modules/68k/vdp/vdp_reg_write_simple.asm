; ============================================================================
; VDP Register Write (Simple)
; ROM Range: $001482-$0014A0 (32 bytes)
; ============================================================================
; Compact VDP VRAM write command builder. Converts D0 low 14 bits
; to VDP command format and writes atomically. Only saves/restores D0.
;
; Entry: D0 = VRAM address, A5 = VDP control port
; Uses: D0 (saved/restored)
; ============================================================================

vdp_reg_write_simple:
        move.w  d0,-(a7)                ; Save D0 word
        andi.l  #$00003FFF,d0            ; Mask to 14-bit address
        ori.w   #$4000,d0               ; Set VRAM write bit
        swap    d0                      ; Move to high word
        addi.w  #$0010,d0               ; Set additional address bits
        move    sr,-(a7)                ; Save status register
        move.w  #$2700,sr               ; Disable interrupts
        move.l  d0,(a5)                 ; Write VDP command
        move    (a7)+,sr                ; Restore interrupts
        move.w  (a7)+,d0                ; Restore D0
        rts
