; ============================================================================
; Camera Game 011 (auto-analyzed)
; ROM Range: $01377A-$0137C0 (70 bytes)
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

fn_12200_011:
        TST.W  D2                               ; $01377A
        BNE.S  .loc_0022                        ; $01377C
        ADD.W  D0,(-24544).W                    ; $01377E
        TST.W  (-24544).W                       ; $013782
        BGE.S  .loc_0014                        ; $013786
        MOVE.W  #$0009,(-24544).W               ; $013788
.loc_0014:
        CMPI.W  #$0009,(-24544).W               ; $01378E
        BLE.S  .loc_0044                        ; $013794
        CLR.W  (-24544).W                       ; $013796
        BRA.S  .loc_0044                        ; $01379A
.loc_0022:
        CMPI.W  #$0002,(-24542).W               ; $01379C
        BEQ.S  .loc_0030                        ; $0137A2
        MOVE.B  #$CA,(-14302).W                 ; $0137A4
.loc_0030:
        LEA     $0089ACE6,A0                    ; $0137AA
        MOVE.W  (-24544).W,D0                   ; $0137B0
        MOVE.B  $00(A0,D0.W),(-14172).W         ; $0137B4
        SUBQ.W  #4,(-14210).W                   ; $0137BA
.loc_0044:
        RTS                                     ; $0137BE
