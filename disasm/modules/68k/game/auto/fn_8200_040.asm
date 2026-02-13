; ============================================================================
; State Velocity 040 (auto-analyzed)
; ROM Range: $0099AA-$009B12 (360 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0): +$02 (flags/type), +$04 (speed_index/velocity), +$0E (param_e), +$10, +$3C (heading_mirror), +$4C
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D6, D7, A0
; Object fields:
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$0E: param_e
;   +$10: [unknown]
;   +$3C: heading_mirror
;   +$4C: [unknown]
;   +$62: [unknown]
;   +$6A: [unknown]
; Confidence: medium
; ============================================================================

fn_8200_040:
        MOVE.W  #$00B5,D6                       ; $0099AA
        MOVE.W  D6,D7                           ; $0099AE
        MOVE.W  (-16384).W,D0                   ; $0099B0
        BPL.S  .loc_000E                        ; $0099B4
        NEG.W  D0                               ; $0099B6
.loc_000E:
        MULS    $0010(A0),D0                    ; $0099B8
        ASR.L  #7,D0                            ; $0099BC
        MOVEQ   #$00,D1                         ; $0099BE
        CMPI.W  #$00C8,$0004(A0)                ; $0099C0
        BLE.S  .loc_0030                        ; $0099C6
        BTST    #4,(-13967).W                   ; $0099C8
        BEQ.S  .loc_0030                        ; $0099CE
        MOVE.W  #$00FF,D1                       ; $0099D0
        SUB.W  $000E(A0),D1                     ; $0099D4
        ASL.W  #3,D1                            ; $0099D8
.loc_0030:
        DC.W    $D041                           ; $0099DA
        MOVE.W  $0078(A0),D1                    ; $0099DC
        DC.W    $9240                           ; $0099E0
        CMPI.W  #$00FF,D1                       ; $0099E2
        BLE.S  .loc_0042                        ; $0099E6
        MOVE.W  #$00FF,D1                       ; $0099E8
.loc_0042:
        CMPI.W  #$0040,D1                       ; $0099EC
        BGE.S  .loc_004C                        ; $0099F0
        MOVE.W  #$0040,D1                       ; $0099F2
.loc_004C:
        MOVE.W  D1,$0078(A0)                    ; $0099F6
        MOVE.W  $0092(A0),D0                    ; $0099FA
        ADD.W  $0062(A0),D0                     ; $0099FE
        BNE.W  .loc_00FC                        ; $009A02
        MOVE.W  $004C(A0),D0                    ; $009A06
        MOVE.W  D0,D1                           ; $009A0A
        BPL.S  .loc_0066                        ; $009A0C
        NEG.W  D1                               ; $009A0E
.loc_0066:
        CMPI.W  #$0037,D1                       ; $009A10
        BLE.W  .loc_00FC                        ; $009A14
        MOVE.W  $0094(A0),D1                    ; $009A18
        BPL.S  .loc_0076                        ; $009A1C
        NEG.W  D1                               ; $009A1E
.loc_0076:
        MOVE.W  #$0200,D2                       ; $009A20
        SUB.W  $0078(A0),D2                     ; $009A24
        MULS    D2,D0                           ; $009A28
        ASR.L  #8,D0                            ; $009A2A
        DIVS    (-16146).W,D0                   ; $009A2C
        CMP.W  (-16144).W,D1                    ; $009A30
        BLE.S  .loc_008E                        ; $009A34
        ASR.W  #1,D0                            ; $009A36
.loc_008E:
        ADD.W  D0,$0094(A0)                     ; $009A38
        MOVE.W  $0094(A0),D0                    ; $009A3C
        MOVE.W  D0,D2                           ; $009A40
        DC.W    $D442                           ; $009A42
        MOVE.W  D2,$0096(A0)                    ; $009A44
        MOVE.W  D0,D1                           ; $009A48
        BPL.S  .loc_00A4                        ; $009A4A
        NEG.W  D1                               ; $009A4C
.loc_00A4:
        CMPI.W  #$0100,D1                       ; $009A4E
        BLT.S  .loc_00C2                        ; $009A52
        MOVEQ   #$7F,D2                         ; $009A54
        TST.W  D0                               ; $009A56
        BMI.S  .loc_00B2                        ; $009A58
        NEG.W  D2                               ; $009A5A
.loc_00B2:
        DC.W    $DC42                           ; $009A5C
        DC.W    $9E42                           ; $009A5E
        CMPI.W  #$000B,$0080(A0)                ; $009A60
        BGE.S  .loc_00C2                        ; $009A66
        ADDQ.W  #4,$0080(A0)                    ; $009A68
.loc_00C2:
        MULS    (-16138).W,D0                   ; $009A6C
        ASR.L  #8,D0                            ; $009A70
        SUB.W  D0,$003C(A0)                     ; $009A72
        CMP.W  (-16142).W,D1                    ; $009A76
        BLT.W  .loc_015A                        ; $009A7A
        MOVE.W  $006A(A0),D2                    ; $009A7E
        ADD.W  $008C(A0),D2                     ; $009A82
        BNE.W  .loc_015A                        ; $009A86
        MOVE.W  #$2000,D2                       ; $009A8A
        TST.W  $0094(A0)                        ; $009A8E
        BMI.S  .loc_00EE                        ; $009A92
        MOVE.W  #$1000,D2                       ; $009A94
.loc_00EE:
        MOVE.B  #$B2,(-14172).W                 ; $009A98
        OR.W   D2,$0002(A0)                     ; $009A9E
        BRA.W  .loc_015A                        ; $009AA2
.loc_00FC:
        MOVE.W  $0094(A0),D0                    ; $009AA6
        MOVE.W  D0,D1                           ; $009AAA
        BMI.S  .loc_0110                        ; $009AAC
        CMPI.W  #$0200,D0                       ; $009AAE
        BGT.S  .loc_011A                        ; $009AB2
        MOVE.W  #$0200,D0                       ; $009AB4
        BRA.S  .loc_011A                        ; $009AB8
.loc_0110:
        CMPI.W  #$FE00,D0                       ; $009ABA
        BLT.S  .loc_011A                        ; $009ABE
        MOVE.W  #$FE00,D0                       ; $009AC0
.loc_011A:
        MOVE.W  D0,D1                           ; $009AC4
        MULS    (-16140).W,D0                   ; $009AC6
        ASR.L  #8,D0                            ; $009ACA
        SUB.W  D0,$0094(A0)                     ; $009ACC
        MOVE.W  $0094(A0),D2                    ; $009AD0
        DC.W    $B540                           ; $009AD4
        BPL.S  .loc_0132                        ; $009AD6
        CLR.W  $0094(A0)                        ; $009AD8
.loc_0132:
        MOVE.W  $0094(A0),D0                    ; $009ADC
        MOVE.W  D0,D2                           ; $009AE0
        ASR.W  #1,D2                            ; $009AE2
        DC.W    $D440                           ; $009AE4
        MOVE.W  D2,$0096(A0)                    ; $009AE6
        TST.W  D1                               ; $009AEA
        BGE.S  .loc_0148                        ; $009AEC
        NEG.W  D0                               ; $009AEE
        NEG.W  D1                               ; $009AF0
.loc_0148:
        CMP.W  D0,D1                            ; $009AF2
        BLT.S  .loc_015A                        ; $009AF4
        TST.W  D0                               ; $009AF6
        BLT.S  .loc_015A                        ; $009AF8
        CMPI.W  #$000F,D0                       ; $009AFA
        BGT.S  .loc_015A                        ; $009AFE
        CLR.W  $0094(A0)                        ; $009B00
.loc_015A:
        MOVE.W  D6,$00FF617A                    ; $009B04
        MOVE.W  D7,$00FF618E                    ; $009B0A
        RTS                                     ; $009B10
