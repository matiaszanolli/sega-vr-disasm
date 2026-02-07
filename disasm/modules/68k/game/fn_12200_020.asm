; ============================================================================
; Sh2 Comm Send Cmd 020 (auto-analyzed)
; ROM Range: $012618-$0126A6 (142 bytes)
; ============================================================================
; Category: sh2
; Purpose: Calls: sh2_send_cmd
;
; Uses: D0, D1, A0, A1
; Calls:
;   $00E35A: sh2_send_cmd
; Confidence: medium
; ============================================================================

fn_12200_020:
        CMPI.B  #$60,D1                         ; $012618
        BGT.W  .loc_0030                        ; $01261C
        CMPI.B  #$40,D1                         ; $012620
        BGT.W  .loc_0048                        ; $012624
        CMPI.B  #$20,D1                         ; $012628
        BEQ.W  .loc_008A                        ; $01262C
        CMPI.B  #$21,D1                         ; $012630
        BEQ.W  .loc_005E                        ; $012634
        CMPI.B  #$2E,D1                         ; $012638
        BEQ.W  .loc_0064                        ; $01263C
        MOVE.W  #$0036,D1                       ; $012640
        BRA.W  .loc_0068                        ; $012644
.loc_0030:
        SUBI.B  #$47,D1                         ; $012648
        ANDI.W  #$00FF,D1                       ; $01264C
        CMPI.W  #$0033,D1                       ; $012650
        BLE.W  .loc_0068                        ; $012654
        MOVE.W  #$0036,D1                       ; $012658
        BRA.W  .loc_0068                        ; $01265C
.loc_0048:
        SUBI.B  #$41,D1                         ; $012660
        ANDI.W  #$00FF,D1                       ; $012664
        CMPI.W  #$0019,D1                       ; $012668
        BLE.W  .loc_0068                        ; $01266C
        MOVE.W  #$0036,D1                       ; $012670
        BRA.S  .loc_0068                        ; $012674
.loc_005E:
        MOVE.W  #$0035,D1                       ; $012676
        BRA.S  .loc_0068                        ; $01267A
.loc_0064:
        MOVE.W  #$0034,D1                       ; $01267C
.loc_0068:
        LEA     $060207C0,A0                    ; $012680
        TST.W  D1                               ; $012686
        BEQ.S  .loc_007E                        ; $012688
        SUBQ.W  #1,D1                           ; $01268A
.loc_0074:
        ADDA.L  #$000000C0,A0                   ; $01268C
        DBRA    D1,.loc_0074                    ; $012692
.loc_007E:
        MOVE.W  #$000C,D0                       ; $012696
        MOVE.W  #$0010,D1                       ; $01269A
        DC.W    $4EBA,$BCBA         ; JSR     $00E35A(PC); $01269E
.loc_008A:
        ADDQ.L  #8,A1                           ; $0126A2
        RTS                                     ; $0126A4
