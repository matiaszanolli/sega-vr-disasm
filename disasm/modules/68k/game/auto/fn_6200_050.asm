; ============================================================================
; fn_6200_050 — Object Type Return — Type 2 (E)
; ROM Range: $007C42-$007C46 (4 bytes)
; Returns constant 2 in D0. Jump table target for object type dispatch.
;
; Uses: D0
; Confidence: high
; ============================================================================

fn_6200_050:
        MOVEQ   #$02,D0                         ; $007C42
        RTS                                     ; $007C44
