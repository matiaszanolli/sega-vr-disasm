; ============================================================================
; Check Timeout (60 Frames)
; ROM Range: $004168-$00417A (20 bytes)
; ============================================================================
; Checks if timer at $C8AA has reached 60 frames (1 second).
; If so, advances game phase at $C07C and resets timer.
;
; Entry: none
; Uses: none (only modifies memory)
; ============================================================================

check_timeout_60:
        dc.w    $0C78,$003C,$C8AA     ; CMPI.W #$003C,($C8AA).W
        bne.s   .done                 ; If not 60, return
        dc.w    $5878,$C07C           ; ADDQ.W #4,($C07C).W
        dc.w    $31FC,$0000,$C8AA     ; MOVE.W #$0000,($C8AA).W
.done:
        rts
