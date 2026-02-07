; ============================================================================
; Vint Dispatch 032 (auto-analyzed)
; ROM Range: $001A64-$001A72 (14 bytes)
; ============================================================================
; Category: vint
; Purpose: Short helper function
;   RAM: $C87A (vint_dispatch_state)
;
; Uses: D0, A5
; RAM:
;   $C87A: vint_dispatch_state
; Confidence: medium
; ============================================================================

fn_200_032:
        MOVE.W  #$002C,(-14214).W               ; $001A64
        DC.W    $4EFA,$065A         ; JMP     $0020C6(PC); $001A6A
        MOVE.W  (A5),D0                         ; $001A6E
        RTS                                     ; $001A70
