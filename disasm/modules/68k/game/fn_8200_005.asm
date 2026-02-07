; ============================================================================
; Display Status Code 005 (auto-analyzed)
; ROM Range: $0082E0-$0082E8 (8 bytes)
; ============================================================================
; Category: display
; Purpose: Small leaf function
;   RAM: $68F0 (status_code)
;
; Uses: D7
; RAM:
;   $68F0: status_code
; Confidence: medium
; ============================================================================

fn_8200_005:
        MOVE.B  D7,$00FF68F0                    ; $0082E0
        RTS                                     ; $0082E6
