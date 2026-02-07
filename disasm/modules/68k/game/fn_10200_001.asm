; ============================================================================
; Sh2 Comm Game 001 (auto-analyzed)
; ROM Range: $0105DE-$010606 (40 bytes)
; ============================================================================
; Category: sh2
; Purpose: Short helper function
;   Accesses 32X registers: COMM0
;   RAM: $C87E (game_state)
;
; RAM:
;   $C87E: game_state
; Confidence: high
; ============================================================================

fn_10200_001:
.loc_0000:
        TST.B  $00A15120                        ; $0105DE
        BNE.S  .loc_0000                        ; $0105E4
        CLR.B  $00A15123                        ; $0105E6
        MOVE.W  #$0000,(-14210).W               ; $0105EC
        MOVE.W  #$0020,$00FF0008                ; $0105F2
        MOVE.L  #$008909AE,$00FF0002            ; $0105FA
        RTS                                     ; $010604
