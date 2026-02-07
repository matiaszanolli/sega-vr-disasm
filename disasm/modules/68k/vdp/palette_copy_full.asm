; ============================================================================
; Palette Copy Full
; ROM Range: $00284C-$002860 (22 bytes)
; ============================================================================
; Copies 512 bytes from (A2) to CRAM palette (full 256 entries).
;
; Entry: A2 = source palette data
; Uses: A2, A3, D7
; ============================================================================

palette_copy_full:
        lea     $00A15200,a3          ; CRAM destination
        moveq   #31,d7               ; 32 iterations
.loop:
        move.l  (a2)+,(a3)+           ; 4x unrolled
        move.l  (a2)+,(a3)+
        move.l  (a2)+,(a3)+
        move.l  (a2)+,(a3)+
        dbra    d7,.loop              ; 32 * 16 = 512 bytes
        rts
