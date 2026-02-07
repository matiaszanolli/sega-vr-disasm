; ============================================================================
; Fast Fill 128 Bytes (Fixed Address)
; ROM Range: $004888-$0048CA (66 bytes)
; ============================================================================
; Writes D1 to fixed address (A6) 32 times (128 bytes).
; A6 has no post-increment - suitable for FIFO/register writes.
;
; Entry: D1 = fill value, A6 = destination (fixed)
; Uses: none
; ============================================================================

fast_fill_128_fixed:
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        move.l  d1,(a6)
        rts
