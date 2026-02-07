; ============================================================================
; Vint Position 062 (auto-analyzed)
; ROM Range: $003AB2-$003B28 (118 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1, A2): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 (speed), +$0A (param_a), +$0C
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, A0, A1
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$06: speed
;   +$0A: param_a
;   +$0C: [unknown]
;   +$0E: param_e
;   +$10: [unknown]
; Confidence: low
; ============================================================================

fn_2200_062:
        LEA     $00883A9C,A1                    ; $003AB2
        LEA     $00FF65B0,A2                    ; $003AB8
        ADDI.W  #$003C,(-14110).W               ; $003ABE
        MOVE.W  #$0C80,D1                       ; $003AC4
        MOVE.W  #$1400,D3                       ; $003AC8
        MOVE.W  #$0000,$0000(A2)                ; $003ACC
        MOVE.W  (-14110).W,D0                   ; $003AD2
        ANDI.W  #$1FFF,D0                       ; $003AD6
        MOVE.W  D0,$000A(A2)                    ; $003ADA
        MOVE.W  $0030(A0),D2                    ; $003ADE
        MOVE.W  $0034(A0),D4                    ; $003AE2
        MOVE.W  $0032(A0),D5                    ; $003AE6
        SUB.W  (A1),D2                          ; $003AEA
        BPL.S  .loc_003E                        ; $003AEC
        NEG.W  D2                               ; $003AEE
.loc_003E:
        CMP.W  D1,D2                            ; $003AF0
        BGT.S  .loc_0074                        ; $003AF2
        SUB.W  $0002(A1),D5                     ; $003AF4
        BPL.S  .loc_004A                        ; $003AF8
        NEG.W  D5                               ; $003AFA
.loc_004A:
        CMP.W  D3,D5                            ; $003AFC
        BGT.S  .loc_0074                        ; $003AFE
        SUB.W  $0004(A1),D4                     ; $003B00
        BPL.S  .loc_0056                        ; $003B04
        NEG.W  D4                               ; $003B06
.loc_0056:
        CMP.W  D1,D4                            ; $003B08
        BGT.S  .loc_0074                        ; $003B0A
        MOVE.W  #$0001,$0000(A2)                ; $003B0C
        MOVE.L  (A1)+,$0002(A2)                 ; $003B12
        MOVE.W  (A1)+,$0006(A2)                 ; $003B16
        MOVE.W  (A1)+,$000C(A2)                 ; $003B1A
        MOVE.W  (A1)+,$000E(A2)                 ; $003B1E
        MOVE.L  (A1)+,$0010(A2)                 ; $003B22
.loc_0074:
        RTS                                     ; $003B26
