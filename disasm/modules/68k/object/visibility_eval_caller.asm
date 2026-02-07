; ============================================================================
; Visibility Evaluation Caller
; ROM Range: $007BAC-$007BE2 (56 bytes)
; ============================================================================
; Loads object position, calls angle normalization and BSP visibility test.
; If visible, stores plane pointer in object, calls dispatch for type lookup,
; then evaluates signed plane. If result > 0, averages field $32.
;
; Entry: A0 = object pointer, A2 = BSP data pointer (set by caller)
; Uses: D0-D2, A2
; Fields accessed:
;   A0+$30: Position X (angle input 1)
;   A0+$32: Position Y / averaging field (read/updated)
;   A0+$34: Position Z (angle input 2)
;   A0+$55: Visibility result flag (set to 1 before test, updated)
;   A0+$CE: BSP plane data pointer (stored if visible)
; ============================================================================

visibility_eval_caller:
        move.w  $30(a0),d1              ; D1 = position X (angle 1)
        move.w  $34(a0),d2              ; D2 = position Z (angle 2)
        move.b  #1,$55(a0)              ; Set visibility flag = 1 (testing)
        dc.w    $4EBA,$F82C             ; JSR $73E8(PC) - angle pre-processing
        jsr     angle_normalize(pc)     ; BSP visibility test
        beq.s   .return                 ; If result = 0 (culled), return
        move.l  a2,$CE(a0)              ; Store BSP data pointer in object
        bsr.s   *+28                    ; Call type dispatch at $7BE4
        move.b  d0,$55(a0)              ; Store dispatch result as visibility
        jsr     plane_eval(pc)          ; Evaluate BSP plane (signed variant)
        ble.s   .return                 ; If result <= 0, return
        move.w  $32(a0),d2              ; Load field $32
        ext.l   d2                      ; Sign extend to long
        add.l   d2,d1                   ; D1 = D1 + D2
        asr.l   #1,d1                   ; D1 = (D1 + D2) / 2 (average)
        move.w  d1,$32(a0)              ; Store averaged value
.return:
        rts
