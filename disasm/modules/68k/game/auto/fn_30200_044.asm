; ============================================================================
; Set Channel Multiplier — read multiplier from sequence
; ROM Range: $0311E2-$0311E8 (6 bytes)
; ============================================================================
; Reads one byte from sequence pointer (A4), stores to sound driver
; channel multiplier at A6+$03. Used for pitch scaling in sequence data.
;
; Entry: A4 = sequence pointer, A6 = sound driver state pointer
; Uses: A4
; Confidence: high
; ============================================================================

fn_30200_044:
        MOVE.B  (A4)+,$0003(A6)                 ; $0311E2
        RTS                                     ; $0311E6
