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
        btst    #7,($FFFFC80E).w        ; $0838 $0007 $C80E
        bne.s   .done                 ; If SH2 busy, skip
        addq.w  #4,($FFFFC07C).w        ; $5878 $C07C
.done:
        rts
