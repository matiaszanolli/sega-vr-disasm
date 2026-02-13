; ============================================================================
; Entity Target Action
; ROM Range: $00AD14-$00ADC2 (174 bytes)
; ============================================================================
; Chained from ai_target_check via BNE.S when conditions met.
; Computes speed/distance between two entities (A0, A1), adjusts speed
; values, flips directional bits, and either returns or chains to
; entity_directional_push at $AED8.
;
; Entry: A0 = object, A1 = entity target (from ai_target_check)
; Uses: D0-D3
; Fields accessed:
;   A0/A1+$02: Status flags (ORI.W bit-set)
;   A0/A1+$04: Speed value
;   A0/A1+$06: Speed parameter
;   A0+$88: Direction flags
; RAM:
;   ($C8A4).W: Active AI mode byte
;   ($C8CE).W: Speed threshold
;   ($C8D0).W: Position threshold
; ============================================================================

entity_target_action:
        dc.w    $11FC,$00B8,$C8A4       ; MOVE.B #$B8,($C8A4).W - set AI mode
        move.w  $04(a0),d0              ; Load speed_a
        sub.w   $04(a1),d0              ; speed_a - speed_b
        bpl.s   .abs_speed              ; If positive, skip negate
        neg.w   d0                      ; |speed difference|
.abs_speed:
        dc.w    $B078,$C8CE             ; CMP.W ($C8CE).W,D0 - vs threshold
        ble.w   .too_close              ; If within threshold, jump to proximity check
        move.w  $06(a0),d0              ; Load param_a
        add.w   $06(a1),d0              ; param_a + param_b
        move.w  d0,d2                   ; D2 = sum
        asr.w   #1,d2                   ; D2 = sum/2
        asr.w   #2,d0                   ; D0 = sum/4
        add.w   d0,d2                   ; D2 = sum/2 + sum/4 = 3*sum/4
        move.w  d0,d1                   ; D1 = sum/4
        asr.w   #1,d1                   ; D1 = sum/8
        add.w   d0,d1                   ; D1 = sum/4 + sum/8 = 3*sum/8
        cmpi.w  #$04DC,d1              ; Clamp D1 to max $04DC
        ble.s   .d1_ok
        move.w  #$04DC,d1
.d1_ok:
        cmpi.w  #$04DC,d2              ; Clamp D2 to max $04DC
        ble.s   .d2_ok
        move.w  #$04DC,d2
.d2_ok:
        move.w  $06(a1),d0              ; Load param_b
        cmp.w   $06(a0),d0              ; Compare param_b vs param_a
        ble.s   .no_swap                ; If param_b <= param_a, no swap
        exg     d1,d2                   ; Swap D1/D2 (give larger to faster entity)
.no_swap:
        move.w  d2,$06(a1)              ; Store D2 as new param_b
        move.w  $04(a0),d3              ; Load speed_a
        sub.w   $04(a1),d3              ; D3 = speed_a - speed_b
        dc.w    $B678,$C8D0             ; CMP.W ($C8D0).W,D3 - vs position threshold
        ble.s   .close_position         ; If within threshold, set speed
        ori.w   #$1000,$02(a1)          ; Set bit 12 in A1 flags
        ori.w   #$0800,$02(a0)          ; Set bit 11 in A0 flags
        rts
.close_position:
        move.w  d1,$06(a0)              ; Store D1 as new param_a
        move.w  $88(a0),d0              ; Load direction flags
        moveq   #1,d1                   ; Test bit 0
        and.w   d0,d1
        bne.s   .alt_bits               ; If bit 0 set, use alternate
        moveq   #4,d1                   ; Test bit 2
        and.w   d0,d1
        bne.s   .alt_bits               ; If bit 2 set, use alternate
        ori.w   #$2000,$02(a0)          ; Set bit 13 in A0 flags
        ori.w   #$1000,$02(a1)          ; Set bit 12 in A1 flags
        dc.w    $11FC,$00B2,$C8A4       ; MOVE.B #$B2,($C8A4).W - set AI mode
        rts
.alt_bits:
        ori.w   #$1000,$02(a0)          ; Set bit 12 in A0 flags
        ori.w   #$2000,$02(a1)          ; Set bit 13 in A1 flags
        dc.w    $11FC,$00B2,$C8A4       ; MOVE.B #$B2,($C8A4).W - set AI mode
        rts
.too_close:
        dc.w    $4EFA,$0116             ; JMP $AED8(PC) - chain to entity_directional_push
