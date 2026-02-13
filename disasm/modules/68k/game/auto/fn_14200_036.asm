; ============================================================================
; fn_14200_036 — Scroll Position Increment
; ROM Range: $014862-$014872 (16 bytes)
; ============================================================================
; Increments a scroll position by $10 (16 pixels). Compares current value
; at (A1) with target at (A2), updates (A2) if different, then adds $10
; to (A2) and writes result back to (A1).
;
; Entry: A1 = current position pointer, A2 = target position pointer
; Exit: (A1) updated with incremented value
; Uses: D0, A1, A2
; ============================================================================

fn_14200_036:
        MOVE.W  (A1),D0                         ; $014862
        CMP.W  (A2),D0                          ; $014864
        BEQ.S  .loc_0008                        ; $014866
        MOVE.W  D0,(A2)                         ; $014868
.loc_0008:
        ADDI.W  #$0010,(A2)                     ; $01486A
        MOVE.W  (A2),(A1)                       ; $01486E
        RTS                                     ; $014870
