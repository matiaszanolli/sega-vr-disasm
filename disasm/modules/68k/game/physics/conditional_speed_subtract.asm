; ============================================================================
; conditional_speed_subtract — Conditional Speed Subtract
; ROM Range: $006CF6-$006D00 (10 bytes)
; Calls condition check at $006D00, then subtracts D0 from A1+$04 (speed
; field) if condition is met (Z flag clear).
;
; Entry: D0 = adjustment value, A1 = entity pointer
; Uses: D0, A1
; Object fields: +$04 speed
; Confidence: high
; ============================================================================

conditional_speed_subtract:
        DC.W    $6108               ; BSR.S  $006D00; $006CF6
        BEQ.S  .loc_0008                        ; $006CF8
        SUB.W  D0,$0004(A1)                     ; $006CFA
.loc_0008:
        RTS                                     ; $006CFE
