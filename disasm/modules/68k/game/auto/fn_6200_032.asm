; ============================================================================
; Math Cosine Lookup 032 (auto-analyzed)
; ROM Range: $00764E-$0076A2 (84 bytes)
; ============================================================================
; Category: math
; Purpose: Calls: cosine_lookup, sine_lookup
;   Object (A0): +$1E, +$20, +$22, +$30 (x_position), +$34 (y_position), +$72
;
; Entry: A0 = object/entity pointer
; Uses: D0, D2, D3, D4, D5, A0
; Calls:
;   $008F4E: cosine_lookup
;   $008F52: sine_lookup
; Object fields:
;   +$1E: [unknown]
;   +$20: [unknown]
;   +$22: [unknown]
;   +$30: x_position
;   +$34: y_position
;   +$72: [unknown]
;   +$E2: [unknown]
; Confidence: high
; ============================================================================

fn_6200_032:
        MOVE.W  $001E(A0),D0                    ; $00764E
        DC.W    $4EBA,$18FA         ; JSR     $008F4E(PC); $007652
        MOVE.W  D0,D4                           ; $007656
        MOVE.W  $0020(A0),D2                    ; $007658
        SUB.W  $0030(A0),D2                     ; $00765C
        MULS    D0,D2                           ; $007660
        MOVE.W  $001E(A0),D0                    ; $007662
        DC.W    $4EBA,$18EA         ; JSR     $008F52(PC); $007666
        MOVE.W  D0,D5                           ; $00766A
        MOVE.W  $0022(A0),D3                    ; $00766C
        SUB.W  $0034(A0),D3                     ; $007670
        MULS    D0,D3                           ; $007674
        DC.W    $D682                           ; $007676
        ASR.L  #8,D3                            ; $007678
        NEG.W  D3                               ; $00767A
        MOVE.W  D3,$0072(A0)                    ; $00767C
        MOVE.W  D5,D0                           ; $007680
        MOVE.W  $0020(A0),D2                    ; $007682
        SUB.W  $0030(A0),D2                     ; $007686
        MULS    D0,D2                           ; $00768A
        MOVE.W  D4,D0                           ; $00768C
        MOVE.W  $0022(A0),D3                    ; $00768E
        SUB.W  $0034(A0),D3                     ; $007692
        MULS    D0,D3                           ; $007696
        DC.W    $9483                           ; $007698
        ASR.L  #8,D2                            ; $00769A
        MOVE.W  D2,$00E2(A0)                    ; $00769C
        RTS                                     ; $0076A0
