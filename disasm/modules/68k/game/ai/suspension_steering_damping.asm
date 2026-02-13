; ============================================================================
; Suspension Steering Damping
; ROM Range: $009802-$00987E (124 bytes)
; ============================================================================
; Dispatches via 3-entry jump table indexed by race_substate_b.
; State 0 handler: applies steering damping based on lateral velocity
; ($004C field). If velocity and steering indicators are non-zero,
; uses ASR-based damping. Otherwise applies decay by subtracting
; 1/4 of current value, clamping to zero when small enough.
;
; Entry: A0 = object pointer (+$4C, +$62, +$88, +$92, +$94, +$96)
; Uses: D0, D1, D4, A0, A1, A2
; RAM:
;   $C8CC: race_substate_b (jump table index: 0/4/8)
; ============================================================================

suspension_steering_damping:
; --- state dispatch ---
        move.w  ($FFFFC8CC).w,d0                ; race_substate_b (table index)
        movea.l $00980C(pc,d0.w),a1             ; load handler address
        jmp     (a1)                            ; dispatch
; --- jump table (3 entries) ---
        dc.l    $00889818                        ; state 0 → damping calc (below)
        dc.l    $008899AA                        ; state 1 → external handler
        dc.l    $0088987E                        ; state 2 → external handler
; --- state 0: steering damping calculation ---
        move.w  $0092(a0),d0                    ; steering indicator
        or.w    $0062(a0),d0                    ; combine with lateral flag
        bne.s   .decay                           ; both zero → skip active damping
; --- active damping: velocity-based ---
        move.w  $004C(a0),d0                    ; lateral velocity
        bpl.s   .positive
        neg.w   d0                              ; absolute value
.positive:
        cmpi.w  #$0037,d0                       ; threshold check
        ble.s   .decay                           ; below threshold → use decay
        move.w  $004C(a0),d0                    ; signed lateral velocity
        asr.w   #7,d0                           ; ÷ 128
        move.w  d0,d1                           ; save
        asr.w   #1,d0                           ; ÷ 256
        add.w   d1,d0                            ; ×1.5 of ÷128 = ×3/256
        add.w   d0,$0094(a0)                    ; add to suspension
        move.w  $0094(a0),d0                    ; read updated suspension
        asr.w   #1,d0                           ; halve for display
        move.w  d0,$0096(a0)                    ; store display value
        bra.w   .done
; --- decay path: reduce by 1/4 ---
.decay:
        move.w  $0094(a0),d0                    ; current suspension
        move.w  d0,d1                           ; save original
        asr.w   #2,d0                           ; ÷ 4
        sub.w   d0,$0094(a0)                    ; subtract 1/4
        move.w  $0094(a0),d0                    ; read updated value
        move.w  d0,$0096(a0)                    ; store display value
; --- check if value has crossed zero or is small enough to clamp ---
        tst.w   d1                              ; original positive?
        bge.s   .check_pos
        neg.w   d0                              ; negate for comparison
        neg.w   d1
.check_pos:
        cmp.w   d0,d1                           ; sign changed?
        blt.s   .done                            ; yes → stop
        tst.w   d0                              ; went negative?
        blt.s   .done
        cmpi.w  #$000F,d0                       ; small enough?
        bgt.s   .done
        clr.w   $0094(a0)                       ; clamp to zero
.done:
        rts
