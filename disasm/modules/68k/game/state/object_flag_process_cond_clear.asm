; ============================================================================
; Object Flag Process + Conditional Clear
; ROM Range: $008256-$008280 (42 bytes)
; ============================================================================
; Data prefix (6 bytes: $85 $86 $87 $88 $89 $00), then object
; flag processing. Tests bit 6 of object+$02: if clear, falls
; through to next fn. Otherwise clears bit 6. Then tests bit 1:
; if clear, falls through. Otherwise clears $C04E and bit 9 of
; object+$02 before returning.
;
; Memory:
;   $FFFFC04E = display/scroll value (word, conditionally cleared)
; Entry: A0 = object pointer | Exit: flags processed | Uses: A0
; ============================================================================

object_flag_process_cond_clear:
        dc.w    $8586                           ; $008256: data byte $85,$86
        dc.w    $8788                           ; $008258: data byte $87,$88
        dc.w    $8900                           ; $00825A: data byte $89,$00
        btst    #6,$0002(a0)                    ; $00825C: $0828 $0006 $0002 — test object flag bit 6
        beq.s   timer_disp_update_004+38        ; $008262: bit clear → fall through to timer fn
        andi.w  #$BFFF,$0002(a0)                ; $008264: $0268 $BFFF $0002 — clear bit 6 (14)
        btst    #1,$0002(a0)                    ; $00826A: $0828 $0001 $0002 — test flag bit 1
        beq.s   timer_disp_update_004           ; $008270: bit clear → fall through to timer fn
        move.w  #$0000,($FFFFC04E).w            ; $008272: $31FC $0000 $C04E — clear display value
        andi.w  #$FDFF,$0002(a0)                ; $008278: $0268 $FDFF $0002 — clear bit 9
        rts                                     ; $00827E: $4E75

