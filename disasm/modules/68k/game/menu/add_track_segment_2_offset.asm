; ============================================================================
; Add Track Segment 2 Offset
; ROM Range: $014772-$01477C (10 bytes)
; ============================================================================
; Reads track segment value 2 from $C8B4 and adds it to its
; accumulator at $C0B0. Paired with subtract_track_segment_2_offset (subtract).
;
; Memory:
;   $FFFFC8B4 = track segment value 2 (word, read)
;   $FFFFC0B0 = segment accumulator 2 (word, incremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

add_track_segment_2_offset:
        move.w  ($FFFFC8B4).w,d0               ; $014772: $3038 $C8B4 — load segment value 2
        add.w   d0,($FFFFC0B0).w               ; $014776: $D178 $C0B0 — add to accumulator
        rts                                     ; $01477A: $4E75
