; ============================================================================
; Set Instrument Number — read instrument index from sequence
; ROM Range: $0312A6-$0312AC (6 bytes)
; ============================================================================
; Reads one byte from sequence pointer (A4), stores to sound driver
; instrument number at A6+$0A. Used to switch instrument mid-sequence.
;
; Entry: A4 = sequence pointer, A6 = sound driver state pointer
; Uses: A4
; Confidence: high
; ============================================================================

set_instrument_number:
        MOVE.B  (A4)+,$000A(A6)                 ; $0312A6
        RTS                                     ; $0312AA
