; ============================================================================
; Conditional Return on Display Config Flag
; ROM Range: $00B590-$00B598 (8 bytes)
; ============================================================================
; Tests the display config flag at $C819. If nonzero, returns to caller.
; If zero, falls through to the next function (skip return).
;
; Memory:
;   $FFFFC819 = display config flag (byte, tested)
; Entry: none | Exit: returns if flag set, falls through if clear
; Uses: none
; ============================================================================

fn_a200_019:
        tst.b   ($FFFFC819).w                   ; $00B590: $4A38 $C819 — check display config flag
        beq.s   fn_a200_019_end                 ; $00B594: $6702 — zero → fall through
        rts                                     ; $00B596: $4E75 — nonzero → return
fn_a200_019_end:
