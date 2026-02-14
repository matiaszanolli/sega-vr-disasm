; ============================================================================
; rotational_offset_calc — Rotational Offset Calculation
; ROM Range: $00764E-$0076A2 (84 bytes)
; Computes rotational offsets for billboard rendering. Takes entity heading
; angle (+$1E), computes cos/sin via lookup tables, multiplies by position
; deltas (+$20 - +$30 and +$22 - +$34), and stores results as lateral
; offset (+$72) and longitudinal offset (+$E2). Uses cross-product style
; rotation.
;
; Entry: A0 = entity base pointer
; Uses: D0, D2, D3, D4, D5, A0
; Object fields: +$1E heading_angle, +$20 target_x, +$22 target_y,
;   +$30 x_position, +$34 y_position, +$72 lateral_offset, +$E2 long_offset
; Confidence: high
; ============================================================================

rotational_offset_calc:
        MOVE.W  $001E(A0),D0                    ; $00764E
        jsr     sine_cosine_quadrant_lookup(pc); $4EBA $18FA
        MOVE.W  D0,D4                           ; $007656
        MOVE.W  $0020(A0),D2                    ; $007658
        SUB.W  $0030(A0),D2                     ; $00765C
        MULS    D0,D2                           ; $007660
        MOVE.W  $001E(A0),D0                    ; $007662
        jsr     sine_cosine_quadrant_lookup+4(pc); $4EBA $18EA
        MOVE.W  D0,D5                           ; $00766A
        MOVE.W  $0022(A0),D3                    ; $00766C
        SUB.W  $0034(A0),D3                     ; $007670
        MULS    D0,D3                           ; $007674
        ADD.L   D2,D3                           ; $007676
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
        SUB.L   D3,D2                           ; $007698
        ASR.L  #8,D2                            ; $00769A
        MOVE.W  D2,$00E2(A0)                    ; $00769C
        RTS                                     ; $0076A0
