; ============================================================================
; Add Track Segment 1 Offset
; ROM Range: $01475E-$014768 (10 bytes)
; ============================================================================
; Reads track segment value 1 from $C8B2 and adds it to its
; accumulator at $C086. Paired with fn_14200_019 (subtract).
;
; Memory:
;   $FFFFC8B2 = track segment value 1 (word, read)
;   $FFFFC086 = segment accumulator 1 (word, incremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

fn_14200_018:
        move.w  ($FFFFC8B2).w,d0               ; $01475E: $3038 $C8B2 — load segment value 1
        add.w   d0,($FFFFC086).w               ; $014762: $D178 $C086 — add to accumulator
        rts                                     ; $014766: $4E75
