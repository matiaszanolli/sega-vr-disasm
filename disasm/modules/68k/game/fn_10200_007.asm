; ============================================================================
; Sh2 Comm 007 (auto-analyzed)
; ROM Range: $011A70-$011B08 (152 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: COMM0, COMM4, COMM6, COMM5
;   Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, A0, A1, A2, A3
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_10200_007:
        NEG.B  D0                               ; $011A70
        NEG.L  -(A3)                            ; $011A72
        DC.W    $4946                           ; $011A74
        LEA     $4400(A1),A6                    ; $011A76
        NEG.L  -(A3)                            ; $011A7A
        DC.W    $4946                           ; $011A7C
        LEA     $0000(A1),A6                    ; $011A7E
        ORI.B  #$11,D0                          ; $011A82
        ORI.B  #$05,D3                          ; $011A86
        ORI.B  #$06,(A1)                        ; $011A8A
        DC.W    $000A                           ; $011A8E
        ORI.B  #$08,(A2)                        ; $011A90
        DC.W    $000F                           ; $011A94
        DC.W    $0013                           ; $011A96
.loc_0028:
        TST.B  $00A15120                        ; $011A98
        BNE.S  .loc_0028                        ; $011A9E
        MOVE.L  A1,$00A15128                    ; $011AA0
        MOVE.B  #$01,$00A1512C                  ; $011AA6
        MOVE.B  #$20,$00A15121                  ; $011AAE
        MOVE.B  #$01,$00A15120                  ; $011AB6
.loc_004E:
        TST.B  $00A1512C                        ; $011ABE
        BNE.S  .loc_004E                        ; $011AC4
        MOVE.W  D0,$00A15128                    ; $011AC6
        MOVE.W  D1,$00A1512A                    ; $011ACC
        MOVE.B  #$01,$00A1512C                  ; $011AD2
.loc_006A:
        TST.B  $00A1512C                        ; $011ADA
        BNE.S  .loc_006A                        ; $011AE0
        MOVE.W  D2,$00A15128                    ; $011AE2
        MOVE.B  #$01,$00A1512C                  ; $011AE8
.loc_0080:
        TST.B  $00A1512C                        ; $011AF0
        BNE.S  .loc_0080                        ; $011AF6
        MOVE.L  A0,$00A15128                    ; $011AF8
        MOVE.B  #$01,$00A1512C                  ; $011AFE
        RTS                                     ; $011B06
