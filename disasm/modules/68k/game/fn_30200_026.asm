; ============================================================================
; Fm Write Conditional 026 (auto-analyzed)
; ROM Range: $030CA2-$030CBA (24 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Calls: z80_bus_request, fm_write_conditional
;
; Uses: A5
; Calls:
;   $030CCC: fm_write_conditional
;   $030D1C: z80_bus_request
; Confidence: high
; ============================================================================

fn_30200_026:
        BTST    #2,(A5)                         ; $030CA2
        BNE.S  .loc_0016                        ; $030CA6
        DC.W    $4EBA,$0072         ; JSR     $030D1C(PC); $030CA8
        DC.W    $4EBA,$001E         ; JSR     $030CCC(PC); $030CAC
        MOVE.W  #$0000,$00A11100                ; $030CB0
.loc_0016:
        RTS                                     ; $030CB8
