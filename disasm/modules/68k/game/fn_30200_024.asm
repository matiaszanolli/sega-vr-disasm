; ============================================================================
; Fm 024 (auto-analyzed)
; ROM Range: $030BF6-$030C8A (148 bytes)
; ============================================================================
; Category: sound
; Purpose: Object (A5): +$01
;
; Entry: A5 = object/entity pointer
; Uses: D0, D1, A0, A1, A5, A6
; Object fields:
;   +$01: [unknown]
; Confidence: low
; ============================================================================

fn_30200_024:
        LEA     $00FF8500,A6                    ; $030BF6
        MOVE.W  #$0100,$00A11100                ; $030BFC
.loc_000E:
        BTST    #0,$00A11100                    ; $030C04
        BNE.S  .loc_000E                        ; $030C0C
        DC.W    $41FA,$0A78         ; LEA     $031688(PC),A0; $030C0E
        LEA     $00A00000,A1                    ; $030C12
        MOVE.W  #$028C,D0                       ; $030C18
.loc_0026:
        MOVE.B  (A0)+,(A1)+                     ; $030C1C
        DBRA    D0,.loc_0026                    ; $030C1E
        DC.W    $41FA,$0CF1         ; LEA     $031915(PC),A0; $030C22
        LEA     $00A01000,A1                    ; $030C26
        MOVE.W  #$0FFF,D0                       ; $030C2C
.loc_003A:
        MOVE.B  (A0)+,(A1)+                     ; $030C30
        DBRA    D0,.loc_003A                    ; $030C32
        MOVE.W  #$0000,$00A11200                ; $030C36
        NOP                                     ; $030C3E
        NOP                                     ; $030C40
        NOP                                     ; $030C42
        NOP                                     ; $030C44
        NOP                                     ; $030C46
        NOP                                     ; $030C48
        NOP                                     ; $030C4A
        NOP                                     ; $030C4C
        NOP                                     ; $030C4E
        NOP                                     ; $030C50
        NOP                                     ; $030C52
        NOP                                     ; $030C54
        NOP                                     ; $030C56
        NOP                                     ; $030C58
        MOVE.W  #$0100,$00A11200                ; $030C5A
        MOVE.W  #$0000,$00A11100                ; $030C62
        DC.W    $6000,$FF24         ; BRA.W  $030B90; $030C6A
        BTST    #1,(A5)                         ; $030C6E
        BNE.S  .loc_0092                        ; $030C72
        BTST    #2,(A5)                         ; $030C74
        BNE.S  .loc_0092                        ; $030C78
        MOVEQ   #$28,D0                         ; $030C7A
        MOVE.B  $0001(A5),D1                    ; $030C7C
        ORI.B  #$F0,D1                          ; $030C80
        DC.W    $6000,$0034         ; BRA.W  $030CBA; $030C84
.loc_0092:
        RTS                                     ; $030C88
