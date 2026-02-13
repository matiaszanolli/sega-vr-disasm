; ============================================================================
; Counter Check and Advance Secondary State
; ROM Range: $004696-$0046AA (20 bytes)
; ============================================================================
; Checks if step counter equals 3; if so, advances secondary state
; at $C8BE and resets frame counter.
;
; Entry: none
; Uses: none
; ============================================================================

counter_check_advance:
        dc.w    $0C38,$0003,$C819     ; CMPI.B #$03,($C819).W
        bne.s   .done                 ; If not 3, skip
        dc.w    $5878,$C8BE           ; ADDQ.W #4,($C8BE).W
        dc.w    $31FC,$0000,$C8AA     ; MOVE.W #$0000,($C8AA).W
.done:
        rts
