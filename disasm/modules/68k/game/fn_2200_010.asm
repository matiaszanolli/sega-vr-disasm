; ============================================================================
; Vint Random Number Gen 010 (auto-analyzed)
; ROM Range: $00240C-$002426 (26 bytes)
; ============================================================================
; Category: vint
; Purpose: Short helper function
;   Calls: random_number_gen
;
; Uses: D0, D1, A1
; Calls:
;   $00496E: random_number_gen
; Confidence: low
; ============================================================================

fn_2200_010:
        MOVE.W  #$21D0,D1                       ; $00240C
        CMP.W  (A1),D1                          ; $002410
        BNE.S  .loc_0012                        ; $002412
        DC.W    $4EBA,$2558         ; JSR     $00496E(PC); $002414
        ANDI.W  #$000F,D0                       ; $002418
        DC.W    $9240                           ; $00241C
.loc_0012:
        MOVE.W  D1,(A1)                         ; $00241E
        MOVE.W  (A1),(-30880).W                 ; $002420
        RTS                                     ; $002424
