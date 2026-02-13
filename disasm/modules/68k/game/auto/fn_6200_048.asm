; ============================================================================
; fn_6200_048 — Object Type Return — Type 8
; ROM Range: $007C3A-$007C3E (4 bytes)
; Returns constant 8 in D0. Jump table target for object type dispatch.
;
; Uses: D0
; Confidence: high
; ============================================================================

fn_6200_048:
        MOVEQ   #$08,D0                         ; $007C3A
        RTS                                     ; $007C3C
