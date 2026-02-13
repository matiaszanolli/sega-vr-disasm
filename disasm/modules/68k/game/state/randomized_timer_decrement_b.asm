; ============================================================================
; randomized_timer_decrement_b — Randomized Timer Decrement B
; ROM Range: $0022D6-$0022EC (22 bytes)
; ============================================================================
; If (A1) equals target value $21D0, generates a random number (0-15)
; and subtracts it from D1. Stores result to (A1).
; Paired with weighted_timer_average_a (wider range variant, target = upper bound).
;
; Entry: D1 = timer value, A1 = timer storage pointer
; Exit: D1 = adjusted timer, (A1) = updated
; Uses: D0, D1, A1
; Calls:
;   $00496E: random_number_gen (JSR PC-relative)
; ============================================================================

randomized_timer_decrement_b:
        MOVE.W  #$21D0,D1                       ; $0022D6
        CMP.W  (A1),D1                          ; $0022DA
        BNE.S  .loc_0012                        ; $0022DC
        DC.W    $4EBA,$268E         ; JSR     $00496E(PC); $0022DE
        ANDI.W  #$000F,D0                       ; $0022E2
        SUB.W   D0,D1                           ; $0022E6
.loc_0012:
        MOVE.W  D1,(A1)                         ; $0022E8
        RTS                                     ; $0022EA
