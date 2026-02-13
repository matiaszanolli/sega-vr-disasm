; ============================================================================
; Set Base Frequency — read 16-bit frequency from sequence
; ROM Range: $03117C-$031188 (12 bytes)
; ============================================================================
; Reads 2 bytes from sequence pointer (A4) as big-endian 16-bit value
; (high byte first via LSL #8). Stores result to channel base frequency
; at A5+$1E. Used as a sequence command for direct frequency override.
;
; Entry: A4 = sequence data pointer (advanced by 2)
; Entry: A5 = channel structure pointer
; Uses: D0, A4
; Confidence: high
; ============================================================================

set_base_freq:
        MOVE.B  (A4)+,D0                        ; $03117C
        LSL.W  #8,D0                            ; $03117E
        MOVE.B  (A4)+,D0                        ; $031180
        MOVE.W  D0,$001E(A5)                    ; $031182
        RTS                                     ; $031186
