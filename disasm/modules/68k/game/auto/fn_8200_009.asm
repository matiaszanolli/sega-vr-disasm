; ============================================================================
; fn_8200_009 — Object State Assignment — Less-Than Case
; ROM Range: $00837A-$00838A (16 bytes)
; Less-than handler for the three-way comparison (fn_8200_008). Copies
; (A3) to (A4), stores D5 at +$04(A4), calls subroutine at $00B478,
; returns D0=2/D1=$0D.
;
; Entry: D5 = new speed value, A3 = source pointer, A4 = object pointer
; Uses: D0, D1, D5, A3, A4
; Object fields: +$00 state, +$04 speed
; Confidence: high
; ============================================================================

fn_8200_009:
        MOVE.L  (A3),(A4)                       ; $00837A
        MOVE.L  D5,$0004(A4)                    ; $00837C
        DC.W    $4EBA,$30F6         ; JSR     $00B478(PC); $008380
        MOVEQ   #$02,D0                         ; $008384
        MOVEQ   #$0D,D1                         ; $008386
        RTS                                     ; $008388
