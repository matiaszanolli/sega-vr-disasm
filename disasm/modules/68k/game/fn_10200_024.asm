; ============================================================================
; Name Entry Object Update 024 (auto-analyzed)
; ROM Range: $011240-$01141A (474 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 6 subroutines
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, object_update, sprite_update, sh2_send_cmd
;
; Uses: D0, D1, D2, A0, A1, A2
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
;   $0118D4: time_digit_render
; Confidence: high
; ============================================================================

fn_10200_024:
        CLR.W  D0                               ; $011240
        DC.W    $4EBA,$D2E8         ; JSR     $00E52C(PC); $011242
        DC.W    $4EBA,$A43C         ; JSR     $00B684(PC); $011246
        DC.W    $4EBA,$A48E         ; JSR     $00B6DA(PC); $01124A
        MOVEA.L #$06018F80,A0                   ; $01124E
        MOVEA.L #$0400E038,A1                   ; $011254
        MOVE.W  #$00D8,D0                       ; $01125A
        MOVE.W  #$0010,D1                       ; $01125E
        DC.W    $4EBA,$D0F6         ; JSR     $00E35A(PC); $011262
        MOVEA.L #$06028000,A0                   ; $011266
        MOVEA.L #$04010038,A1                   ; $01126C
        MOVE.W  #$00D8,D0                       ; $011272
        MOVE.W  #$0050,D1                       ; $011276
        DC.W    $4EBA,$D0DE         ; JSR     $00E35A(PC); $01127A
        LEA     $0402C090,A1                    ; $01127E
        LEA     (-24506).W,A2                   ; $011284
        DC.W    $4EBA,$064A         ; JSR     $0118D4(PC); $011288
        MOVEA.L #$06018C00,A0                   ; $01128C
        MOVEA.L #$0400C048,A1                   ; $011292
        MOVE.W  #$0038,D0                       ; $011298
        MOVE.W  #$0010,D1                       ; $01129C
        DC.W    $4EBA,$D0B8         ; JSR     $00E35A(PC); $0112A0
        TST.W  (-24510).W                       ; $0112A4
        BNE.W  .loc_00B4                        ; $0112A8
        MOVEA.L #$0601A200,A0                   ; $0112AC
        MOVEA.L #$0401B030,A1                   ; $0112B2
        MOVE.W  #$0080,D0                       ; $0112B8
        MOVE.W  #$0010,D1                       ; $0112BC
        DC.W    $4EBA,$D098         ; JSR     $00E35A(PC); $0112C0
        MOVEA.L #$0601AA00,A0                   ; $0112C4
        MOVEA.L #$0401B0D0,A1                   ; $0112CA
        MOVE.W  #$0018,D0                       ; $0112D0
        MOVE.W  #$0010,D1                       ; $0112D4
        DC.W    $4EBA,$D080         ; JSR     $00E35A(PC); $0112D8
        MOVEA.L #$0601AB80,A0                   ; $0112DC
        MOVEA.L #$0401B100,A1                   ; $0112E2
        MOVE.W  #$0018,D0                       ; $0112E8
        MOVE.W  #$0010,D1                       ; $0112EC
        DC.W    $4EBA,$D068         ; JSR     $00E35A(PC); $0112F0
.loc_00B4:
        CMPI.W  #$0001,(-24484).W               ; $0112F4
        BEQ.W  .loc_019C                        ; $0112FA
        CMPI.W  #$0002,(-24484).W               ; $0112FE
        BEQ.W  .loc_01B2                        ; $011304
        JSR     $0088179E                       ; $011308
        MOVE.W  (-14228).W,D1                   ; $01130E
        MOVE.W  D1,D2                           ; $011312
        ANDI.B  #$E0,D2                         ; $011314
        BEQ.S  .loc_0108                        ; $011318
        MOVE.B  #$A8,(-14172).W                 ; $01131A
        MOVE.B  #$01,(-14327).W                 ; $011320
        MOVE.B  #$01,(-14326).W                 ; $011326
        BSET    #7,(-14322).W                   ; $01132C
        MOVE.B  #$01,(-14334).W                 ; $011332
        JSR     $0088205E                       ; $011338
        MOVE.W  #$0002,(-24484).W               ; $01133E
        BRA.W  .loc_01CC                        ; $011344
.loc_0108:
        BTST    #4,D1                           ; $011348
        BEQ.S  .loc_015C                        ; $01134C
        TST.B  (-24551).W                       ; $01134E
        BNE.W  .loc_012E                        ; $011352
        TST.W  (-24510).W                       ; $011356
        BNE.W  .loc_012E                        ; $01135A
        MOVE.B  #$A9,(-14172).W                 ; $01135E
        MOVE.B  #$01,(-24551).W                 ; $011364
        BRA.W  .loc_01CC                        ; $01136A
.loc_012E:
        MOVE.B  #$A8,(-14172).W                 ; $01136E
        MOVE.B  #$01,(-14327).W                 ; $011374
        MOVE.B  #$01,(-14326).W                 ; $01137A
        BSET    #7,(-14322).W                   ; $011380
        MOVE.B  #$01,(-14334).W                 ; $011386
        JSR     $0088205E                       ; $01138C
        MOVE.W  #$0002,(-24484).W               ; $011392
        BRA.W  .loc_01CC                        ; $011398
.loc_015C:
        TST.W  (-24510).W                       ; $01139C
        BNE.S  .loc_01CC                        ; $0113A0
        BTST    #2,D1                           ; $0113A2
        BEQ.S  .loc_017E                        ; $0113A6
        TST.B  (-24551).W                       ; $0113A8
        BEQ.W  .loc_01CC                        ; $0113AC
        MOVE.B  #$A9,(-14172).W                 ; $0113B0
        CLR.B  (-24551).W                       ; $0113B6
        BRA.W  .loc_01CC                        ; $0113BA
.loc_017E:
        BTST    #3,D1                           ; $0113BE
        BEQ.S  .loc_01CC                        ; $0113C2
        TST.B  (-24551).W                       ; $0113C4
        BNE.W  .loc_01CC                        ; $0113C8
        MOVE.B  #$A9,(-14172).W                 ; $0113CC
        MOVE.B  #$01,(-24551).W                 ; $0113D2
        BRA.W  .loc_01CC                        ; $0113D8
.loc_019C:
        JSR     $0088FB36                       ; $0113DC
        BTST    #6,(-14322).W                   ; $0113E2
        BNE.S  .loc_01CC                        ; $0113E8
        CLR.W  (-24484).W                       ; $0113EA
        BRA.W  .loc_01CC                        ; $0113EE
.loc_01B2:
        JSR     $0088FB36                       ; $0113F2
        BTST    #7,(-14322).W                   ; $0113F8
        BNE.S  .loc_01CC                        ; $0113FE
        CLR.W  (-24484).W                       ; $011400
        ADDQ.W  #4,(-14210).W                   ; $011404
        BRA.W  .loc_01D0                        ; $011408
.loc_01CC:
        DC.W    $6100,$05AA         ; BSR.W  $0119B8; $01140C
.loc_01D0:
        MOVE.W  #$0018,$00FF0008                ; $011410
        RTS                                     ; $011418
