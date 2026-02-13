; ============================================================================
; fn_6200_046 — Object Type Return — Type 2 (D)
; ROM Range: $007C32-$007C36 (4 bytes)
; Returns constant 2 in D0. Jump table target for object type dispatch.
;
; Uses: D0
; Confidence: high
; ============================================================================

fn_6200_046:
        MOVEQ   #$02,D0                         ; $007C32
        RTS                                     ; $007C34
