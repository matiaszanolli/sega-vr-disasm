; ============================================================================
; Camera Dispatch 036 (auto-analyzed)
; ROM Range: $013A88-$013C30 (424 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Object (A0): +$77
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; RAM:
;   $C87E: game_state
; Object fields:
;   +$77: [unknown]
; Confidence: medium
; ============================================================================

fn_12200_036:
        DC.W    $0000                           ; $013A88
        DC.W    $0421                           ; $013A8A
        DC.W    $0842                           ; $013A8C
        CMPI.W  #$1084,-(A3)                    ; $013A8E
        MOVE.B  -(A5),(A2)                      ; $013A92
        MOVE.B  D6,(A4)+                        ; $013A94
        MOVE.B  -(A7),(A6)+                     ; $013A96
        MOVE.L  A0,-(A0)                        ; $013A98
        MOVE.L  $294A(A1),-(A2)                 ; $013A9A
        MOVE.L  $318C(A3),$35AD(A6)             ; $013A9E
        DC.W    $39CE                           ; $013AA4
        DC.W    $3DEF                           ; $013AA6
        CLR.B  (A0)                             ; $013AA8
        DC.W    $4631                           ; $013AAA
        TST.W  (A2)                             ; $013AAC
        RTE                                     ; $013AAE
        DC.W    $7FFF                           ; $013AB0
        DC.W    $56B5                           ; $013AB2
        SPL     (A6)                            ; $013AB4
        DC.W    $5EF7                           ; $013AB6
        BLS.S  .loc_004A                        ; $013AB8
        DC.W    $6739                           ; $013ABA
.loc_0034:
        BMI.S  $013B18                          ; $013ABC
        DC.W    $7FFF                           ; $013ABE
        DC.W    $739C                           ; $013AC0
        DC.W    $77BD                           ; $013AC2
        DC.W    $7BDE                           ; $013AC4
        DC.W    $7FFF                           ; $013AC6
        MOVEQ   #$2C,D7                         ; $013AC8
        DC.W    $7F97                           ; $013ACA
        DC.W    $7F55                           ; $013ACC
        DC.W    $7F13                           ; $013ACE
        MOVEQ   #-$71,D7                        ; $013AD0
.loc_004A:
        DC.W    $7F75                           ; $013AD2
        DC.W    $7F76                           ; $013AD4
        MOVE.L  D3,(A4)                         ; $013AD6
        MOVEQ   #-$50,D7                        ; $013AD8
        MOVEQ   #-$0E,D7                        ; $013ADA
        DC.W    $7F34                           ; $013ADC
        CMPI.W  #$4926,D2                       ; $013ADE
        MOVE.L  -(A4),(A6)                      ; $013AE2
        MOVE.B  D3,(A2)                         ; $013AE4
        DC.W    $4506                           ; $013AE6
        MOVE.W  D4,(A2)+                        ; $013AE8
        DC.W    $7FFF                           ; $013AEA
        DC.W    $7FFF                           ; $013AEC
        BCS.S  .loc_0034                        ; $013AEE
        DC.W    $7FFF                           ; $013AF0
        DC.W    $7FFF                           ; $013AF2
        DC.W    $7FFF                           ; $013AF4
        DC.W    $7FFF                           ; $013AF6
        DC.W    $7FFF                           ; $013AF8
        DC.W    $7FFF                           ; $013AFA
        DC.W    $7FFF                           ; $013AFC
        DC.W    $7FFF                           ; $013AFE
        DC.W    $7FFF                           ; $013B00
        DC.W    $7FFF                           ; $013B02
        DC.W    $7FFF                           ; $013B04
        MOVE.B  -(A1),(A0)+                     ; $013B06
        MOVE.L  D3,$31A6(A0)                    ; $013B08
        DC.W    $4209                           ; $013B0C
        MOVE.B  D0,D6                           ; $013B0E
        MOVE.L  -(A3),(A4)                      ; $013B10
        MOVE.W  D6,$41E9(A2)                    ; $013B12
        BTST    #16,(A0)+                       ; $013B16
        DC.W    $084D                           ; $013B1A
        DC.W    $108A                           ; $013B1C
        DC.W    $7FFF                           ; $013B1E
        DC.W    $6F7B                           ; $013B20
        SPL     (A6)                            ; $013B22
        TST.W  (A2)                             ; $013B24
        DC.W    $7FFF                           ; $013B26
        DC.W    $7FFF                           ; $013B28
        DC.W    $7FFF                           ; $013B2A
        DC.W    $7FFF                           ; $013B2C
        DC.W    $7FFF                           ; $013B2E
        DC.W    $7FFF                           ; $013B30
        DC.W    $7FFF                           ; $013B32
        DC.W    $7FFF                           ; $013B34
        DC.W    $7FFF                           ; $013B36
        DC.W    $7FFF                           ; $013B38
.loc_00B2:
        DC.W    $7FFF                           ; $013B3A
        DC.W    $7FFF                           ; $013B3C
        DC.W    $0000                           ; $013B3E
        RTE                                     ; $013B40
        DC.W    $6739                           ; $013B42
        DC.W    $7FFF                           ; $013B44
        DC.W    $7FFF                           ; $013B46
        DC.W    $7FFF                           ; $013B48
        DC.W    $7FFF                           ; $013B4A
        DC.W    $7FFF                           ; $013B4C
        NEG.W  D5                               ; $013B4E
        MOVE    D6,CCR                          ; $013B50
        DC.W    $4968                           ; $013B52
        LEA     $7FFF(A2),A6                    ; $013B54
        DC.W    $63F5                           ; $013B58
        DC.W    $7FFF                           ; $013B5A
        DC.W    $7FFF                           ; $013B5C
        DC.W    $7FFF                           ; $013B5E
        DC.W    $7FFF                           ; $013B60
        DC.W    $7FFF                           ; $013B62
        DC.W    $7FFF                           ; $013B64
        DC.W    $7714                           ; $013B66
        DC.W    $6EF1                           ; $013B68
        BNE.S  .loc_00B2                        ; $013B6A
        ADDQ.L  #7,$7FFF(A3)                    ; $013B6C
        DC.W    $7FFF                           ; $013B70
        DC.W    $7FFF                           ; $013B72
        DC.W    $7FFF                           ; $013B74
        DC.W    $7FFF                           ; $013B76
        DC.W    $7FFF                           ; $013B78
        DC.W    $7FFF                           ; $013B7A
        DC.W    $7FFF                           ; $013B7C
        DC.W    $6337                           ; $013B7E
        SUBQ.B  #7,(A4)                         ; $013B80
        DC.W    $5AF0                           ; $013B82
        DC.W    $56CC,$10E1         ; DBNE    D4,$014C67; $013B84
        DC.W    $29A8                           ; $013B88
        DC.W    $4670                           ; $013B8A
        DC.W    $6337                           ; $013B8C
.loc_0106:
        NEG.W  D5                               ; $013B8E
        SUBQ.B  #8,$6212(A3)                    ; $013B90
        BGT.S  .loc_0106                        ; $013B94
        DC.W    $7FFF                           ; $013B96
        BTST    D1,(A7)+                        ; $013B98
        DC.W    $7FFF                           ; $013B9A
        DC.W    $7FFF                           ; $013B9C
        DC.W    $7FFF                           ; $013B9E
        DC.W    $7FFF                           ; $013BA0
        DC.W    $7FFF                           ; $013BA2
        DC.W    $7FFF                           ; $013BA4
        DC.W    $7FFF                           ; $013BA6
        DC.W    $7FFF                           ; $013BA8
        DC.W    $7FFF                           ; $013BAA
        DC.W    $7FFF                           ; $013BAC
        DC.W    $7FFF                           ; $013BAE
        DC.W    $7FFF                           ; $013BB0
        DC.W    $7FFF                           ; $013BB2
        DC.W    $7FFF                           ; $013BB4
        DC.W    $0000                           ; $013BB6
        DC.W    $021F                           ; $013BB8
        DC.W    $027F                           ; $013BBA
        DC.W    $06DF                           ; $013BBC
        MOVE.L  A0,-(A6)                        ; $013BBE
        DC.W    $49CD                           ; $013BC0
        ADDQ.W  #3,(A0)                         ; $013BC2
        DC.W    $66D1                           ; $013BC4
        JSR     $00882080                       ; $013BC6
        MOVE.W  (-14210).W,D0                   ; $013BCC
        MOVEA.L $013BD6(PC,D0.W),A1             ; $013BD0
        JMP     (A1)                            ; $013BD4
        DC.W    $0089                           ; $013BD6
        DC.W    $3BE6                           ; $013BD8
        DC.W    $0089                           ; $013BDA
        MOVE.W  -$77(A0,D0.W),D6                ; $013BDC
        DC.W    $3CBA,$0089         ; MOVE.W  $013C6B(PC),(A6); $013BE0
        DC.W    $3F80                           ; $013BE4
        CLR.W  D0                               ; $013BE6
        BTST    #0,(-14312).W                   ; $013BE8
        BEQ.S  .loc_016C                        ; $013BEE
        MOVE.W  #$0001,D0                       ; $013BF0
.loc_016C:
        MOVE.W  #$00FF,D3                       ; $013BF4
        LEA     (-366).W,A0                     ; $013BF8
        LEA     (-382).W,A1                     ; $013BFC
        LEA     (-364).W,A2                     ; $013C00
        DC.W    $6100,$03DA         ; BSR.W  $013FE0; $013C04
        CLR.W  D0                               ; $013C08
        BTST    #1,(-14312).W                   ; $013C0A
        BEQ.S  .loc_018E                        ; $013C10
        MOVE.W  #$0001,D0                       ; $013C12
.loc_018E:
        MOVE.W  #$00FF,D3                       ; $013C16
        LEA     (-365).W,A0                     ; $013C1A
        LEA     (-374).W,A1                     ; $013C1E
        LEA     (-356).W,A2                     ; $013C22
        DC.W    $6100,$03B8         ; BSR.W  $013FE0; $013C26
        ADDQ.W  #4,(-14210).W                   ; $013C2A
        RTS                                     ; $013C2E
