; ============================================================================
; Camera Position Smoothing
; ROM Range: $007008-$007082 (124 bytes)
; ============================================================================
; Smooths camera/entity position using interpolation and trig-based movement.
; Two paths based on slope direction ($72) vs stored direction ($68):
;   Same direction: direct position update with 1/8 damping
;   Different direction: 50% interpolation toward target
; Then applies rotation-based movement using external trig functions.
;
; Entry: A0 = entity/camera object
; Uses: D0-D3, D6
; Fields accessed:
;   A0+$1E: Target position
;   A0+$30: World position X (updated)
;   A0+$34: World position Y (updated)
;   A0+$3C: Intermediate position (updated)
;   A0+$40: Display position (updated)
;   A0+$64: Rotation offset (updated)
;   A0+$66: Damping value
;   A0+$68: Direction flag
;   A0+$72: Slope direction
; ============================================================================

camera_position_smooth:
        moveq   #1,d0                   ; D0 = 1 (positive direction)
        tst.w   $72(a0)                 ; Check slope direction
        bgt.s   .check_direction        ; If positive, skip
        bmi.s   .negate                 ; If negative, negate
        moveq   #0,d0                   ; If zero, D0 = 0
.negate:
        neg.w   d0                      ; D0 = -1
.check_direction:
        cmp.w   $68(a0),d0              ; Compare with stored direction
        bne.s   .interpolate            ; If different, interpolate
        move.w  $66(a0),d0              ; Load damping value
        move.w  d0,d1                   ; Copy to D1
        asr.w   #3,d0                   ; D0 = damping/8
        sub.w   d0,$3C(a0)             ; Intermediate -= damping/8
        move.w  $3C(a0),d0             ; Reload intermediate
        sub.w   d1,d0                   ; D0 = intermediate - damping
        move.w  d0,$40(a0)             ; Store display position
        bra.s   .apply_rotation         ; Go to rotation step
.interpolate:
        move.w  $1E(a0),d0             ; Load target position
        move.w  d0,d1                   ; Copy
        sub.w   $3C(a0),d1             ; D1 = target - intermediate
        asr.w   #1,d1                   ; D1 /= 2 (50% lerp)
        add.w   d1,$3C(a0)            ; Intermediate += lerp
        move.w  d0,d1                   ; Copy target again
        sub.w   $40(a0),d1             ; D1 = target - display
        asr.w   #1,d1                   ; D1 /= 2
        add.w   d1,$40(a0)            ; Display += lerp
        sub.w   $64(a0),d0             ; D0 = target - rotation offset
        asr.w   #1,d0                   ; D0 /= 2
        add.w   d0,$64(a0)            ; Rotation offset += lerp
.apply_rotation:
        move.w  $64(a0),d0             ; Load rotation offset
        neg.w   d0                      ; Negate
        move.w  #$01AB,d3              ; Trig scaling constant
        moveq   #12,d6                  ; Shift count
        move.w  d0,d2                   ; Save D0 for second trig call
        dc.w    $4EBA,$1EE8             ; JSR trig_cos(PC) at $8F52
        muls.w  d3,d0                   ; D0 = cos * scale
        asr.l   d6,d0                   ; D0 >>= 12 (fixed-point)
        add.w   d0,$30(a0)             ; Position X += result
        move.w  d2,d0                   ; Restore angle
        dc.w    $4EBA,$1ED6             ; JSR trig_sin(PC) at $8F4E
        muls.w  d3,d0                   ; D0 = sin * scale
        asr.l   d6,d0                   ; D0 >>= 12
        add.w   d0,$34(a0)             ; Position Y += result
        rts
