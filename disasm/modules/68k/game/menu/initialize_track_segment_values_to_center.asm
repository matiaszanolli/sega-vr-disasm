; ============================================================================
; Initialize Track Segment Values to Center
; ROM Range: $0147E8-$01480E (38 bytes)
; ============================================================================
; Sets all 6 track segment variables ($C8B0-$C8BA) to $0080 (center/default).
; These segments feed into the scroll and position registers via other
; track segment add/subtract functions.
;
; Memory:
;   $FFFFC8B0 = track segment 0 (word, set to $0080)
;   $FFFFC8B2 = track segment 1 (word, set to $0080)
;   $FFFFC8B4 = track segment 2 (word, set to $0080)
;   $FFFFC8B6 = track segment 3 (word, set to $0080)
;   $FFFFC8B8 = track segment 4 (word, set to $0080)
;   $FFFFC8BA = track segment 5 (word, set to $0080)
; Entry: none | Exit: all segments centered | Uses: none
; ============================================================================

initialize_track_segment_values_to_center:
        move.w  #$0080,($FFFFC8B0).w            ; $0147E8: $31FC $0080 $C8B0 — segment 0 = center
        move.w  #$0080,($FFFFC8B2).w            ; $0147EE: $31FC $0080 $C8B2 — segment 1 = center
        move.w  #$0080,($FFFFC8B4).w            ; $0147F4: $31FC $0080 $C8B4 — segment 2 = center
        move.w  #$0080,($FFFFC8B6).w            ; $0147FA: $31FC $0080 $C8B6 — segment 3 = center
        move.w  #$0080,($FFFFC8B8).w            ; $014800: $31FC $0080 $C8B8 — segment 4 = center
        move.w  #$0080,($FFFFC8BA).w            ; $014806: $31FC $0080 $C8BA — segment 5 = center
        rts                                     ; $01480C: $4E75

