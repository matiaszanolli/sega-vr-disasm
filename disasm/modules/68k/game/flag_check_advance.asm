; ============================================================================
; Flag Check and Advance State
; ROM Range: $004498-$0044A6 (14 bytes)
; ============================================================================
; Waits for SH2 processing to complete (bit 7 of $C80E clear),
; then advances state machine.
;
; Entry: none
; Uses: none
; ============================================================================

flag_check_advance:
        dc.w    $0838,$0007,$C80E     ; BTST #7,($C80E).W
        bne.s   .done                 ; If SH2 busy, skip
        dc.w    $5878,$C07C           ; ADDQ.W #4,($C07C).W
.done:
        rts
