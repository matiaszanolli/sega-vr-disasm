; ============================================================================
; scroll_pos_decrement — Scroll Position Decrement
; ROM Range: $014872-$014882 (16 bytes)
; ============================================================================
; Decrements a scroll position by $10 (16 pixels). Compares current value
; at (A1) with target at (A2), updates (A2) if different, then subtracts $10
; from (A2) and writes result back to (A1).
;
; Entry: A1 = current position pointer, A2 = target position pointer
; Exit: (A1) updated with decremented value
; Uses: D0, A1, A2
; ============================================================================

scroll_pos_decrement:
        MOVE.W  (A1),D0                         ; $014872
        CMP.W  (A2),D0                          ; $014874
        BEQ.S  .loc_0008                        ; $014876
        MOVE.W  D0,(A2)                         ; $014878
.loc_0008:
        SUBI.W  #$0010,(A2)                     ; $01487A
        MOVE.W  (A2),(A1)                       ; $01487E
        RTS                                     ; $014880
