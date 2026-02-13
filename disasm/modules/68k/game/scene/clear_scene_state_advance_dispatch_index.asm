; ============================================================================
; Clear Scene State + Advance Dispatch Index
; ROM Range: $003E52-$003E64 (18 bytes)
; ============================================================================
; Data prefix (6 bytes) followed by code that clears the scene state
; ($C8AA) and advances the dispatch index ($C8AC) by 4.
;
; Memory:
;   $FFFFC8AA = scene state (word, cleared to 0)
;   $FFFFC8AC = state dispatch index (word, incremented by 4)
; Entry: none | Exit: scene state reset, dispatch advanced
; Uses: D2, D7, A1
; ============================================================================

clear_scene_state_advance_dispatch_index:
; --- Data prefix (6 bytes) ---
        dc.w    $8383                           ; $003E52: data
        dc.w    $8499                           ; $003E54: data (decodes as OR.L (A1)+,D2)
        dc.w    $9E99                           ; $003E56: data (decodes as SUB.L (A1)+,D7)
; --- Code ---
        move.w  #$0000,($FFFFC8AA).w           ; $003E58: $31FC $0000 $C8AA — clear scene state
        addq.w  #4,($FFFFC8AC).w               ; $003E5E: $5878 $C8AC — advance dispatch index
        rts                                     ; $003E62: $4E75
