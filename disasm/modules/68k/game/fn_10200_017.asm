; ============================================================================
; Sh2 Comm Send Cmd 017 (auto-analyzed)
; ROM Range: $010674-$01071C (168 bytes)
; ============================================================================
; Category: sh2
; Purpose: Calls: sh2_send_cmd
;
; Uses: D0, D1, A0
; Calls:
;   $00E35A: sh2_send_cmd
; Confidence: medium
; ============================================================================

fn_10200_017:
        CMPI.W  #$0020,D0                       ; $010674
        BEQ.W  .loc_0048                        ; $010678
        CMPI.W  #$0008,D0                       ; $01067C
        BEQ.W  .loc_0050                        ; $010680
        CMPI.W  #$0003,D0                       ; $010684
        BEQ.W  .loc_0058                        ; $010688
        CMPI.W  #$002E,D0                       ; $01068C
        BEQ.W  .loc_0060                        ; $010690
        CMPI.W  #$0021,D0                       ; $010694
        BEQ.W  .loc_0068                        ; $010698
        CMPI.W  #$003F,D0                       ; $01069C
        BEQ.W  .loc_0040                        ; $0106A0
        CMPI.W  #$005A,D0                       ; $0106A4
        BLE.W  .loc_0070                        ; $0106A8
        CMPI.W  #$007A,D0                       ; $0106AC
        BLE.W  .loc_0078                        ; $0106B0
.loc_0040:
        MOVE.W  #$0036,D0                       ; $0106B4
        BRA.W  .loc_007C                        ; $0106B8
.loc_0048:
        MOVE.W  #$0037,D0                       ; $0106BC
        BRA.W  .loc_007C                        ; $0106C0
.loc_0050:
        MOVE.W  #$0038,D0                       ; $0106C4
        BRA.W  .loc_007C                        ; $0106C8
.loc_0058:
        MOVE.W  #$0039,D0                       ; $0106CC
        BRA.W  .loc_007C                        ; $0106D0
.loc_0060:
        MOVE.W  #$0034,D0                       ; $0106D4
        BRA.W  .loc_007C                        ; $0106D8
.loc_0068:
        MOVE.W  #$0035,D0                       ; $0106DC
        BRA.W  .loc_007C                        ; $0106E0
.loc_0070:
        SUBI.W  #$0041,D0                       ; $0106E4
        BRA.W  .loc_007C                        ; $0106E8
.loc_0078:
        SUBI.W  #$0047,D0                       ; $0106EC
.loc_007C:
        ANDI.L  #$0000FFFF,D0                   ; $0106F0
        LSL.L  #6,D0                            ; $0106F6
        MOVE.L  D0,D1                           ; $0106F8
        LSL.L  #1,D0                            ; $0106FA
        DC.W    $D280                           ; $0106FC
        LSL.L  #1,D0                            ; $0106FE
        DC.W    $D280                           ; $010700
        LSL.L  #1,D0                            ; $010702
        DC.W    $D081                           ; $010704
        MOVEA.L #$06024000,A0                   ; $010706
        ADDA.L  D0,A0                           ; $01070C
        MOVE.W  #$0018,D0                       ; $01070E
        MOVE.W  #$0028,D1                       ; $010712
        DC.W    $4EBA,$DC42         ; JSR     $00E35A(PC); $010716
        RTS                                     ; $01071A
