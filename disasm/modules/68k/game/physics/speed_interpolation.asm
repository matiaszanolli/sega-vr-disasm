; ============================================================================
; Speed Interpolation (Table-Based with Clamping)
; ROM Range: $00A3EA-$00A432 (74 bytes)
; ============================================================================
; Gradually adjusts speed toward a target value read from a lookup table.
; The delta is divided by 103 for smooth interpolation, then clamped to
; system-defined acceleration bounds stored in RAM.
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A1
; Fields accessed:
;   A0+$04: Speed table index
;   A0+$06: Accumulated speed delta (output, clamped >= 0)
;   A0+$08: Secondary speed field
;   A0+$16: Current speed
; RAM:
;   ($C0F8).W: Upper acceleration limit
;   ($C0FA).W: Lower acceleration limit
; ============================================================================

speed_interpolation:
        lea     $00899DA4,a1            ; Speed table base address
        move.w  $4(a0),d0               ; Load speed index
        add.w   d0,d0                   ; Word offset (index * 2)
        move.w  (a1,d0.w),d1            ; $3231 $0000 — read target speed from table
        sub.w   $16(a0),d1              ; Delta = target - current speed
        ext.l   d1                      ; Sign-extend to long for division
        divs.w  #$0067,d1               ; Divide by 103 (gradual interpolation)
        move.w  $8(a0),d0               ; Load secondary speed field
        sub.w   $6(a0),d0               ; Remaining = secondary - accumulated
        cmp.w   ($FFFFC0F8).w,d1        ; $B278 $C0F8 — check upper acceleration limit
        ble.s   .check_lower            ; If D1 <= upper limit, skip clamp
        move.w  ($FFFFC0F8).w,d1        ; $3238 $C0F8 — clamp to upper limit
.check_lower:
        cmp.w   d1,d0                   ; Compare remaining delta vs interpolated
        bge.s   .use_interpolated       ; If remaining >= interpolated, use interpolated
        cmp.w   ($FFFFC0FA).w,d0        ; $B078 $C0FA — check lower acceleration limit
        bge.s   .apply                  ; If D0 >= lower limit, use as-is
        move.w  ($FFFFC0FA).w,d0        ; $3038 $C0FA — clamp to lower limit
        bra.s   .apply
.use_interpolated:
        move.w  d1,d0                   ; Use interpolated value
.apply:
        add.w   d0,$6(a0)              ; Apply delta to accumulated speed
        bge.s   .return                 ; If result >= 0, done
        clr.w   $6(a0)                  ; Floor at zero
.return:
        rts
