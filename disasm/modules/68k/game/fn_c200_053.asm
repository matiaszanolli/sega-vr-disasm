; ============================================================================
; Negative Velocity Step — Small Decrement
; ROM Range: $00DCBE-$00DCD0 (18 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Adjusts D0 toward negative limit. If D0 >= $C000 (-$4000 signed),
; subtracts $0010 (small step). If D0 < $C000, returns unchanged. An
; alternate entry at .sub_large provides a $0040 (large step) variant.
;
; This is the negative counterpart to c200_func_022 (fn_c200_052).
;
; Entry: D0 = velocity/position value (word)
; Exit:  D0 = adjusted value
; Uses:  D0
; ============================================================================

c200_func_023:
        cmpi.w  #$C000,d0                      ; $00DCBE: $0C40 $C000 — below negative threshold?
        blt.s   .done                           ; $00DCC2: $6D0A — yes: leave unchanged
        subi.w  #$0010,d0                       ; $00DCC4: $0440 $0010 — small step: subtract $10
        bra.s   .done                           ; $00DCC8: $6004
.sub_large:
        subi.w  #$0040,d0                       ; $00DCCA: $0440 $0040 — large step: subtract $40
.done:
        rts                                     ; $00DCCE: $4E75
