; ============================================================================
; object_type_return_007a8e — Object Type Return — Type 2
; ROM Range: $007A8E-$007A92 (4 bytes)
; Returns constant 2 in D0. Target of object_type_dispatch jump table, indicating
; object type classification 2 (e.g., scenery/non-collidable).
;
; Entry: (from jump table dispatch)
; Uses: D0
; Confidence: high
; ============================================================================

object_type_return_007a8e:
        MOVEQ   #$02,D0                         ; $007A8E
        RTS                                     ; $007A90
