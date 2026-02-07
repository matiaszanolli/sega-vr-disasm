; ============================================================================
; Vint Physics 027 (auto-analyzed)
; ROM Range: $002CDC-$002DCA (238 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$04 (speed_index/velocity), +$06 (speed), +$08, +$0A (param_a), +$0C, +$16 (calc_speed)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, A0, A1, A2
; Object fields:
;   +$04: speed_index/velocity
;   +$06: speed
;   +$08: [unknown]
;   +$0A: param_a
;   +$0C: [unknown]
;   +$16: calc_speed
;   +$18: [unknown]
;   +$1A: direction
; Confidence: medium
; ============================================================================

fn_2200_027:
        MOVE.W  $0030(A0),D0                    ; $002CDC
        MOVE.W  D0,$0016(A1)                    ; $002CE0
        MOVE.W  D0,$011A(A2)                    ; $002CE4
        MOVE.W  $009C(A0),D0                    ; $002CE8
        ASL.W  #4,D0                            ; $002CEC
        MOVE.W  D0,D1                           ; $002CEE
        SUB.W  (-16300).W,D1                    ; $002CF0
        NEG.W  D1                               ; $002CF4
        MOVE.W  D1,$0004(A1)                    ; $002CF6
        ADD.W  (-16156).W,D0                    ; $002CFA
        ADD.W  $0032(A0),D0                     ; $002CFE
        MOVE.W  D0,$0018(A1)                    ; $002D02
        MOVE.W  D0,$011C(A2)                    ; $002D06
        MOVE.W  (-16298).W,$0006(A1)            ; $002D0A
        MOVE.W  $0034(A0),D0                    ; $002D10
        MOVE.W  D0,$001A(A1)                    ; $002D14
        MOVE.W  D0,$011E(A2)                    ; $002D18
        MOVE.W  $003A(A0),D0                    ; $002D1C
        ASR.W  #3,D0                            ; $002D20
        MOVE.W  D0,D1                           ; $002D22
        ADD.W  (-16184).W,D0                    ; $002D24
        ADD.W  (-16210).W,D0                    ; $002D28
        MOVE.W  D0,$0008(A1)                    ; $002D2C
        MOVE.W  $0044(A0),D0                    ; $002D30
        ASR.W  #3,D0                            ; $002D34
        DC.W    $D041                           ; $002D36
        NEG.W  D0                               ; $002D38
        MOVE.W  D0,$001C(A1)                    ; $002D3A
        MOVE.W  D0,$0120(A2)                    ; $002D3E
        MOVE.W  $003C(A0),D0                    ; $002D42
        ADD.W  $0096(A0),D0                     ; $002D46
        ASR.W  #3,D0                            ; $002D4A
        MOVE.W  D0,D1                           ; $002D4C
        ADD.W  (-16182).W,D0                    ; $002D4E
        ADD.W  (-16208).W,D0                    ; $002D52
        NEG.W  D0                               ; $002D56
        MOVE.W  D0,$000A(A1)                    ; $002D58
        MOVE.W  $0046(A0),D0                    ; $002D5C
        ASR.W  #3,D0                            ; $002D60
        DC.W    $9240                           ; $002D62
        MOVE.W  D1,$001E(A1)                    ; $002D64
        MOVE.W  D1,$0122(A2)                    ; $002D68
        MOVE.W  $003E(A0),D0                    ; $002D6C
        ASR.W  #3,D0                            ; $002D70
        MOVE.W  D0,D1                           ; $002D72
        ADD.W  (-16180).W,D0                    ; $002D74
        ADD.W  (-16206).W,D0                    ; $002D78
        MOVE.W  D0,$000C(A1)                    ; $002D7C
        MOVE.W  $004A(A0),D0                    ; $002D80
        ADD.W  $004C(A0),D0                     ; $002D84
        ASR.W  #5,D0                            ; $002D88
        DC.W    $9041                           ; $002D8A
        MOVE.W  D0,$0020(A1)                    ; $002D8C
        MOVE.W  D0,$0124(A2)                    ; $002D90
        MOVE.W  $0090(A0),D0                    ; $002D94
        ASR.W  #3,D0                            ; $002D98
        MOVE.W  D0,$0032(A1)                    ; $002D9A
        MOVE.W  D0,$0046(A1)                    ; $002D9E
        MOVE.W  D0,$0136(A2)                    ; $002DA2
        MOVE.W  D0,$014A(A2)                    ; $002DA6
        MOVE.W  $00BC(A0),D0                    ; $002DAA
        ASR.W  #3,D0                            ; $002DAE
        MOVE.W  D0,$0030(A1)                    ; $002DB0
        MOVE.W  D0,$0044(A1)                    ; $002DB4
        MOVE.W  D0,$0058(A1)                    ; $002DB8
        MOVE.W  D0,$0134(A2)                    ; $002DBC
        MOVE.W  D0,$0148(A2)                    ; $002DC0
        MOVE.W  D0,$015C(A2)                    ; $002DC4
        RTS                                     ; $002DC8
