; ============================================================================
; object_type_return_007c36 — Object Type Return — Type 4
; ROM Range: $007C36-$007C3A (4 bytes)
; Returns constant 4 in D0. Jump table target for object type dispatch.
;
; Uses: D0
; Confidence: high
; ============================================================================

object_type_return_007c36:
        MOVEQ   #$04,D0                         ; $007C36
        RTS                                     ; $007C38
