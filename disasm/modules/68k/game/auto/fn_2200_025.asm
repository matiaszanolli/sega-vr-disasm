; ============================================================================
; Vint Physics 025 (auto-analyzed)
; ROM Range: $002ADE-$002BB0 (210 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$04 (speed_index/velocity), +$06 (speed), +$08, +$0A (param_a), +$0C, +$16 (calc_speed)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, A0, A1
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

fn_2200_025:
        MOVE.L  (-14556).W,$0024(A1)            ; $002ADE
        TST.W  $008A(A0)                        ; $002AE4
        BEQ.S  .loc_0012                        ; $002AE8
        MOVE.L  (-14512).W,$0024(A1)            ; $002AEA
.loc_0012:
        MOVE.W  $0030(A0),D0                    ; $002AF0
        MOVE.W  D0,$0016(A1)                    ; $002AF4
        MOVE.W  (-16300).W,$0004(A1)            ; $002AF8
        MOVE.W  $009C(A0),D0                    ; $002AFE
        ASL.W  #4,D0                            ; $002B02
        ADD.W  $0032(A0),D0                     ; $002B04
        ADD.W  (-16156).W,D0                    ; $002B08
        MOVE.W  D0,$0018(A1)                    ; $002B0C
        MOVE.W  (-16298).W,$0006(A1)            ; $002B10
        MOVE.W  $0034(A0),D0                    ; $002B16
        MOVE.W  D0,$001A(A1)                    ; $002B1A
        MOVE.W  $003A(A0),D0                    ; $002B1E
        ASR.W  #3,D0                            ; $002B22
        MOVE.W  D0,D1                           ; $002B24
        ADD.W  (-16184).W,D0                    ; $002B26
        MOVE.W  D0,$0008(A1)                    ; $002B2A
        NEG.W  D1                               ; $002B2E
        MOVE.W  D1,$001C(A1)                    ; $002B30
        MOVE.W  $003C(A0),D0                    ; $002B34
        ADD.W  $0096(A0),D0                     ; $002B38
        SUB.W  $0046(A0),D0                     ; $002B3C
        ASR.W  #3,D0                            ; $002B40
        MOVE.W  D0,D1                           ; $002B42
        ADD.W  (-16182).W,D0                    ; $002B44
        NEG.W  D0                               ; $002B48
        MOVE.W  D0,$000A(A1)                    ; $002B4A
        MOVE.W  D1,$001E(A1)                    ; $002B4E
        MOVE.W  $003E(A0),D0                    ; $002B52
        ASR.W  #3,D0                            ; $002B56
        MOVE.W  D0,D1                           ; $002B58
        ADD.W  (-16180).W,D0                    ; $002B5A
        MOVE.W  D0,$000C(A1)                    ; $002B5E
        MOVE.W  $004C(A0),D0                    ; $002B62
        ASR.W  #4,D0                            ; $002B66
        DC.W    $9041                           ; $002B68
        MOVE.W  D0,$0020(A1)                    ; $002B6A
        MOVE.W  $0090(A0),D0                    ; $002B6E
        ASR.W  #3,D0                            ; $002B72
        MOVE.W  D0,$0032(A1)                    ; $002B74
        MOVE.W  D0,$0046(A1)                    ; $002B78
        MOVE.W  $00BC(A0),D0                    ; $002B7C
        ASR.W  #3,D0                            ; $002B80
        MOVE.W  D0,$0030(A1)                    ; $002B82
        MOVE.W  D0,$0044(A1)                    ; $002B86
        MOVE.W  (-16248).W,D1                   ; $002B8A
        MOVE.W  $008E(A0),D0                    ; $002B8E
        EXT.L   D1                              ; $002B92
        EXT.L   D0                              ; $002B94
        DC.W    $D081                           ; $002B96
        ASR.L  #1,D0                            ; $002B98
        MOVE.W  D0,(-16248).W                   ; $002B9A
        NEG.W  D0                               ; $002B9E
        MOVE.W  D0,D1                           ; $002BA0
        ASR.W  #7,D1                            ; $002BA2
        ASR.W  #6,D0                            ; $002BA4
        DC.W    $D041                           ; $002BA6
        ASL.W  #1,D0                            ; $002BA8
        MOVE.W  D0,$0070(A1)                    ; $002BAA
        RTS                                     ; $002BAE
