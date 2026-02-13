; ============================================================================
; conditional_speed_add — Conditional Speed Add
; ROM Range: $006CEC-$006CF6 (10 bytes)
; Calls condition check at $006D00, then adds D0 to A1+$04 (speed field)
; if condition is met (Z flag clear).
;
; Entry: D0 = adjustment value, A1 = entity pointer
; Uses: D0, A1
; Object fields: +$04 speed
; Confidence: high
; ============================================================================

conditional_speed_add:
        DC.W    $6112               ; BSR.S  $006D00; $006CEC
        DC.W    $670E               ; BEQ.S  $006CFE; $006CEE
        ADD.W  D0,$0004(A1)                     ; $006CF0
        RTS                                     ; $006CF4
