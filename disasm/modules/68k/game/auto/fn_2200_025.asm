; ============================================================================
; fn_2200_025 — Camera Parameter Calculation B
; ROM Range: $002ADE-$002BB0 (210 bytes)
; ============================================================================
; Computes camera view parameters from entity A0 ($FF9000), stores to
; camera buffer A1 ($FF6100). Reads positions/velocities, scales by
; ASR #3 (÷8), computes lateral/height/roll components relative to
; world reference points (RAM $C034-$C03E area). Includes angular
; velocity smoothing at end: averages $008E(A0) with stored value,
; applies non-linear scaling (ASR #7 + ASR #6 + shift).
;
; Entry: A0 = entity ($FF9000), A1 = camera buffer ($FF6100)
; Uses: D0, D1, A0, A1
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
        SUB.W   D1,D0                           ; $002B68
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
        ADD.L   D1,D0                           ; $002B96
        ASR.L  #1,D0                            ; $002B98
        MOVE.W  D0,(-16248).W                   ; $002B9A
        NEG.W  D0                               ; $002B9E
        MOVE.W  D0,D1                           ; $002BA0
        ASR.W  #7,D1                            ; $002BA2
        ASR.W  #6,D0                            ; $002BA4
        ADD.W   D1,D0                           ; $002BA6
        ASL.W  #1,D0                            ; $002BA8
        MOVE.W  D0,$0070(A1)                    ; $002BAA
        RTS                                     ; $002BAE
