; ============================================================================
; randomized_timer_decrement_a — Randomized Timer Decrement A
; ROM Range: $002294-$0022AA (22 bytes)
; ============================================================================
; If (A1) equals target value $1E00, generates a random number (0-15)
; and subtracts it from D1 to introduce jitter. Stores result to (A1).
; Used for V-INT frame timing with randomized variation.
;
; Entry: D1 = timer value, A1 = timer storage pointer
; Exit: D1 = adjusted timer, (A1) = updated
; Uses: D0, D1, A1
; Calls:
;   $00496E: random_number_gen (JSR PC-relative)
; ============================================================================

randomized_timer_decrement_a:
        MOVE.W  #$1E00,D1                       ; $002294
        CMP.W  (A1),D1                          ; $002298
        BNE.S  .loc_0012                        ; $00229A
        jsr     random_number_gen(pc)   ; $4EBA $26D0
        ANDI.W  #$000F,D0                       ; $0022A0
        SUB.W   D0,D1                           ; $0022A4
.loc_0012:
        MOVE.W  D1,(A1)                         ; $0022A6
        RTS                                     ; $0022A8
