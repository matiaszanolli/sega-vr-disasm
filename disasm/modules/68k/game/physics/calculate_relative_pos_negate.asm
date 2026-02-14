; ============================================================================
; Calculate Relative Position + Negate
; ROM Range: $008ED6-$008EF4 (30 bytes)
; ============================================================================
; Computes relative position from object to viewport: loads
; object+$32 minus $C0BC (X offset), shifted right 4. Loads
; object+$34 minus $C0BE (Y offset). Calls sub at $00A7A4,
; negates result D0, and stores in $C0C0.
;
; Memory:
;   $FFFFC0BC = viewport X reference (word, subtracted)
;   $FFFFC0BE = viewport Y reference (word, subtracted)
;   $FFFFC0C0 = result (word, negated value stored)
; Entry: A0 = object pointer | Exit: $C0C0 set | Uses: D0, D2, D3
; ============================================================================

calculate_relative_pos_negate:
        move.w  $0032(a0),d3                    ; $008ED6: $3628 $0032 — load object X
        sub.w   ($FFFFC0BC).w,d3                ; $008EDA: $9678 $C0BC — subtract viewport X
        asr.w   #4,d3                           ; $008EDE: $E843 — divide by 16
        move.w  $0034(a0),d2                    ; $008EE0: $3428 $0034 — load object Y
        sub.w   ($FFFFC0BE).w,d2                ; $008EE4: $9478 $C0BE — subtract viewport Y
        jsr     ai_steering_calc+4(pc)  ; $4EBA $18BA
        neg.w   d0                              ; $008EEC: $4440 — negate result
        move.w  d0,($FFFFC0C0).w                ; $008EEE: $31C0 $C0C0 — store result
        rts                                     ; $008EF2: $4E75

