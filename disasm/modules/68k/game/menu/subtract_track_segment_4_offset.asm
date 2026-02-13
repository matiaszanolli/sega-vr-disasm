; ============================================================================
; Subtract Track Segment 4 Offset
; ROM Range: $0147A4-$0147AE (10 bytes)
; ============================================================================
; Reads track segment value 4 from $C8B8 and subtracts it from its
; accumulator at $C0B2. Paired with add_track_segment_4_offset (add).
;
; Memory:
;   $FFFFC8B8 = track segment value 4 (word, read)
;   $FFFFC0B2 = segment accumulator 4 (word, decremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

subtract_track_segment_4_offset:
        move.w  ($FFFFC8B8).w,d0               ; $0147A4: $3038 $C8B8 — load segment value 4
        sub.w   d0,($FFFFC0B2).w               ; $0147A8: $9178 $C0B2 — subtract from accumulator
        rts                                     ; $0147AC: $4E75
