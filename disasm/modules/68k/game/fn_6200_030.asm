; ============================================================================
; Conditional Object Velocity Negate
; ROM Range: $007624-$007636 (18 bytes)
; ============================================================================
; If the word at $C0BA is nonzero, loads the word at $C0C2, negates
; it, and stores the result into object+$CC. Falls through past $7636
; if $C0BA is zero.
;
; Memory:
;   $FFFFC0BA = velocity enable flag (word, tested)
;   $FFFFC0C2 = velocity value (word, read and negated)
; Entry: A0 = object pointer | Exit: object+$CC set or falls through
; Uses: D0, A0
; ============================================================================

fn_6200_030:
        tst.w   ($FFFFC0BA).w                   ; $007624: $4A78 $C0BA — velocity enabled?
        beq.s   fn_6200_030_end                 ; $007628: $670C — zero → fall through
        move.w  ($FFFFC0C2).w,d0               ; $00762A: $3038 $C0C2 — load velocity
        neg.w   d0                              ; $00762E: $4440 — negate
        move.w  d0,$00CC(a0)                    ; $007630: $3140 $00CC — store in object+$CC
        rts                                     ; $007634: $4E75
fn_6200_030_end:
