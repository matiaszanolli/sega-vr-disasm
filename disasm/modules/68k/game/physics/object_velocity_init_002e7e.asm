; ============================================================================
; Object Velocity Init (Dual Object, Source $C754)
; ROM Range: $002E7E-$002E9E (32 bytes)
; ============================================================================
; Copies velocity data from $C754 to both A1+$24 and A2+$128.
; Sets A1+$64 to 1 (active). Tests A0+$8C (velocity_x): if non-zero,
; clears the active flag before returning.
;
; Memory:
;   $FFFFC754 = velocity data source (long)
; Entry: A0 = source obj, A1 = target obj 1, A2 = target obj 2
; Exit: velocity set | Uses: A0, A1, A2
; ============================================================================

object_velocity_init_002e7e:
        move.l  ($FFFFC754).w,$0024(a1)         ; $002E7E: $2378 $C754 $0024 — copy velocity to obj 1
        move.l  ($FFFFC754).w,$0128(a2)         ; $002E84: $2578 $C754 $0128 — copy velocity to obj 2
        move.w  #$0001,$0064(a1)                ; $002E8A: $337C $0001 $0064 — set active flag
        tst.w   $008C(a0)                       ; $002E90: $4A68 $008C — test velocity_x
        beq.s   .done                           ; $002E94: $6706 — zero → done
        move.w  #$0000,$0064(a1)                ; $002E96: $337C $0000 $0064 — clear active flag
.done:
        rts                                     ; $002E9C: $4E75

