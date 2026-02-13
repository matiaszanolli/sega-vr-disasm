; ============================================================================
; conditional_pos_subtract — Conditional Position Subtract
; ROM Range: $006CE4-$006CEC (8 bytes)
; Calls condition check at $006D00, then subtracts D0 from (A1) if
; condition is met (Z flag clear). Used for conditional entity position
; adjustment.
;
; Entry: D0 = adjustment value, A1 = target address
; Uses: D0, A1
; Confidence: high
; ============================================================================

conditional_pos_subtract:
        DC.W    $611A               ; BSR.S  $006D00; $006CE4
        DC.W    $6716               ; BEQ.S  $006CFE; $006CE6
        SUB.W  D0,(A1)                          ; $006CE8
        RTS                                     ; $006CEA
