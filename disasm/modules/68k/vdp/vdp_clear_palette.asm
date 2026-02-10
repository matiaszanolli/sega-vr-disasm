; ============================================================================
; VDP Clear Palette
; ROM Range: $00277A-$002796 (30 bytes)
; ============================================================================
; Clears all 256 CRAM palette entries to 0 (black).
;
; Entry: D0 = fill value (typically 0)
; Uses: A2, D7
; ============================================================================

vdp_clear_palette:
        andi.b  #$40,MARS_VDP_MODE+1   ; Configure VDP access
        lea     MARS_CRAM,a2          ; CRAM palette base
        moveq   #31,d7               ; 32 iterations
.loop:
        move.l  d0,(a2)+              ; 4x unrolled
        move.l  d0,(a2)+
        move.l  d0,(a2)+
        move.l  d0,(a2)+
        dbra    d7,.loop              ; 32 * 8 = 256 entries
        rts
