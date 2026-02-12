; ============================================================================
; Load Display List Pointer (Set B)
; ROM Range: $002EB2-$002EC6 (20 bytes)
; ============================================================================
; Loads a display list pointer from $C758 into A1+$24. If the param
; at A0+$8A is nonzero, overrides with the pointer from $C764.
; Paired with fn_2200_034 (set A).
;
; Memory:
;   $FFFFC758 = display list pointer B (long, read)
;   $FFFFC764 = display list pointer B alt (long, read)
; Entry: A0 = param source, A1 = dest struct
; Exit: A1+$24 = display list pointer | Uses: A0, A1
; ============================================================================

fn_2200_035:
        move.l  ($FFFFC758).w,$0024(a1)        ; $002EB2: $2378 $C758 $0024 — default pointer
        tst.w   $008A(a0)                       ; $002EB8: $4A68 $008A — param nonzero?
        beq.s   .done                           ; $002EBC: $6706 — no → keep default
        move.l  ($FFFFC764).w,$0024(a1)        ; $002EBE: $2378 $C764 $0024 — override pointer
.done:
        rts                                     ; $002EC4: $4E75
