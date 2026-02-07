; ============================================================================
; Util Dispatch 040 (auto-analyzed)
; ROM Range: $0143C6-$0143FA (52 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;
; Uses: D0, A1
; RAM:
;   $C87E: game_state
; Confidence: medium
; ============================================================================

fn_14200_040:
        JSR     $00882080                       ; $0143C6
        MOVE.W  (-14210).W,D0                   ; $0143CC
        MOVEA.L $0143D6(PC,D0.W),A1             ; $0143D0
        JMP     (A1)                            ; $0143D4
        DC.W    $0089                           ; $0143D6
        DC.W    $43E2                           ; $0143D8
        DC.W    $0089                           ; $0143DA
        DC.W    $43FA,$0089         ; LEA     $014467(PC),A1; $0143DC
        NEG.B  D0                               ; $0143E0
        JSR     $0088179E                       ; $0143E2
        DC.W    $4EBA,$0024         ; JSR     $01440E(PC); $0143E8
        ADDQ.W  #4,(-14210).W                   ; $0143EC
        MOVE.W  #$0020,$00FF0008                ; $0143F0
        RTS                                     ; $0143F8
