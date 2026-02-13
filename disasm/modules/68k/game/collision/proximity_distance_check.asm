; ============================================================================
; Proximity Distance Check
; ROM Range: $00ADC4-$00AE04 (66 bytes)
; ============================================================================
; Checks 3D proximity between two entities (A0, A1).
; Compares absolute differences of positions $32, $30, $34 against thresholds.
; If all within range ($200, $40, $40), chains to zone_check at $AE0A.
; Otherwise returns D0=0.
;
; Entry: A0 = entity A, A1 = entity B (from entity_target_action chain)
; Uses: D0
; Fields accessed:
;   A0/A1+$30: Position X
;   A0/A1+$32: Position Z
;   A0/A1+$34: Position Y
;   A1+$88: Direction flags (cleared)
; ============================================================================

proximity_distance_check:
        clr.w   $88(a1)                 ; Clear target direction flags
        move.w  $32(a1),d0              ; Load Z position (target)
        sub.w   $32(a0),d0              ; Z_target - Z_self
        bpl.s   .abs_z                  ; If positive, skip negate
        neg.w   d0                      ; |Z difference|
.abs_z:
        cmpi.w  #$0200,d0              ; Z threshold = 512
        bge.s   .too_far                ; If >= 512, fail
        move.w  $30(a1),d0              ; Load X position (target)
        sub.w   $30(a0),d0              ; X_target - X_self
        bpl.s   .abs_x                  ; If positive, skip negate
        neg.w   d0                      ; |X difference|
.abs_x:
        cmpi.w  #$0040,d0              ; X threshold = 64
        bge.s   .too_far                ; If >= 64, fail
        move.w  $34(a1),d0              ; Load Y position (target)
        sub.w   $34(a0),d0              ; Y_target - Y_self
        bpl.s   .abs_y                  ; If positive, skip negate
        neg.w   d0                      ; |Y difference|
.abs_y:
        cmpi.w  #$0040,d0              ; Y threshold = 64
        bge.s   .too_far                ; If >= 64, fail
        dc.w    $4EFA,$000A             ; JMP zone_check_inner(PC) - chain to $AE0A
.too_far:
        moveq   #0,d0                   ; Return 0 (not in proximity)
        rts
