; ============================================================================
; Sh2 Comm Game 004 (auto-analyzed)
; ROM Range: $011862-$01188A (40 bytes)
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

fn_10200_004:
.loc_0000:
        TST.B  COMM0_HI                        ; $011862
        BNE.S  .loc_0000                        ; $011868
        CLR.B  COMM1_LO                        ; $01186A
        MOVE.W  #$0000,(-14210).W               ; $011870
        MOVE.W  #$0020,$00FF0008                ; $011876
        MOVE.L  #$0088D4A4,$00FF0002            ; $01187E
        RTS                                     ; $011888
