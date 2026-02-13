; ============================================================================
; Vint Random Number Gen 004 (auto-analyzed)
; ROM Range: $0022D6-$0022EC (22 bytes)
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

fn_2200_004:
        MOVE.W  #$21D0,D1                       ; $0022D6
        CMP.W  (A1),D1                          ; $0022DA
        BNE.S  .loc_0012                        ; $0022DC
        DC.W    $4EBA,$268E         ; JSR     $00496E(PC); $0022DE
        ANDI.W  #$000F,D0                       ; $0022E2
        DC.W    $9240                           ; $0022E6
.loc_0012:
        MOVE.W  D1,(A1)                         ; $0022E8
        RTS                                     ; $0022EA
