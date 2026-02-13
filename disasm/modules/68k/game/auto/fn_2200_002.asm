; ============================================================================
; Vint Random Number Gen 002 (auto-analyzed)
; ROM Range: $002294-$0022AA (22 bytes)
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

fn_2200_002:
        MOVE.W  #$1E00,D1                       ; $002294
        CMP.W  (A1),D1                          ; $002298
        BNE.S  .loc_0012                        ; $00229A
        DC.W    $4EBA,$26D0         ; JSR     $00496E(PC); $00229C
        ANDI.W  #$000F,D0                       ; $0022A0
        DC.W    $9240                           ; $0022A4
.loc_0012:
        MOVE.W  D1,(A1)                         ; $0022A6
        RTS                                     ; $0022A8
