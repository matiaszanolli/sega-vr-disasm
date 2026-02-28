; ============================================================================
; Object Param 8A Dispatch (Variant A)
; ROM Range: $002DCA-$002DF4 (42 bytes)
; ============================================================================
; Category: game
; Purpose: Reads object param_8a (A0+$8A) and dispatches:
;   param=0 → branches forward to $002E14 (external handler)
;   param=1 → branches forward to $002DF4 (external handler)
;   param≥2 → copies longword from $C74C to obj1.field24 and obj2.field128,
;     sets obj1.field64 based on velocity_x (A0+$8C):
;     velocity_x=0 → field64=1, velocity_x≠0 → field64=0.
;
; Entry: A0 = source object, A1 = target object 1, A2 = target object 2
; Uses: D0, A0, A1, A2
; Object fields:
;   A0+$8A: param_8a (word, dispatch key)
;   A0+$8C: velocity_x (word)
;   A1+$24: field24 (long, set from $C74C)
;   A1+$64: field64 (word, 0 or 1)
;   A2+$128: field128 (long, set from $C74C)
; RAM:
;   $C74C: position/transform value (long)
; ============================================================================

object_param_8a_dispatch_002dca:
        move.w  $008A(A0),D0                    ; $002DCA  D0 = param_8a
        beq.s   object_velocity_init_002e14     ; $002DCE  param=0 → external handler
        subq.w  #1,D0                           ; $002DD0  D0 -= 1
        beq.s   object_velocity_init_002df4     ; $002DD2  param=1 → external handler
        move.l  ($FFFFC74C).w,$0024(A1)         ; $002DD4  obj1.field24 = $C74C
        move.l  ($FFFFC74C).w,$0128(A2)         ; $002DDA  obj2.field128 = $C74C
        move.w  #$0001,$0064(A1)                ; $002DE0  obj1.field64 = 1
        tst.w   $008C(A0)                       ; $002DE6  velocity_x == 0?
        beq.s   object_velocity_init_002e14+30  ; $002DEA  velocity=0 → rts in next fn
        move.w  #$0000,$0064(A1)                ; $002DEC  obj1.field64 = 0 (moving)
        rts                                     ; $002DF2
