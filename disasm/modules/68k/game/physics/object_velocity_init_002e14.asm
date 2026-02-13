; ============================================================================
; Object Velocity Init (Dual Object, Source $C710)
; ROM Range: $002E14-$002E34 (32 bytes)
; ============================================================================
; Copies velocity data from $C710 to both A1+$24 and A2+$128.
; Sets A1+$64 to 1 (active). Tests A0+$8C (velocity_x): if non-zero,
; clears the active flag before returning.
;
; Memory:
;   $FFFFC710 = velocity data source (long)
; Entry: A0 = source obj, A1 = target obj 1, A2 = target obj 2
; Exit: velocity set | Uses: A0, A1, A2
; ============================================================================

object_velocity_init_002e14:
        move.l  ($FFFFC710).w,$0024(a1)         ; $002E14: $2378 $C710 $0024 — copy velocity to obj 1
        move.l  ($FFFFC710).w,$0128(a2)         ; $002E1A: $2578 $C710 $0128 — copy velocity to obj 2
        move.w  #$0001,$0064(a1)                ; $002E20: $337C $0001 $0064 — set active flag
        tst.w   $008C(a0)                       ; $002E26: $4A68 $008C — test velocity_x
        beq.s   .done                           ; $002E2A: $6706 — zero → done
        move.w  #$0000,$0064(a1)                ; $002E2C: $337C $0000 $0064 — clear active flag
.done:
        rts                                     ; $002E32: $4E75

