; ============================================================================
; Fm 032 (auto-analyzed)
; ROM Range: $030E20-$030ECE (174 bytes)
; ============================================================================
; Category: sound
; Purpose: Orchestrator calling 9 subroutines
;   Object (A0, A5): +$00, +$04 (speed_index/velocity), +$08, +$0E (param_e), +$10
;
; Entry: A0 = object/entity pointer
; Entry: A5 = object/entity pointer
; Uses: D1, D5, D6, A0, A3, A4, A5, A6
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
;   +$08: [unknown]
;   +$0E: param_e
;   +$10: [unknown]
; Confidence: low
; ============================================================================

fn_30200_032:
        ANDI.W  #$0284,(A6)+                    ; $030E20
        ANDI.L  #$02D302FE,$032D(A3)            ; $030E24
        BCHG    D1,(A4)+                        ; $030E2C
        DC.W    $038F                           ; $030E2E
        BSET    D1,D5                           ; $030E30
        DC.W    $03FF                           ; $030E32
        DC.W    $043C                           ; $030E34
        DC.W    $047C                           ; $030E36
        SUBQ.B  #1,$000E(A5)                    ; $030E38
        BNE.S  .loc_002E                        ; $030E3C
        BCLR    #4,(A5)                         ; $030E3E
        DC.W    $4EBA,$001A         ; JSR     $030E5E(PC); $030E42
        DC.W    $4EBA,$007A         ; JSR     $030EC2(PC); $030E46
        DC.W    $6000,$00CA         ; BRA.W  $030F16; $030E4A
.loc_002E:
        DC.W    $4EBA,$F3CA         ; JSR     $03021A(PC); $030E4E
        DC.W    $4EBA,$00BA         ; JSR     $030F0E(PC); $030E52
        DC.W    $4EBA,$F3EA         ; JSR     $030242(PC); $030E56
        DC.W    $6000,$0072         ; BRA.W  $030ECE; $030E5A
        BCLR    #1,(A5)                         ; $030E5E
        MOVEA.L $0004(A5),A4                    ; $030E62
.loc_0046:
        MOVEQ   #$00,D5                         ; $030E66
        MOVE.B  (A4)+,D5                        ; $030E68
        CMPI.B  #$E0,D5                         ; $030E6A
        BCS.S  .loc_0056                        ; $030E6E
        DC.W    $4EBA,$0222         ; JSR     $031094(PC); $030E70
        BRA.S  .loc_0046                        ; $030E74
.loc_0056:
        TST.B  D5                               ; $030E76
        BPL.S  .loc_006A                        ; $030E78
        DC.W    $4EBA,$0016         ; JSR     $030E92(PC); $030E7A
        MOVE.B  (A4)+,D5                        ; $030E7E
        TST.B  D5                               ; $030E80
        BPL.S  .loc_006A                        ; $030E82
        SUBQ.W  #1,A4                           ; $030E84
        DC.W    $6000,$F34A         ; BRA.W  $0301D2; $030E86
.loc_006A:
        DC.W    $4EBA,$F326         ; JSR     $0301B2(PC); $030E8A
        DC.W    $6000,$F342         ; BRA.W  $0301D2; $030E8E
        SUBI.B  #$81,D5                         ; $030E92
        BCS.S  .loc_0090                        ; $030E96
        ADD.B  $0008(A5),D5                     ; $030E98
        ANDI.W  #$007F,D5                       ; $030E9C
        LSL.W  #1,D5                            ; $030EA0
        DC.W    $41FA,$013C         ; LEA     $030FE0(PC),A0; $030EA2
        MOVE.W  $00(A0,D5.W),$0010(A5)          ; $030EA6
        DC.W    $6000,$F324         ; BRA.W  $0301D2; $030EAC
.loc_0090:
        BSET    #1,(A5)                         ; $030EB0
        MOVE.W  #$FFFF,$0010(A5)                ; $030EB4
        DC.W    $4EBA,$F316         ; JSR     $0301D2(PC); $030EBA
        DC.W    $6000,$00F2         ; BRA.W  $030FB2; $030EBE
        MOVE.W  $0010(A5),D6                    ; $030EC2
        DC.W    $6A0C               ; BPL.S  $030ED4; $030EC6
        BSET    #1,(A5)                         ; $030EC8
        RTS                                     ; $030ECC
