; ============================================================================
; AI Target Check
; ROM Range: $00ACD4-$00AD12 (62 bytes)
; ============================================================================
; Checks entity conditions then calls a validation routine for two entity
; slots. If either slot check returns NE, falls through past RTS into the
; next function at $AD14 (conditional chaining).
;
; Entry: A0 = object/entity pointer
; Uses: D0, A1
; Fields accessed:
;   A0+$6A: Timer (must be 0)
;   A0+$88: Cleared on entry
;   A0+$8C: Lock flag (must be 0)
;   A0+$A4: First entity slot index
;   A0+$A6: Second entity slot index
; RAM:
;   ($C02C).W: Counter (must be <= 0)
;   ($9000).W: Entity table base (stride via LSL #8)
; Calls: validation routine at $ADC4 (via JSR PC-relative)
; Note: BNE.S instructions at $ACFC and $AD10 chain past RTS into $AD14
; ============================================================================

ai_target_check:
        tst.w   $6A(a0)                 ; Timer active?
        bne.s   .return                 ; If active, exit
        dc.w    $4A78,$C02C             ; TST.W ($C02C).W - check counter
        bgt.s   .return                 ; If > 0, exit
        tst.w   $8C(a0)                 ; Lock flag set?
        bne.s   .return                 ; If set, exit
        clr.w   $88(a0)                 ; Clear processing flag

        ; --- Check first entity slot ---
        dc.w    $43F8,$9000             ; LEA ($9000).W,A1 - entity table base
        move.w  $A4(a0),d0              ; First slot index
        lsl.w   #8,d0                   ; Index * 256 (entity stride)
        dc.w    $43F1,$0000             ; LEA 0(A1,D0.W),A1 - point to entity
        dc.w    $4EBA,$00CA             ; JSR $ADC4(PC) - validate entity slot
        dc.w    $6616                   ; BNE.S +22 → $AD14 (chain to next function)

        ; --- Check second entity slot ---
        dc.w    $43F8,$9000             ; LEA ($9000).W,A1 - entity table base
        move.w  $A6(a0),d0              ; Second slot index
        lsl.w   #8,d0                   ; Index * 256 (entity stride)
        dc.w    $43F1,$0000             ; LEA 0(A1,D0.W),A1 - point to entity
        dc.w    $4EBA,$00B6             ; JSR $ADC4(PC) - validate entity slot
        dc.w    $6602                   ; BNE.S +2 → $AD14 (chain to next function)
.return:
        rts
