; ============================================================================
; Name Entry Dma Transfer 010 (auto-analyzed)
; ROM Range: $010244-$01035C (280 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 3 subroutines
;   RAM: $C87E (game_state)
;   Calls: dma_transfer
;   Object (A0): +$00
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, A0
; RAM:
;   $C87E: game_state
; Calls:
;   $00E52C: dma_transfer
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_10200_010:
        CLR.W  D0                               ; $010244
        DC.W    $4EBA,$E2E4         ; JSR     $00E52C(PC); $010246
        MOVEA.L (-24552).W,A0                   ; $01024A
        DC.W    $6100,$0546         ; BSR.W  $010796; $01024E
        JSR     $0088179E                       ; $010252
        CMPI.W  #$0001,(-24522).W               ; $010258
        BEQ.W  .loc_00F8                        ; $01025E
        MOVE.W  (-14228).W,D1                   ; $010262
        BTST    #4,D1                           ; $010266
        BNE.W  .loc_009C                        ; $01026A
        MOVE.W  D1,D2                           ; $01026E
        ANDI.B  #$E0,D2                         ; $010270
        BEQ.W  .loc_00F4                        ; $010274
        MOVE.B  #$01,(-24532).W                 ; $010278
        MOVE.B  #$00,(-24531).W                 ; $01027E
        MOVE.B  #$A8,(-14172).W                 ; $010284
        BTST    #7,D1                           ; $01028A
        BNE.W  .loc_0094                        ; $01028E
        MOVE.W  (-24540).W,D0                   ; $010292
        CMPI.B  #$03,D0                         ; $010296
        BEQ.W  .loc_0094                        ; $01029A
        CMPI.B  #$08,D0                         ; $01029E
        BEQ.W  .loc_009C                        ; $0102A2
        CLR.W  D1                               ; $0102A6
        MOVE.B  (-24544).W,D1                   ; $0102A8
        MOVEA.L (-24552).W,A0                   ; $0102AC
        MOVE.B  D0,$00(A0,D1.W)                 ; $0102B0
        BTST    #1,(-24556).W                   ; $0102B4
        BEQ.W  .loc_0082                        ; $0102BA
        MOVEA.L (-24548).W,A0                   ; $0102BE
        MOVE.B  D0,$00(A0,D1.W)                 ; $0102C2
.loc_0082:
        ADDQ.B  #1,(-24544).W                   ; $0102C6
        CMPI.B  #$03,(-24544).W                 ; $0102CA
        BGE.W  .loc_0094                        ; $0102D0
        BRA.W  .loc_010A                        ; $0102D4
.loc_0094:
        ADDQ.W  #4,(-14210).W                   ; $0102D8
        BRA.W  .loc_010E                        ; $0102DC
.loc_009C:
        TST.B  (-24544).W                       ; $0102E0
        BEQ.W  .loc_010A                        ; $0102E4
        CLR.W  D1                               ; $0102E8
        MOVE.B  (-24544).W,D1                   ; $0102EA
        MOVEA.L (-24552).W,A0                   ; $0102EE
        MOVE.B  #$20,$00(A0,D1.W)               ; $0102F2
        BTST    #1,(-24556).W                   ; $0102F8
        BEQ.W  .loc_00C8                        ; $0102FE
        MOVEA.L (-24548).W,A0                   ; $010302
        MOVE.B  #$20,$00(A0,D1.W)               ; $010306
.loc_00C8:
        SUBQ.B  #1,(-24544).W                   ; $01030C
        CLR.W  D1                               ; $010310
        MOVE.B  (-24544).W,D1                   ; $010312
        MOVEA.L (-24552).W,A0                   ; $010316
        MOVE.B  #$20,$00(A0,D1.W)               ; $01031A
        BTST    #1,(-24556).W                   ; $010320
        BEQ.W  .loc_00F0                        ; $010326
        MOVEA.L (-24548).W,A0                   ; $01032A
        MOVE.B  #$20,$00(A0,D1.W)               ; $01032E
.loc_00F0:
        BRA.W  .loc_010A                        ; $010334
.loc_00F4:
        DC.W    $6100,$0512         ; BSR.W  $01084C; $010338
.loc_00F8:
        JSR     $0088FB36                       ; $01033C
        BTST    #6,(-14322).W                   ; $010342
        BNE.S  .loc_010A                        ; $010348
        CLR.W  (-24522).W                       ; $01034A
.loc_010A:
        SUBQ.W  #4,(-14210).W                   ; $01034E
.loc_010E:
        MOVE.W  #$0018,$00FF0008                ; $010352
        RTS                                     ; $01035A
