; ============================================================================
; Vint Random Number Gen 006 (auto-analyzed)
; ROM Range: $002314-$00232A (22 bytes)
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

fn_2200_006:
        MOVE.W  #$21A0,D1                       ; $002314
        CMP.W  (A1),D1                          ; $002318
        BNE.S  .loc_0012                        ; $00231A
        DC.W    $4EBA,$2650         ; JSR     $00496E(PC); $00231C
        ANDI.W  #$000F,D0                       ; $002320
        DC.W    $9240                           ; $002324
.loc_0012:
        MOVE.W  D1,(A1)                         ; $002326
        RTS                                     ; $002328
