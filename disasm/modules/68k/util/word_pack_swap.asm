; ============================================================================
; Word Pack and Swap (VDP Command Format)
; ROM Range: $00482A-$004836 (12 bytes)
; ============================================================================
; Packs D0 value with VDP flag bit: shift left 2, shift low word right 2,
; set bit 14, swap words.
;
; Entry: D0 = value
; Exit: D0 = packed VDP command
; Uses: D0
; ============================================================================

word_pack_swap:
        lsl.l   #2,d0                 ; D0 <<= 2
        lsr.w   #2,d0                 ; Low word >>= 2
        ori.w   #$4000,d0             ; Set bit 14
        swap    d0                    ; Swap high/low words
        rts
