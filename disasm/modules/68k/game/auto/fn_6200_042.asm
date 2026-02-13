; ============================================================================
; fn_6200_042 — Object Type Return — Type 2 (C)
; ROM Range: $007AAE-$007AB2 (4 bytes)
; Returns constant 2 in D0. Jump table target for object type dispatch,
; indicating type classification 2.
;
; Uses: D0
; Confidence: high
; ============================================================================

fn_6200_042:
        MOVEQ   #$02,D0                         ; $007AAE
        RTS                                     ; $007AB0
