; ============================================================================
; Fm Init Channel 014 (auto-analyzed)
; ROM Range: $03061C-$03078C (368 bytes)
; ============================================================================
; Category: sound
; Purpose: Orchestrator calling 6 subroutines
;   Accesses VDP registers
;   Calls: fm_write_wrapper, z80_bus_request, fm_init_channel, fm_set_volume
;   Object (A0, A1, A3, A4, A6): +$00, +$01, +$02 (flags/type), +$03, +$04 (speed_index/velocity), +$05
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A3 = object/entity pointer
; Entry: A4 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D4, D5, D6, D7, A0, A1
; Calls:
;   $030C8A: fm_init_channel
;   $030CBA: fm_write_wrapper
;   $030D1C: z80_bus_request
;   $030FB2: fm_set_volume
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$02: flags/type
;   +$03: [unknown]
;   +$04: speed_index/velocity
;   +$05: [unknown]
;   +$08: [unknown]
;   +$0A: param_a
; Confidence: high
; ============================================================================

fn_30200_014:
        DC.W    $4EBA,$05C2         ; JSR     $030BE0(PC); $03061C
        DC.W    $49FA,$2496         ; LEA     $032AB8(PC),A4; $030620
        SUBI.B  #$81,D7                         ; $030624
        LSL.W  #2,D7                            ; $030628
        MOVEA.L $00(A4,D7.W),A4                 ; $03062A
        MOVEQ   #$00,D0                         ; $03062E
        MOVE.W  (A4),D0                         ; $030630
        ADD.L  A4,D0                            ; $030632
        MOVE.L  D0,$0030(A6)                    ; $030634
        MOVE.B  $0005(A4),$0002(A6)             ; $030638
        MOVE.B  $0005(A4),$0001(A6)             ; $03063E
        MOVEQ   #$00,D1                         ; $030644
        MOVEA.L A4,A3                           ; $030646
        ADDQ.W  #6,A4                           ; $030648
        MOVEQ   #$00,D7                         ; $03064A
        MOVE.B  $0002(A3),D7                    ; $03064C
        BEQ.S  .loc_00AC                        ; $030650
        SUBQ.B  #1,D7                           ; $030652
        MOVE.B  #$C0,D1                         ; $030654
        MOVE.B  $0004(A3),D4                    ; $030658
        MOVEQ   #$30,D6                         ; $03065C
        MOVE.B  #$01,D5                         ; $03065E
        LEA     $0040(A6),A1                    ; $030662
        DC.W    $45FA,$0124         ; LEA     $03078C(PC),A2; $030666
.loc_004E:
        BSET    #7,(A1)                         ; $03066A
        MOVE.B  (A2)+,$0001(A1)                 ; $03066E
        MOVE.B  D4,$0002(A1)                    ; $030672
        MOVE.B  D6,$000D(A1)                    ; $030676
        MOVE.B  D1,$0027(A1)                    ; $03067A
        MOVE.B  D5,$000E(A1)                    ; $03067E
        MOVEQ   #$00,D0                         ; $030682
        MOVE.W  (A4)+,D0                        ; $030684
        ADD.L  A3,D0                            ; $030686
        MOVE.L  D0,$0004(A1)                    ; $030688
        MOVE.W  (A4)+,$0008(A1)                 ; $03068C
        ADDA.W  D6,A1                           ; $030690
        DBRA    D7,.loc_004E                    ; $030692
        CMPI.B  #$07,$0002(A3)                  ; $030696
        BNE.S  .loc_008C                        ; $03069C
        MOVEQ   #$2B,D0                         ; $03069E
        MOVEQ   #$00,D1                         ; $0306A0
        DC.W    $4EBA,$0616         ; JSR     $030CBA(PC); $0306A2
        BRA.S  .loc_00AC                        ; $0306A6
.loc_008C:
        MOVEQ   #$28,D0                         ; $0306A8
        MOVEQ   #$06,D1                         ; $0306AA
        DC.W    $4EBA,$060C         ; JSR     $030CBA(PC); $0306AC
        MOVE.B  #$B6,D0                         ; $0306B0
        MOVE.B  #$C0,D1                         ; $0306B4
        DC.W    $4EBA,$0662         ; JSR     $030D1C(PC); $0306B8
        DC.W    $4EBA,$0640         ; JSR     $030CFE(PC); $0306BC
        MOVE.W  #$0000,$00A11100                ; $0306C0
.loc_00AC:
        MOVEQ   #$00,D7                         ; $0306C8
        MOVE.B  $0003(A3),D7                    ; $0306CA
        BEQ.S  .loc_00EE                        ; $0306CE
        SUBQ.B  #1,D7                           ; $0306D0
        LEA     $0190(A6),A1                    ; $0306D2
        DC.W    $45FA,$00BC         ; LEA     $030794(PC),A2; $0306D6
.loc_00BE:
        BSET    #7,(A1)                         ; $0306DA
        MOVE.B  (A2)+,$0001(A1)                 ; $0306DE
        MOVE.B  D4,$0002(A1)                    ; $0306E2
        MOVE.B  D6,$000D(A1)                    ; $0306E6
        MOVE.B  D5,$000E(A1)                    ; $0306EA
        MOVEQ   #$00,D0                         ; $0306EE
        MOVE.W  (A4)+,D0                        ; $0306F0
        ADD.L  A3,D0                            ; $0306F2
        MOVE.L  D0,$0004(A1)                    ; $0306F4
        MOVE.W  (A4)+,$0008(A1)                 ; $0306F8
        MOVE.B  (A4)+,$000A(A1)                 ; $0306FC
        MOVE.B  (A4)+,$000B(A1)                 ; $030700
        ADDA.W  D6,A1                           ; $030704
        DBRA    D7,.loc_00BE                    ; $030706
.loc_00EE:
        LEA     $0220(A6),A1                    ; $03070A
        MOVEQ   #$05,D7                         ; $03070E
.loc_00F4:
        TST.B  (A1)                             ; $030710
        BPL.W  .loc_0116                        ; $030712
        MOVEQ   #$00,D0                         ; $030716
        MOVE.B  $0001(A1),D0                    ; $030718
        BMI.S  .loc_0108                        ; $03071C
        SUBQ.B  #2,D0                           ; $03071E
        LSL.B  #2,D0                            ; $030720
        BRA.S  .loc_010A                        ; $030722
.loc_0108:
        LSR.B  #3,D0                            ; $030724
.loc_010A:
        DC.W    $41FA,$012A         ; LEA     $030852(PC),A0; $030726
        MOVEA.L $00(A0,D0.W),A0                 ; $03072A
        BSET    #2,(A0)                         ; $03072E
.loc_0116:
        ADDA.W  D6,A1                           ; $030732
        DBRA    D7,.loc_00F4                    ; $030734
        TST.W  $0340(A6)                        ; $030738
        BPL.S  .loc_0128                        ; $03073C
        BSET    #2,$0100(A6)                    ; $03073E
.loc_0128:
        TST.W  $0370(A6)                        ; $030744
        BPL.S  .loc_0134                        ; $030748
        BSET    #2,$01F0(A6)                    ; $03074A
.loc_0134:
        LEA     $0070(A6),A5                    ; $030750
        MOVEQ   #$05,D4                         ; $030754
.loc_013A:
        BTST    #2,(A5)                         ; $030756
        BNE.S  .loc_0144                        ; $03075A
        DC.W    $4EBA,$052C         ; JSR     $030C8A(PC); $03075C
.loc_0144:
        ADDA.W  D6,A5                           ; $030760
        DBRA    D4,.loc_013A                    ; $030762
        MOVEQ   #$02,D4                         ; $030766
.loc_014C:
        BTST    #2,(A5)                         ; $030768
        BNE.S  .loc_0156                        ; $03076C
        DC.W    $4EBA,$0842         ; JSR     $030FB2(PC); $03076E
.loc_0156:
        ADDA.W  D6,A5                           ; $030772
        DBRA    D4,.loc_014C                    ; $030774
        BTST    #2,$01F0(A6)                    ; $030778
        BNE.S  .loc_016C                        ; $03077E
        MOVE.B  #$FF,$00C00011                  ; $030780
.loc_016C:
        ADDQ.W  #4,A7                           ; $030788
        RTS                                     ; $03078A
