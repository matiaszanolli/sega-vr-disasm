; ============================================================================
; Display Num To Decimal 013 (auto-analyzed)
; ROM Range: $0083E4-$0084F4 (272 bytes)
; ============================================================================
; Category: display
; Purpose: Orchestrator calling 4 subroutines
;   RAM: $C8AA (scene_state), $68F8 (time_display_buf), $9F00 (obj_table_3), $68F0 (status_code)
;   Calls: num_to_decimal
;   Object (A0, A1, A2): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$07
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D7, A0, A1, A2, A3
; RAM:
;   $68F0: status_code
;   $68F8: time_display_buf
;   $9F00: obj_table_3
;   $C8AA: scene_state
; Calls:
;   $00839A: num_to_decimal
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$07: [unknown]
; Confidence: high
; ============================================================================

fn_8200_013:
        MOVEQ   #$00,D0                         ; $0083E4
        MOVE.B  (-22047).W,D0                   ; $0083E6
        ADDQ.B  #1,(-22047).W                   ; $0083EA
        LEA     (-22041).W,A1                   ; $0083EE
        LEA     (-22288).W,A2                   ; $0083F2
        LSL.W  #2,D0                            ; $0083F6
        LEA     $00(A2,D0.W),A2                 ; $0083F8
        MOVE.L  A2,-(A7)                        ; $0083FC
        DC.W    $4EBA,$2FCE         ; JSR     $00B3CE(PC); $0083FE
        MOVEA.L (A7)+,A1                        ; $008402
        MOVEQ   #$00,D0                         ; $008404
        MOVE.B  (-15591).W,D0                   ; $008406
        ANDI.W  #$00C0,D0                       ; $00840A
        LSR.W  #6,D0                            ; $00840E
        SUBQ.W  #1,D0                           ; $008410
        DC.W    $D040                           ; $008412
        DC.W    $4EFA,$2FA6         ; JMP     $00B3BC(PC); $008414
        BTST    #6,$0002(A0)                    ; $008418
        BEQ.S  .loc_0088                        ; $00841E
        ANDI.W  #$BFFF,$0002(A0)                ; $008420
        CLR.W  (-14166).W                       ; $008426
        LEA     (-22528).W,A2                   ; $00842A
        LEA     (-22288).W,A3                   ; $00842E
        MOVEQ   #$00,D1                         ; $008432
        MOVE.B  (-22048).W,D1                   ; $008434
        DC.W    $4EBA,$00BA         ; JSR     $0084F4(PC); $008438
        BEQ.S  .loc_0062                        ; $00843C
        MOVE.W  #$0000,(-16306).W               ; $00843E
        BRA.S  .loc_00A6                        ; $008444
.loc_0062:
        ANDI.W  #$BFFF,$0002(A1)                ; $008446
        DC.W    $4EBA,$00C0         ; JSR     $00850E(PC); $00844C
        LEA     $00FF68F8,A1                    ; $008450
        MOVE.L  #$04028070,-$0004(A1)           ; $008456
        MOVE.B  D0,-$0007(A1)                   ; $00845E
        MOVE.B  D1,(A1)+                        ; $008462
        DC.W    $4EBA,$FF34         ; JSR     $00839A(PC); $008464
        LEA     (-24832).W,A1                   ; $008468
.loc_0088:
        TST.W  (-16306).W                       ; $00846C
        BEQ.S  .loc_00A6                        ; $008470
        MOVEQ   #$00,D7                         ; $008472
        SUBQ.W  #1,(-16306).W                   ; $008474
        BEQ.S  .loc_00A0                        ; $008478
        BTST    #2,(-14165).W                   ; $00847A
        BNE.S  .loc_00A0                        ; $008480
        MOVEQ   #$03,D7                         ; $008482
.loc_00A0:
        MOVE.B  D7,$00FF68F0                    ; $008484
.loc_00A6:
        BTST    #6,$0002(A1)                    ; $00848A
        BEQ.S  .loc_00F0                        ; $008490
        ANDI.W  #$BFFF,$0002(A1)                ; $008492
        CLR.W  (-14166).W                       ; $008498
        LEA     (-22288).W,A2                   ; $00849C
        LEA     (-22528).W,A3                   ; $0084A0
        MOVEQ   #$00,D1                         ; $0084A4
        MOVE.B  (-22047).W,D1                   ; $0084A6
        DC.W    $4EBA,$0048         ; JSR     $0084F4(PC); $0084AA
        BEQ.S  .loc_00D4                        ; $0084AE
        MOVE.W  #$0000,(-18514).W               ; $0084B0
        BRA.S  .loc_010E                        ; $0084B6
.loc_00D4:
        DC.W    $4EBA,$0054         ; JSR     $00850E(PC); $0084B8
        LEA     $00FF68F8,A1                    ; $0084BC
        MOVE.L  #$04034070,-$0004(A1)           ; $0084C2
        MOVE.B  D0,-$0007(A1)                   ; $0084CA
        MOVE.B  D1,(A1)+                        ; $0084CE
        DC.W    $4EBA,$FEC8         ; JSR     $00839A(PC); $0084D0
.loc_00F0:
        TST.W  (-18514).W                       ; $0084D4
        BEQ.S  .loc_010E                        ; $0084D8
        MOVEQ   #$00,D7                         ; $0084DA
        SUBQ.W  #1,(-18514).W                   ; $0084DC
        BEQ.S  .loc_0108                        ; $0084E0
        BTST    #2,(-14165).W                   ; $0084E2
        BNE.S  .loc_0108                        ; $0084E8
        MOVEQ   #$03,D7                         ; $0084EA
.loc_0108:
        MOVE.B  D7,$00FF68F0                    ; $0084EC
.loc_010E:
        RTS                                     ; $0084F2
