; ============================================================================
; Vint 061 (auto-analyzed)
; ROM Range: $003A4E-$003AB2 (100 bytes)
; ============================================================================
; Category: vint
; Purpose: Object (A4): +$100
;
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D3, D4, D6, D7, A0, A1
; Object fields:
;   +$100: [unknown]
; Confidence: low
; ============================================================================

fn_2200_061:
        DC.W    $F372                           ; $003A4E
        DC.W    $1E33                           ; $003A50
        ASR.W  D7,D7                            ; $003A52
        DC.W    $F000                           ; $003A54
        BTST    D0,D0                           ; $003A56
        DC.W    $1049                           ; $003A58
        DC.W    $0FCD                           ; $003A5A
        ROXL.W  -(A2)                           ; $003A5C
        DC.W    $F000                           ; $003A5E
        BTST    D0,(A0)                         ; $003A60
        DC.W    $F0A8                           ; $003A62
        BSET    D6,-(A6)                        ; $003A64
        ROXL.W  D4,D7                           ; $003A66
        DC.W    $FCDF                           ; $003A68
        DC.W    $00F7                           ; $003A6A
        DC.W    $0F89                           ; $003A6C
        DC.W    $08CD                           ; $003A6E
        ROR.B  D0,D4                            ; $003A70
        DC.W    $F800                           ; $003A72
        BTST    D0,D0                           ; $003A74
        MOVE.B  (A7),D3                         ; $003A76
        ADDI.L  #$F7AEF476,$0100(A4)            ; $003A78
        MOVE.B  $10A8F74A,-$0BB9(A2)            ; $003A80
        DC.W    $0000                           ; $003A88
        MOVE.L  $20DE(A2),D1                    ; $003A8A
        ORI.B  #$00,D0                          ; $003A8E
        DC.W    $FA6A                           ; $003A92
        ORI.B  #$00,D0                          ; $003A94
        MOVE.L  $2272(A2),D1                    ; $003A98
        DC.W    $F2E1                           ; $003A9C
        DC.W    $0633                           ; $003A9E
        MOVE.L  A1,(A5)                         ; $003AA0
        DC.W    $0000                           ; $003AA2
        BTST    D0,D0                           ; $003AA4
        MOVE.L  $2508(A2),D1                    ; $003AA6
        TST.B  (-14321).W                       ; $003AAA
        DC.W    $6702               ; BEQ.S  $003AB2; $003AAE
        RTS                                     ; $003AB0
