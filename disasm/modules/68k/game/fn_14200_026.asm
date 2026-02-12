; ============================================================================
; Add Track Segment 5 Offset
; ROM Range: $0147AE-$0147B8 (10 bytes)
; ============================================================================
; Reads track segment value 5 from $C8BA and adds it to the scroll X
; accumulator at $C054. Paired with fn_14200_027 (subtract).
;
; Memory:
;   $FFFFC8BA = track segment value 5 (word, read)
;   $FFFFC054 = scroll X position / accumulator (word, incremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

fn_14200_026:
        move.w  ($FFFFC8BA).w,d0               ; $0147AE: $3038 $C8BA — load segment value 5
        add.w   d0,($FFFFC054).w               ; $0147B2: $D178 $C054 — add to scroll X
        rts                                     ; $0147B6: $4E75
