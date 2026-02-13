; ============================================================================
; Set Instrument Index — read instrument number from sequence
; ROM Range: $0314FC-$031502 (6 bytes)
; ============================================================================
; Reads one byte from sequence pointer (A4), stores to channel instrument
; index at A5+$0B. Used to switch FM instrument for TL register writes.
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Uses: A4
; Confidence: high
; ============================================================================

fn_30200_056:
        MOVE.B  (A4)+,$000B(A5)                 ; $0314FC
        RTS                                     ; $031500
