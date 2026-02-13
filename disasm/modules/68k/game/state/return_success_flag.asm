; ============================================================================
; return_success_flag — Return Success Flag
; ROM Range: $00850A-$00850E (4 bytes)
; Returns D0=1 (success/true). Fallthrough target from time_array_entry_comparison when
; the array comparison condition is not met.
;
; Uses: D0
; Confidence: high
; ============================================================================

return_success_flag:
        MOVEQ   #$01,D0                         ; $00850A
        RTS                                     ; $00850C
