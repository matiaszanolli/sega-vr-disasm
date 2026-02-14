; ============================================================================
; FM Write Wrapper — request bus, write port 0, release (fm_write_wrapper)
; ROM Range: $030CBA-$030CCC (18 bytes)
; ============================================================================
; Convenience wrapper: requests Z80 bus, calls fm_write_port0 to write
; register D0 with data D1 to YM2612 port 0, releases Z80 bus.
;
; Entry: D0 = FM register number, D1 = data value
; Calls:
;   $030CD8: fm_write_port0
;   $030D1C: z80_bus_request
; Confidence: high
; ============================================================================

fm_write_wrapper:
        jsr     z80_bus_wait(pc)        ; $4EBA $0060
        jsr     fm_write_cond+12(pc)    ; $4EBA $0018
        MOVE.W  #$0000,Z80_BUSREQ                ; $030CC2
        RTS                                     ; $030CCA
