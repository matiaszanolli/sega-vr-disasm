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
        cmpi.b  #$03,($FFFFC819).w      ; $0C38 $0003 $C819
        bne.s   .done                 ; If not 3, skip
        addq.w  #4,($FFFFC8BE).w        ; $5878 $C8BE
        move.w  #$0000,($FFFFC8AA).w    ; $31FC $0000 $C8AA
.done:
        rts
