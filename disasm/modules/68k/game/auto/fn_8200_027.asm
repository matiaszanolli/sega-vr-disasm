; ============================================================================
; Math Cosine Lookup 027 (auto-analyzed)
; ROM Range: $008DC0-$008EB6 (246 bytes)
; ============================================================================
; Category: math
; Purpose: Orchestrator calling 4 subroutines
;   Calls: ai_steering_calc, cosine_lookup, sine_lookup
;   Object (A0): +$30 (x_position), +$32, +$34 (y_position)
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D3, A0
; Calls:
;   $008F4E: cosine_lookup
;   $008F52: sine_lookup
;   $00A7A0: ai_steering_calc
; Object fields:
;   +$30: x_position
;   +$32: [unknown]
;   +$34: y_position
; Confidence: high
; ============================================================================

fn_8200_027:
        MOVE.W  (-16198).W,D0                   ; $008DC0
        MOVE.W  (-16194).W,D1                   ; $008DC4
        MOVE.W  $0030(A0),D2                    ; $008DC8
        MOVE.W  $0034(A0),D3                    ; $008DCC
        DC.W    $4EBA,$19CE         ; JSR     $00A7A0(PC); $008DD0
        SUBI.W  #$4000,D0                       ; $008DD4
        NEG.W  D0                               ; $008DD8
        TST.W  (-16126).W                       ; $008DDA
        BEQ.S  .loc_004E                        ; $008DDE
        MOVEQ   #$00,D3                         ; $008DE0
        TST.W  D0                               ; $008DE2
        BMI.S  .loc_003E                        ; $008DE4
        MOVE.W  (-16126).W,D3                   ; $008DE6
        BPL.S  .loc_0044                        ; $008DEA
.loc_002C:
        CMPI.W  #$C000,D0                       ; $008DEC
        BCC.S  .loc_0038                        ; $008DF0
        CMPI.W  #$4000,D0                       ; $008DF2
        BCC.S  .loc_0044                        ; $008DF6
.loc_0038:
        DC.W    $D043                           ; $008DF8
        ASR.W  #1,D0                            ; $008DFA
        BRA.S  .loc_004E                        ; $008DFC
.loc_003E:
        MOVE.W  (-16126).W,D3                   ; $008DFE
        BPL.S  .loc_002C                        ; $008E02
.loc_0044:
        ANDI.L  #$0000FFFF,D0                   ; $008E04
        DC.W    $D083                           ; $008E0A
        ASR.L  #1,D0                            ; $008E0C
.loc_004E:
        MOVE.W  D0,(-16190).W                   ; $008E0E
        MOVE.W  D0,(-16126).W                   ; $008E12
        CMPI.W  #$1000,D0                       ; $008E16
        BCS.S  .loc_006E                        ; $008E1A
        CMPI.W  #$F000,D0                       ; $008E1C
        BCC.S  .loc_006E                        ; $008E20
        CMPI.W  #$9000,D0                       ; $008E22
        BCC.S  .loc_0088                        ; $008E26
        CMPI.W  #$7000,D0                       ; $008E28
        BCS.S  .loc_0088                        ; $008E2C
.loc_006E:
        DC.W    $4EBA,$011E         ; JSR     $008F4E(PC); $008E2E
        MOVE.W  $0030(A0),D2                    ; $008E32
        SUB.W  (-16198).W,D2                    ; $008E36
        TST.W  D0                               ; $008E3A
        BEQ.S  .loc_00A6                        ; $008E3C
        MOVE.W  $0034(A0),D2                    ; $008E3E
        SUB.W  (-16194).W,D2                    ; $008E42
        BRA.S  .loc_00A0                        ; $008E46
.loc_0088:
        DC.W    $4EBA,$0108         ; JSR     $008F52(PC); $008E48
        MOVE.W  $0034(A0),D2                    ; $008E4C
        SUB.W  (-16194).W,D2                    ; $008E50
        TST.W  D0                               ; $008E54
        BEQ.S  .loc_00A6                        ; $008E56
        MOVE.W  $0030(A0),D2                    ; $008E58
        SUB.W  (-16198).W,D2                    ; $008E5C
.loc_00A0:
        EXT.L   D2                              ; $008E60
        ASL.L  #8,D2                            ; $008E62
        DIVS    D0,D2                           ; $008E64
.loc_00A6:
        MOVE.W  $0032(A0),D3                    ; $008E66
        SUB.W  (-16196).W,D3                    ; $008E6A
        ASR.W  #4,D3                            ; $008E6E
        MOVE.W  D2,D2                           ; $008E70
        DC.W    $4EBA,$1930         ; JSR     $00A7A4(PC); $008E72
        NEG.W  D0                               ; $008E76
        TST.W  (-16128).W                       ; $008E78
        BEQ.S  .loc_00EC                        ; $008E7C
        MOVEQ   #$00,D3                         ; $008E7E
        TST.W  D0                               ; $008E80
        BMI.S  .loc_00DC                        ; $008E82
        MOVE.W  (-16128).W,D3                   ; $008E84
        BPL.S  .loc_00E2                        ; $008E88
.loc_00CA:
        CMPI.W  #$C000,D0                       ; $008E8A
        BCC.S  .loc_00D6                        ; $008E8E
        CMPI.W  #$4000,D0                       ; $008E90
        BCC.S  .loc_00E2                        ; $008E94
.loc_00D6:
        DC.W    $D043                           ; $008E96
        ASR.W  #1,D0                            ; $008E98
        BRA.S  .loc_00EC                        ; $008E9A
.loc_00DC:
        MOVE.W  (-16128).W,D3                   ; $008E9C
        BPL.S  .loc_00CA                        ; $008EA0
.loc_00E2:
        ANDI.L  #$0000FFFF,D0                   ; $008EA2
        DC.W    $D083                           ; $008EA8
        ASR.L  #1,D0                            ; $008EAA
.loc_00EC:
        MOVE.W  D0,(-16192).W                   ; $008EAC
        MOVE.W  D0,(-16128).W                   ; $008EB0
        RTS                                     ; $008EB4
