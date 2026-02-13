; ============================================================================
; object_type_return_007aae — Object Type Return — Type 2 (C)
; ROM Range: $007AAE-$007AB2 (4 bytes)
; Returns constant 2 in D0. Jump table target for object type dispatch,
; indicating type classification 2.
;
; Uses: D0
; Confidence: high
; ============================================================================

object_type_return_007aae:
        MOVEQ   #$02,D0                         ; $007AAE
        RTS                                     ; $007AB0
