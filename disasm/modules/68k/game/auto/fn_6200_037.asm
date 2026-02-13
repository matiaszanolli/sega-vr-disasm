; ============================================================================
; fn_6200_037 — Object Type Return — Type 2
; ROM Range: $007A8E-$007A92 (4 bytes)
; Returns constant 2 in D0. Target of fn_6200_036 jump table, indicating
; object type classification 2 (e.g., scenery/non-collidable).
;
; Entry: (from jump table dispatch)
; Uses: D0
; Confidence: high
; ============================================================================

fn_6200_037:
        MOVEQ   #$02,D0                         ; $007A8E
        RTS                                     ; $007A90
