; ============================================================================
; Object Velocity Init (Dual Object, Alt Source)
; ROM Range: $002E5E-$002E7E (32 bytes)
; ============================================================================
; Copies velocity data from $C75C to both A1+$24 and A2+$128.
; Sets A1+$64 to 1 (active). Tests A0+$8C (velocity_x): if zero,
; falls through to next function. Otherwise clears A1+$64 and returns.
;
; Memory:
;   $FFFFC75C = velocity data source (long)
; Entry: A0 = source obj, A1 = target obj 1, A2 = target obj 2
; Exit: conditional return or fall-through | Uses: A0, A1, A2
; ============================================================================

object_velocity_init_002e5e:
        move.l  ($FFFFC75C).w,$0024(a1)         ; $002E5E: $2378 $C75C $0024 — copy velocity to obj 1
        move.l  ($FFFFC75C).w,$0128(a2)         ; $002E64: $2578 $C75C $0128 — copy velocity to obj 2
        move.w  #$0001,$0064(a1)                ; $002E6A: $337C $0001 $0064 — set active flag
        tst.w   $008C(a0)                       ; $002E70: $4A68 $008C — test velocity_x
        dc.w    $6726                           ; BEQ.S fn_2200_032_end ; $002E74: — zero → fall through
        move.w  #$0000,$0064(a1)                ; $002E76: $337C $0000 $0064 — clear active flag
        rts                                     ; $002E7C: $4E75

