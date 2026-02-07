; ============================================================================
; Obj Reg Write 002 (auto-analyzed)
; ROM Range: $006240-$006496 (598 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 42 subroutines
;   RAM: $9F00 (obj_table_3)
;   Calls: state_jump_indexed, vdp_reg_write, vdp_dma_setup, obj_angle_calc
;   Object (A0, A1, A6): +$00, +$18, +$44 (display_offset), +$46 (display_scale), +$4A, +$88
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; RAM:
;   $9F00: obj_table_3
; Calls:
;   $003126: vdp_reg_write
;   $003160: vdp_dma_setup
;   $0036DE: clear_buffer
;   $0037B6: memory_copy
;   $003F86: clear_display_vars
;   $006F98: calc_steering
; Object fields:
;   +$00: [unknown]
;   +$18: [unknown]
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: [unknown]
;   +$88: [unknown]
;   +$92: param_92
;   +$B2: [unknown]
; Confidence: high
; ============================================================================

fn_6200_002:
        DC.W    $0088                           ; $006240
        DC.W    $3C7E                           ; $006242
        DC.W    $0088                           ; $006244
        MOVE.W  (A2)+,$0088(A6)                 ; $006246
        MOVE.W  (A2)+,$0088(A6)                 ; $00624A
        MOVE.W  (A2)+,$0088(A6)                 ; $00624E
        MOVE.W  (A2)+,$0088(A6)                 ; $006252
        MOVE.W  (A2)+,$7000(A6)                 ; $006256
        MOVE.W  D0,$0044(A0)                    ; $00625A
        MOVE.W  D0,$0046(A0)                    ; $00625E
        MOVE.W  D0,$004A(A0)                    ; $006262
        DC.W    $4EBA,$0EE2         ; JSR     $00714A(PC); $006266
        DC.W    $4EBA,$13E2         ; JSR     $00764E(PC); $00626A
        DC.W    $4EBA,$2458         ; JSR     $0086C8(PC); $00626E
        DC.W    $4EBA,$CEB2         ; JSR     $003126(PC); $006272
        DC.W    $4EBA,$CEE8         ; JSR     $003160(PC); $006276
        DC.W    $4EBA,$13A8         ; JSR     $007624(PC); $00627A
        DC.W    $4EBA,$10CE         ; JSR     $00734E(PC); $00627E
        MOVE.B  (-15612).W,(-15604).W           ; $006282
        JSR     $00886C88                       ; $006288
        DC.W    $4EFA,$E71A         ; JMP     $0049AA(PC); $00628E
        MOVEQ   #$00,D0                         ; $006292
        MOVE.W  D0,$0044(A0)                    ; $006294
        MOVE.W  D0,$0046(A0)                    ; $006298
        MOVE.W  D0,$004A(A0)                    ; $00629C
        MOVE.L  #$00100010,(-13968).W           ; $0062A0
        MOVE.W  #$0002,$0092(A0)                ; $0062A8
        DC.W    $4EBA,$22EA         ; JSR     $00859A(PC); $0062AE
        DC.W    $4EBA,$409C         ; JSR     $00A350(PC); $0062B2
        DC.W    $4EBA,$1EB8         ; JSR     $008170(PC); $0062B6
        DC.W    $4EBA,$1E10         ; JSR     $0080CC(PC); $0062BA
        DC.W    $4EBA,$2288         ; JSR     $008548(PC); $0062BE
        DC.W    $4EBA,$3236         ; JSR     $0094FA(PC); $0062C2
        DC.W    $4EBA,$304A         ; JSR     $009312(PC); $0062C6
        DC.W    $4EBA,$3846         ; JSR     $009B12(PC); $0062CA
        DC.W    $4EBA,$2EB2         ; JSR     $009182(PC); $0062CE
        DC.W    $4EBA,$334A         ; JSR     $00961E(PC); $0062D2
        DC.W    $4EBA,$33B0         ; JSR     $009688(PC); $0062D6
        DC.W    $4EBA,$3526         ; JSR     $009802(PC); $0062DA
        DC.W    $4EBA,$1B9A         ; JSR     $007E7A(PC); $0062DE
        DC.W    $4EBA,$0CB4         ; JSR     $006F98(PC); $0062E2
        DC.W    $4EBA,$19F0         ; JSR     $007CD8(PC); $0062E6
        DC.W    $4EBA,$4148         ; JSR     $00A434(PC); $0062EA
        DC.W    $4EBA,$0DBA         ; JSR     $0070AA(PC); $0062EE
        DC.W    $4EBA,$1C10         ; JSR     $007F04(PC); $0062F2
        DC.W    $4EBA,$1956         ; JSR     $007C4E(PC); $0062F6
        DC.W    $4EBA,$0E4E         ; JSR     $00714A(PC); $0062FA
        DC.W    $4EBA,$134E         ; JSR     $00764E(PC); $0062FE
        DC.W    $4EBA,$1C4C         ; JSR     $007F50(PC); $006302
        DC.W    $4EBA,$39C6         ; JSR     $009CCE(PC); $006306
        DC.W    $4EBA,$3848         ; JSR     $009B54(PC); $00630A
        DC.W    $4EBA,$23B8         ; JSR     $0086C8(PC); $00630E
        DC.W    $4EBA,$49C0         ; JSR     $00ACD4(PC); $006312
        DC.W    $4EBA,$E116         ; JSR     $00442E(PC); $006316
        DC.W    $4EBA,$CE0A         ; JSR     $003126(PC); $00631A
        DC.W    $4EBA,$CE40         ; JSR     $003160(PC); $00631E
        DC.W    $4EBA,$1300         ; JSR     $007624(PC); $006322
        DC.W    $4EBA,$1026         ; JSR     $00734E(PC); $006326
        DC.W    $4EBA,$D3B2         ; JSR     $0036DE(PC); $00632A
        DC.W    $4EBA,$D486         ; JSR     $0037B6(PC); $00632E
        DC.W    $4EBA,$DC52         ; JSR     $003F86(PC); $006332
        DC.W    $4EFA,$2D2C         ; JMP     $009064(PC); $006336
        MOVEQ   #$00,D0                         ; $00633A
        MOVE.W  D0,$0044(A0)                    ; $00633C
        MOVE.W  D0,$0046(A0)                    ; $006340
        MOVE.W  D0,$004A(A0)                    ; $006344
        DC.W    $4EBA,$1D82         ; JSR     $0080CC(PC); $006348
        DC.W    $4EBA,$21FA         ; JSR     $008548(PC); $00634C
        DC.W    $4EBA,$34B0         ; JSR     $009802(PC); $006350
        DC.W    $4EBA,$1B24         ; JSR     $007E7A(PC); $006354
        DC.W    $4EBA,$0C3E         ; JSR     $006F98(PC); $006358
        DC.W    $4EBA,$197A         ; JSR     $007CD8(PC); $00635C
        DC.W    $4EBA,$0D48         ; JSR     $0070AA(PC); $006360
        DC.W    $4EBA,$0DE4         ; JSR     $00714A(PC); $006364
        DC.W    $4EBA,$12E4         ; JSR     $00764E(PC); $006368
        DC.W    $4EBA,$1BE2         ; JSR     $007F50(PC); $00636C
        DC.W    $4EBA,$395C         ; JSR     $009CCE(PC); $006370
        DC.W    $4EBA,$37DE         ; JSR     $009B54(PC); $006374
        DC.W    $4EBA,$2400         ; JSR     $00877A(PC); $006378
        DC.W    $4EBA,$2D26         ; JSR     $0090A4(PC); $00637C
        DC.W    $4EBA,$CDA4         ; JSR     $003126(PC); $006380
        DC.W    $4EBA,$1278         ; JSR     $0075FE(PC); $006384
        DC.W    $4EBA,$0E1C         ; JSR     $0071A6(PC); $006388
        DC.W    $4EBA,$D350         ; JSR     $0036DE(PC); $00638C
        DC.W    $4EFA,$D424         ; JMP     $0037B6(PC); $006390
        MOVEQ   #$00,D0                         ; $006394
        MOVE.W  D0,$0044(A0)                    ; $006396
        MOVE.W  D0,$0046(A0)                    ; $00639A
        MOVE.W  D0,$004A(A0)                    ; $00639E
        MOVE.L  #$00100010,(-13968).W           ; $0063A2
        MOVE.W  #$0002,$0092(A0)                ; $0063AA
        BCLR    #4,(-15602).W                   ; $0063B0
        DC.W    $4EBA,$21E2         ; JSR     $00859A(PC); $0063B6
        DC.W    $4EBA,$218C         ; JSR     $008548(PC); $0063BA
        DC.W    $4EBA,$2F52         ; JSR     $009312(PC); $0063BE
        DC.W    $4EBA,$374E         ; JSR     $009B12(PC); $0063C2
        DC.W    $4EBA,$2DBA         ; JSR     $009182(PC); $0063C6
        DC.W    $4EBA,$3252         ; JSR     $00961E(PC); $0063CA
        DC.W    $4EBA,$0BC8         ; JSR     $006F98(PC); $0063CE
        DC.W    $4EBA,$4060         ; JSR     $00A434(PC); $0063D2
        DC.W    $4EBA,$0CD2         ; JSR     $0070AA(PC); $0063D6
        DC.W    $4EBA,$1872         ; JSR     $007C4E(PC); $0063DA
        DC.W    $4EBA,$0D6A         ; JSR     $00714A(PC); $0063DE
        DC.W    $4EBA,$126A         ; JSR     $00764E(PC); $0063E2
        DC.W    $4EBA,$38E6         ; JSR     $009CCE(PC); $0063E6
        DC.W    $4EBA,$3768         ; JSR     $009B54(PC); $0063EA
        DC.W    $4EBA,$238A         ; JSR     $00877A(PC); $0063EE
        DC.W    $4EBA,$2CB0         ; JSR     $0090A4(PC); $0063F2
        DC.W    $4EBA,$CD2E         ; JSR     $003126(PC); $0063F6
        DC.W    $4EBA,$1202         ; JSR     $0075FE(PC); $0063FA
        DC.W    $4EBA,$0DA6         ; JSR     $0071A6(PC); $0063FE
        DC.W    $4EBA,$D2DA         ; JSR     $0036DE(PC); $006402
        DC.W    $4EBA,$D3AE         ; JSR     $0037B6(PC); $006406
        DC.W    $4EFA,$DB7A         ; JMP     $003F86(PC); $00640A
        LEA     (-24576).W,A4                   ; $00640E
        LEA     (-28672).W,A0                   ; $006412
        MOVE.B  (-337).W,(-15601).W             ; $006416
        DC.W    $4EBA,$07A0         ; JSR     $006BBE(PC); $00641C
        MOVE.L  $00B2(A0),$0018(A0)             ; $006420
        MOVE.B  $00E5(A0),D1                    ; $006426
        ANDI.B  #$06,D1                         ; $00642A
        BEQ.S  .loc_01F6                        ; $00642E
        MOVE.L  (-14580).W,$0018(A0)            ; $006430
.loc_01F6:
        MOVE.W  (-16262).W,D0                   ; $006436
        DC.W    $43FA,$0160         ; LEA     $00659C(PC),A1; $00643A
        MOVEA.L $00(A1,D0.W),A1                 ; $00643E
        JSR     (A1)                            ; $006442
        DC.W    $4EBA,$1ABE         ; JSR     $007F04(PC); $006444
        DC.W    $4EBA,$1F72         ; JSR     $0083BC(PC); $006448
        LEA     (-24832).W,A1                   ; $00644C
        DC.W    $4EBA,$2220         ; JSR     $008672(PC); $006450
        LEA     (-32356).W,A1                   ; $006454
        DC.W    $4EBA,$2C74         ; JSR     $0090CE(PC); $006458
        LEA     (-16384).W,A2                   ; $00645C
        LEA     (-19456).W,A1                   ; $006460
        MOVEQ   #$1F,D7                         ; $006464
.loc_0226:
        MOVEM.L (A2)+,D0/D1/D2/D3/D4/D5/D6/A3   ; $006466
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,-(A1)   ; $00646A
        DBRA    D7,.loc_0226                    ; $00646E
        MOVE.L  (-13968).W,(-13960).W           ; $006472
        MOVE.L  (-13964).W,(-13968).W           ; $006478
        LEA     (-19456).W,A1                   ; $00647E
        LEA     (-15360).W,A2                   ; $006482
        MOVEQ   #$1F,D7                         ; $006486
.loc_0248:
        MOVEM.L (A1)+,D0/D1/D2/D3/D4/D5/D6/A3   ; $006488
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,-(A2)   ; $00648C
        DBRA    D7,.loc_0248                    ; $006490
        RTS                                     ; $006494
