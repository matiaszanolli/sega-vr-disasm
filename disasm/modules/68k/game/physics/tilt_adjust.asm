; ============================================================================
; Tilt Adjust (Entity Banking)
; ROM Range: $00961E-$009688 (106 bytes)
; ============================================================================
; Adjusts entity tilt for banking. Checks race condition first.
; X-tilt clamped to [$FFCD, $00FF], Z-tilt clamped to [$0000, $00FF].
;
; Entry: A0 = entity
; Uses: D0, D1
; ============================================================================

tilt_adjust:
        move.w  $006A(a0),d0          ; Race condition A
        or.w    $008C(a0),d0          ; Race condition B
        bne.s   .done                 ; If either set, skip
        moveq   #$30,d0              ; Tilt rate
        dc.w    $3238,$C0AC           ; MOVE.W ($C0AC).W,D1 - track tilt
        cmp.w   $0092(a0),d1          ; Compare with entity direction
        blt.s   .negate_x
        dc.w    $0838,$0004,$C971     ; BTST #4,($C971).W - direction flag
        bne.s   .x_apply
.negate_x:
        neg.w   d0                    ; Reverse tilt
.x_apply:
        move.w  $000E(a0),d1          ; Current X-tilt
        add.w   d0,d1                 ; Apply tilt rate
        cmpi.w  #$00FF,d1             ; Upper clamp
        ble.s   .x_upper_ok
        move.w  #$00FF,d1
.x_upper_ok:
        cmpi.w  #$FFCD,d1             ; Lower clamp
        bge.s   .x_lower_ok
        move.w  #$FFCD,d1
.x_lower_ok:
        move.w  d1,$000E(a0)          ; Store X-tilt
        moveq   #$30,d0              ; Reset tilt rate
        dc.w    $0838,$0006,$C971     ; BTST #6,($C971).W - Z direction flag
        bne.s   .z_apply
        neg.w   d0
.z_apply:
        move.w  $0010(a0),d1          ; Current Z-tilt
        add.w   d0,d1
        cmpi.w  #$00FF,d1             ; Upper clamp
        ble.s   .z_upper_ok
        move.w  #$00FF,d1
.z_upper_ok:
        cmpi.w  #$0000,d1             ; Lower clamp (0)
        bge.s   .z_lower_ok
        move.w  #$0000,d1
.z_lower_ok:
        move.w  d1,$0010(a0)          ; Store Z-tilt
.done: rts
