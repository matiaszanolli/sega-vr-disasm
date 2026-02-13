; ============================================================================
; Entity Speed Clamp
; ROM Range: $009B12-$009B32 (32 bytes)
; ============================================================================
; Clamps entity speed to max, multiplies by $48, stores result.
;
; Entry: A0 = entity
; Uses: D0
; ============================================================================

entity_speed_clamp:
        move.w  $0006(a0),d0          ; Read speed field
        tst.w   $00A8(a0)             ; Check timer
        bne.s   .apply                ; If timer active, skip max check
        cmp.w   $000A(a0),d0          ; Compare with max speed
        ble.s   .apply                ; If <= max, use as-is
        move.w  $000A(a0),d0          ; Cap at max
.apply:
        muls.w  #$0048,d0             ; Scale factor
        asr.l   #8,d0                 ; Divide by 256
        move.w  d0,$0004(a0)          ; Store result
        rts
