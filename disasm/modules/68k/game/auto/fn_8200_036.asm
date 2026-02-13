; ============================================================================
; Vint 036 (auto-analyzed)
; ROM Range: $0094F4-$00961E (298 bytes)
; ============================================================================
; Category: vint
; Purpose: RAM: $C8C8 (vint_state)
;   Object (A0, A1): +$00, +$01, +$8E (velocity_y), +$94, +$AA
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, A0, A1
; RAM:
;   $C8C8: vint_state
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$8E: velocity_y
;   +$94: [unknown]
;   +$AA: [unknown]
; Confidence: medium
; ============================================================================

fn_8200_036:
        DC.W    $FFE8                           ; $0094F4
        ORI.B  #$18,D0                          ; $0094F6
        MOVE.B  (-15616).W,(-15615).W           ; $0094FA
        MOVE.B  (-13967).W,(-15616).W           ; $009500
        MOVEQ   #$02,D2                         ; $009506
        MOVEQ   #$03,D3                         ; $009508
        BTST    #7,(-600).W                     ; $00950A
        BEQ.S  .loc_0020                        ; $009510
        DC.W    $C543                           ; $009512
.loc_0020:
        LEA     (-15616).W,A1                   ; $009514
        MOVEQ   #$00,D0                         ; $009518
        MOVEQ   #$00,D1                         ; $00951A
        BTST    D2,$0001(A1)                    ; $00951C
        BEQ.S  .loc_0030                        ; $009520
        MOVEQ   #$01,D0                         ; $009522
.loc_0030:
        BTST    D3,$0001(A1)                    ; $009524
        BEQ.S  .loc_0038                        ; $009528
        SUBQ.W  #1,D0                           ; $00952A
.loc_0038:
        BTST    D2,(A1)                         ; $00952C
        BEQ.S  .loc_003E                        ; $00952E
        MOVEQ   #$01,D1                         ; $009530
.loc_003E:
        BTST    D3,(A1)                         ; $009532
        BEQ.S  .loc_0044                        ; $009534
        SUBQ.W  #1,D1                           ; $009536
.loc_0044:
        DC.W    $43FA,$FFBC         ; LEA     $0094F6(PC),A1; $009538
        CMP.W  (-16378).W,D1                    ; $00953C
        BEQ.S  .loc_0066                        ; $009540
        MOVE.W  D1,(-16378).W                   ; $009542
        MOVE.W  D1,D2                           ; $009546
        DC.W    $D442                           ; $009548
        MOVE.W  $00(A1,D2.W),D2                 ; $00954A
        MOVE.W  D2,(-16384).W                   ; $00954E
        LSL.W  #8,D2                            ; $009552
        MOVE.W  D2,$008E(A0)                    ; $009554
        BRA.S  .loc_00AC                        ; $009558
.loc_0066:
        TST.W  D1                               ; $00955A
        BNE.S  .loc_0082                        ; $00955C
        MOVE.W  (-16384).W,D2                   ; $00955E
        BEQ.S  .loc_0078                        ; $009562
        BPL.S  .loc_0076                        ; $009564
        MOVEQ   #-$02,D2                        ; $009566
        BRA.S  .loc_0078                        ; $009568
.loc_0076:
        MOVEQ   #$02,D2                         ; $00956A
.loc_0078:
        MOVE.W  $00(A1,D2.W),D2                 ; $00956C
        SUB.W  D2,(-16384).W                    ; $009570
        BRA.S  .loc_00AC                        ; $009574
.loc_0082:
        MOVE.W  D1,(-16378).W                   ; $009576
        MOVE.W  D1,D2                           ; $00957A
        DC.W    $D442                           ; $00957C
        MOVE.W  $00(A1,D2.W),D2                 ; $00957E
        TST.W  (-14136).W                       ; $009582
        BEQ.S  .loc_00A8                        ; $009586
        MOVE.W  $0094(A0),D0                    ; $009588
        DC.W    $B540                           ; $00958C
        BMI.S  .loc_00A8                        ; $00958E
        ASR.W  #1,D2                            ; $009590
        MOVE.W  $0094(A0),D0                    ; $009592
        ASR.W  #3,D0                            ; $009596
        SUB.W  D0,$0094(A0)                     ; $009598
.loc_00A8:
        ADD.W  D2,(-16384).W                    ; $00959C
.loc_00AC:
        CMPI.W  #$007F,(-16384).W               ; $0095A0
        BLE.S  .loc_00BA                        ; $0095A6
        MOVE.W  #$007F,(-16384).W               ; $0095A8
.loc_00BA:
        CMPI.W  #$FF81,(-16384).W               ; $0095AE
        BGE.S  .loc_00C8                        ; $0095B4
        MOVE.W  #$FF81,(-16384).W               ; $0095B6
.loc_00C8:
        MOVE.W  (-16384).W,D2                   ; $0095BC
        MOVE.W  D2,D0                           ; $0095C0
        BPL.S  .loc_00D4                        ; $0095C2
        NEG.W  D0                               ; $0095C4
        BVC.S  .loc_00DE                        ; $0095C6
.loc_00D4:
        CMPI.W  #$0018,D0                       ; $0095C8
        BGE.S  .loc_00DE                        ; $0095CC
        CLR.W  (-16384).W                       ; $0095CE
.loc_00DE:
        EXT.L   D2                              ; $0095D2
        LSL.L  #8,D2                            ; $0095D4
        MOVE.W  $008E(A0),D1                    ; $0095D6
        EXT.L   D1                              ; $0095DA
        DC.W    $D481                           ; $0095DC
        ASR.L  #1,D2                            ; $0095DE
        MOVE.L  D2,D3                           ; $0095E0
        DC.W    $9681                           ; $0095E2
        TST.W  D3                               ; $0095E4
        BPL.S  .loc_00F6                        ; $0095E6
        NEG.W  D3                               ; $0095E8
.loc_00F6:
        ASR.W  #8,D3                            ; $0095EA
        ADD.W  $00AA(A0),D3                     ; $0095EC
        CMPI.W  #$00C8,D3                       ; $0095F0
        BLE.S  .loc_0106                        ; $0095F4
        MOVE.W  #$00C8,D3                       ; $0095F6
.loc_0106:
        CMPI.W  #$0000,D3                       ; $0095FA
        BGE.S  .loc_0110                        ; $0095FE
        MOVE.W  #$0000,D3                       ; $009600
.loc_0110:
        MOVE.W  D3,$00AA(A0)                    ; $009604
        MOVE.W  D2,D1                           ; $009608
        BPL.S  .loc_011C                        ; $00960A
        NEG.W  D1                               ; $00960C
        BVS.S  .loc_0124                        ; $00960E
.loc_011C:
        CMPI.W  #$0018,D1                       ; $009610
        BGE.S  .loc_0124                        ; $009614
        MOVEQ   #$00,D2                         ; $009616
.loc_0124:
        MOVE.W  D2,$008E(A0)                    ; $009618
        RTS                                     ; $00961C
