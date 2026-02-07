; ============================================================================
; Camera Game 008 (auto-analyzed)
; ROM Range: $0136AA-$0136EA (64 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C87E (game_state)
;   Object (A2, A4): +$77, +$89
;
; Entry: A2 = object/entity pointer
; Entry: A4 = object/entity pointer
; Uses: D0, D2, A2, A3, A4
; RAM:
;   $C87E: game_state
; Object fields:
;   +$77: [unknown]
;   +$89: [unknown]
; Confidence: medium
; ============================================================================

fn_12200_008:
        DC.W    $0089                           ; $0136AA
        MOVE.W  D2,(A3)+                        ; $0136AC
        DC.W    $0089                           ; $0136AE
        MOVE.W  $0089(A2),(A3)+                 ; $0136B0
        MOVE.W  -$77(A4,D0.W),-(A3)             ; $0136B4
        DC.W    $377A,$0089,$37C0   ; MOVE.W  $013743(PC),$37C0(A3); $0136B8
        DC.W    $0089                           ; $0136BE
        DC.W    $37F4                           ; $0136C0
        TST.W  D2                               ; $0136C2
        BNE.S  .loc_003A                        ; $0136C4
        ADD.W  D0,(-24550).W                    ; $0136C6
        TST.W  (-24550).W                       ; $0136CA
        BGE.S  .loc_002C                        ; $0136CE
        MOVE.W  #$0002,(-24550).W               ; $0136D0
.loc_002C:
        CMPI.W  #$0002,(-24550).W               ; $0136D6
        BLE.S  .loc_003E                        ; $0136DC
        CLR.W  (-24550).W                       ; $0136DE
        BRA.S  .loc_003E                        ; $0136E2
.loc_003A:
        SUBQ.W  #4,(-14210).W                   ; $0136E4
.loc_003E:
        RTS                                     ; $0136E8
