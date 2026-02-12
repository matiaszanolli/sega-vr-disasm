; ============================================================================
; Add Track Segment 4 Offset
; ROM Range: $01479A-$0147A4 (10 bytes)
; ============================================================================
; Reads track segment value 4 from $C8B8 and adds it to its
; accumulator at $C0B2. Paired with fn_14200_025 (subtract).
;
; Memory:
;   $FFFFC8B8 = track segment value 4 (word, read)
;   $FFFFC0B2 = segment accumulator 4 (word, incremented)
; Entry: none | Exit: accumulator updated | Uses: D0
; ============================================================================

fn_14200_024:
        move.w  ($FFFFC8B8).w,d0               ; $01479A: $3038 $C8B8 — load segment value 4
        add.w   d0,($FFFFC0B2).w               ; $01479E: $D178 $C0B2 — add to accumulator
        rts                                     ; $0147A2: $4E75
