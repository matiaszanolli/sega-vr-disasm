; ============================================================================
; object_type_return_007aaa — Object Type Return — Type 2 (B)
; ROM Range: $007AAA-$007AAE (4 bytes)
; Returns constant 2 in D0. Jump table target for object type dispatch,
; indicating type classification 2.
;
; Uses: D0
; Confidence: high
; ============================================================================

object_type_return_007aaa:
        MOVEQ   #$02,D0                         ; $007AAA
        RTS                                     ; $007AAC
