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
        cmpi.w  #$003C,($FFFFC8AA).w    ; $0C78 $003C $C8AA
        bne.s   .done                 ; If not 60, return
        addq.w  #4,($FFFFC07C).w        ; $5878 $C07C
        move.w  #$0000,($FFFFC8AA).w    ; $31FC $0000 $C8AA
.done:
        rts
