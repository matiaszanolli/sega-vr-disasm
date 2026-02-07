; ============================================================================
; Vint Random Number Gen 008 (auto-analyzed)
; ROM Range: $0023C2-$0023DC (26 bytes)
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

fn_2200_008:
        MOVE.W  #$1E00,D1                       ; $0023C2
        CMP.W  (A1),D1                          ; $0023C6
        BNE.S  .loc_0012                        ; $0023C8
        DC.W    $4EBA,$25A2         ; JSR     $00496E(PC); $0023CA
        ANDI.W  #$000F,D0                       ; $0023CE
        DC.W    $9240                           ; $0023D2
.loc_0012:
        MOVE.W  D1,(A1)                         ; $0023D4
        MOVE.W  (A1),(-30880).W                 ; $0023D6
        RTS                                     ; $0023DA
