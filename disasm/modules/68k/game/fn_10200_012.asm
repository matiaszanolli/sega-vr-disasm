; ============================================================================
; Name Entry Dma Transfer 012 (auto-analyzed)
; ROM Range: $0103C4-$0104A2 (222 bytes)
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

fn_10200_012:
        CLR.W  D0                               ; $0103C4
        DC.W    $4EBA,$E164         ; JSR     $00E52C(PC); $0103C6
        MOVEA.L (-24548).W,A0                   ; $0103CA
        DC.W    $6100,$03C6         ; BSR.W  $010796; $0103CE
        JSR     $0088179E                       ; $0103D2
        CMPI.W  #$0001,(-24522).W               ; $0103D8
        BEQ.W  .loc_00BE                        ; $0103DE
        MOVE.W  (-14228).W,D1                   ; $0103E2
        BTST    #4,D1                           ; $0103E6
        BNE.W  .loc_008A                        ; $0103EA
        MOVE.W  D1,D2                           ; $0103EE
        ANDI.B  #$E0,D2                         ; $0103F0
        BEQ.W  .loc_00BA                        ; $0103F4
        MOVE.B  #$01,(-24532).W                 ; $0103F8
        MOVE.B  #$00,(-24531).W                 ; $0103FE
        MOVE.B  #$A8,(-14172).W                 ; $010404
        BTST    #7,D1                           ; $01040A
        BNE.W  .loc_0082                        ; $01040E
        MOVE.W  (-24540).W,D0                   ; $010412
        CMPI.B  #$03,D0                         ; $010416
        BEQ.W  .loc_0082                        ; $01041A
        CMPI.B  #$08,D0                         ; $01041E
        BEQ.W  .loc_008A                        ; $010422
        CLR.W  D1                               ; $010426
        MOVE.B  (-24544).W,D1                   ; $010428
        MOVEA.L (-24548).W,A0                   ; $01042C
        MOVE.B  D0,$00(A0,D1.W)                 ; $010430
        ADDQ.B  #1,(-24544).W                   ; $010434
        CMPI.B  #$03,(-24544).W                 ; $010438
        BGE.W  .loc_0082                        ; $01043E
        BRA.W  .loc_00D0                        ; $010442
.loc_0082:
        ADDQ.W  #4,(-14210).W                   ; $010446
        BRA.W  .loc_00D4                        ; $01044A
.loc_008A:
        CLR.W  D1                               ; $01044E
        MOVE.B  (-24544).W,D1                   ; $010450
        MOVEA.L (-24548).W,A0                   ; $010454
        MOVE.B  #$20,$00(A0,D1.W)               ; $010458
        TST.B  (-24544).W                       ; $01045E
        BEQ.W  .loc_00D0                        ; $010462
        SUBQ.B  #1,(-24544).W                   ; $010466
        CLR.W  D1                               ; $01046A
        MOVE.B  (-24544).W,D1                   ; $01046C
        MOVEA.L (-24548).W,A0                   ; $010470
        MOVE.B  #$20,$00(A0,D1.W)               ; $010474
        BRA.W  .loc_00D0                        ; $01047A
.loc_00BA:
        DC.W    $6100,$03CC         ; BSR.W  $01084C; $01047E
.loc_00BE:
        JSR     $0088FB36                       ; $010482
        BTST    #6,(-14322).W                   ; $010488
        BNE.S  .loc_00D0                        ; $01048E
        CLR.W  (-24522).W                       ; $010490
.loc_00D0:
        SUBQ.W  #4,(-14210).W                   ; $010494
.loc_00D4:
        MOVE.W  #$0018,$00FF0008                ; $010498
        RTS                                     ; $0104A0
