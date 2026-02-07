; ============================================================================
; Entity Set Model (Type 0)
; ROM Range: $002AC4-$002ADC (26 bytes)
; ============================================================================
; Sets entity model pointer from lookup table at $C710 and conditionally
; sets visibility based on mode flag at A0+$8C.
;
; Entry: A0 = source entity, A1 = destination entity
; Uses: none (only modifies memory)
; ============================================================================

entity_set_model_type0:
        dc.w    $2378,$C710,$0024     ; MOVE.L ($C710).W,$0024(A1)
        move.w  #$0001,$0064(a1)      ; Set visibility = 1
        tst.w   $008C(a0)             ; Check mode flag
        beq.s   .done                 ; If zero, keep visible
        move.w  #$0000,$0064(a1)      ; Clear visibility
.done:
        rts
