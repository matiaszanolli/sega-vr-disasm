; ============================================================================
; Camera Game 010 (auto-analyzed)
; ROM Range: $013734-$01377A (70 bytes)
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

fn_12200_010:
        TST.W  D2                               ; $013734
        BNE.S  .loc_0022                        ; $013736
        ADD.W  D0,(-24546).W                    ; $013738
        TST.W  (-24546).W                       ; $01373C
        BGE.S  .loc_0014                        ; $013740
        MOVE.W  #$000C,(-24546).W               ; $013742
.loc_0014:
        CMPI.W  #$000C,(-24546).W               ; $013748
        BLE.S  .loc_0044                        ; $01374E
        CLR.W  (-24546).W                       ; $013750
        BRA.S  .loc_0044                        ; $013754
.loc_0022:
        CMPI.W  #$0002,(-24542).W               ; $013756
        BEQ.S  .loc_0030                        ; $01375C
        MOVE.B  #$CA,(-14302).W                 ; $01375E
.loc_0030:
        LEA     $0089ACB0,A0                    ; $013764
        MOVE.W  (-24546).W,D0                   ; $01376A
        MOVE.B  $00(A0,D0.W),(-14172).W         ; $01376E
        SUBQ.W  #4,(-14210).W                   ; $013774
.loc_0044:
        RTS                                     ; $013778
