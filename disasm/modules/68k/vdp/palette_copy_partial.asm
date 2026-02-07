; ============================================================================
; Palette Copy Partial
; ROM Range: $002862-$002876 (22 bytes)
; ============================================================================
; Copies 128 bytes to CRAM starting at offset $40 (entries 32-63).
;
; Entry: A2 = source palette data
; Uses: A2, A3, D7
; ============================================================================

palette_copy_partial:
        lea     $00A15240,a3          ; CRAM destination (offset $40)
        moveq   #7,d7                ; 8 iterations
.loop:
        move.l  (a2)+,(a3)+           ; 4x unrolled
        move.l  (a2)+,(a3)+
        move.l  (a2)+,(a3)+
        move.l  (a2)+,(a3)+
        dbra    d7,.loop              ; 8 * 16 = 128 bytes
        rts
