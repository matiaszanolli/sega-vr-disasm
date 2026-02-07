; ============================================================================
; Fm Write Conditional 010 (auto-analyzed)
; ROM Range: $03046C-$030536 (202 bytes)
; ============================================================================
; Category: sound
; Purpose: Orchestrator calling 4 subroutines
;   Calls: z80_bus_request, fm_write_port0, fm_write_conditional
;   Object (A5, A6): +$07, +$27, +$40 (heading_angle)
;
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, A5, A6
; Calls:
;   $030CCC: fm_write_conditional
;   $030CD8: fm_write_port0
;   $030D1C: z80_bus_request
; Object fields:
;   +$07: [unknown]
;   +$27: [unknown]
;   +$40: heading_angle
; Confidence: high
; ============================================================================

fn_30200_010:
        DC.W    $008B                           ; $03046C
        SUBI.W  #$008B,($047A).W                ; $03046E
        DC.W    $008B                           ; $030474
        DC.W    $047D                           ; $030476
        NEGX.L D0                               ; $030478
        MOVE    SR,D0                           ; $03047A
        DIVU    D0,D0                           ; $03047C
        DIVU    D0,D0                           ; $03047E
        NEGX.B D0                               ; $030480
        BMI.S  .loc_0052                        ; $030482
        MOVEQ   #$02,D2                         ; $030484
        MOVE.B  #$B4,D0                         ; $030486
        MOVEQ   #$00,D1                         ; $03048A
        DC.W    $4EBA,$088E         ; JSR     $030D1C(PC); $03048C
.loc_0024:
        DC.W    $4EBA,$0846         ; JSR     $030CD8(PC); $030490
        DC.W    $4EBA,$0868         ; JSR     $030CFE(PC); $030494
        ADDQ.B  #1,D0                           ; $030498
        DBRA    D2,.loc_0024                    ; $03049A
        MOVEQ   #$02,D2                         ; $03049E
        MOVEQ   #$28,D0                         ; $0304A0
.loc_0036:
        MOVE.B  D2,D1                           ; $0304A2
        DC.W    $4EBA,$0832         ; JSR     $030CD8(PC); $0304A4
        ADDQ.B  #4,D1                           ; $0304A8
        DC.W    $4EBA,$082C         ; JSR     $030CD8(PC); $0304AA
        DBRA    D2,.loc_0036                    ; $0304AE
        MOVE.W  #$0000,$00A11100                ; $0304B2
        DC.W    $6000,$0B0C         ; BRA.W  $030FC8; $0304BA
.loc_0052:
        CLR.B  $0007(A6)                        ; $0304BE
        MOVEQ   #$30,D3                         ; $0304C2
        LEA     $0040(A6),A5                    ; $0304C4
        MOVEQ   #$06,D4                         ; $0304C8
        DC.W    $4EBA,$0850         ; JSR     $030D1C(PC); $0304CA
.loc_0062:
        BTST    #7,(A5)                         ; $0304CE
        BEQ.S  .loc_007A                        ; $0304D2
        BTST    #2,(A5)                         ; $0304D4
        BNE.S  .loc_007A                        ; $0304D8
        MOVE.B  #$B4,D0                         ; $0304DA
        MOVE.B  $0027(A5),D1                    ; $0304DE
        DC.W    $4EBA,$07E8         ; JSR     $030CCC(PC); $0304E2
.loc_007A:
        ADDA.W  D3,A5                           ; $0304E6
        DBRA    D4,.loc_0062                    ; $0304E8
        LEA     $0220(A6),A5                    ; $0304EC
        MOVEQ   #$02,D4                         ; $0304F0
.loc_0086:
        BTST    #7,(A5)                         ; $0304F2
        BEQ.S  .loc_009E                        ; $0304F6
        BTST    #2,(A5)                         ; $0304F8
        BNE.S  .loc_009E                        ; $0304FC
        MOVE.B  #$B4,D0                         ; $0304FE
        MOVE.B  $0027(A5),D1                    ; $030502
        DC.W    $4EBA,$07C4         ; JSR     $030CCC(PC); $030506
.loc_009E:
        ADDA.W  D3,A5                           ; $03050A
        DBRA    D4,.loc_0086                    ; $03050C
        LEA     $0340(A6),A5                    ; $030510
        BTST    #7,(A5)                         ; $030514
        BEQ.S  .loc_00C0                        ; $030518
        BTST    #2,(A5)                         ; $03051A
        BNE.S  .loc_00C0                        ; $03051E
        MOVE.B  #$B4,D0                         ; $030520
        MOVE.B  $0027(A5),D1                    ; $030524
        DC.W    $4EBA,$07A2         ; JSR     $030CCC(PC); $030528
.loc_00C0:
        MOVE.W  #$0000,$00A11100                ; $03052C
        RTS                                     ; $030534
