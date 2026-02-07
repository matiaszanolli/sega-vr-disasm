; ============================================================================
; State Position 029 (auto-analyzed)
; ROM Range: $008ED6-$008EF4 (30 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0): +$32, +$34 (y_position)
;
; Entry: A0 = object/entity pointer
; Uses: D0, D2, D3, A0
; Object fields:
;   +$32: [unknown]
;   +$34: y_position
; Confidence: medium
; ============================================================================

fn_8200_029:
        MOVE.W  $0032(A0),D3                    ; $008ED6
        SUB.W  (-16196).W,D3                    ; $008EDA
        ASR.W  #4,D3                            ; $008EDE
        MOVE.W  $0034(A0),D2                    ; $008EE0
        SUB.W  (-16194).W,D2                    ; $008EE4
        DC.W    $4EBA,$18BA         ; JSR     $00A7A4(PC); $008EE8
        NEG.W  D0                               ; $008EEC
        MOVE.W  D0,(-16192).W                   ; $008EEE
        RTS                                     ; $008EF2
