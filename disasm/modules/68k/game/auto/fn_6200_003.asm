; ============================================================================
; Obj Memory Copy 003 (auto-analyzed)
; ROM Range: $006496-$00659C (262 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 22 subroutines
;   RAM: $9F00 (obj_table_3)
;   Calls: race_state_read, obj_distance_calc, state_jump_table, memory_copy
;   Object (A0, A1): +$00, +$18, +$8A (param_8a), +$B2, +$E5
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; RAM:
;   $9F00: obj_table_3
; Calls:
;   $0037B6: memory_copy
;   $0075FE: obj_distance_calc
;   $009EC0: state_jump_table
;   $00A1FC: race_state_read
; Object fields:
;   +$00: [unknown]
;   +$18: [unknown]
;   +$8A: param_8a
;   +$B2: [unknown]
;   +$E5: [unknown]
; Confidence: high
; ============================================================================

fn_6200_003:
        LEA     (-24576).W,A4                   ; $006496
        LEA     (-24832).W,A0                   ; $00649A
        MOVE.B  (-336).W,(-15601).W             ; $00649E
        DC.W    $4EBA,$0718         ; JSR     $006BBE(PC); $0064A4
        MOVE.L  $00B2(A0),$0018(A0)             ; $0064A8
        MOVE.B  $00E5(A0),D1                    ; $0064AE
        ANDI.B  #$06,D1                         ; $0064B2
        BEQ.S  .loc_0028                        ; $0064B6
        MOVE.L  (-14580).W,$0018(A0)            ; $0064B8
.loc_0028:
        MOVE.W  (-16262).W,D0                   ; $0064BE
        DC.W    $43FA,$00D8         ; LEA     $00659C(PC),A1; $0064C2
        MOVEA.L $00(A1,D0.W),A1                 ; $0064C6
        JSR     (A1)                            ; $0064CA
        DC.W    $4EBA,$398C         ; JSR     $009E5A(PC); $0064CC
        DC.W    $4EBA,$1A2A         ; JSR     $007EFC(PC); $0064D0
        DC.W    $4EBA,$1F04         ; JSR     $0083DA(PC); $0064D4
        DC.W    $4EBA,$2308         ; JSR     $0087E2(PC); $0064D8
        LEA     (-24832).W,A0                   ; $0064DC
        LEA     (-28672).W,A1                   ; $0064E0
        DC.W    $4EBA,$218C         ; JSR     $008672(PC); $0064E4
        LEA     (-31972).W,A1                   ; $0064E8
        DC.W    $4EBA,$2BE0         ; JSR     $0090CE(PC); $0064EC
        LEA     (-28672).W,A0                   ; $0064F0
        DC.W    $4EBA,$3964         ; JSR     $009E5A(PC); $0064F4
        DC.W    $4EBA,$4A1E         ; JSR     $00AF18(PC); $0064F8
        LEA     (-24832).W,A0                   ; $0064FC
        MOVE.W  #$0000,$008A(A0)                ; $006500
        DC.W    $4EBA,$3CF4         ; JSR     $00A1FC(PC); $006506
        DC.W    $4EBA,$10F2         ; JSR     $0075FE(PC); $00650A
        DC.W    $4EBA,$0D60         ; JSR     $007270(PC); $00650E
        DC.W    $4EBA,$C6F0         ; JSR     $002C04(PC); $006512
        DC.W    $4EBA,$CE62         ; JSR     $00337A(PC); $006516
        DC.W    $4EBA,$D60C         ; JSR     $003B28(PC); $00651A
        DC.W    $4EBA,$DA3A         ; JSR     $003F5A(PC); $00651E
        MOVE.B  (-15612).W,(-15604).W           ; $006522
        DC.W    $4EBA,$06C0         ; JSR     $006BEA(PC); $006528
        LEA     (-16384).W,A2                   ; $00652C
        LEA     (-18432).W,A1                   ; $006530
        MOVEQ   #$1F,D7                         ; $006534
.loc_00A0:
        MOVEM.L (A2)+,D0/D1/D2/D3/D4/D5/D6/A3   ; $006536
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,-(A1)   ; $00653A
        DBRA    D7,.loc_00A0                    ; $00653E
        MOVE.L  (-13960).W,(-13968).W           ; $006542
        LEA     (-20480).W,A1                   ; $006548
        LEA     (-15360).W,A2                   ; $00654C
        MOVEQ   #$1F,D7                         ; $006550
.loc_00BC:
        MOVEM.L (A1)+,D0/D1/D2/D3/D4/D5/D6/A3   ; $006552
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,-(A2)   ; $006556
        DBRA    D7,.loc_00BC                    ; $00655A
        LEA     (-28672).W,A0                   ; $00655E
        LEA     (-24832).W,A1                   ; $006562
        DC.W    $4EBA,$1EB0         ; JSR     $008418(PC); $006566
        DC.W    $4EBA,$3954         ; JSR     $009EC0(PC); $00656A
        MOVE.W  #$0000,$008A(A0)                ; $00656E
        DC.W    $4EBA,$3C86         ; JSR     $00A1FC(PC); $006574
        DC.W    $4EBA,$1084         ; JSR     $0075FE(PC); $006578
        DC.W    $4EBA,$0CE2         ; JSR     $007260(PC); $00657C
        DC.W    $4EBA,$C62E         ; JSR     $002BB0(PC); $006580
        DC.W    $4EBA,$CDF4         ; JSR     $00337A(PC); $006584
        DC.W    $4EBA,$D22C         ; JSR     $0037B6(PC); $006588
        DC.W    $4EBA,$D9A0         ; JSR     $003F2E(PC); $00658C
        MOVE.B  (-15612).W,(-15604).W           ; $006590
        DC.W    $4EBA,$0652         ; JSR     $006BEA(PC); $006596
        RTS                                     ; $00659A
