; ============================================================================
; Plane Evaluation Pair
; ROM Range: $0075C8-$0075FD (54 bytes)
; ============================================================================
; Two BSP plane evaluation helpers for visibility testing.
; Computes: result = (D1*coef_A + D2*coef_B + C<<5) >> shift
;
; plane_eval: shift = 6 (direct entry)
; plane_eval_signed: checks sign at A2+$19, branches to plane_eval if positive,
;                    otherwise uses shift = 5
;
; Entry: D1 = normalized angle 1, D2 = normalized angle 2, A2 = plane data ptr
; Returns: D1 = evaluation result
; Uses: D1, D2
; Fields accessed:
;   A2+$12: Plane coefficient A (word, used as MULS operand)
;   A2+$14: Plane coefficient B (word, used as MULS operand)
;   A2+$16: Plane constant C (word)
;   A2+$19: Sign flag (byte, tested by signed variant)
; ============================================================================

plane_eval:
        muls.w  $12(a2),d1              ; D1 = D1 * coefficient A
        muls.w  $14(a2),d2              ; D2 = D2 * coefficient B
        add.l   d2,d1                   ; D1 += D2
        move.w  $16(a2),d2              ; D2 = constant C
        ext.l   d2                      ; Sign extend to long
        asl.l   #5,d2                   ; D2 <<= 5
        add.l   d2,d1                   ; D1 += D2
        asr.l   #6,d1                   ; D1 >>= 6
        rts

plane_eval_signed:
        tst.b   $19(a2)                 ; Check sign flag
        bpl.s   plane_eval              ; If positive, use shift=6 path
        muls.w  $12(a2),d1              ; D1 = D1 * coefficient A
        muls.w  $14(a2),d2              ; D2 = D2 * coefficient B
        add.l   d2,d1                   ; D1 += D2
        move.w  $16(a2),d2              ; D2 = constant C
        ext.l   d2                      ; Sign extend
        asl.l   #5,d2                   ; D2 <<= 5
        add.l   d2,d1                   ; D1 += D2
        asr.l   #5,d1                   ; D1 >>= 5 (less aggressive shift)
        rts
