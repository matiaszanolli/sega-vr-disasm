; ============================================================================
; Stack Pop Return — skip caller's remaining code
; ROM Range: $030354-$030358 (4 bytes)
; ============================================================================
; Pops return address from stack (ADDQ.W #4,A7), then returns. This causes
; execution to skip the caller's remaining code and return to the
; grandparent. Used by the sound driver as a tail-call abort.
;
; Confidence: high
; ============================================================================

stack_pop_return:
        ADDQ.W  #4,A7                           ; $030354
        RTS                                     ; $030356
