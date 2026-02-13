; ============================================================================
; Subtract Track Segment 2 Offset
; ROM Range: $01477C-$014786 (10 bytes)
; ============================================================================
; Reads track segment value 2 from $C8B4 and subtracts it from its
; accumulator at $C0B0. Paired with add_track_segment_2_offset (add).
;
; Memory:
;   $FFFFC8B4 = track segment value 2 (word, read)
;   $FFFFC0B0 = segment accumulator 2 (word, decremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

subtract_track_segment_2_offset:
        move.w  ($FFFFC8B4).w,d0               ; $01477C: $3038 $C8B4 — load segment value 2
        sub.w   d0,($FFFFC0B0).w               ; $014780: $9178 $C0B0 — subtract from accumulator
        rts                                     ; $014784: $4E75
