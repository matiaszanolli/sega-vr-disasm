; ============================================================================
; Obj 017 (auto-analyzed)
; ROM Range: $006CEC-$006CF6 (10 bytes)
; ============================================================================
; Category: game
; Purpose: Small leaf function
;   Object (A1): +$04 (speed_index/velocity)
;
; Entry: A1 = object/entity pointer
; Uses: D0, A1
; Object fields:
;   +$04: speed_index/velocity
; Confidence: low
; ============================================================================

fn_6200_017:
        DC.W    $6112               ; BSR.S  $006D00; $006CEC
        DC.W    $670E               ; BEQ.S  $006CFE; $006CEE
        ADD.W  D0,$0004(A1)                     ; $006CF0
        RTS                                     ; $006CF4
