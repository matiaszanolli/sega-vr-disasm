; ============================================================================
; Subtract Track Segment 1 Offset
; ROM Range: $014768-$014772 (10 bytes)
; ============================================================================
; Reads track segment value 1 from $C8B2 and subtracts it from its
; accumulator at $C086. Paired with add_track_segment_1_offset (add).
;
; Memory:
;   $FFFFC8B2 = track segment value 1 (word, read)
;   $FFFFC086 = segment accumulator 1 (word, decremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

subtract_track_segment_1_offset:
        move.w  ($FFFFC8B2).w,d0               ; $014768: $3038 $C8B2 — load segment value 1
        sub.w   d0,($FFFFC086).w               ; $01476C: $9178 $C086 — subtract from accumulator
        rts                                     ; $014770: $4E75
