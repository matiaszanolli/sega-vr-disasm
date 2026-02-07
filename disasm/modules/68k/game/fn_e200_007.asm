; ============================================================================
; Sh2 Comm Send Cmd 007 (auto-analyzed)
; ROM Range: $00F44C-$00F682 (566 bytes)
; ============================================================================
; Category: sh2
; Purpose: RAM: $C87E (game_state)
;   Calls: sh2_send_cmd
;
; Uses: D0, D1, D2, A0, A1, A2
; RAM:
;   $C87E: game_state
; Calls:
;   $00E35A: sh2_send_cmd
; Confidence: medium
; ============================================================================

fn_e200_007:
        CLR.W  D0                               ; $00F44C
        MOVE.B  (-24549).W,D0                   ; $00F44E
        DC.W    $6100,$0438         ; BSR.W  $00F88C; $00F452
        JSR     $0088179E                       ; $00F456
        TST.W  (-24540).W                       ; $00F45C
        BNE.W  .loc_01F6                        ; $00F460
        MOVE.B  (-24551).W,D0                   ; $00F464
        MOVE.W  (-14228).W,D1                   ; $00F468
        BTST    #3,D1                           ; $00F46C
        BEQ.S  .loc_006E                        ; $00F470
        MOVE.B  #$A9,(-14172).W                 ; $00F472
        TST.B  (-24549).W                       ; $00F478
        BEQ.W  .loc_004C                        ; $00F47C
        CMPI.B  #$01,(-24549).W                 ; $00F480
        BEQ.W  .loc_005A                        ; $00F486
        CMPI.B  #$04,D0                         ; $00F48A
        BLT.W  .loc_0068                        ; $00F48E
        CLR.B  D0                               ; $00F492
        BRA.W  .loc_012E                        ; $00F494
.loc_004C:
        CMPI.B  #$02,D0                         ; $00F498
        BLT.W  .loc_0068                        ; $00F49C
        CLR.B  D0                               ; $00F4A0
        BRA.W  .loc_012E                        ; $00F4A2
.loc_005A:
        CMPI.B  #$01,D0                         ; $00F4A6
        BLT.W  .loc_0068                        ; $00F4AA
        CLR.B  D0                               ; $00F4AE
        BRA.W  .loc_012E                        ; $00F4B0
.loc_0068:
        ADDQ.B  #1,D0                           ; $00F4B4
        BRA.W  .loc_012E                        ; $00F4B6
.loc_006E:
        BTST    #2,D1                           ; $00F4BA
        BEQ.S  .loc_00B0                        ; $00F4BE
        MOVE.B  #$A9,(-14172).W                 ; $00F4C0
        TST.B  D0                               ; $00F4C6
        BLE.W  .loc_0086                        ; $00F4C8
        SUBQ.B  #1,D0                           ; $00F4CC
        BRA.W  .loc_012E                        ; $00F4CE
.loc_0086:
        TST.B  (-24549).W                       ; $00F4D2
        BEQ.W  .loc_00A0                        ; $00F4D6
        CMPI.B  #$01,(-24549).W                 ; $00F4DA
        BEQ.W  .loc_00A8                        ; $00F4E0
        MOVE.B  #$04,D0                         ; $00F4E4
        BRA.W  .loc_012E                        ; $00F4E8
.loc_00A0:
        MOVE.B  #$02,D0                         ; $00F4EC
        BRA.W  .loc_012E                        ; $00F4F0
.loc_00A8:
        MOVE.B  #$01,D0                         ; $00F4F4
        BRA.W  .loc_012E                        ; $00F4F8
.loc_00B0:
        BTST    #0,D1                           ; $00F4FC
        BEQ.W  .loc_00F0                        ; $00F500
        TST.B  (-24549).W                       ; $00F504
        BEQ.W  .loc_012E                        ; $00F508
        MOVE.B  #$A9,(-14172).W                 ; $00F50C
        CMPI.B  #$01,(-24549).W                 ; $00F512
        BEQ.S  .loc_00E0                        ; $00F518
        MOVE.B  #$01,(-24549).W                 ; $00F51A
        MOVE.B  D0,(-24543).W                   ; $00F520
        MOVE.B  (-24544).W,D0                   ; $00F524
        BRA.W  .loc_012E                        ; $00F528
.loc_00E0:
        CLR.B  (-24549).W                       ; $00F52C
        MOVE.B  D0,(-24544).W                   ; $00F530
        MOVE.B  (-24545).W,D0                   ; $00F534
        BRA.W  .loc_012E                        ; $00F538
.loc_00F0:
        BTST    #1,D1                           ; $00F53C
        BEQ.W  .loc_012E                        ; $00F540
        CMPI.B  #$02,(-24549).W                 ; $00F544
        BGE.W  .loc_012E                        ; $00F54A
        MOVE.B  #$A9,(-14172).W                 ; $00F54E
        TST.B  (-24549).W                       ; $00F554
        BEQ.S  .loc_0120                        ; $00F558
        MOVE.B  #$02,(-24549).W                 ; $00F55A
        MOVE.B  D0,(-24544).W                   ; $00F560
        MOVE.B  (-24543).W,D0                   ; $00F564
        BRA.W  .loc_012E                        ; $00F568
.loc_0120:
        MOVE.B  #$01,(-24549).W                 ; $00F56C
        MOVE.B  D0,(-24545).W                   ; $00F572
        MOVE.B  (-24544).W,D0                   ; $00F576
.loc_012E:
        MOVE.B  D0,(-24551).W                   ; $00F57A
        MOVE.B  (-24550).W,D0                   ; $00F57E
        MOVE.W  (-14226).W,D1                   ; $00F582
        BTST    #3,D1                           ; $00F586
        BEQ.S  .loc_0172                        ; $00F58A
        MOVE.B  #$A9,(-14172).W                 ; $00F58C
        CMPI.B  #$01,(-24548).W                 ; $00F592
        BEQ.W  .loc_015E                        ; $00F598
        CMPI.B  #$04,D0                         ; $00F59C
        BLT.W  .loc_016C                        ; $00F5A0
        CLR.B  D0                               ; $00F5A4
        BRA.W  .loc_01F2                        ; $00F5A6
.loc_015E:
        CMPI.B  #$01,D0                         ; $00F5AA
        BLT.W  .loc_016C                        ; $00F5AE
        CLR.B  D0                               ; $00F5B2
        BRA.W  .loc_01F2                        ; $00F5B4
.loc_016C:
        ADDQ.B  #1,D0                           ; $00F5B8
        BRA.W  .loc_01F2                        ; $00F5BA
.loc_0172:
        BTST    #2,D1                           ; $00F5BE
        BEQ.S  .loc_01A4                        ; $00F5C2
        MOVE.B  #$A9,(-14172).W                 ; $00F5C4
        TST.B  D0                               ; $00F5CA
        BLE.W  .loc_018A                        ; $00F5CC
        SUBQ.B  #1,D0                           ; $00F5D0
        BRA.W  .loc_01F2                        ; $00F5D2
.loc_018A:
        CMPI.B  #$01,(-24548).W                 ; $00F5D6
        BEQ.W  .loc_019C                        ; $00F5DC
        MOVE.B  #$04,D0                         ; $00F5E0
        BRA.W  .loc_01F2                        ; $00F5E4
.loc_019C:
        MOVE.B  #$01,D0                         ; $00F5E8
        BRA.W  .loc_01F2                        ; $00F5EC
.loc_01A4:
        BTST    #0,D1                           ; $00F5F0
        BEQ.W  .loc_01CC                        ; $00F5F4
        CMPI.B  #$01,(-24548).W                 ; $00F5F8
        BEQ.S  .loc_01F2                        ; $00F5FE
        MOVE.B  #$A9,(-14172).W                 ; $00F600
        MOVE.B  #$01,(-24548).W                 ; $00F606
        MOVE.B  D0,(-24541).W                   ; $00F60C
        MOVE.B  (-24542).W,D0                   ; $00F610
        BRA.W  .loc_01F2                        ; $00F614
.loc_01CC:
        BTST    #1,D1                           ; $00F618
        BEQ.W  .loc_01F2                        ; $00F61C
        CMPI.B  #$02,(-24548).W                 ; $00F620
        BGE.W  .loc_01F2                        ; $00F626
        MOVE.B  #$A9,(-14172).W                 ; $00F62A
        MOVE.B  #$02,(-24548).W                 ; $00F630
        MOVE.B  D0,(-24542).W                   ; $00F636
        MOVE.B  (-24541).W,D0                   ; $00F63A
.loc_01F2:
        MOVE.B  D0,(-24550).W                   ; $00F63E
.loc_01F6:
        MOVEA.L #$06038000,A0                   ; $00F642
        MOVEA.L #$04007010,A1                   ; $00F648
        MOVE.W  #$0120,D0                       ; $00F64E
        MOVE.W  #$0030,D1                       ; $00F652
        DC.W    $4EBA,$ED02         ; JSR     $00E35A(PC); $00F656
        LEA     $0088F682,A2                    ; $00F65A
        MOVE.W  #$0007,D2                       ; $00F660
.loc_0218:
        MOVEA.L (A2)+,A0                        ; $00F664
        MOVEA.L (A2)+,A1                        ; $00F666
        MOVE.W  (A2)+,D0                        ; $00F668
        MOVE.W  (A2)+,D1                        ; $00F66A
        DC.W    $4EBA,$ECEC         ; JSR     $00E35A(PC); $00F66C
        DBRA    D2,.loc_0218                    ; $00F670
        ADDQ.W  #4,(-14210).W                   ; $00F674
        MOVE.W  #$0020,$00FF0008                ; $00F678
        RTS                                     ; $00F680
