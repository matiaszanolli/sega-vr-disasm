; ============================================================================
; Add Track Segment 3 Offset
; ROM Range: $014786-$014790 (10 bytes)
; ============================================================================
; Reads track segment value 3 from $C8B6 and adds it to its
; accumulator at $C0AE. Paired with subtract_track_segment_3_offset (subtract).
;
; Memory:
;   $FFFFC8B6 = track segment value 3 (word, read)
;   $FFFFC0AE = segment accumulator 3 (word, incremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

add_track_segment_3_offset:
        move.w  ($FFFFC8B6).w,d0               ; $014786: $3038 $C8B6 — load segment value 3
        add.w   d0,($FFFFC0AE).w               ; $01478A: $D178 $C0AE — add to accumulator
        rts                                     ; $01478E: $4E75
