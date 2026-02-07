; ============================================================================
; Fm Init Channel 054 (auto-analyzed)
; ROM Range: $031418-$0314DC (196 bytes)
; ============================================================================
; Category: sound
; Purpose: Orchestrator calling 4 subroutines
;   Accesses VDP registers
;   Calls: fm_init_channel, fm_set_volume, fm_write_wrapper
;   Object (A0, A5, A6): +$00, +$01, +$08, +$0B, +$0E (param_e), +$0F
;
; Entry: A0 = object/entity pointer
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, A0, A1, A3, A5, A6
; Calls:
;   $030C8A: fm_init_channel
;   $030CBA: fm_write_wrapper
;   $030FB2: fm_set_volume
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$08: [unknown]
;   +$0B: [unknown]
;   +$0E: param_e
;   +$0F: [unknown]
;   +$25: [unknown]
;   +$30: x_position
; Confidence: high
; ============================================================================

fn_30200_054:
        BCLR    #7,(A5)                         ; $031418
        BCLR    #4,(A5)                         ; $03141C
        TST.B  $0001(A5)                        ; $031420
        BMI.S  .loc_001C                        ; $031424
        TST.B  $0008(A6)                        ; $031426
        BMI.W  .loc_00C0                        ; $03142A
        DC.W    $4EBA,$F85A         ; JSR     $030C8A(PC); $03142E
        BRA.S  .loc_0020                        ; $031432
.loc_001C:
        DC.W    $4EBA,$FB7C         ; JSR     $030FB2(PC); $031434
.loc_0020:
        TST.B  $000E(A6)                        ; $031438
        BPL.W  .loc_00C0                        ; $03143C
        CLR.B  $0000(A6)                        ; $031440
        MOVEQ   #$00,D0                         ; $031444
        MOVE.B  $0001(A5),D0                    ; $031446
        BMI.S  .loc_008A                        ; $03144A
        DC.W    $41FA,$F404         ; LEA     $030852(PC),A0; $03144C
        MOVEA.L A5,A3                           ; $031450
        CMPI.B  #$04,D0                         ; $031452
        BNE.S  .loc_0050                        ; $031456
        TST.B  $0340(A6)                        ; $031458
        BPL.S  .loc_0050                        ; $03145C
        LEA     $0340(A6),A5                    ; $03145E
        MOVEA.L $0034(A6),A1                    ; $031462
        BRA.S  .loc_0060                        ; $031466
.loc_0050:
        SUBQ.B  #2,D0                           ; $031468
        LSL.B  #2,D0                            ; $03146A
        MOVEA.L $00(A0,D0.W),A5                 ; $03146C
        TST.B  (A5)                             ; $031470
        BPL.S  .loc_0070                        ; $031472
        MOVEA.L $0030(A6),A1                    ; $031474
.loc_0060:
        BCLR    #2,(A5)                         ; $031478
        BSET    #1,(A5)                         ; $03147C
        MOVE.B  $000B(A5),D0                    ; $031480
        DC.W    $4EBA,$FE62         ; JSR     $0312E8(PC); $031484
.loc_0070:
        MOVEA.L A3,A5                           ; $031488
        CMPI.B  #$02,$0001(A5)                  ; $03148A
        BNE.S  .loc_00C0                        ; $031490
        TST.B  $000F(A6)                        ; $031492
        BNE.S  .loc_00C0                        ; $031496
        MOVEQ   #$00,D1                         ; $031498
        MOVEQ   #$27,D0                         ; $03149A
        DC.W    $4EBA,$F81C         ; JSR     $030CBA(PC); $03149C
        BRA.S  .loc_00C0                        ; $0314A0
.loc_008A:
        LEA     $0370(A6),A0                    ; $0314A2
        TST.B  (A0)                             ; $0314A6
        BPL.S  .loc_009E                        ; $0314A8
        CMPI.B  #$E0,D0                         ; $0314AA
        BEQ.S  .loc_00A8                        ; $0314AE
        CMPI.B  #$C0,D0                         ; $0314B0
        BEQ.S  .loc_00A8                        ; $0314B4
.loc_009E:
        DC.W    $41FA,$F39A         ; LEA     $030852(PC),A0; $0314B6
        LSR.B  #3,D0                            ; $0314BA
        MOVEA.L $00(A0,D0.W),A0                 ; $0314BC
.loc_00A8:
        BCLR    #2,(A0)                         ; $0314C0
        BSET    #1,(A0)                         ; $0314C4
        CMPI.B  #$E0,$0001(A0)                  ; $0314C8
        BNE.S  .loc_00C0                        ; $0314CE
        MOVE.B  $0025(A0),$00C00011             ; $0314D0
.loc_00C0:
        ADDQ.W  #8,A7                           ; $0314D8
        RTS                                     ; $0314DA
