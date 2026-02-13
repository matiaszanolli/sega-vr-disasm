; ============================================================================
; Object Param 8A Dispatch (Variant B)
; ROM Range: $002E34-$002E5E (42 bytes)
; ============================================================================
; Category: game
; Purpose: Reads object param_8a (A0+$8A) and dispatches:
;   param=0 → branches forward to $002E7E (external handler)
;   param=1 → branches forward to $002E5E (external handler)
;   param≥2 → copies longword from $C760 to obj1.field24 and obj2.field128,
;     sets obj1.field64 based on velocity_x (A0+$8C):
;     velocity_x=0 → field64=1, velocity_x≠0 → field64=0.
;   Identical structure to object_param_8a_dispatch_002dca but uses $C760 instead of $C74C.
;
; Entry: A0 = source object, A1 = target object 1, A2 = target object 2
; Uses: D0, A0, A1, A2
; Object fields:
;   A0+$8A: param_8a (word, dispatch key)
;   A0+$8C: velocity_x (word)
;   A1+$24: field24 (long, set from $C760)
;   A1+$64: field64 (word, 0 or 1)
;   A2+$128: field128 (long, set from $C760)
; RAM:
;   $C760: position/transform value (long)
; ============================================================================

object_param_8a_dispatch_002e34:
        move.w  $008A(A0),D0                    ; $002E34  D0 = param_8a
        dc.w    $6744                           ; $002E38  beq.s $002E7E — param=0 → external
        subq.w  #1,D0                           ; $002E3A  D0 -= 1
        dc.w    $6720                           ; $002E3C  beq.s $002E5E — param=1 → external
        move.l  ($FFFFC760).w,$0024(A1)         ; $002E3E  obj1.field24 = $C760
        move.l  ($FFFFC760).w,$0128(A2)         ; $002E44  obj2.field128 = $C760
        move.w  #$0001,$0064(A1)                ; $002E4A  obj1.field64 = 1
        tst.w   $008C(A0)                       ; $002E50  velocity_x == 0?
        dc.w    $6746                           ; $002E54  beq.s $002E9C — yes → external
        move.w  #$0000,$0064(A1)                ; $002E56  obj1.field64 = 0 (moving)
        rts                                     ; $002E5C
