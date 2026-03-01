; ============================================================================
; Race Frame Update (State 7)
; ROM Range: $006A3A-$006AB4 (122 bytes)
; ============================================================================
; Race-mode frame update: calls camera selector, sets game_active,
; clears display offsets, then executes 12 subroutine calls for
; physics/steering/position updates. Dispatches to state handler
; via external jump table at $006AB4. On frame 20: copies camera
; state, clears game_active, and advances dispatch state.
;
; Entry: A0 = object pointer (+$44, +$46, +$4A cleared)
; Uses: D0, A0, A1
; RAM:
;   $C048: camera_position (set to 1 on dispatch)
;   $C07A: camera_state_copy (receives value from $C092)
;   $C092: camera_state
;   $C800: game_active
;   $C89C: race_substate
;   $C8A0: race_state (jump table index at $006AB4)
;   $C8AA: scene_state (frame counter)
;   $C8AC: state_dispatch_idx
; Calls:
;   $006F98: calc_steering (JSR PC-relative)
;   $0070AA: angle_to_sine (JSR PC-relative)
;   $007CD8: obj_position_x (JSR PC-relative)
;   $007E7A: obj_velocity_y (JSR PC-relative)
;   $007F50: obj_velocity_x (JSR PC-relative)
;   $0080CC: load_object_params (JSR PC-relative)
;   $00B770: camera_state_selector (JSR PC-relative)
; Jump table: external at $006AB4 (5 entries, in next module)
; ============================================================================

race_frame_update:
        jsr     camera_state_selector(pc); $4EBA $4D34
        move.b  #$01,($FFFFC800).w              ; set game_active
        moveq   #$00,d0
        move.w  d0,$0044(a0)                    ; clear display_offset
        move.w  d0,$0046(a0)                    ; clear display_scale
        move.w  d0,$004A(a0)                    ; clear object field +$4A
; --- 12 physics/update subroutine calls ---
        jsr     triple_guard_set_state_to_be(pc) ; $4EBA $1678
        dc.w    $4EBA,$1AF0                      ; jsr $008548(pc)
        dc.w    $4EBA,$2DA6                      ; jsr $009802(pc)
        jsr     object_anim_timer_speed_clear(pc) ; $4EBA $141A
        jsr     entity_pos_update(pc)   ; $4EBA $0534
        jsr     tire_screech_sound_trigger_053(pc) ; $4EBA $1270
        jsr     angle_to_sine(pc)       ; $4EBA $063E
        jsr     object_link_copy_table_lookup(pc) ; $4EBA $06DA
        jsr     calculate_object_heading_composite(pc) ; $4EBA $0BDA
        jsr     object_heading_deviation_check_warning_flag(pc) ; $4EBA $14D8
        jsr     effect_countdown(pc)    ; $4EBA $41C2
        jsr     speed_modifier(pc)      ; $4EBA $30D4
; --- state dispatch via external jump table ---
        move.w  ($FFFFC8A0).w,d0                ; race_state (table index)
        movea.l $006AB4(pc,d0.w),a1             ; load handler from table at $006AB4
        jsr     (a1)                            ; call state handler
; --- check frame 20: copy camera + advance state ---
        cmpi.w  #$0014,($FFFFC8AA).w            ; frame 20?
        bne.s   .done
        move.w  ($FFFFC092).w,($FFFFC07A).w     ; copy camera_state → camera_state_copy
        move.b  #$00,($FFFFC800).w              ; clear game_active
        move.w  #$0004,($FFFFC8AC).w            ; advance state_dispatch_idx
        tst.w   ($FFFFC89C).w                   ; race_substate active?
        beq.s   .done
        move.w  #$0020,($FFFFC8AC).w            ; alternate dispatch index
.done:
        rts
