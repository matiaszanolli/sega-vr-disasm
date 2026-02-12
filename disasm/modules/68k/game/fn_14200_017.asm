; ============================================================================
; Subtract Track Segment Offset
; ROM Range: $014754-$01475E (10 bytes)
; ============================================================================
; Reads the track segment value from $C8B0 and subtracts it from the
; accumulator at $C056. Paired with fn_14200_016 (add).
;
; Memory:
;   $FFFFC8B0 = track segment value (word, read)
;   $FFFFC056 = segment accumulator (word, decremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

fn_14200_017:
        move.w  ($FFFFC8B0).w,d0               ; $014754: $3038 $C8B0 — load track segment value
        sub.w   d0,($FFFFC056).w               ; $014758: $9178 $C056 — subtract from accumulator
        rts                                     ; $01475C: $4E75
