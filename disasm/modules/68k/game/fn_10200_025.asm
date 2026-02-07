; ============================================================================
; Sh2 Comm Dma Transfer 025 (auto-analyzed)
; ROM Range: $01141A-$01146E (84 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: COMM0, COMM6, COMM4
;   RAM: $C87E (game_state)
;   Calls: dma_transfer
;
; Uses: D0
; RAM:
;   $C87E: game_state
; Calls:
;   $00E52C: dma_transfer
; Confidence: high
; ============================================================================

fn_10200_025:
        CLR.W  D0                               ; $01141A
        DC.W    $4EBA,$D10E         ; JSR     $00E52C(PC); $01141C
.loc_0006:
        TST.B  $00A15120                        ; $011420
        BNE.S  .loc_0006                        ; $011426
        MOVE.W  #$0101,$00A1512C                ; $011428
        MOVE.W  #$8000,$00A15128                ; $011430
        MOVE.B  #$2C,$00A15121                  ; $011438
        MOVE.B  #$01,$00A15120                  ; $011440
.loc_002E:
        TST.B  $00A1512C                        ; $011448
        BNE.S  .loc_002E                        ; $01144E
        MOVE.W  #$0050,$00A15128                ; $011450
        MOVE.W  #$0101,$00A1512C                ; $011458
        MOVE.W  #$0020,$00FF0008                ; $011460
        ADDQ.W  #4,(-14210).W                   ; $011468
        RTS                                     ; $01146C
