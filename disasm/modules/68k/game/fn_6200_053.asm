; ============================================================================
; Obj 053 (auto-analyzed)
; ROM Range: $007C56-$007CD8 (130 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0): +$58, +$59, +$98, +$9A, +$E6, +$E8
;
; Entry: A0 = object/entity pointer
; Uses: D2, A0
; Object fields:
;   +$58: [unknown]
;   +$59: [unknown]
;   +$98: [unknown]
;   +$9A: [unknown]
;   +$E6: [unknown]
;   +$E8: [unknown]
; Confidence: low
; ============================================================================

fn_6200_053:
        TST.W  $0098(A0)                        ; $007C56
        BNE.S  .loc_0020                        ; $007C5A
        BTST    #3,$0058(A0)                    ; $007C5C
        BEQ.S  .loc_0020                        ; $007C62
        MOVE.W  #$000F,$0098(A0)                ; $007C64
        TST.B  (-14172).W                       ; $007C6A
        BNE.S  .loc_0020                        ; $007C6E
        MOVE.B  #$D2,(-14172).W                 ; $007C70
.loc_0020:
        TST.W  $009A(A0)                        ; $007C76
        BNE.S  .loc_0040                        ; $007C7A
        BTST    #3,$0059(A0)                    ; $007C7C
        BEQ.S  .loc_0040                        ; $007C82
        MOVE.W  #$000F,$009A(A0)                ; $007C84
        TST.B  (-14172).W                       ; $007C8A
        BNE.S  .loc_0040                        ; $007C8E
        MOVE.B  #$D2,(-14172).W                 ; $007C90
.loc_0040:
        TST.W  $00E6(A0)                        ; $007C96
        BNE.S  .loc_0060                        ; $007C9A
        BTST    #4,$0058(A0)                    ; $007C9C
        BEQ.S  .loc_0060                        ; $007CA2
        MOVE.W  #$000F,$00E6(A0)                ; $007CA4
        TST.B  (-14172).W                       ; $007CAA
        BNE.S  .loc_0060                        ; $007CAE
        MOVE.B  #$D2,(-14172).W                 ; $007CB0
.loc_0060:
        TST.W  $00E8(A0)                        ; $007CB6
        BNE.S  .loc_0080                        ; $007CBA
        BTST    #4,$0059(A0)                    ; $007CBC
        BEQ.S  .loc_0080                        ; $007CC2
        MOVE.W  #$000F,$00E8(A0)                ; $007CC4
        TST.B  (-14172).W                       ; $007CCA
        BNE.S  .loc_0080                        ; $007CCE
        MOVE.B  #$D2,(-14172).W                 ; $007CD0
.loc_0080:
        RTS                                     ; $007CD6
