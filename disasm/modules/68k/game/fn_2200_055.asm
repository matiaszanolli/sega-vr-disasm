; ============================================================================
; Conditional Return on Display Flag
; ROM Range: $00385E-$003866 (8 bytes)
; ============================================================================
; Tests the display control byte at $C80F. If nonzero, returns early (RTS).
; If zero, falls through to the next function in the section — acting as
; a conditional gate for the following code.
;
; Memory: $FFFFC80F = display control byte (tested for zero)
; Entry: none | Exit: returns if flag set, falls through if clear
; Uses: condition codes
; ============================================================================

fn_2200_055:
        tst.b   ($FFFFC80F).w                   ; $00385E: $4A38 $C80F — test display flag
        beq.s   .skip                           ; $003862: $6702 — zero: fall through to next fn
        rts                                     ; $003864: $4E75 — nonzero: return early
.skip:
