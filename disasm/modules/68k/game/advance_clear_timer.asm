; ============================================================================
; Advance State and Clear Timer
; ROM Range: $004384-$004390 (12 bytes)
; ============================================================================
; Advances state machine by 4 and resets frame counter.
;
; Entry: none
; Uses: none
; ============================================================================

advance_clear_timer:
        dc.w    $5878,$C07C           ; ADDQ.W #4,($C07C).W
        dc.w    $31FC,$0000,$C8AA     ; MOVE.W #$0000,($C8AA).W
        rts
