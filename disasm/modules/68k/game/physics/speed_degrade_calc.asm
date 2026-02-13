; ============================================================================
; Speed Degrade Calculation
; ROM Range: $00859A-$0085C4 (42 bytes)
; ============================================================================
; Calculates speed degradation for entity. Reads speed, clamps,
; applies to drag field at $00BC(A0).
;
; Entry: A0 = entity
; Uses: D0, D1
; ============================================================================

speed_degrade_calc:
        move.w  $0004(a0),d0          ; Read speed
        ext.l   d0                    ; Sign-extend to long
        moveq   #6,d1
        lsl.l   d1,d0                 ; Shift left 6
        bpl.s   .nonneg
        moveq   #0,d0                 ; Clamp negative to 0
.nonneg:
        cmpi.l  #$00001900,d0         ; Low threshold
        bcs.s   .apply                ; If < $1900, use as-is
        lsl.l   #2,d0                 ; Shift left 2
        cmpi.l  #$00007000,d0         ; High threshold
        bcs.s   .apply                ; If < $7000, use
        move.w  #$7080,d0             ; Cap at $7080
.apply:
        sub.w   d0,$00BC(a0)          ; Subtract from drag
        rts
