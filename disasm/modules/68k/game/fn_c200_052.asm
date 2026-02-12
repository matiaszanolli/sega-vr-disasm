; ============================================================================
; Positive Velocity Step — Small Increment
; ROM Range: $00DCAC-$00DCBE (18 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Adjusts D0 toward positive limit. If D0 <= $4000 (signed), adds $0010
; (small step). If D0 > $4000, returns unchanged. An alternate entry at
; .add_large provides a $0040 (large step) variant for external callers.
;
; This is the positive counterpart to c200_func_023 (fn_c200_053).
;
; Entry: D0 = velocity/position value (word)
; Exit:  D0 = adjusted value
; Uses:  D0
; ============================================================================

c200_func_022:
        cmpi.w  #$4000,d0                      ; $00DCAC: $0C40 $4000 — above positive threshold?
        bgt.s   .done                           ; $00DCB0: $6E0A — yes: leave unchanged
        addi.w  #$0010,d0                       ; $00DCB2: $0640 $0010 — small step: add $10
        bra.s   .done                           ; $00DCB6: $6004
.add_large:
        addi.w  #$0040,d0                       ; $00DCB8: $0640 $0040 — large step: add $40
.done:
        rts                                     ; $00DCBC: $4E75
