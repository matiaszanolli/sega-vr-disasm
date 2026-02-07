; ============================================================================
; Reset Timer and Advance State
; ROM Range: $003D9A-$003DA4 (12 bytes)
; ============================================================================
; Resets timer at $C8AA to 0 and advances state machine at $C8AC by 4.
;
; Entry: none
; Uses: none (only modifies memory)
; ============================================================================

reset_timer_advance_state:
        dc.w    $31FC,$0000,$C8AA     ; MOVE.W #$0000,($C8AA).W
        dc.w    $5878,$C8AC           ; ADDQ.W #4,($C8AC).W
        rts
