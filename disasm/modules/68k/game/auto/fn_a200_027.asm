; ============================================================================
; fn_a200_027 — Display State Bit 10 Guard
; ROM Range: $00B7E6-$00B7EE (8 bytes)
; Tests bit 10 of D0. If set, falls through to fn_a200_028 camera
; animation state dispatcher. If clear, returns immediately.
;
; Entry: D0 = flags word
; Uses: D0
; Confidence: high
; ============================================================================

fn_a200_027:
        BTST    #10,D0                          ; $00B7E6
        DC.W    $6616               ; BNE.S  $00B802; $00B7EA
        RTS                                     ; $00B7EC
