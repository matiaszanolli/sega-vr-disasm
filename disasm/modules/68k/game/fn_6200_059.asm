; ============================================================================
; Conditional Return on State Match
; ROM Range: $007EA4-$007EB2 (14 bytes)
; ============================================================================
; Sets D1 = $14 (object type/size), then compares words at $C07A and
; $C098. Returns only if they are equal; falls through otherwise.
;
; Memory:
;   $FFFFC07A = state variable A (word, read)
;   $FFFFC098 = state variable B (word, compared)
; Entry: none | Exit: D1 = $14, returns if match
; Uses: D1, D4
; ============================================================================

fn_6200_059:
        moveq   #$14,d1                         ; $007EA4: $7214 — set object type
        move.w  ($FFFFC07A).w,d4               ; $007EA6: $3838 $C07A — load state A
        cmp.w   ($FFFFC098).w,d4               ; $007EAA: $B878 $C098 — compare with state B
        bne.s   fn_6200_059_end                 ; $007EAE: $6602 — not equal → fall through
        rts                                     ; $007EB0: $4E75 — equal → return
fn_6200_059_end:
