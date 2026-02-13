; ============================================================================
; fn_6200_026 — VDP Nametable Setup + Display List Build
; ROM Range: $007248-$007270 (40 bytes)
; Configures VDP nametable addresses (scroll A at $C000, scroll B at $E000)
; and scroll mode via register writes through A5/A6, then loads display
; buffer at $FF6000 and calls display list builder. Stores object count
; in $FF610E.
;
; Entry: A5/A6 = VDP register write ports
; Uses: D0, D4, A2, A5, A6
; Confidence: high
; ============================================================================

fn_6200_026:
        ORI.L  #$C0000095,(A5)                  ; $007248
        DC.W    $D000                           ; $00724E
        ORI.L  #$E0000095,(A5)                  ; $007250
        DC.W    $F000                           ; $007256
        ORI.L  #$10000096,(A6)                  ; $007258
        MOVE.B  D0,D0                           ; $00725E
        LEA     $00FF6000,A2                    ; $007260
        DC.W    $6118               ; BSR.S  $007280; $007266
        MOVE.W  D4,$00FF610E                    ; $007268
        RTS                                     ; $00726E
