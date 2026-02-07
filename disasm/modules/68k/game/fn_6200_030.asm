; ============================================================================
; Obj 030 (auto-analyzed)
; ROM Range: $007624-$007636 (18 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0): +$CC
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; Object fields:
;   +$CC: [unknown]
; Confidence: low
; ============================================================================

fn_6200_030:
        TST.W  (-16198).W                       ; $007624
        DC.W    $670C               ; BEQ.S  $007636; $007628
        MOVE.W  (-16190).W,D0                   ; $00762A
        NEG.W  D0                               ; $00762E
        MOVE.W  D0,$00CC(A0)                    ; $007630
        RTS                                     ; $007634
