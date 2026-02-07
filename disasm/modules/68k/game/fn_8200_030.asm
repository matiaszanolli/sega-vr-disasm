; ============================================================================
; State Cosine Lookup 030 (auto-analyzed)
; ROM Range: $008EFC-$008F4E (82 bytes)
; ============================================================================
; Category: game
; Purpose: Calls: ai_steering_calc, cosine_lookup
;   Object (A0): +$30 (x_position), +$34 (y_position)
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D3, A0
; Calls:
;   $008F4E: cosine_lookup
;   $00A7A0: ai_steering_calc
; Object fields:
;   +$30: x_position
;   +$34: y_position
; Confidence: medium
; ============================================================================

fn_8200_030:
        MOVE.W  (-16198).W,D0                   ; $008EFC
        MOVE.W  (-16194).W,D1                   ; $008F00
        MOVE.W  $0030(A0),D2                    ; $008F04
        MOVE.W  $0034(A0),D3                    ; $008F08
        DC.W    $4EBA,$1892         ; JSR     $00A7A0(PC); $008F0C
        SUBI.W  #$4000,D0                       ; $008F10
        NEG.W  D0                               ; $008F14
        MOVE.W  D0,D3                           ; $008F16
        DC.W    $4EBA,$0034         ; JSR     $008F4E(PC); $008F18
        MOVE.W  $0030(A0),D2                    ; $008F1C
        SUB.W  (-16198).W,D2                    ; $008F20
        CMPI.W  #$C000,D3                       ; $008F24
        BNE.S  .loc_0030                        ; $008F28
        NEG.W  D2                               ; $008F2A
.loc_0030:
        TST.W  D0                               ; $008F2C
        BEQ.S  .loc_0050                        ; $008F2E
        MOVE.W  $0034(A0),D2                    ; $008F30
        SUB.W  (-16194).W,D2                    ; $008F34
        EXT.L   D2                              ; $008F38
        ASL.L  #8,D2                            ; $008F3A
        DIVS    D0,D2                           ; $008F3C
        BMI.S  .loc_0050                        ; $008F3E
        MOVE.W  $00FF5000,D3                    ; $008F40
        MULU    D3,D2                           ; $008F46
        MOVE.W  D2,(-16186).W                   ; $008F48
.loc_0050:
        RTS                                     ; $008F4C
