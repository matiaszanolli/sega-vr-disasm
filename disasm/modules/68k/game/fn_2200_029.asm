; ============================================================================
; Object Velocity Init (Dual Object)
; ROM Range: $002DF4-$002E14 (32 bytes)
; ============================================================================
; Copies velocity data from $C748 to both A1+$24 and A2+$128.
; Sets A1+$64 to 1 (active). Tests A0+$8C (velocity_x): if zero,
; falls through to next function. Otherwise clears A1+$64 and returns.
;
; Memory:
;   $FFFFC748 = velocity data source (long)
; Entry: A0 = source obj, A1 = target obj 1, A2 = target obj 2
; Exit: conditional return or fall-through | Uses: A0, A1, A2
; ============================================================================

fn_2200_029:
        move.l  ($FFFFC748).w,$0024(a1)         ; $002DF4: $2378 $C748 $0024 — copy velocity to obj 1
        move.l  ($FFFFC748).w,$0128(a2)         ; $002DFA: $2578 $C748 $0128 — copy velocity to obj 2
        move.w  #$0001,$0064(a1)                ; $002E00: $337C $0001 $0064 — set active flag
        tst.w   $008C(a0)                       ; $002E06: $4A68 $008C — test velocity_x
        dc.w    $6726                           ; BEQ.S fn_2200_029_end ; $002E0A: — zero → fall through
        move.w  #$0000,$0064(a1)                ; $002E0C: $337C $0000 $0064 — clear active flag
        rts                                     ; $002E12: $4E75

