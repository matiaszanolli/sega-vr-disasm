; ============================================================================
; Advance Sub-Sequence Timer
; ROM Range: $0057CA-$0057D0 (6 bytes)
; ============================================================================
; Increments the sub-sequence timer byte at $C8C5 by 4.
;
; Memory:
;   $FFFFC8C5 = sub-sequence timer value (byte, incremented by 4)
; Entry: none | Exit: timer updated | Uses: none
; ============================================================================

advance_sub_seq_timer:
        addq.b  #4,($FFFFC8C5).w               ; $0057CA: $5038 $C8C5 — advance timer
        rts                                     ; $0057CE: $4E75
