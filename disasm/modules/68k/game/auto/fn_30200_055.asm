; ============================================================================
; Set Envelope Number — read envelope index from sequence
; ROM Range: $0314F6-$0314FC (6 bytes)
; ============================================================================
; Reads one byte from sequence pointer (A4), stores to channel envelope
; number at A5+$0A. Used to switch volume/frequency envelope mid-sequence.
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Uses: A4
; Confidence: high
; ============================================================================

fn_30200_055:
        MOVE.B  (A4)+,$000A(A5)                 ; $0314F6
        RTS                                     ; $0314FA
