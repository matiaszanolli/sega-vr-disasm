; ============================================================================
; Ai Dispatch 024 (auto-analyzed)
; ROM Range: $00B6D0-$00B722 (82 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;
; Uses: D0, D1, A1
; Confidence: medium
; ============================================================================

fn_a200_024:
        DC.W    $FFFE                           ; $00B6D0
        DC.W    $FDFC                           ; $00B6D2
        DC.W    $FBFA                           ; $00B6D4
        DC.W    $F9F8                           ; $00B6D6
        DC.W    $F880                           ; $00B6D8
        BTST    #7,(-14322).W                   ; $00B6DA
        BEQ.S  .loc_0050                        ; $00B6E0
        SUBQ.B  #1,(-14326).W                   ; $00B6E2
        BNE.S  .loc_0050                        ; $00B6E6
        MOVE.B  (-14327).W,(-14326).W           ; $00B6E8
        MOVEQ   #$00,D0                         ; $00B6EE
        MOVE.B  (-14299).W,D0                   ; $00B6F0
        MOVE.B  $00B722(PC,D0.W),D1             ; $00B6F4
        MOVE.B  D1,$00FF60D5                    ; $00B6F8
        ADDQ.B  #1,D0                           ; $00B6FE
        MOVE.B  D0,(-14299).W                   ; $00B700
        CMPI.B  #$0A,D0                         ; $00B704
        BNE.S  .loc_0050                        ; $00B708
        MOVEQ   #$00,D1                         ; $00B70A
        LEA     (-31616).W,A1                   ; $00B70C
        DC.W    $4EBA,$9134         ; JSR     $004846(PC); $00B710
        MOVE.B  #$00,(-14299).W                 ; $00B714
        BCLR    #7,(-14322).W                   ; $00B71A
.loc_0050:
        RTS                                     ; $00B720
