; ============================================================================
; Obj 052 (auto-analyzed)
; ROM Range: $007C4A-$007C56 (12 bytes)
; ============================================================================
; Category: game
; Purpose: Small leaf function
;   Object (A0): +$04 (speed_index/velocity)
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; Object fields:
;   +$04: speed_index/velocity
; Confidence: low
; ============================================================================

fn_6200_052:
        DIVU    #$0000,D0                       ; $007C4A
        TST.W  $0004(A0)                        ; $007C4E
        DC.W    $6602               ; BNE.S  $007C56; $007C52
        RTS                                     ; $007C54
