; ============================================================================
; State Cosine Lookup 026 (auto-analyzed)
; ROM Range: $008D62-$008DC0 (94 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 3 subroutines
;   Calls: ai_steering_calc, cosine_lookup
;   Object (A0): +$30 (x_position), +$32, +$34 (y_position)
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D3, A0
; Calls:
;   $008F4E: cosine_lookup
;   $00A7A0: ai_steering_calc
; Object fields:
;   +$30: x_position
;   +$32: [unknown]
;   +$34: y_position
; Confidence: medium
; ============================================================================

fn_8200_026:
        MOVE.W  (-16198).W,D0                   ; $008D62
        MOVE.W  (-16194).W,D1                   ; $008D66
        MOVE.W  $0030(A0),D2                    ; $008D6A
        MOVE.W  $0034(A0),D3                    ; $008D6E
        DC.W    $4EBA,$1A2C         ; JSR     $00A7A0(PC); $008D72
        SUBI.W  #$4000,D0                       ; $008D76
        NEG.W  D0                               ; $008D7A
        MOVE.W  D0,(-16190).W                   ; $008D7C
        DC.W    $4EBA,$01CC         ; JSR     $008F4E(PC); $008D80
        MOVE.W  $0030(A0),D2                    ; $008D84
        SUB.W  (-16198).W,D2                    ; $008D88
        CMPI.W  #$C000,(-16190).W               ; $008D8C
        BNE.S  .loc_0034                        ; $008D92
        NEG.W  D2                               ; $008D94
.loc_0034:
        TST.W  D0                               ; $008D96
        BEQ.S  .loc_0046                        ; $008D98
        MOVE.W  $0034(A0),D2                    ; $008D9A
        SUB.W  (-16194).W,D2                    ; $008D9E
        EXT.L   D2                              ; $008DA2
        ASL.L  #8,D2                            ; $008DA4
        DIVS    D0,D2                           ; $008DA6
.loc_0046:
        MOVE.W  $0032(A0),D3                    ; $008DA8
        SUB.W  (-16196).W,D3                    ; $008DAC
        ASR.W  #4,D3                            ; $008DB0
        MOVE.W  D2,D2                           ; $008DB2
        DC.W    $4EBA,$19EE         ; JSR     $00A7A4(PC); $008DB4
        NEG.W  D0                               ; $008DB8
        MOVE.W  D0,(-16192).W                   ; $008DBA
        RTS                                     ; $008DBE
