; ============================================================================
; Speed Scale Calculation
; ROM Range: $00B06A-$00B092 (40 bytes)
; ============================================================================
; Converts a raw distance/speed value to a scaled result:
;   1. Subtract base offset 6000 ($1770), clamp to 0
;   2. Clamp max to 11000 ($2AF8)
;   3. Compute D0 = D0/8 + D0/16 = 3*D0/16
;   4. Clamp max to 2048 ($0800)
;   5. Add base 2048 ($0800)
; Result range: $0800-$1000 (2048-4096)
;
; Entry: D0.W = raw value
; Exit:  D0.W = scaled result ($0800-$1000)
; Uses: D0, D1
; ============================================================================

speed_scale_calc:
        subi.w  #$1770,d0               ; Subtract base offset 6000
        bpl.s   .check_max              ; If positive, check max
        moveq   #0,d0                   ; Floor at 0
.check_max:
        cmpi.w  #$2AF8,d0               ; Compare to max 11000
        blt.s   .scale                  ; If less, proceed to scale
        move.w  #$2AF8,d0               ; Clamp to 11000
.scale:
        lsr.w   #3,d0                   ; D0 / 8
        move.w  d0,d1                   ; D1 = D0/8
        lsr.w   #1,d0                   ; D0 / 16
        add.w   d1,d0                   ; D0 = D0/8 + D0/16 = 3*D0/16
        cmpi.w  #$0800,d0               ; Compare to max 2048
        ble.s   .add_base               ; If <= 2048, add base
        move.w  #$0800,d0               ; Clamp to 2048
.add_base:
        addi.w  #$0800,d0               ; Add base 2048
        rts
