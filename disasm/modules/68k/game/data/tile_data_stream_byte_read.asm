; ============================================================================
; tile_data_stream_byte_read — Tile Data Stream Byte Read
; ROM Range: $0011E4-$0011EE (10 bytes)
; ============================================================================
; Reads next byte from tile data stream (A0)+. If byte is $FF (end marker),
; returns to caller. Otherwise falls through to tile decompressor engine
; at $0011EE (tile_decompressor_engine).
;
; Entry: A0 = pointer to compressed tile data stream
; Exit: D0 = byte read; falls through if not $FF
; Uses: D0, A0
; ============================================================================

tile_data_stream_byte_read:
        MOVE.B  (A0)+,D0                        ; $0011E4
        CMPI.B  #$FF,D0                         ; $0011E6
        DC.W    $6602               ; BNE.S  $0011EE; $0011EA
        RTS                                     ; $0011EC
