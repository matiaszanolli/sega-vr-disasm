; ============================================================================
; Vint Obj Table 3 063 (auto-analyzed)
; ROM Range: $003B28-$003C1A (242 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $9F00 (obj_table_3), $C8A0 (race_state), $C89C (sh2_comm_state)
;   Object (A0, A1, A2): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 (speed), +$0A (param_a), +$0E (param_e)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D7, A0
; RAM:
;   $9F00: obj_table_3
;   $C89C: sh2_comm_state
;   $C8A0: race_state
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$06: speed
;   +$0A: param_a
;   +$0E: param_e
;   +$10: [unknown]
;   +$30: x_position
; Confidence: medium
; ============================================================================

fn_2200_063:
        LEA     (-24832).W,A0                   ; $003B28
        MOVE.W  (-14176).W,D1                   ; $003B2C
        LEA     $00895A64,A1                    ; $003B30
        MOVEA.L $00(A1,D1.W),A1                 ; $003B36
        LEA     $00FF663C,A2                    ; $003B3A
        MOVE.W  #$0C80,D1                       ; $003B40
        MOVEQ   #$02,D7                         ; $003B44
.loc_001E:
        MOVE.W  $0030(A0),D2                    ; $003B46
        MOVE.W  $0034(A0),D4                    ; $003B4A
        SUB.W  (A1),D2                          ; $003B4E
        BPL.S  .loc_002C                        ; $003B50
        NEG.W  D2                               ; $003B52
.loc_002C:
        CMP.W  D1,D2                            ; $003B54
        BGT.S  .loc_0076                        ; $003B56
        SUB.W  $0004(A1),D4                     ; $003B58
        BPL.S  .loc_0038                        ; $003B5C
        NEG.W  D4                               ; $003B5E
.loc_0038:
        CMP.W  D1,D4                            ; $003B60
        BGT.S  .loc_0076                        ; $003B62
        MOVE.W  #$0001,$0000(A2)                ; $003B64
        MOVE.L  (A1)+,$0002(A2)                 ; $003B6A
        MOVE.W  (A1)+,$0006(A2)                 ; $003B6E
        MOVE.W  (A1)+,$000A(A2)                 ; $003B72
        MOVE.W  (A1)+,$000E(A2)                 ; $003B76
        MOVEA.L (A1),A1                         ; $003B7A
        MOVE.W  (-16376).W,D0                   ; $003B7C
        ADDQ.W  #1,D0                           ; $003B80
        CMPI.W  #$000C,D0                       ; $003B82
        BNE.S  .loc_0064                        ; $003B86
        MOVE.W  #$0000,D0                       ; $003B88
.loc_0064:
        MOVE.W  D0,(-16376).W                   ; $003B8C
        LSR.W  #1,D0                            ; $003B90
        DC.W    $D040                           ; $003B92
        DC.W    $D040                           ; $003B94
        MOVE.L  $00(A1,D0.W),$0010(A2)          ; $003B96
        BRA.S  .loc_0084                        ; $003B9C
.loc_0076:
        LEA     $000E(A1),A1                    ; $003B9E
        DBRA    D7,.loc_001E                    ; $003BA2
        MOVE.W  #$0000,$0000(A2)                ; $003BA6
.loc_0084:
        MOVE.W  (-14180).W,D1                   ; $003BAC
        CMPI.W  #$0001,D1                       ; $003BB0
        DC.W    $6672               ; BNE.S  $003C28; $003BB4
        LEA     $00883A4E,A1                    ; $003BB6
        LEA     $00FF6650,A2                    ; $003BBC
        MOVE.W  #$0C80,D1                       ; $003BC2
        MOVE.W  #$0300,D3                       ; $003BC6
        MOVEQ   #$03,D7                         ; $003BCA
        MOVE.W  $0030(A0),D2                    ; $003BCC
        MOVE.W  $0034(A0),D4                    ; $003BD0
        MOVE.W  $0032(A0),D5                    ; $003BD4
        SUB.W  (A1),D2                          ; $003BD8
        BPL.S  .loc_00B6                        ; $003BDA
        NEG.W  D2                               ; $003BDC
.loc_00B6:
        CMP.W  D1,D2                            ; $003BDE
        DC.W    $6E38               ; BGT.S  $003C1A; $003BE0
        SUB.W  $0002(A1),D5                     ; $003BE2
        BPL.S  .loc_00C2                        ; $003BE6
        NEG.W  D5                               ; $003BE8
.loc_00C2:
        CMP.W  D3,D5                            ; $003BEA
        DC.W    $6E2C               ; BGT.S  $003C1A; $003BEC
        SUB.W  $0004(A1),D4                     ; $003BEE
        BPL.S  .loc_00CE                        ; $003BF2
        NEG.W  D4                               ; $003BF4
.loc_00CE:
        CMP.W  D1,D4                            ; $003BF6
        DC.W    $6E20               ; BGT.S  $003C1A; $003BF8
        MOVE.W  #$0001,$0000(A2)                ; $003BFA
        MOVE.L  (A1)+,$0002(A2)                 ; $003C00
        MOVE.W  (A1)+,$0006(A2)                 ; $003C04
        MOVE.W  (A1)+,$000A(A2)                 ; $003C08
        MOVE.W  (A1),$000E(A2)                  ; $003C0C
        MOVE.L  #$22295A24,$0010(A2)            ; $003C10
        RTS                                     ; $003C18
