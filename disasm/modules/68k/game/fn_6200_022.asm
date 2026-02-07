; ============================================================================
; Obj Dispatch 022 (auto-analyzed)
; ROM Range: $006D9C-$006F98 (508 bytes)
; ============================================================================
; Category: object
; Purpose: State dispatcher using jump table
;   RAM: $9100 (obj_table_1), $9700 (obj_table_2), $9F00 (obj_table_3)
;   Calls: table_lookup, effect_timer_mgmt, object_frame_timer, load_object_params
;   Object (A0): +$06 (speed), +$18, +$44 (display_offset), +$46 (display_scale), +$4A, +$74
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D6, D7, A0, A1, A2, A3
; RAM:
;   $9100: obj_table_1
;   $9700: obj_table_2
;   $9F00: obj_table_3
; Calls:
;   $004922: FastCopy16
;   $0049EE: reset_scroll_vars
;   $0059EC: table_lookup
;   $006F98: calc_steering
;   $007084: obj_position_update
;   $0070AA: angle_to_sine
; Object fields:
;   +$06: speed
;   +$18: [unknown]
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: [unknown]
;   +$74: [unknown]
;   +$B2: [unknown]
;   +$E5: [unknown]
; Confidence: high
; ============================================================================

fn_6200_022:
        DC.W    $4EBA,$FDEC         ; JSR     $006B8A(PC); $006D9C
        LEA     (-24576).W,A4                   ; $006DA0
        MOVE.B  #$00,$00FF5FFE                  ; $006DA4
        LEA     (-28416).W,A0                   ; $006DAC
        DC.W    $4EBA,$EC3A         ; JSR     $0059EC(PC); $006DB0
        DC.W    $4EBA,$EC36         ; JSR     $0059EC(PC); $006DB4
        DC.W    $4EBA,$EC32         ; JSR     $0059EC(PC); $006DB8
        DC.W    $4EBA,$EC2E         ; JSR     $0059EC(PC); $006DBC
        DC.W    $4EBA,$EC2A         ; JSR     $0059EC(PC); $006DC0
        DC.W    $4EFA,$EC26         ; JMP     $0059EC(PC); $006DC4
        LEA     (-24576).W,A4                   ; $006DC8
        LEA     (-26880).W,A0                   ; $006DCC
        DC.W    $4EBA,$EC1A         ; JSR     $0059EC(PC); $006DD0
.loc_0038:
        DC.W    $4EBA,$EC16         ; JSR     $0059EC(PC); $006DD4
        DC.W    $4EBA,$EC12         ; JSR     $0059EC(PC); $006DD8
        DC.W    $4EBA,$EC0E         ; JSR     $0059EC(PC); $006DDC
        DC.W    $4EBA,$EC0A         ; JSR     $0059EC(PC); $006DE0
        DC.W    $4EBA,$EC06         ; JSR     $0059EC(PC); $006DE4
        DC.W    $4EBA,$EC02         ; JSR     $0059EC(PC); $006DE8
        DC.W    $4EFA,$EBFE         ; JMP     $0059EC(PC); $006DEC
        LEA     (-24576).W,A4                   ; $006DF0
        LEA     (-24832).W,A0                   ; $006DF4
        DC.W    $4EBA,$EBF2         ; JSR     $0059EC(PC); $006DF8
        LEA     (-28672).W,A0                   ; $006DFC
        MOVE.L  $00B2(A0),$0018(A0)             ; $006E00
        MOVE.B  $00E5(A0),D1                    ; $006E06
        ANDI.B  #$06,D1                         ; $006E0A
        BEQ.S  .loc_007A                        ; $006E0E
        MOVE.L  (-14580).W,$0018(A0)            ; $006E10
.loc_007A:
        MOVE.W  (-16262).W,D0                   ; $006E16
        MOVEA.L $006E20(PC,D0.W),A1             ; $006E1A
        JMP     (A1)                            ; $006E1E
        DC.W    $0088                           ; $006E20
        BGT.S  $006E6C                          ; $006E22
        DC.W    $0088                           ; $006E24
        SUBQ.L  #7,(A2)+                        ; $006E26
        DC.W    $0088                           ; $006E28
        BGT.S  $006DEA                          ; $006E2A
        DC.W    $0088                           ; $006E2C
        BRA.S  $006E04                          ; $006E2E
        DC.W    $0088                           ; $006E30
        BSR.S  .loc_0112                        ; $006E32
        DC.W    $0088                           ; $006E34
        SLT     -(A0)                           ; $006E36
        DC.W    $0088                           ; $006E38
        BHI.S  $006DCE                          ; $006E3A
        DC.W    $0088                           ; $006E3C
        BLS.S  .loc_0038                        ; $006E3E
        DC.W    $0088                           ; $006E40
        BLS.S  .loc_00E2                        ; $006E42
        DC.W    $0088                           ; $006E44
        BGT.S  $006E12                          ; $006E46
        MOVEQ   #$00,D0                         ; $006E48
        MOVE.W  D0,$0044(A0)                    ; $006E4A
        MOVE.W  D0,$0046(A0)                    ; $006E4E
        MOVE.W  D0,$004A(A0)                    ; $006E52
        DC.W    $4EBA,$34F8         ; JSR     $00A350(PC); $006E56
        DC.W    $4EBA,$1314         ; JSR     $008170(PC); $006E5A
        DC.W    $4EBA,$126C         ; JSR     $0080CC(PC); $006E5E
        DC.W    $4EBA,$16E4         ; JSR     $008548(PC); $006E62
        DC.W    $4EBA,$2692         ; JSR     $0094FA(PC); $006E66
        DC.W    $4EBA,$24A6         ; JSR     $009312(PC); $006E6A
        DC.W    $4EBA,$2CA2         ; JSR     $009B12(PC); $006E6E
        DC.W    $4EBA,$230E         ; JSR     $009182(PC); $006E72
        DC.W    $4EBA,$27A6         ; JSR     $00961E(PC); $006E76
        DC.W    $4EBA,$280C         ; JSR     $009688(PC); $006E7A
.loc_00E2:
        DC.W    $4EBA,$2982         ; JSR     $009802(PC); $006E7E
        DC.W    $4EBA,$0FF6         ; JSR     $007E7A(PC); $006E82
        DC.W    $4EBA,$0110         ; JSR     $006F98(PC); $006E86
        DC.W    $4EBA,$0E4C         ; JSR     $007CD8(PC); $006E8A
        DC.W    $4EBA,$35A4         ; JSR     $00A434(PC); $006E8E
        DC.W    $4EBA,$0216         ; JSR     $0070AA(PC); $006E92
        DC.W    $4EBA,$106C         ; JSR     $007F04(PC); $006E96
        DC.W    $4EBA,$2FD2         ; JSR     $009E6E(PC); $006E9A
        DC.W    $4EBA,$0DAE         ; JSR     $007C4E(PC); $006E9E
        DC.W    $4EBA,$02A6         ; JSR     $00714A(PC); $006EA2
        DC.W    $4EBA,$07A6         ; JSR     $00764E(PC); $006EA6
        DC.W    $4EBA,$10A4         ; JSR     $007F50(PC); $006EAA
.loc_0112:
        DC.W    $4EBA,$2E1E         ; JSR     $009CCE(PC); $006EAE
        DC.W    $4EBA,$2CA0         ; JSR     $009B54(PC); $006EB2
        DC.W    $4EBA,$1810         ; JSR     $0086C8(PC); $006EB6
        DC.W    $4EFA,$3E18         ; JMP     $00ACD4(PC); $006EBA
        MOVE.W  #$0000,$0006(A0)                ; $006EBE
        MOVE.W  #$0000,$0074(A0)                ; $006EC4
        MOVEQ   #$00,D0                         ; $006ECA
        MOVE.W  D0,$0044(A0)                    ; $006ECC
        MOVE.W  D0,$0046(A0)                    ; $006ED0
        MOVE.W  D0,$004A(A0)                    ; $006ED4
        DC.W    $4EBA,$DB14         ; JSR     $0049EE(PC); $006ED8
        DC.W    $4EBA,$16BC         ; JSR     $00859A(PC); $006EDC
        DC.W    $4EBA,$346E         ; JSR     $00A350(PC); $006EE0
        DC.W    $4EBA,$128A         ; JSR     $008170(PC); $006EE4
        DC.W    $4EBA,$11E2         ; JSR     $0080CC(PC); $006EE8
        DC.W    $4EBA,$165A         ; JSR     $008548(PC); $006EEC
        DC.W    $4EBA,$2608         ; JSR     $0094FA(PC); $006EF0
        CMPI.W  #$0004,(-15764).W               ; $006EF4
        BEQ.S  .loc_0164                        ; $006EFA
        DC.W    $4EBA,$2414         ; JSR     $009312(PC); $006EFC
.loc_0164:
        DC.W    $4EBA,$2C10         ; JSR     $009B12(PC); $006F00
        DC.W    $4EBA,$227C         ; JSR     $009182(PC); $006F04
        DC.W    $4EBA,$28F8         ; JSR     $009802(PC); $006F08
        DC.W    $4EBA,$0176         ; JSR     $007084(PC); $006F0C
        DC.W    $4EBA,$0198         ; JSR     $0070AA(PC); $006F10
        DC.W    $4EBA,$0900         ; JSR     $007816(PC); $006F14
        SUBQ.W  #1,(-16340).W                   ; $006F18
        BGT.S  .loc_0194                        ; $006F1C
        MOVE.W  #$0000,(-16340).W               ; $006F1E
        MOVE.W  #$0000,$0074(A0)                ; $006F24
        MOVE.W  (-16244).W,(-16262).W           ; $006F2A
.loc_0194:
        DC.W    $4EBA,$0FD2         ; JSR     $007F04(PC); $006F30
        DC.W    $4EBA,$2F38         ; JSR     $009E6E(PC); $006F34
        DC.W    $4EBA,$0D14         ; JSR     $007C4E(PC); $006F38
        DC.W    $4EBA,$020C         ; JSR     $00714A(PC); $006F3C
        DC.W    $4EBA,$070C         ; JSR     $00764E(PC); $006F40
        DC.W    $4EBA,$100A         ; JSR     $007F50(PC); $006F44
        DC.W    $4EBA,$2D84         ; JSR     $009CCE(PC); $006F48
        DC.W    $4EBA,$3CF0         ; JSR     $00AC3E(PC); $006F4C
        DC.W    $4EBA,$2C02         ; JSR     $009B54(PC); $006F50
        DC.W    $4EBA,$1772         ; JSR     $0086C8(PC); $006F54
        DC.W    $4EFA,$3D7A         ; JMP     $00ACD4(PC); $006F58
        MOVE.L  A4,-(A7)                        ; $006F5C
        MOVE.W  #$0001,$00FF3000                ; $006F5E
        LEA     $0089C064,A1                    ; $006F66
        LEA     $00FF3022,A2                    ; $006F6C
        LEA     $00FF301A,A3                    ; $006F72
        LEA     $00FF3002,A4                    ; $006F78
        MOVEQ   #$01,D6                         ; $006F7E
.loc_01E4:
        MOVE.L  A2,(A3)+                        ; $006F80
        MOVE.W  (A1),D7                         ; $006F82
        MOVE.W  (A1)+,(A2)+                     ; $006F84
.loc_01EA:
        DC.W    $4EBA,$D99A         ; JSR     $004922(PC); $006F86
        DBRA    D7,.loc_01EA                    ; $006F8A
        DBRA    D6,.loc_01E4                    ; $006F8E
        MOVE.L  A2,(A4)+                        ; $006F92
        MOVEA.L (A7)+,A4                        ; $006F94
        RTS                                     ; $006F96
