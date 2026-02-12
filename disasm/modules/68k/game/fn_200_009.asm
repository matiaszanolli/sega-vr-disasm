; ============================================================================
; Double-Conditional Guard
; ROM Range: $000DC4-$000DD2 (14 bytes)
; ============================================================================
; Returns ONLY if $EF05 is nonzero AND $EF06 is zero. In all other
; cases (both zero, or $EF06 nonzero), falls through to the next
; function past $000DD2.
;
; Memory:
;   $FFFFFFEF05 = work RAM flag A (byte, tested)
;   $FFFFFFEF06 = work RAM flag B (byte, tested)
; Entry: none | Exit: returns or falls through
; Uses: none
; ============================================================================

fn_200_009:
        tst.b   ($FFFFEF05).w                   ; $000DC4: $4A38 $EF05 — check flag A
        beq.s   fn_200_009_end                  ; $000DC8: $6708 — zero → fall through
        tst.b   ($FFFFEF06).w                   ; $000DCA: $4A38 $EF06 — check flag B
        bne.s   fn_200_009_end                  ; $000DCE: $6602 — nonzero → fall through
        rts                                     ; $000DD0: $4E75 — A set, B clear → return
fn_200_009_end:
