; ============================================================================
; fn_2200_006 — Randomized Timer Decrement C
; ROM Range: $002314-$00232A (22 bytes)
; ============================================================================
; If (A1) equals target value $21A0, generates a random number (0-15)
; and subtracts it from D1. Stores result to (A1).
; Paired with fn_2200_005 (narrower range variant, target = upper bound).
;
; Entry: D1 = timer value, A1 = timer storage pointer
; Exit: D1 = adjusted timer, (A1) = updated
; Uses: D0, D1, A1
; Calls:
;   $00496E: random_number_gen (JSR PC-relative)
; ============================================================================

fn_2200_006:
        MOVE.W  #$21A0,D1                       ; $002314
        CMP.W  (A1),D1                          ; $002318
        BNE.S  .loc_0012                        ; $00231A
        DC.W    $4EBA,$2650         ; JSR     $00496E(PC); $00231C
        ANDI.W  #$000F,D0                       ; $002320
        SUB.W   D0,D1                           ; $002324
.loc_0012:
        MOVE.W  D1,(A1)                         ; $002326
        RTS                                     ; $002328
