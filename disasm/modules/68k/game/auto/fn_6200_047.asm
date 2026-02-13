; ============================================================================
; fn_6200_047 — Object Type Return — Type 4
; ROM Range: $007C36-$007C3A (4 bytes)
; Returns constant 4 in D0. Jump table target for object type dispatch.
;
; Uses: D0
; Confidence: high
; ============================================================================

fn_6200_047:
        MOVEQ   #$04,D0                         ; $007C36
        RTS                                     ; $007C38
