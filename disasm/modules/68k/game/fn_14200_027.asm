; ============================================================================
; Subtract Track Segment 5 Offset
; ROM Range: $0147B8-$0147C2 (10 bytes)
; ============================================================================
; Reads track segment value 5 from $C8BA and subtracts it from the scroll
; X accumulator at $C054. Paired with fn_14200_026 (add).
;
; Memory:
;   $FFFFC8BA = track segment value 5 (word, read)
;   $FFFFC054 = scroll X position / accumulator (word, decremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

fn_14200_027:
        move.w  ($FFFFC8BA).w,d0               ; $0147B8: $3038 $C8BA — load segment value 5
        sub.w   d0,($FFFFC054).w               ; $0147BC: $9178 $C054 — subtract from scroll X
        rts                                     ; $0147C0: $4E75
