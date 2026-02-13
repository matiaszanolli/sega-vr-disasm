; ============================================================================
; fn_200_018 — Tile Data Stream Byte Read
; ROM Range: $0011E4-$0011EE (10 bytes)
; ============================================================================
; Reads next byte from tile data stream (A0)+. If byte is $FF (end marker),
; returns to caller. Otherwise falls through to tile decompressor engine
; at $0011EE (fn_200_019).
;
; Entry: A0 = pointer to compressed tile data stream
; Exit: D0 = byte read; falls through if not $FF
; Uses: D0, A0
; ============================================================================

fn_200_018:
        MOVE.B  (A0)+,D0                        ; $0011E4
        CMPI.B  #$FF,D0                         ; $0011E6
        DC.W    $6602               ; BNE.S  $0011EE; $0011EA
        RTS                                     ; $0011EC
