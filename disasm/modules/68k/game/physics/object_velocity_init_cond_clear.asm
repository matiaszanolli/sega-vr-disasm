; ============================================================================
; Object Velocity Init + Conditional Clear
; ROM Range: $002AAA-$002AC4 (26 bytes)
; ============================================================================
; Copies velocity data from $C748 to object A1 offset +$24.
; Sets A1+$64 to 1 (active). Tests A0+$8C (velocity_x): if zero,
; falls through to next function. Otherwise clears A1+$64 and returns.
;
; Memory:
;   $FFFFC748 = velocity data source (long)
; Entry: A0 = source object, A1 = target object
; Exit: conditional return or fall-through | Uses: A0, A1
; ============================================================================

object_velocity_init_cond_clear:
        move.l  ($FFFFC748).w,$0024(a1)         ; $002AAA: $2378 $C748 $0024 — copy velocity data
        move.w  #$0001,$0064(a1)                ; $002AB0: $337C $0001 $0064 — set active flag
        tst.w   $008C(a0)                       ; $002AB6: $4A68 $008C — test velocity_x
        dc.w    $6720                           ; BEQ.S fn_2200_024_end ; $002ABA: — zero → fall through
        move.w  #$0000,$0064(a1)                ; $002ABC: $337C $0000 $0064 — clear active flag
        rts                                     ; $002AC2: $4E75

