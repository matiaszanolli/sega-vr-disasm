; ============================================================================
; Name Entry Dispatch 039 (auto-analyzed)
; ROM Range: $011F38-$012084 (332 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Calls: object_update
;
; Uses: D0, D1, D3, D4, D5, D6, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
; Confidence: high
; ============================================================================

fn_10200_039:
        DC.W    $0000                           ; $011F38
        DC.W    $0421                           ; $011F3A
        DC.W    $0842                           ; $011F3C
        CMPI.W  #$1084,-(A3)                    ; $011F3E
        MOVE.B  -(A5),(A2)                      ; $011F42
        MOVE.B  D6,(A4)+                        ; $011F44
        MOVE.B  -(A7),(A6)+                     ; $011F46
        MOVE.L  A0,-(A0)                        ; $011F48
        MOVE.L  $7FFF(A1),-(A2)                 ; $011F4A
        DC.W    $7FFF                           ; $011F4E
        DC.W    $318C                           ; $011F50
        DC.W    $7FFF                           ; $011F52
        DC.W    $39CE                           ; $011F54
        DC.W    $3DEF                           ; $011F56
        DC.W    $7FFF                           ; $011F58
        DC.W    $7FFF                           ; $011F5A
        DC.W    $7FFF                           ; $011F5C
        DC.W    $7FFF                           ; $011F5E
        ADDQ.L  #1,(A4)                         ; $011F60
        DC.W    $56B5                           ; $011F62
        DC.W    $7FFF                           ; $011F64
        DC.W    $5EF7                           ; $011F66
        BLS.S  .loc_004A                        ; $011F68
        DC.W    $7FFF                           ; $011F6A
        BMI.S  .loc_0090                        ; $011F6C
        DC.W    $6F7B                           ; $011F6E
        DC.W    $7FFF                           ; $011F70
        DC.W    $7FFF                           ; $011F72
        DC.W    $7BDE                           ; $011F74
        DC.W    $7FFF                           ; $011F76
        DC.W    $7FFF                           ; $011F78
        DC.W    $7FFF                           ; $011F7A
        DC.W    $7FFF                           ; $011F7C
        DC.W    $7FFF                           ; $011F7E
        DC.W    $7FFF                           ; $011F80
.loc_004A:
        DC.W    $7FFF                           ; $011F82
        DC.W    $7FFF                           ; $011F84
        DC.W    $7FFF                           ; $011F86
        DC.W    $7FFF                           ; $011F88
        DC.W    $7FFF                           ; $011F8A
        DC.W    $7FFF                           ; $011F8C
        DC.W    $7FFF                           ; $011F8E
        DC.W    $7FFF                           ; $011F90
.loc_005A:
        DC.W    $7FFF                           ; $011F92
        DC.W    $7FFF                           ; $011F94
        DC.W    $6337                           ; $011F96
        DC.W    $6737                           ; $011F98
        BMI.S  $011FF4                          ; $011F9A
        DC.W    $6F79                           ; $011F9C
.loc_0066:
        NEG.W  D5                               ; $011F9E
        SUBQ.B  #8,$6212(A3)                    ; $011FA0
        BGT.S  .loc_0066                        ; $011FA4
        DC.W    $739A                           ; $011FA6
        BSR.S  .loc_005A                        ; $011FA8
        DC.W    $7FFF                           ; $011FAA
        DC.W    $7FFF                           ; $011FAC
        DC.W    $7FFF                           ; $011FAE
        DC.W    $7FFF                           ; $011FB0
        DC.W    $7FFF                           ; $011FB2
        DC.W    $7FFF                           ; $011FB4
        DC.W    $7FFF                           ; $011FB6
        MOVEQ   #$00,D0                         ; $011FB8
        MOVEQ   #-$60,D6                        ; $011FBA
        MOVEQ   #-$19,D0                        ; $011FBC
        DC.W    $7FFF                           ; $011FBE
        ADDQ.B  #4,D0                           ; $011FC0
        BCLR    D0,D0                           ; $011FC2
        ANDI.B  #$0E,D0                         ; $011FC4
.loc_0090:
        DC.W    $0014                           ; $011FC8
        DC.W    $1CFB                           ; $011FCA
        DC.W    $7FFF                           ; $011FCC
        DC.W    $7FFF                           ; $011FCE
        DC.W    $7FFF                           ; $011FD0
        DC.W    $7FFF                           ; $011FD2
        DC.W    $7FFF                           ; $011FD4
        NEG.B  D0                               ; $011FD6
        NEG.L  -(A3)                            ; $011FD8
        DC.W    $4946                           ; $011FDA
        LEA     $1C00(A1),A6                    ; $011FDC
        MOVE.L  -(A3),(A4)                      ; $011FE0
        MOVE.W  D6,$41E9(A2)                    ; $011FE2
        SUBQ.W  #4,D0                           ; $011FE6
        SUBQ.L  #4,D3                           ; $011FE8
        SCS     -(A6)                           ; $011FEA
        ADDQ.B  #3,$1C00(A1)                    ; $011FEC
        MOVE.L  -(A3),(A4)                      ; $011FF0
        MOVE.W  D6,$41E9(A2)                    ; $011FF2
        NEG.B  D0                               ; $011FF6
        NEG.L  -(A3)                            ; $011FF8
        DC.W    $4946                           ; $011FFA
        LEA     $7FFF(A1),A6                    ; $011FFC
        DC.W    $63F5                           ; $012000
        DC.W    $7FFF                           ; $012002
        DC.W    $7FFF                           ; $012004
        DC.W    $0010                           ; $012006
        DC.W    $7FFF                           ; $012008
        MOVE.L  A6,$7FFF(A4)                    ; $01200A
        DC.W    $0000                           ; $01200E
        RTE                                     ; $012010
.loc_00DA:
        DC.W    $6739                           ; $012012
        DC.W    $7FFF                           ; $012014
        DC.W    $6337                           ; $012016
        DC.W    $6737                           ; $012018
        BMI.S  $012074                          ; $01201A
        DC.W    $6F79               ; DC.W    $6F79; $01201C
        BMI.S  .loc_011E                        ; $01201E
        DC.W    $6B37                           ; $012020
        BLE.S  .loc_0144                        ; $012022
        DC.W    $6F79               ; DC.W    $6F79; $012024
        DC.W    $739A                           ; $012026
        BSR.S  .loc_00DA                        ; $012028
        DC.W    $7FFF                           ; $01202A
        DC.W    $7FFF                           ; $01202C
        DC.W    $7FFF                           ; $01202E
        DC.W    $7FFF                           ; $012030
        DC.W    $7FFF                           ; $012032
        DC.W    $7FFF                           ; $012034
        MOVE.B  -(A1),(A0)+                     ; $012036
        DC.W    $29A8                           ; $012038
        DC.W    $4670                           ; $01203A
        DC.W    $6337                           ; $01203C
.loc_0106:
        NEG.W  D5                               ; $01203E
        SUBQ.B  #8,$6212(A3)                    ; $012040
        BGT.S  .loc_0106                        ; $012044
        DC.W    $7FFF                           ; $012046
        BTST    D1,(A7)+                        ; $012048
        DC.W    $7FFF                           ; $01204A
        DC.W    $7FFF                           ; $01204C
        DC.W    $7FFF                           ; $01204E
        DC.W    $7FFF                           ; $012050
        DC.W    $7FFF                           ; $012052
        DC.W    $7FFF                           ; $012054
.loc_011E:
        JSR     $00882080                       ; $012056
        MOVE.W  (-14210).W,D0                   ; $01205C
        MOVEA.L $012066(PC,D0.W),A1             ; $012060
        JMP     (A1)                            ; $012064
        DC.W    $0089                           ; $012066
        MOVE.L  D4,(A0)                         ; $012068
        DC.W    $0089                           ; $01206A
        MOVE.L  -(A4),D1                        ; $01206C
        DC.W    $0089                           ; $01206E
        MOVE.L  A4,-(A2)                        ; $012070
        DC.W    $4EBA,$9610         ; JSR     $00B684(PC); $012072
        BTST    #6,(-14322).W                   ; $012076
.loc_0144:
        BNE.S  .loc_014A                        ; $01207C
        ADDQ.W  #4,(-14210).W                   ; $01207E
.loc_014A:
        RTS                                     ; $012082
