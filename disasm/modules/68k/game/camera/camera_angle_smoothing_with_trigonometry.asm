; ============================================================================
; camera_angle_smoothing_with_trigonometry — Camera Angle Smoothing with Trigonometry
; ROM Range: $008DC0-$008EB6 (246 bytes)
; Computes smoothed camera angles using ai_steering_calc for initial angle,
; then applies cosine/sine lookups with conditional blending. Smooths both
; horizontal and vertical camera rotation with damping. Dual-axis processing
; with mirrored logic for each axis.
;
; Entry: A0 = entity pointer
; Uses: D0, D1, D2, D3, A0
; Calls: $008F4E (cosine_lookup), $008F52 (sine_lookup),
;        $00A7A0 (ai_steering_calc), $00A7A4 (steering variant)
; Object fields: +$30 x_pos, +$32 z_pos, +$34 y_pos
; Confidence: high
; ============================================================================

camera_angle_smoothing_with_trigonometry:
        MOVE.W  (-16198).W,D0                   ; $008DC0
        MOVE.W  (-16194).W,D1                   ; $008DC4
        MOVE.W  $0030(A0),D2                    ; $008DC8
        MOVE.W  $0034(A0),D3                    ; $008DCC
        jsr     ai_steering_calc(pc)    ; $4EBA $19CE
        SUBI.W  #$4000,D0                       ; $008DD4
        NEG.W  D0                               ; $008DD8
        TST.W  (-16126).W                       ; $008DDA
        BEQ.S  .store_h_angle                   ; $008DDE
        MOVEQ   #$00,D3                         ; $008DE0
        TST.W  D0                               ; $008DE2
        BMI.S  .h_angle_negative                ; $008DE4
        MOVE.W  (-16126).W,D3                   ; $008DE6
        BPL.S  .h_blend_long                    ; $008DEA
.h_check_quadrant:
        CMPI.W  #$C000,D0                       ; $008DEC
        BCC.S  .h_blend_word                    ; $008DF0
        CMPI.W  #$4000,D0                       ; $008DF2
        BCC.S  .h_blend_long                    ; $008DF6
.h_blend_word:
        ADD.W   D3,D0                           ; $008DF8
        ASR.W  #1,D0                            ; $008DFA
        BRA.S  .store_h_angle                   ; $008DFC
.h_angle_negative:
        MOVE.W  (-16126).W,D3                   ; $008DFE
        BPL.S  .h_check_quadrant                ; $008E02
.h_blend_long:
        ANDI.L  #$0000FFFF,D0                   ; $008E04
        ADD.L   D3,D0                           ; $008E0A
        ASR.L  #1,D0                            ; $008E0C
.store_h_angle:
        MOVE.W  D0,(-16190).W                   ; $008E0E
        MOVE.W  D0,(-16126).W                   ; $008E12
        CMPI.W  #$1000,D0                       ; $008E16
        BCS.S  .sine_path                       ; $008E1A
        CMPI.W  #$F000,D0                       ; $008E1C
        BCC.S  .sine_path                       ; $008E20
        CMPI.W  #$9000,D0                       ; $008E22
        BCC.S  .cosine_path                     ; $008E26
        CMPI.W  #$7000,D0                       ; $008E28
        BCS.S  .cosine_path                     ; $008E2C
.sine_path:
        jsr     sine_cosine_quadrant_lookup(pc); $4EBA $011E
        MOVE.W  $0030(A0),D2                    ; $008E32
        SUB.W  (-16198).W,D2                    ; $008E36
        TST.W  D0                               ; $008E3A
        BEQ.S  .calc_vertical                   ; $008E3C
        MOVE.W  $0034(A0),D2                    ; $008E3E
        SUB.W  (-16194).W,D2                    ; $008E42
        BRA.S  .compute_ratio                   ; $008E46
.cosine_path:
        jsr     sine_cosine_quadrant_lookup+4(pc); $4EBA $0108
        MOVE.W  $0034(A0),D2                    ; $008E4C
        SUB.W  (-16194).W,D2                    ; $008E50
        TST.W  D0                               ; $008E54
        BEQ.S  .calc_vertical                   ; $008E56
        MOVE.W  $0030(A0),D2                    ; $008E58
        SUB.W  (-16198).W,D2                    ; $008E5C
.compute_ratio:
        EXT.L   D2                              ; $008E60
        ASL.L  #8,D2                            ; $008E62
        DIVS    D0,D2                           ; $008E64
.calc_vertical:
        MOVE.W  $0032(A0),D3                    ; $008E66
        SUB.W  (-16196).W,D3                    ; $008E6A
        ASR.W  #4,D3                            ; $008E6E
        MOVE.W  D2,D2                           ; $008E70
        jsr     ai_steering_calc+4(pc)  ; $4EBA $1930
        NEG.W  D0                               ; $008E76
        TST.W  (-16128).W                       ; $008E78
        BEQ.S  .store_v_angle                   ; $008E7C
        MOVEQ   #$00,D3                         ; $008E7E
        TST.W  D0                               ; $008E80
        BMI.S  .v_angle_negative                ; $008E82
        MOVE.W  (-16128).W,D3                   ; $008E84
        BPL.S  .v_blend_long                    ; $008E88
.v_check_quadrant:
        CMPI.W  #$C000,D0                       ; $008E8A
        BCC.S  .v_blend_word                    ; $008E8E
        CMPI.W  #$4000,D0                       ; $008E90
        BCC.S  .v_blend_long                    ; $008E94
.v_blend_word:
        ADD.W   D3,D0                           ; $008E96
        ASR.W  #1,D0                            ; $008E98
        BRA.S  .store_v_angle                   ; $008E9A
.v_angle_negative:
        MOVE.W  (-16128).W,D3                   ; $008E9C
        BPL.S  .v_check_quadrant                ; $008EA0
.v_blend_long:
        ANDI.L  #$0000FFFF,D0                   ; $008EA2
        ADD.L   D3,D0                           ; $008EA8
        ASR.L  #1,D0                            ; $008EAA
.store_v_angle:
        MOVE.W  D0,(-16192).W                   ; $008EAC
        MOVE.W  D0,(-16128).W                   ; $008EB0
        RTS                                     ; $008EB4
