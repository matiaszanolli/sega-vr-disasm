; ============================================================================
; Sh2 Comm Send Cmd 021 (auto-analyzed)
; ROM Range: $0126A6-$0126D2 (44 bytes)
; ============================================================================
; Category: sh2
; Purpose: Calls: sh2_send_cmd
;
; Uses: D0, D1, D5, A0
; Calls:
;   $00E35A: sh2_send_cmd
; Confidence: medium
; ============================================================================

fn_12200_021:
        MOVEA.L #$0601F9C0,A0                   ; $0126A6
        MOVEQ   #$00,D0                         ; $0126AC
        ANDI.W  #$0003,D5                       ; $0126AE
        TST.W  D5                               ; $0126B2
        BEQ.S  .loc_001C                        ; $0126B4
        SUBQ.W  #1,D5                           ; $0126B6
.loc_0012:
        ADDI.L  #$00000380,D0                   ; $0126B8
        DBRA    D5,.loc_0012                    ; $0126BE
.loc_001C:
        ADDA.L  D0,A0                           ; $0126C2
        MOVE.W  #$0038,D0                       ; $0126C4
        MOVE.W  #$0010,D1                       ; $0126C8
        DC.W    $4EBA,$BC8C         ; JSR     $00E35A(PC); $0126CC
        RTS                                     ; $0126D0
