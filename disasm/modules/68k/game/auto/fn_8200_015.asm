; ============================================================================
; fn_8200_015 — Return Success Flag
; ROM Range: $00850A-$00850E (4 bytes)
; Returns D0=1 (success/true). Fallthrough target from fn_8200_014 when
; the array comparison condition is not met.
;
; Uses: D0
; Confidence: high
; ============================================================================

fn_8200_015:
        MOVEQ   #$01,D0                         ; $00850A
        RTS                                     ; $00850C
