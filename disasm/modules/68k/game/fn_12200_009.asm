; ============================================================================
; Camera Game 009 (auto-analyzed)
; ROM Range: $0136EA-$013734 (74 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C87E (game_state)
;   Object (A0): +$00
;
; Entry: A0 = object/entity pointer
; Uses: D0, D2, A0
; RAM:
;   $C87E: game_state
; Object fields:
;   +$00: [unknown]
; Confidence: medium
; ============================================================================

fn_12200_009:
        TST.W  D2                               ; $0136EA
        BNE.S  .loc_0022                        ; $0136EC
        ADD.W  D0,(-24548).W                    ; $0136EE
        TST.W  (-24548).W                       ; $0136F2
        BGE.S  .loc_0014                        ; $0136F6
        MOVE.W  #$0019,(-24548).W               ; $0136F8
.loc_0014:
        CMPI.W  #$0019,(-24548).W               ; $0136FE
        BLE.S  .loc_0048                        ; $013704
        CLR.W  (-24548).W                       ; $013706
        BRA.S  .loc_0048                        ; $01370A
.loc_0022:
        CMPI.W  #$0002,(-24542).W               ; $01370C
        BEQ.S  .loc_0030                        ; $013712
        MOVE.B  #$F3,(-14302).W                 ; $013714
.loc_0030:
        CLR.B  (-14169).W                       ; $01371A
        LEA     $0089AC62,A0                    ; $01371E
        MOVE.W  (-24548).W,D0                   ; $013724
        MOVE.B  $00(A0,D0.W),(-14171).W         ; $013728
        SUBQ.W  #4,(-14210).W                   ; $01372E
.loc_0048:
        RTS                                     ; $013732
