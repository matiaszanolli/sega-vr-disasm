; ============================================================================
; Game Frame Orchestrator
; ROM Range: $005E38-$005EEA (178 bytes)
; ============================================================================
; Category: object
; Purpose: Master frame orchestrator — initializes display params then calls
;   37 subroutines covering physics, steering, rendering, AI, palette,
;   display mode, buffer management, and memory copy.
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; RAM:
;   $C970: display_scale_pair (longword: X|Y = $0010|$0010)
; Calls (37 subroutines via PC-relative JSR):
;   $00B77C, $00859A, $00A350, $008170, $0080CC, $008548,
;   $0094FA, $009312, $009B12, $009182, $00961E, $009688,
;   $009802, $007E7A, $006F98 (calc_steering), $007CD8,
;   $00A434, $0070AA, $007F04, $007C4E, $00714A, $00764E,
;   $007F50, $009CCE, $009B54, $0086FE, $009040, $00ACD4,
;   $004084, $0075FE, $0071A6,
;   $002984 (palette_update), $0031A6 (display_mode_dispatch),
;   $0036DE (clear_buffer), $0037B6 (memory_copy),
;   $003F86 (clear_display_vars), $0030C6
; Object fields:
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: display_param
;   +$92: param_92
; ============================================================================

game_frame_orch:
        moveq   #$00,D0                         ; $005E38
        move.w  D0,$0044(A0)                    ; $005E3A  display_offset = 0
        move.w  D0,$0046(A0)                    ; $005E3E  display_scale = 0
        move.w  D0,$004A(A0)                    ; $005E42  display_param = 0
        move.l  #$00100010,($FFFFC970).w            ; $005E46  display_scale_pair = 16|16
        jsr     camera_state_selector+12(pc); $4EBA $592C
        move.w  #$0002,$0092(A0)                ; $005E52  param_92 = 2
        jsr     speed_degrade_calc(pc)  ; $4EBA $2740
        jsr     effect_timer_mgmt(pc)   ; $4EBA $44F2
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $230E
        jsr     field_check_guard(pc)   ; $4EBA $2266
        jsr     timer_decrement_multi(pc); $4EBA $26DE
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $368C
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $34A0
        jsr     entity_speed_clamp(pc)  ; $4EBA $3C9C
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $3308
        jsr     tilt_adjust(pc)         ; $4EBA $37A0
        jsr     drift_physics_and_camera_offset_calc(pc); $4EBA $3806
        jsr     suspension_steering_damping(pc); $4EBA $397C
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $1FF0
        jsr     entity_pos_update(pc)   ; $4EBA $110A
        jsr     multi_flag_test(pc)     ; $4EBA $1E46
        jsr     ai_opponent_select(pc)  ; $4EBA $459E
        jsr     angle_to_sine(pc)       ; $4EBA $1210
        jsr     object_heading_deviation_check_warning_flag+8(pc); $4EBA $2066
        jsr     entity_speed_guard+4(pc); $4EBA $1DAC
        jsr     object_link_copy_table_lookup(pc); $4EBA $12A4
        jsr     rotational_offset_calc(pc); $4EBA $17A4
        jsr     position_threshold_check(pc); $4EBA $20A2
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $3E1C
        jsr     set_camera_regs_to_invalid(pc); $4EBA $3C9E
        jsr     proximity_zone_multi+54(pc); $4EBA $2844
        jsr     heading_from_position(pc); $4EBA $3182
        jsr     ai_target_check(pc)     ; $4EBA $4E12
        jsr     display_state_disp_004084(pc); $4EBA $E1BE
        jsr     obj_distance_calc(pc)   ; $4EBA $1734
        jsr     object_visibility_collector(pc); $4EBA $12D8
        jsr     camera_param_calc(pc)   ; $4EBA $CAB2
        jsr     object_state_disp_0031a6(pc); $4EBA $D2D0
        jsr     object_table_sprite_param_update(pc); $4EBA $D804
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $D8D8
        jsr     render_slot_setup+88(pc); $4EBA $E0A4
        jsr     camera_offset_clamping(pc); $4EBA $D1E0
        rts                                     ; $005EE8
