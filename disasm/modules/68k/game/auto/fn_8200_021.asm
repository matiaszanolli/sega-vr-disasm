; ============================================================================
; State Dispatch 021 (auto-analyzed)
; ROM Range: $00896E-$008B28 (442 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8A0 (race_state)
;   Object (A0, A1): +$00, +$04 (speed_index/velocity), +$06 (speed), +$08, +$0A (param_a), +$0E (param_e)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; RAM:
;   $C8A0: race_state
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
;   +$06: speed
;   +$08: [unknown]
;   +$0A: param_a
;   +$0E: param_e
;   +$10: [unknown]
;   +$1C: [unknown]
; Confidence: high
; ============================================================================

fn_8200_021:
        MOVE.W  (-14112).W,D0                   ; $00896E
        DC.W    $D040                           ; $008972
        CMPI.W  #$0400,D0                       ; $008974
        BLE.S  .loc_0010                        ; $008978
        MOVE.W  #$0400,D0                       ; $00897A
.loc_0010:
        MOVE.W  D0,(-14112).W                   ; $00897E
        ADD.W  (-14120).W,D0                    ; $008982
        CMPI.W  #$7800,D0                       ; $008986
        BLE.S  .loc_0022                        ; $00898A
        MOVE.W  #$7800,D0                       ; $00898C
.loc_0022:
        MOVE.W  D0,(-14120).W                   ; $008990
        DC.W    $6000,$FF6A         ; BRA.W  $008900; $008994
        MOVE.W  (-14112).W,D0                   ; $008998
        DC.W    $D040                           ; $00899C
        CMPI.W  #$0400,D0                       ; $00899E
        BLE.S  .loc_003A                        ; $0089A2
        MOVE.W  #$0400,D0                       ; $0089A4
.loc_003A:
        MOVE.W  D0,(-14112).W                   ; $0089A8
        NEG.W  D0                               ; $0089AC
        ADD.W  (-14120).W,D0                    ; $0089AE
        CMPI.W  #$0500,D0                       ; $0089B2
        BGE.S  .loc_004E                        ; $0089B6
        MOVE.W  #$0500,D0                       ; $0089B8
.loc_004E:
        MOVE.W  D0,(-14120).W                   ; $0089BC
        DC.W    $6000,$FF3E         ; BRA.W  $008900; $0089C0
        BTST    #4,(-14227).W                   ; $0089C4
        BEQ.S  .loc_006A                        ; $0089CA
        BCHG    #2,(-15597).W                   ; $0089CC
        BCLR    #4,(-15597).W                   ; $0089D2
.loc_006A:
        MOVE.W  #$00C0,(-16184).W               ; $0089D8
        MOVE.W  #$0100,$00FF60CC                ; $0089DE
        MOVE.W  (-14118).W,(-16210).W           ; $0089E6
        MOVE.W  #$0000,(-16208).W               ; $0089EC
        MOVE.W  #$0000,(-16206).W               ; $0089F2
        MOVE.W  (-14116).W,(-16300).W           ; $0089F8
        MOVE.W  (-14114).W,(-16298).W           ; $0089FE
        MOVE.W  (-14176).W,D0                   ; $008A04
        MOVEA.L $008A0E(PC,D0.W),A1             ; $008A08
        JMP     (A1)                            ; $008A0C
        DC.W    $0088                           ; $008A0E
        OR.W   $0088(A0),D5                     ; $008A10
        OR.B   -(A6),D5                         ; $008A14
        DC.W    $0088                           ; $008A16
        OR.W   $0088(A0),D5                     ; $008A18
        OR.W   $0088(A0),D5                     ; $008A1C
        DC.W    $8A42                           ; $008A20
        DC.W    $0088                           ; $008A22
        OR.W   $1028(A0),D5                     ; $008A24
        DC.W    $00E5                           ; $008A28
        BTST    #2,D0                           ; $008A2A
        DC.W    $6600,$014C         ; BNE.W  $008B7C; $008A2E
        CMPI.W  #$00E0,$001C(A0)                ; $008A32
        BLE.S  .loc_00FA                        ; $008A38
        ANDI.B  #$02,D0                         ; $008A3A
        DC.W    $6600,$013C         ; BNE.W  $008B7C; $008A3E
        MOVE.W  $0024(A0),D0                    ; $008A42
        CMPI.W  #$0042,D0                       ; $008A46
        BCS.S  .loc_00FA                        ; $008A4A
        CMPI.W  #$0048,D0                       ; $008A4C
        BCC.S  .loc_00FA                        ; $008A50
        DC.W    $43FA,$0108         ; LEA     $008B5C(PC),A1; $008A52
        BTST    #2,(-15597).W                   ; $008A56
        BEQ.S  .loc_00F4                        ; $008A5C
        DC.W    $43FA,$010C         ; LEA     $008B6C(PC),A1; $008A5E
.loc_00F4:
        LEA     (-16198).W,A2                   ; $008A62
        BRA.S  .loc_0164                        ; $008A66
.loc_00FA:
        BTST    #4,(-15597).W                   ; $008A68
        BEQ.S  .loc_0108                        ; $008A6E
        MOVEA.L (-15736).W,A1                   ; $008A70
        BRA.S  .loc_0164                        ; $008A74
.loc_0108:
        MOVEQ   #$00,D0                         ; $008A76
        BTST    #2,(-15597).W                   ; $008A78
        BEQ.S  .loc_0114                        ; $008A7E
        MOVEQ   #$04,D0                         ; $008A80
.loc_0114:
        LEA     $00FF301A,A1                    ; $008A82
        ADD.W  (-14176).W,D0                    ; $008A88
        ADD.W  (-14176).W,D0                    ; $008A8C
        MOVEA.L $00(A1,D0.W),A1                 ; $008A90
        LEA     (-16198).W,A2                   ; $008A94
        MOVE.W  $0030(A0),D0                    ; $008A98
        MOVE.W  $0034(A0),D1                    ; $008A9C
        MOVE.W  #$0640,D6                       ; $008AA0
        MOVE.W  (A1)+,D7                        ; $008AA4
.loc_0138:
        MOVE.W  $0000(A1),D2                    ; $008AA6
        MOVE.W  $0004(A1),D4                    ; $008AAA
        MOVE.W  D2,D3                           ; $008AAE
        DC.W    $9640                           ; $008AB0
        BPL.S  .loc_0148                        ; $008AB2
        NEG.W  D3                               ; $008AB4
.loc_0148:
        CMP.W  D6,D3                            ; $008AB6
        BGT.S  .loc_0158                        ; $008AB8
        MOVE.W  D4,D3                           ; $008ABA
        DC.W    $9641                           ; $008ABC
        BPL.S  .loc_0154                        ; $008ABE
        NEG.W  D3                               ; $008AC0
.loc_0154:
        CMP.W  D6,D3                            ; $008AC2
        BLE.S  .loc_0164                        ; $008AC4
.loc_0158:
        LEA     $0010(A1),A1                    ; $008AC6
        DBRA    D7,.loc_0138                    ; $008ACA
        DC.W    $4EFA,$00AC         ; JMP     $008B7C(PC); $008ACE
.loc_0164:
        BCLR    #3,(-15597).W                   ; $008AD2
        CMPA.L  (-15736).W,A1                   ; $008AD8
        BEQ.S  .loc_0186                        ; $008ADC
        MOVE.L  A1,(-15736).W                   ; $008ADE
        MOVE.W  $0006(A1),(-16128).W            ; $008AE2
        MOVE.W  $0008(A1),(-16126).W            ; $008AE8
        MOVE.W  $000A(A1),(-16124).W            ; $008AEE
.loc_0186:
        MOVE.W  $000E(A1),D2                    ; $008AF4
        BTST    #15,D2                          ; $008AF8
        BEQ.S  .loc_0196                        ; $008AFC
        BSET    #3,(-15597).W                   ; $008AFE
.loc_0196:
        ANDI.W  #$7FFF,D2                       ; $008B04
        MOVE.L  (A1)+,(A2)+                     ; $008B08
        MOVE.L  (A1)+,(A2)+                     ; $008B0A
        MOVE.L  (A1)+,(A2)+                     ; $008B0C
        MOVE.W  (A1),(A2)                       ; $008B0E
        MOVE.W  (A1),D0                         ; $008B10
        DC.W    $D040                           ; $008B12
        ADD.W  D0,$00FF60CC                     ; $008B14
        MOVEA.L $008B28(PC,D2.W),A1             ; $008B1A
        JSR     (A1)                            ; $008B1E
        BCLR    #1,(-15597).W                   ; $008B20
        RTS                                     ; $008B26
