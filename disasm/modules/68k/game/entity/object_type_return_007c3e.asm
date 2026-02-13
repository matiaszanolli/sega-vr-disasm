; ============================================================================
; object_type_return_007c3e — Object Type Return — Type 16
; ROM Range: $007C3E-$007C42 (4 bytes)
; Returns constant $10 (16) in D0. Jump table target for object type dispatch.
;
; Uses: D0
; Confidence: high
; ============================================================================

object_type_return_007c3e:
        MOVEQ   #$10,D0                         ; $007C3E
        RTS                                     ; $007C40
