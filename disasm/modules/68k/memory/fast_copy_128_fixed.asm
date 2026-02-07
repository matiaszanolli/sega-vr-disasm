; ============================================================================
; Fast Copy 128 Bytes to Fixed Address
; ROM Range: $00492C-$00496E (66 bytes)
; ============================================================================
; Copies 32 longs from (A1)+ to fixed address (A6).
; Suitable for writing data to FIFO/register.
;
; Entry: A1 = source, A6 = destination (fixed)
; Uses: A1 (advances)
; ============================================================================

fast_copy_128_fixed:
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        move.l  (a1)+,(a6)
        rts
