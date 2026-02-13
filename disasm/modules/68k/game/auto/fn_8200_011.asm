; ============================================================================
; fn_8200_011 — Entity Flag Bit Test Guard
; ROM Range: $0083BC-$0083C6 (10 bytes)
; Tests bit 6 of entity flags field +$02(A0). If set, falls through past
; RTS to continue processing. If clear, returns immediately. Guards
; subsequent code from executing on inactive entities.
;
; Entry: A0 = entity pointer
; Uses: A0
; Object fields: +$02 flags (bit 6 = processing gate)
; Confidence: high
; ============================================================================

fn_8200_011:
        BTST    #6,$0002(A0)                    ; $0083BC
        DC.W    $6602               ; BNE.S  $0083C6; $0083C2
        RTS                                     ; $0083C4
