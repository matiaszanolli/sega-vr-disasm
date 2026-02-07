; ============================================================================
; Logic Dispatch 040 (auto-analyzed)
; ROM Range: $00593C-$005AB6 (378 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C89C (sh2_comm_state), $9F00 (obj_table_3)
;   Calls: table_lookup, movement_calc, speed_calculation, collision_avoidance
;   Object (A0, A1, A2, A4, A6): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$18, +$24, +$26
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Entry: A4 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D7, A0, A1, A2, A4, A6
; RAM:
;   $9F00: obj_table_3
;   $C89C: sh2_comm_state
; Calls:
;   $0059EC: table_lookup
;   $007AB6: obj_heading_update
;   $009B12: movement_calc
;   $00A350: effect_timer_mgmt
;   $00A3BA: speed_calculation
;   $00A470: collision_avoidance
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$18: [unknown]
;   +$24: [unknown]
;   +$26: [unknown]
;   +$2C: [unknown]
;   +$32: [unknown]
; Confidence: high
; ============================================================================

fn_4200_040:
        LEA     (-24576).W,A4                   ; $00593C
        MOVE.W  (-15764).W,D0                   ; $005940
        BTST    #7,(-14308).W                   ; $005944
        BNE.S  .loc_0016                        ; $00594A
        TST.W  (-14180).W                       ; $00594C
.loc_0014:
        BEQ.S  .loc_001E                        ; $005950
.loc_0016:
        ANDI.W  #$0138,D0                       ; $005952
        BEQ.S  .loc_0026                        ; $005956
        BRA.S  .loc_002E                        ; $005958
.loc_001E:
        ANDI.W  #$0130,D0                       ; $00595A
        BEQ.S  .loc_0026                        ; $00595E
        BRA.S  .loc_002E                        ; $005960
.loc_0026:
        LEA     (-24832).W,A0                   ; $005962
        DC.W    $4EBA,$0084         ; JSR     $0059EC(PC); $005966
.loc_002E:
        LEA     (-28672).W,A0                   ; $00596A
        MOVE.L  $00B2(A0),$0018(A0)             ; $00596E
        MOVE.B  $00E5(A0),D1                    ; $005974
.loc_003C:
        ANDI.B  #$06,D1                         ; $005978
        BEQ.S  .loc_0048                        ; $00597C
        MOVE.L  (-14580).W,$0018(A0)            ; $00597E
.loc_0048:
        MOVE.W  (-16262).W,D0                   ; $005984
        BTST    #3,(-14322).W                   ; $005988
        BNE.S  .loc_005A                        ; $00598E
        MOVEA.L $00599C(PC,D0.W),A1             ; $005990
        JMP     (A1)                            ; $005994
.loc_005A:
        MOVEA.L $0059C4(PC,D0.W),A1             ; $005996
        JMP     (A1)                            ; $00599A
        DC.W    $0088                           ; $00599C
        ADDQ.L  #5,-$78(A6,D0.W)                ; $00599E
        SUBQ.W  #5,$0088(A6)                    ; $0059A2
        SMI     -(A0)                           ; $0059A6
.loc_006C:
        DC.W    $0088                           ; $0059A8
        ADDQ.W  #6,(A2)+                        ; $0059AA
        DC.W    $0088                           ; $0059AC
        DC.W    $5D08                           ; $0059AE
        DC.W    $0088                           ; $0059B0
        SLT     -(A0)                           ; $0059B2
        DC.W    $0088                           ; $0059B4
        ADDQ.B  #7,($0088).W                    ; $0059B6
        BLS.S  .loc_0014                        ; $0059BA
        DC.W    $0088                           ; $0059BC
        BLS.S  .loc_00BE                        ; $0059BE
        DC.W    $0088                           ; $0059C0
        SMI     $0088(A4)                       ; $0059C2
        SGT     $0088(A2)                       ; $0059C6
        SUBQ.L  #7,(A2)+                        ; $0059CA
        DC.W    $0088                           ; $0059CC
        BRA.S  .loc_009C                        ; $0059CE
        DC.W    $0088                           ; $0059D0
        BRA.S  .loc_006C                        ; $0059D2
        DC.W    $0088                           ; $0059D4
        BSR.S  .loc_0116                        ; $0059D6
.loc_009C:
        DC.W    $0088                           ; $0059D8
        SLT     -(A0)                           ; $0059DA
        DC.W    $0088                           ; $0059DC
        BHI.S  $005972                          ; $0059DE
        DC.W    $0088                           ; $0059E0
        BLS.S  .loc_003C                        ; $0059E2
        DC.W    $0088                           ; $0059E4
        BLS.S  $005A22                          ; $0059E6
        DC.W    $0088                           ; $0059E8
        BRA.S  $005A00                          ; $0059EA
        MOVE.W  D7,-(A7)                        ; $0059EC
        DC.W    $4EBA,$4122         ; JSR     $009B12(PC); $0059EE
        DC.W    $4EBA,$49C6         ; JSR     $00A3BA(PC); $0059F2
        DC.W    $4EBA,$49F2         ; JSR     $00A3EA(PC); $0059F6
.loc_00BE:
        DC.W    $4EBA,$4A74         ; JSR     $00A470(PC); $0059FA
        MOVE.W  $0054(A0),D0                    ; $0059FE
        ANDI.W  #$0009,D0                       ; $005A02
        BEQ.S  .loc_00E0                        ; $005A06
        TST.W  $006A(A0)                        ; $005A08
        BNE.S  .loc_00E0                        ; $005A0C
        CMPI.W  #$0064,$0004(A0)                ; $005A0E
        BLE.S  .loc_00E0                        ; $005A14
        ORI.W  #$1000,$0002(A0)                 ; $005A16
.loc_00E0:
        DC.W    $4EBA,$4932         ; JSR     $00A350(PC); $005A1C
        TST.W  $0004(A0)                        ; $005A20
        BEQ.S  .loc_00F6                        ; $005A24
        SUBI.W  #$2000,$00BC(A0)                ; $005A26
        SUBI.W  #$1800,$00C4(A0)                ; $005A2C
.loc_00F6:
        DC.W    $4EBA,$2082         ; JSR     $007AB6(PC); $005A32
        LEA     $0093AC2C,A1                    ; $005A36
        MOVE.W  $00C8(A0),D0                    ; $005A3C
        SUB.W  $0032(A0),D0                     ; $005A40
        DC.W    $D040                           ; $005A44
        BMI.S  .loc_0116                        ; $005A46
        ANDI.W  #$03FF,D0                       ; $005A48
        MOVE.W  $00(A1,D0.W),D0                 ; $005A4C
        BRA.S  .loc_0122                        ; $005A50
.loc_0116:
        NEG.W  D0                               ; $005A52
        ANDI.W  #$03FF,D0                       ; $005A54
        MOVE.W  $00(A1,D0.W),D0                 ; $005A58
        NEG.W  D0                               ; $005A5C
.loc_0122:
        MOVE.W  D0,$003A(A0)                    ; $005A5E
        LEA     $0093A82C,A1                    ; $005A62
        MOVE.W  $0032(A0),D0                    ; $005A68
        SUB.W  $00C6(A0),D0                     ; $005A6C
        DC.W    $D040                           ; $005A70
        BMI.S  .loc_0142                        ; $005A72
        ANDI.W  #$03FF,D0                       ; $005A74
        MOVE.W  $00(A1,D0.W),D0                 ; $005A78
        BRA.S  .loc_014E                        ; $005A7C
.loc_0142:
        NEG.W  D0                               ; $005A7E
        ANDI.W  #$03FF,D0                       ; $005A80
        MOVE.W  $00(A1,D0.W),D0                 ; $005A84
        NEG.W  D0                               ; $005A88
.loc_014E:
        MOVE.W  D0,$003E(A0)                    ; $005A8A
        MOVE.W  $006E(A0),$0046(A0)             ; $005A8E
        DC.W    $4EBA,$1BB8         ; JSR     $00764E(PC); $005A94
        DC.W    $4EBA,$16B0         ; JSR     $00714A(PC); $005A98
        MOVE.W  $0026(A0),D0                    ; $005A9C
        SUB.W  $0024(A0),D0                     ; $005AA0
        CMPI.W  #$0064,D0                       ; $005AA4
        BLT.S  .loc_0172                        ; $005AA8
        ADDQ.W  #1,$002C(A0)                    ; $005AAA
.loc_0172:
        LEA     $0100(A0),A0                    ; $005AAE
        MOVE.W  (A7)+,D7                        ; $005AB2
        RTS                                     ; $005AB4
