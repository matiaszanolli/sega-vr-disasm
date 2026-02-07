; ============================================================================
; State 011 (auto-analyzed)
; ROM Range: $0083BC-$0083C6 (10 bytes)
; ============================================================================
; Category: game
; Purpose: Small leaf function
;   Object (A0): +$02 (flags/type)
;
; Entry: A0 = object/entity pointer
; Uses: A0
; Object fields:
;   +$02: flags/type
; Confidence: low
; ============================================================================

fn_8200_011:
        BTST    #6,$0002(A0)                    ; $0083BC
        DC.W    $6602               ; BNE.S  $0083C6; $0083C2
        RTS                                     ; $0083C4
