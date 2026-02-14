; ============================================================================
; Z80 DAC Byte Write — write sequence byte to Z80 DAC register
; ROM Range: $031166-$03117C (22 bytes)
; ============================================================================
; Reads one byte from sequence pointer (A4), requests Z80 bus, writes
; byte to Z80 DAC register at $A00FFE, releases Z80 bus. Used as a
; sequence command sub-handler for direct DAC sample control.
;
; Entry: A4 = sequence data pointer (advanced by 1)
; Uses: D0, A4
; Calls:
;   $030D1C: z80_bus_request
; Confidence: high
; ============================================================================

z80_dac_byte_write:
        MOVE.B  (A4)+,D0                        ; $031166
        jsr     z80_bus_wait(pc)        ; $4EBA $FBB2
        MOVE.B  D0,$00A00FFE                    ; $03116C
        MOVE.W  #$0000,Z80_BUSREQ                ; $031172
        RTS                                     ; $03117A
