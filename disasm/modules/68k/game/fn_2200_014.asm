; ============================================================================
; Vint Tile Index Expand 014 (auto-analyzed)
; ROM Range: $002594-$0025B0 (28 bytes)
; ============================================================================
; Category: vint
; Purpose: Short helper function
;   Calls: tile_index_expand
;
; Uses: A0, A5
; Calls:
;   $0024AE: tile_index_expand
; Confidence: low
; ============================================================================

fn_2200_014:
        TST.B  (-14323).W                       ; $002594
        BNE.S  .loc_001A                        ; $002598
        LEA     (-14202).W,A0                   ; $00259A
        MOVE.L  #$622A0002,(A5)                 ; $00259E
        DC.W    $4EBA,$FF08         ; JSR     $0024AE(PC); $0025A4
        MOVE.B  #$00,(-14202).W                 ; $0025A8
.loc_001A:
        RTS                                     ; $0025AE
