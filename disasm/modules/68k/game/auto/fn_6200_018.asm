; ============================================================================
; Obj 018 (auto-analyzed)
; ROM Range: $006CF6-$006D00 (10 bytes)
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

fn_6200_018:
        DC.W    $6108               ; BSR.S  $006D00; $006CF6
        BEQ.S  .loc_0008                        ; $006CF8
        SUB.W  D0,$0004(A1)                     ; $006CFA
.loc_0008:
        RTS                                     ; $006CFE
