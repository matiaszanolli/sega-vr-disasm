; ============================================================================
; Load Display List Pointer (Set A)
; ROM Range: $002E9E-$002EB2 (20 bytes)
; ============================================================================
; Loads a display list pointer from $C724 into A1+$24. If the param
; at A0+$8A is nonzero, overrides with the pointer from $C750.
; Paired with load_disp_list_pointer_002eb2 (set B).
;
; Memory:
;   $FFFFC724 = display list pointer A (long, read)
;   $FFFFC750 = display list pointer A alt (long, read)
; Entry: A0 = param source, A1 = dest struct
; Exit: A1+$24 = display list pointer | Uses: A0, A1
; ============================================================================

load_disp_list_pointer_002e9e:
        move.l  ($FFFFC724).w,$0024(a1)        ; $002E9E: $2378 $C724 $0024 — default pointer
        tst.w   $008A(a0)                       ; $002EA4: $4A68 $008A — param nonzero?
        beq.s   .done                           ; $002EA8: $6706 — no → keep default
        move.l  ($FFFFC750).w,$0024(a1)        ; $002EAA: $2378 $C750 $0024 — override pointer
.done:
        rts                                     ; $002EB0: $4E75
