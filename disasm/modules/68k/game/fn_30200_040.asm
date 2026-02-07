; ============================================================================
; Fm Z80 Bus Request 040 (auto-analyzed)
; ROM Range: $031166-$03117C (22 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Calls: z80_bus_request
;
; Uses: D0, A4
; Calls:
;   $030D1C: z80_bus_request
; Confidence: medium
; ============================================================================

fn_30200_040:
        MOVE.B  (A4)+,D0                        ; $031166
        DC.W    $4EBA,$FBB2         ; JSR     $030D1C(PC); $031168
        MOVE.B  D0,$00A00FFE                    ; $03116C
        MOVE.W  #$0000,$00A11100                ; $031172
        RTS                                     ; $03117A
