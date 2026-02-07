; ============================================================================
; AI Steering Calculation
; ROM Range: $00A7A0-$00A7E0 (66 bytes)
; ============================================================================
; Computes a steering angle from relative position deltas using an arctangent
; approximation. Returns a 16-bit angle in the range $0000-$FFFF (65536 = 360).
;
; Entry: D0 = entity Y position, D1 = entity X position
;        D2 = target Y position, D3 = target X position
; Returns: D0 = steering angle
; Uses: D0, D1, D2, D3, D6 (preserved via stack)
; Calls: atan2_lookup ($8FC8)
; ============================================================================

ai_steering_calc:
        sub.w   d1,d3                   ; DX = target_x - entity_x
        sub.w   d0,d2                   ; DY = target_y - entity_y
        bne.s   .has_dy                 ; If DY != 0, compute angle
        ; DY == 0: purely horizontal
        tst.w   d3                      ; Check DX
        bgt.s   .positive               ; DX > 0: angle = +$4000
        blt.s   .negative               ; DX < 0: angle = -$4000
        moveq   #0,d0                   ; DX == 0: angle = 0 (no movement)
        rts

.has_dy:
        move.w  d3,d0                   ; D0 = DX
        ext.l   d0                      ; Sign-extend to 32 bits
        asl.l   #8,d0                   ; Scale by 256 (fixed-point)
        divs.w  d2,d0                   ; Tangent ratio = (DX * 256) / DY
        bvc.s   .atan_lookup            ; If no overflow, do atan2 lookup
        ; Overflow: return +-$4000 based on DX sign
        tst.w   d3
        bmi.s   .negative               ; DX < 0: return -$4000
.positive:
        move.w  #$4000,d0               ; Return +$4000 (90 degrees)
        rts
.negative:
        move.w  #$C000,d0               ; Return -$4000 (-90 degrees / 270)
        rts

.atan_lookup:
        ext.l   d0                      ; Sign-extend quotient
        movem.l d2/a1,-(sp)             ; Save registers
        dc.w    $4EBA,$E7F6             ; BSR.W atan2_lookup ($8FC8)
        movem.l (sp)+,d2/a1             ; Restore registers
        tst.w   d2                      ; Check DY sign
        bge.s   .return                 ; If DY >= 0, angle is correct
        addi.w  #$8000,d0              ; Adjust angle for negative DY hemisphere
.return:
        rts
