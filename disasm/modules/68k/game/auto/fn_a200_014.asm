; ============================================================================
; fn_a200_014 — Sound Buffer Copy with Decode
; ROM Range: $00B40E-$00B422 (20 bytes)
; Loads decode buffer A3 from $FF68D8, calls shared decoder at $00B43C,
; then copies 8 bytes from decode buffer to sound output at $FF6958.
;
; Uses: A1, A3
; Confidence: high
; ============================================================================

fn_a200_014:
        LEA     $00FF68D8,A3                    ; $00B40E
        DC.W    $6126               ; BSR.S  $00B43C; $00B414
        LEA     $00FF6958,A1                    ; $00B416
        MOVE.L  (A3)+,(A1)+                     ; $00B41C
        MOVE.L  (A3),(A1)                       ; $00B41E
        RTS                                     ; $00B420
