; ============================================================================
; fn_6200_051 — Object Type Return — Type 2 (F)
; ROM Range: $007C46-$007C4A (4 bytes)
; Returns constant 2 in D0. Jump table target for object type dispatch.
;
; Uses: D0
; Confidence: high
; ============================================================================

fn_6200_051:
        MOVEQ   #$02,D0                         ; $007C46
        RTS                                     ; $007C48
