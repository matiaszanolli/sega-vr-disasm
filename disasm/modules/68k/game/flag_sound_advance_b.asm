; ============================================================================
; Flag Set, Sound Queue, Advance (SH2 Gate)
; ROM Range: $0047CA-$0047E4 (26 bytes)
; ============================================================================
; Sets process flag, waits for SH2 completion, queues sound, advances state.
;
; Entry: none
; Uses: none
; ============================================================================

flag_sound_advance_b:
        dc.w    $31FC,$0001,$C048     ; MOVE.W #$0001,($C048).W
        dc.w    $0838,$0007,$C80E     ; BTST #7,($C80E).W
        bne.s   .done                 ; If SH2 busy, skip
        dc.w    $11FC,$00F3,$C822     ; MOVE.B #$F3,($C822).W
        dc.w    $5878,$C07C           ; ADDQ.W #4,($C07C).W
.done:
        rts
