; ============================================================================
; FM Conditional Write with Bus — write FM register if not key-off
; ROM Range: $030CA2-$030CBA (24 bytes)
; ============================================================================
; Checks bit 2 (key-off) on channel (A5). If set, skips write. Otherwise
; requests Z80 bus, calls fm_write_conditional to write register D0 with
; data D1 (with channel offset), releases Z80 bus.
;
; Entry: A5 = FM channel structure pointer
; Entry: D0 = FM register number, D1 = data value
; Uses: D0, D1, A5
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
        MOVE.W  #$0000,Z80_BUSREQ                ; $030CB0
.loc_0016:
        RTS                                     ; $030CB8
