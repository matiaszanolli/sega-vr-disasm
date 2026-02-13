; ============================================================================
; FM Fade Clear — reset fade state to off
; ROM Range: $030DEE-$030DF4 (6 bytes)
; ============================================================================
; Clears fade state byte (A6+$38 = 0) to disable fade processing.
; Called when fade operation completes or is cancelled.
;
; Entry: A6 = sound driver state pointer
; Uses: A6
; Confidence: high
; ============================================================================

fn_30200_031:
        CLR.B  $0038(A6)                        ; $030DEE
        RTS                                     ; $030DF2
