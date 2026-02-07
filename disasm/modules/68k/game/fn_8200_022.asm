; ============================================================================
; State 022 (auto-analyzed)
; ROM Range: $008B28-$008B9C (116 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A2, A4, A6): +$00, +$78
;
; Entry: A2 = object/entity pointer
; Entry: A4 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D2, D5, D6, D7, A0, A2, A3
; Object fields:
;   +$00: [unknown]
;   +$78: [unknown]
; Confidence: low
; ============================================================================

fn_8200_022:
        DC.W    $0088                           ; $008B28
        OR.W   D6,-(A2)                         ; $008B2A
        DC.W    $0088                           ; $008B2C
        OR.L   -$78(A6,D0.W),D7                 ; $008B2E
        DIVU    (A6),D7                         ; $008B32
        DC.W    $0088                           ; $008B34
        DIVU    -$78(A2,D0.W),D7                ; $008B36
        DIVU    -$78(A4,D0.W),D7                ; $008B3A
        DIVU    #$0088,D7                       ; $008B3E
        DC.W    $8C40                           ; $008B42
        DC.W    $0088                           ; $008B44
        DC.W    $8CCE                           ; $008B46
        DC.W    $0088                           ; $008B48
        OR.L   D5,(A4)+                         ; $008B4A
        DC.W    $0088                           ; $008B4C
        DIVS    D0,D6                           ; $008B4E
        DC.W    $0088                           ; $008B50
        DIVS    D2,D5                           ; $008B52
        DC.W    $0088                           ; $008B54
        DIVS    -$78(A2,D0.W),D5                ; $008B56
        OR.B   (A6),D6                          ; $008B5A
        DC.W    $FA30                           ; $008B5C
        ADDQ.B  #4,D0                           ; $008B5E
        MOVE.B  (A0)+,$0000(A6)                 ; $008B60
        ORI.B  #$00,D0                          ; $008B64
        ORI.B  #$24,D0                          ; $008B68
        LSL.W  D6,D0                            ; $008B6C
        NEG.B  D0                               ; $008B6E
        MOVE.B  (A3),(A7)                       ; $008B70
        ORI.B  #$00,D0                          ; $008B72
        DC.W    $0000                           ; $008B76
        BTST    D0,D0                           ; $008B78
        DC.W    $0024                           ; $008B7A
        MOVE.W  #$0000,(-16186).W               ; $008B7C
        MOVE.W  #$0000,(-16198).W               ; $008B82
        BSET    #1,(-15597).W                   ; $008B88
        BCLR    #3,(-15597).W                   ; $008B8E
        MOVE.B  #$00,(-14186).W                 ; $008B94
        RTS                                     ; $008B9A
