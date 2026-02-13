; ============================================================================
; fn_8200_010 — Object State Assignment — Greater-Than Case
; ROM Range: $00838A-$00839A (16 bytes)
; Greater-than handler for the three-way comparison (fn_8200_008). Stores
; D5 at (A4), copies (A3) to +$04(A4), calls subroutine at $00B478,
; returns D0=1/D1=$0C. Reverse assignment order from fn_8200_009.
;
; Entry: D5 = new value, A3 = source pointer, A4 = object pointer
; Uses: D0, D1, D5, A3, A4
; Object fields: +$00 state, +$04 speed
; Confidence: high
; ============================================================================

fn_8200_010:
        MOVE.L  D5,(A4)                         ; $00838A
        MOVE.L  (A3),$0004(A4)                  ; $00838C
        DC.W    $4EBA,$30E6         ; JSR     $00B478(PC); $008390
        MOVEQ   #$01,D0                         ; $008394
        MOVEQ   #$0C,D1                         ; $008396
        RTS                                     ; $008398
