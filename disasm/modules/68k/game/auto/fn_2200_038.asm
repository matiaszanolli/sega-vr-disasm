; ============================================================================
; Vint Physics 038 (auto-analyzed)
; ROM Range: $002F04-$003010 (268 bytes)
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

fn_2200_038:
        MOVE.W  $0030(A0),D0                    ; $002F04
        MOVE.W  D0,$0016(A1)                    ; $002F08
        MOVE.W  D0,$011A(A2)                    ; $002F0C
        MOVE.W  (-16300).W,$0004(A1)            ; $002F10
        MOVE.W  $009C(A0),D0                    ; $002F16
        ASL.W  #4,D0                            ; $002F1A
        ADD.W  $0032(A0),D0                     ; $002F1C
        ADD.W  (-16156).W,D0                    ; $002F20
        MOVE.W  D0,$0018(A1)                    ; $002F24
        MOVE.W  D0,$011C(A2)                    ; $002F28
        MOVE.W  (-16298).W,$0006(A1)            ; $002F2C
        MOVE.W  $0034(A0),D0                    ; $002F32
        MOVE.W  D0,$001A(A1)                    ; $002F36
        MOVE.W  D0,$011E(A2)                    ; $002F3A
        MOVE.W  $003A(A0),D0                    ; $002F3E
        ASR.W  #3,D0                            ; $002F42
        MOVE.W  D0,D1                           ; $002F44
        ADD.W  (-16184).W,D0                    ; $002F46
        ADD.W  (-16210).W,D0                    ; $002F4A
        MOVE.W  D0,$0008(A1)                    ; $002F4E
        NEG.W  D1                               ; $002F52
        MOVE.W  D1,$001C(A1)                    ; $002F54
        MOVE.W  D1,$0120(A2)                    ; $002F58
        MOVE.W  $003C(A0),D0                    ; $002F5C
        ADD.W  $0096(A0),D0                     ; $002F60
        SUB.W  $0046(A0),D0                     ; $002F64
        ASR.W  #3,D0                            ; $002F68
        MOVE.W  D0,D1                           ; $002F6A
        ADD.W  (-16182).W,D0                    ; $002F6C
        ADD.W  (-16208).W,D0                    ; $002F70
        NEG.W  D0                               ; $002F74
        MOVE.W  D0,$000A(A1)                    ; $002F76
        MOVE.W  D1,$001E(A1)                    ; $002F7A
        MOVE.W  $0046(A0),D0                    ; $002F7E
        ASR.W  #3,D0                            ; $002F82
        DC.W    $9240                           ; $002F84
        MOVE.W  D1,$0122(A2)                    ; $002F86
        MOVE.W  $003E(A0),D0                    ; $002F8A
        ASR.W  #3,D0                            ; $002F8E
        MOVE.W  D0,D1                           ; $002F90
        ADD.W  (-16180).W,D0                    ; $002F92
        ADD.W  (-16206).W,D0                    ; $002F96
        MOVE.W  D0,$000C(A1)                    ; $002F9A
        MOVE.W  $004C(A0),D0                    ; $002F9E
        ASR.W  #4,D0                            ; $002FA2
        DC.W    $9041                           ; $002FA4
        MOVE.W  D0,$0020(A1)                    ; $002FA6
        MOVE.W  $004A(A0),D0                    ; $002FAA
        ADD.W  $004C(A0),D0                     ; $002FAE
        ASR.W  #5,D0                            ; $002FB2
        DC.W    $9041                           ; $002FB4
        MOVE.W  D0,$0124(A2)                    ; $002FB6
        MOVE.W  $0090(A0),D0                    ; $002FBA
        ASR.W  #3,D0                            ; $002FBE
        MOVE.W  D0,$0032(A1)                    ; $002FC0
        MOVE.W  D0,$0046(A1)                    ; $002FC4
        MOVE.W  D0,$0136(A2)                    ; $002FC8
        MOVE.W  D0,$014A(A2)                    ; $002FCC
        MOVE.W  $00BC(A0),D0                    ; $002FD0
        ASR.W  #3,D0                            ; $002FD4
        MOVE.W  D0,$0030(A1)                    ; $002FD6
        MOVE.W  D0,$0044(A1)                    ; $002FDA
        MOVE.W  D0,$0134(A2)                    ; $002FDE
        MOVE.W  D0,$0148(A2)                    ; $002FE2
        MOVE.W  D0,$015C(A2)                    ; $002FE6
        MOVE.W  (-16248).W,D1                   ; $002FEA
        MOVE.W  $008E(A0),D0                    ; $002FEE
        EXT.L   D1                              ; $002FF2
        EXT.L   D0                              ; $002FF4
        DC.W    $D081                           ; $002FF6
        ASR.L  #1,D0                            ; $002FF8
        MOVE.W  D0,(-16248).W                   ; $002FFA
        NEG.W  D0                               ; $002FFE
        MOVE.W  D0,D1                           ; $003000
        ASR.W  #7,D1                            ; $003002
        ASR.W  #6,D0                            ; $003004
        DC.W    $D041                           ; $003006
        ASL.W  #1,D0                            ; $003008
        MOVE.W  D0,$0070(A1)                    ; $00300A
        RTS                                     ; $00300E
