; ============================================================================
; Name Entry Object Update 026 (auto-analyzed)
; ROM Range: $01146E-$0115A8 (314 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 4 subroutines
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, object_update, sprite_update, sh2_send_cmd
;
; Uses: D0, D1, D2, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Confidence: high
; ============================================================================

fn_10200_026:
        CLR.W  D0                               ; $01146E
        DC.W    $4EBA,$D0BA         ; JSR     $00E52C(PC); $011470
        DC.W    $4EBA,$A20E         ; JSR     $00B684(PC); $011474
        DC.W    $4EBA,$A260         ; JSR     $00B6DA(PC); $011478
        MOVEA.L #$06018F80,A0                   ; $01147C
        MOVEA.L #$0400E038,A1                   ; $011482
        MOVE.W  #$00D8,D0                       ; $011488
        MOVE.W  #$0010,D1                       ; $01148C
        DC.W    $4EBA,$CEC8         ; JSR     $00E35A(PC); $011490
        MOVEA.L #$26028000,A0                   ; $011494
        MOVE.L  (-24542).W,D0                   ; $01149A
        ADDA.L  D0,A0                           ; $01149E
        MOVEA.L #$24010038,A1                   ; $0114A0
        MOVE.W  #$00D8,D0                       ; $0114A6
        MOVE.W  #$0050,D1                       ; $0114AA
        DC.W    $4EBA,$CEAA         ; JSR     $00E35A(PC); $0114AE
        TST.L  (-24538).W                       ; $0114B2
        BEQ.W  .loc_0066                        ; $0114B6
        MOVE.L  (-24542).W,D0                   ; $0114BA
        MOVE.L  (-24538).W,D1                   ; $0114BE
        DC.W    $D081                           ; $0114C2
        MOVE.L  D0,(-24542).W                   ; $0114C4
        SUBQ.B  #1,(-24530).W                   ; $0114C8
        BCC.W  .loc_012C                        ; $0114CC
        CLR.L  (-24538).W                       ; $0114D0
.loc_0066:
        CMPI.W  #$0001,(-24484).W               ; $0114D4
        BEQ.W  .loc_00FC                        ; $0114DA
        CMPI.W  #$0002,(-24484).W               ; $0114DE
        BEQ.W  .loc_0112                        ; $0114E4
        JSR     $0088179E                       ; $0114E8
        MOVE.W  (-14228).W,D1                   ; $0114EE
        MOVE.W  D1,D2                           ; $0114F2
        ANDI.B  #$F0,D2                         ; $0114F4
        BEQ.S  .loc_00BA                        ; $0114F8
        MOVE.B  #$A8,(-14172).W                 ; $0114FA
        MOVE.W  #$0002,(-24484).W               ; $011500
        MOVE.B  #$01,(-14327).W                 ; $011506
        MOVE.B  #$01,(-14326).W                 ; $01150C
        BSET    #7,(-14322).W                   ; $011512
        MOVE.B  #$01,(-14334).W                 ; $011518
        JSR     $0088205E                       ; $01151E
        BRA.W  .loc_0130                        ; $011524
.loc_00BA:
        LSR.W  #8,D1                            ; $011528
        BTST    #0,D1                           ; $01152A
        BEQ.S  .loc_00DC                        ; $01152E
        TST.L  (-24542).W                       ; $011530
        BLE.W  .loc_012C                        ; $011534
        MOVE.L  #$FFFFFE50,(-24538).W           ; $011538
        MOVE.B  #$07,(-24530).W                 ; $011540
        BRA.W  .loc_012C                        ; $011546
.loc_00DC:
        BTST    #1,D1                           ; $01154A
        BEQ.S  .loc_012C                        ; $01154E
        MOVE.L  (-24542).W,D0                   ; $011550
        CMP.L  (-24534).W,D0                    ; $011554
        BGE.W  .loc_012C                        ; $011558
        MOVE.L  #$000001B0,(-24538).W           ; $01155C
        MOVE.B  #$07,(-24530).W                 ; $011564
.loc_00FC:
        JSR     $0088FB36                       ; $01156A
        BTST    #6,(-14322).W                   ; $011570
        BNE.S  .loc_012C                        ; $011576
        CLR.W  (-24484).W                       ; $011578
        BRA.W  .loc_012C                        ; $01157C
.loc_0112:
        JSR     $0088FB36                       ; $011580
        BTST    #7,(-14322).W                   ; $011586
        BNE.S  .loc_012C                        ; $01158C
        CLR.W  (-24484).W                       ; $01158E
        ADDQ.W  #4,(-14210).W                   ; $011592
        BRA.W  .loc_0130                        ; $011596
.loc_012C:
        SUBQ.W  #4,(-14210).W                   ; $01159A
.loc_0130:
        MOVE.W  #$0018,$00FF0008                ; $01159E
        RTS                                     ; $0115A6
