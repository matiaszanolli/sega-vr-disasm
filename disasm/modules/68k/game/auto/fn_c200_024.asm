; ============================================================================
; Scene Dispatch 024 (auto-analyzed)
; ROM Range: $00D7B2-$00D8B8 (262 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Object (A4): +$88
;
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D4, D5, D6, A0, A1, A2
; RAM:
;   $C87E: game_state
; Object fields:
;   +$88: [unknown]
; Confidence: medium
; ============================================================================

fn_c200_024:
        NEG.B  D0                               ; $00D7B2
        NEG.L  -(A3)                            ; $00D7B4
        DC.W    $4946                           ; $00D7B6
        LEA     $1C00(A1),A6                    ; $00D7B8
        MOVE.L  -(A3),(A4)                      ; $00D7BC
        MOVE.W  D6,$41E9(A2)                    ; $00D7BE
        DC.W    $7FFF                           ; $00D7C2
        DC.W    $7FFF                           ; $00D7C4
        DC.W    $7FFF                           ; $00D7C6
        DC.W    $7FFF                           ; $00D7C8
        MOVE.B  D0,D6                           ; $00D7CA
        MOVE.L  -(A3),(A4)                      ; $00D7CC
        MOVE.W  D6,$41E9(A2)                    ; $00D7CE
        NEG.B  D0                               ; $00D7D2
        NEG.L  -(A3)                            ; $00D7D4
        DC.W    $4946                           ; $00D7D6
        LEA     $7FFF(A1),A6                    ; $00D7D8
        DC.W    $63F5                           ; $00D7DC
        DC.W    $7FFF                           ; $00D7DE
        DC.W    $7FFF                           ; $00D7E0
        DC.W    $0010                           ; $00D7E2
        MOVE.B  $294E(A7),(A2)                  ; $00D7E4
        DC.W    $3DED                           ; $00D7E8
        DC.W    $7FFF                           ; $00D7EA
        DC.W    $7FFF                           ; $00D7EC
.loc_003C:
        DC.W    $7FFF                           ; $00D7EE
        DC.W    $7FFF                           ; $00D7F0
        DC.W    $6337                           ; $00D7F2
        DC.W    $6737                           ; $00D7F4
        BMI.S  $00D850                          ; $00D7F6
        DC.W    $6F79                           ; $00D7F8
        BMI.S  .loc_0080                        ; $00D7FA
        DC.W    $6B37                           ; $00D7FC
        BLE.S  .loc_00A6                        ; $00D7FE
        DC.W    $6F79                           ; $00D800
        DC.W    $739A                           ; $00D802
        BSR.S  .loc_003C                        ; $00D804
        DC.W    $7FFF                           ; $00D806
        DC.W    $1D4A                           ; $00D808
        DC.W    $4B3A                           ; $00D80A
        DC.W    $67FF                           ; $00D80C
        DC.W    $3AB6                           ; $00D80E
        DC.W    $25CE                           ; $00D810
        MOVE.B  -(A1),(A0)+                     ; $00D812
        DC.W    $29A8                           ; $00D814
        DC.W    $4670                           ; $00D816
        DC.W    $6337                           ; $00D818
.loc_0068:
        NEG.W  D5                               ; $00D81A
        SUBQ.B  #8,$6212(A3)                    ; $00D81C
        BGT.S  .loc_0068                        ; $00D820
        DC.W    $7FFF                           ; $00D822
        BTST    D1,(A7)+                        ; $00D824
        DC.W    $7FFF                           ; $00D826
        DC.W    $0000                           ; $00D828
        DC.W    $033E                           ; $00D82A
        DC.W    $63FF                           ; $00D82C
        BCLR    D0,$0086(A7)                    ; $00D82E
.loc_0080:
        ORI.B  #$70,D0                          ; $00D832
        BTST    D0,(A0)                         ; $00D836
        BTST    D1,D0                           ; $00D838
        ORI.B  #$00,D0                          ; $00D83A
        BTST    D0,(A0)                         ; $00D83E
        DC.W    $0130                           ; $00D840
        DC.W    $02C0                           ; $00D842
        ORI.B  #$00,D0                          ; $00D844
        BTST    D0,-(A0)                        ; $00D848
        DC.W    $0170                           ; $00D84A
        DC.W    $02C0                           ; $00D84C
        ORI.B  #$00,D0                          ; $00D84E
        DC.W    $0000                           ; $00D852
        BCHG    D0,(A0)                         ; $00D854
        DC.W    $02C0                           ; $00D856
.loc_00A6:
        ORI.B  #$00,D0                          ; $00D858
        DC.W    $0000                           ; $00D85C
        BCLR    D0,D0                           ; $00D85E
        DC.W    $02C0                           ; $00D860
        DC.W    $0000                           ; $00D862
        JSR     $00882080                       ; $00D864
        MOVE.W  (-14210).W,D0                   ; $00D86A
        MOVEA.L $00D874(PC,D0.W),A1             ; $00D86E
        JMP     (A1)                            ; $00D872
        DC.W    $0088                           ; $00D874
        ADDA.W  A4,A4                           ; $00D876
        DC.W    $0088                           ; $00D878
        ADDA.W  D0,A5                           ; $00D87A
        DC.W    $0088                           ; $00D87C
        ADDA.W  (A0),A6                         ; $00D87E
        DC.W    $0088                           ; $00D880
        ADDA.L  $0088(A4),A7                    ; $00D882
        LSR.B  #8,D4                            ; $00D886
        JSR     $00882080                       ; $00D888
        MOVE.W  (-14210).W,D0                   ; $00D88E
        MOVEA.L $00D898(PC,D0.W),A1             ; $00D892
        JMP     (A1)                            ; $00D896
        DC.W    $0088                           ; $00D898
        ADDA.W  A4,A4                           ; $00D89A
        DC.W    $0088                           ; $00D89C
        ADDA.W  D0,A5                           ; $00D89E
        DC.W    $0088                           ; $00D8A0
        ADDA.W  A6,A7                           ; $00D8A2
        DC.W    $0088                           ; $00D8A4
        ADDA.L  $0088(A4),A7                    ; $00D8A6
        LSR.B  #8,D4                            ; $00D8AA
        MOVE.B  #$81,(-14171).W                 ; $00D8AC
        ADDQ.W  #4,(-14210).W                   ; $00D8B2
        RTS                                     ; $00D8B6
