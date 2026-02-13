; ============================================================================
; fn_8200_018 — Object State Assignment — Not-Equal Case
; ROM Range: $008532-$008548 (22 bytes)
; Not-equal handler paired with fn_8200_017. Entry at $008538 from BNE
; branch. Stores D5 at (A4), D4 at +$04(A4), calls subroutine at $00B478,
; returns D0=1/D1=$0C. First 6 bytes (CMPI.L) serve as alternate entry.
;
; Entry: D4, D5 = values to store, A4 = object pointer
; Uses: D0, D1, D4, D5, A4
; Object fields: +$00 state, +$04 speed
; Confidence: high
; ============================================================================

fn_8200_018:
        CMPI.L  #$003C0000,D0                   ; $008532
        MOVE.L  D5,(A4)                         ; $008538
        MOVE.L  D4,$0004(A4)                    ; $00853A
        DC.W    $4EBA,$2F38         ; JSR     $00B478(PC); $00853E
        MOVEQ   #$01,D0                         ; $008542
        MOVEQ   #$0C,D1                         ; $008544
        RTS                                     ; $008546
