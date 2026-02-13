; ============================================================================
; Proximity Loop Iterator A — advance and repeat proximity check
; ROM Range: $003A3E-$003A4E (16 bytes)
; ============================================================================
; Advances A1 by 10 bytes to next object entry, loops back to proximity_check_simple
; body via DBRA D7. If loop exhausted without match, clears output buffer
; visibility flag at (A2)+$00.
;
; Entry: A1 = current object pointer (advanced by $0A per iteration)
; Entry: A2 = output buffer pointer
; Entry: D7 = loop counter
; Uses: D7, A1
; Confidence: medium
; ============================================================================

proximity_loop_iterator_a:
        LEA     $000A(A1),A1                    ; $003A3E
        DC.W    $51CF,$FFB0         ; DBRA    D7,$0039F4; $003A42
        MOVE.W  #$0000,$0000(A2)                ; $003A46
        RTS                                     ; $003A4C
