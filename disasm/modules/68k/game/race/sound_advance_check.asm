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
        dc.w    $0838,$0007,$C80E     ; BTST #7,($C80E).W
        bne.s   .done                 ; If SH2 busy, skip
        dc.w    $11FC,$00F3,$C822     ; MOVE.B #$F3,($C822).W - queue sound
        dc.w    $5878,$C07C           ; ADDQ.W #4,($C07C).W
.done:
        rts
