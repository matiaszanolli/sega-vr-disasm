; ============================================================================
; Vint Random Number Gen 012 (auto-analyzed)
; ROM Range: $002452-$00246C (26 bytes)
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

fn_2200_012:
        MOVE.W  #$21A0,D1                       ; $002452
        CMP.W  (A1),D1                          ; $002456
        BNE.S  .loc_0012                        ; $002458
        DC.W    $4EBA,$2512         ; JSR     $00496E(PC); $00245A
        ANDI.W  #$000F,D0                       ; $00245E
        DC.W    $9240                           ; $002462
.loc_0012:
        MOVE.W  D1,(A1)                         ; $002464
        MOVE.W  (A1),(-30880).W                 ; $002466
        RTS                                     ; $00246A
