; ============================================================================
; Add Track Segment Offset
; ROM Range: $01474A-$014754 (10 bytes)
; ============================================================================
; Reads the track segment value from $C8B0 and adds it to the
; accumulator at $C056. Paired with fn_14200_017 (subtract).
;
; Memory:
;   $FFFFC8B0 = track segment value (word, read)
;   $FFFFC056 = segment accumulator (word, incremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

fn_14200_016:
        move.w  ($FFFFC8B0).w,d0               ; $01474A: $3038 $C8B0 — load track segment value
        add.w   d0,($FFFFC056).w               ; $01474E: $D178 $C056 — add to accumulator
        rts                                     ; $014752: $4E75
