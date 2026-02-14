; ============================================================================
; Sound Queue and Advance (SH2 Gate)
; ROM Range: $0043BC-$0043D0 (20 bytes)
; ============================================================================
; If SH2 processing flag (bit 7 of $C80E) is clear, queues sound $F3
; and advances state machine.
;
; Entry: none
; Uses: none
; ============================================================================

sound_advance_check:
        btst    #7,($FFFFC80E).w        ; $0838 $0007 $C80E
        bne.s   .done                 ; If SH2 busy, skip
        move.b  #$F3,($FFFFC822).w      ; $11FC $00F3 $C822 — queue sound
        addq.w  #4,($FFFFC07C).w        ; $5878 $C07C
.done:
        rts
