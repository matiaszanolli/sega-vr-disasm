; ============================================================================
; Fm Write Port0 027 (auto-analyzed)
; ROM Range: $030CBA-$030CCC (18 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Calls: z80_bus_request, fm_write_port0
;
; Calls:
;   $030CD8: fm_write_port0
;   $030D1C: z80_bus_request
; Confidence: high
; ============================================================================

fn_30200_027:
        DC.W    $4EBA,$0060         ; JSR     $030D1C(PC); $030CBA
        DC.W    $4EBA,$0018         ; JSR     $030CD8(PC); $030CBE
        MOVE.W  #$0000,$00A11100                ; $030CC2
        RTS                                     ; $030CCA
