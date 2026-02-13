; ============================================================================
; Subtract Track Segment 3 Offset
; ROM Range: $014790-$01479A (10 bytes)
; ============================================================================
; Reads track segment value 3 from $C8B6 and subtracts it from its
; accumulator at $C0AE. Paired with add_track_segment_3_offset (add).
;
; Memory:
;   $FFFFC8B6 = track segment value 3 (word, read)
;   $FFFFC0AE = segment accumulator 3 (word, decremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

subtract_track_segment_3_offset:
        move.w  ($FFFFC8B6).w,d0               ; $014790: $3038 $C8B6 — load segment value 3
        sub.w   d0,($FFFFC0AE).w               ; $014794: $9178 $C0AE — subtract from accumulator
        rts                                     ; $014798: $4E75
