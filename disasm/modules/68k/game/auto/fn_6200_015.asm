; ============================================================================
; fn_6200_015 — Conditional Position Add
; ROM Range: $006CDC-$006CE4 (8 bytes)
; Calls condition check at $006D00, then adds D0 to (A1) if condition
; is met (Z flag clear). Used for conditional entity position adjustment.
;
; Entry: D0 = adjustment value, A1 = target address
; Uses: D0, A1
; Confidence: high
; ============================================================================

fn_6200_015:
        DC.W    $6122               ; BSR.S  $006D00; $006CDC
        DC.W    $671E               ; BEQ.S  $006CFE; $006CDE
        ADD.W  D0,(A1)                          ; $006CE0
        RTS                                     ; $006CE2
