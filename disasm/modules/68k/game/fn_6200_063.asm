; ============================================================================
; Obj 063 (auto-analyzed)
; ROM Range: $007FDA-$007FEE (20 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0): +$02 (flags/type)
;
; Entry: A0 = object/entity pointer
; Uses: A0
; Object fields:
;   +$02: flags/type
; Confidence: low
; ============================================================================

fn_6200_063:
        ANDI.W  #$BFFF,$0002(A0)                ; $007FDA
        MOVE.W  #$0000,(-16306).W               ; $007FE0
        MOVE.B  #$00,(-15611).W                 ; $007FE6
        RTS                                     ; $007FEC
