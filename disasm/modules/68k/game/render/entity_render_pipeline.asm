; ============================================================================
; entity_render_pipeline — Entity Render Pipeline
; ROM Range: $005AB6-$005D08 (594 bytes)
; Multi-variant entity render pipeline with 4 entry points. Each variant
; clears display offsets (+$44/+$46/+$4A), then calls 20-46 subroutines
; covering physics, movement, rendering, palette, display mode, memory
; copy, and buffer clear. Variant A (full, 46 calls), Variant B (reduced),
; Variant C (extended with speed=0 init), Variant D (minimal display).
;
; Entry: A0 = entity base pointer
; Uses: D0, A0
; RAM: $C89C sh2_comm_state
; Object fields: +$06 speed, +$44 display_offset, +$46 display_scale,
;   +$4A display_aux, +$74 render_state
; Confidence: high
; ============================================================================

; --- Variant A: Full pipeline (46 calls) ---
; Complete physics + AI + rendering chain for the player entity.
; VR60 Phase 3B: first 6 bytes replaced with JMP to bypass trampoline
; in code_1c200. The trampoline handles camera_state_selector, display
; offset clear, $C8D2 flag check, and either runs physics or skips.
entity_render_pipeline:
        jmp     vr60_physics_bypass_trampoline  ; 6B (replaces JSR camera+12 + MOVEQ #0,D0)
        MOVE.W  D0,$0044(A0)                    ; $005ABC ; clear display_offset
        MOVE.W  D0,$0046(A0)                    ; $005AC0 ; clear display_scale
        MOVE.W  D0,$004A(A0)                    ; $005AC4 ; clear display_aux
; --- Physics pipeline ---
        jsr     tire_squeal_check(pc)   ; $4EBA $2AFA
        jsr     speed_degrade_calc(pc)  ; $4EBA $2ACC
        jsr     effect_timer_mgmt(pc)   ; $4EBA $487E
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $269A
        jsr     field_check_guard(pc)   ; $4EBA $25F2
        jsr     timer_decrement_multi(pc); $4EBA $2A6A
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $3A18
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $382C
        jsr     entity_speed_clamp(pc)  ; $4EBA $4028
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $3694
        jsr     tilt_adjust(pc)         ; $4EBA $3B2C
        jsr     drift_physics_and_camera_offset_calc(pc); $4EBA $3B92
        jsr     suspension_steering_damping(pc); $4EBA $3D08
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $237C
; --- Position + AI (VR60: bypass re-entry point) ---
entity_render_pipeline_position_ai:
        jsr     entity_pos_update(pc)   ; $4EBA $1496
        jsr     multi_flag_test(pc)     ; $4EBA $21D2
        jsr     ai_opponent_select(pc)  ; $4EBA $492A
        jsr     angle_to_sine(pc)       ; $4EBA $159C
        jsr     object_heading_deviation_check_warning_flag+8(pc); $4EBA $23F2
        jsr     proximity_trigger(pc)   ; $4EBA $4358
        jsr     entity_speed_guard+4(pc); $4EBA $2134
        jsr     object_link_copy_table_lookup(pc); $4EBA $162C
        jsr     rotational_offset_calc(pc); $4EBA $1B2C
        jsr     position_threshold_check(pc); $4EBA $242A
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $41A4
        jsr     effect_countdown(pc)    ; $4EBA $5110
        jsr     set_camera_regs_to_invalid(pc); $4EBA $4022
        jsr     proximity_zone_multi+54(pc); $4EBA $2BC8
        jsr     heading_from_position(pc); $4EBA $3506
        jsr     ai_target_check(pc)     ; $4EBA $5196
        DC.W    $4EBA,$2696         ; JSR     $0081D8(PC); $005B40
        jsr     race_start_countdown_sequence(pc); $4EBA $437A
; --- Rendering output ---
        jsr     obj_distance_calc(pc)   ; $4EBA $1AB4
        jsr     object_visibility_collector(pc); $4EBA $1658
        jsr     camera_param_calc(pc)   ; $4EBA $CE32
        jsr     object_state_disp_0031a6(pc); $4EBA $D650
        jsr     object_table_sprite_param_update(pc); $4EBA $DB84
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $DC58
        jsr     render_slot_setup+88(pc); $4EBA $E424
        MOVE.B  (-15612).W,(-15604).W           ; $005B64 ; copy display flags
        jmp     control_flag_check_cond_pos_copy(pc); $4EFA $109C ; tail call

; --- Variant B: Reduced pipeline (non-player) ---
; No steering, drift, or position update.
        jsr     camera_state_selector+12(pc); $4EBA $5C0C
        jsr     effect_timer_mgmt(pc)   ; $4EBA $47DC
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $25F8
        jsr     field_check_guard(pc)   ; $4EBA $2550
        jsr     timer_decrement_multi(pc); $4EBA $29C8
        jsr     tilt_adjust(pc)         ; $4EBA $3A9A
        jsr     collision_response_surface_tracking+278(pc); $4EBA $1C8E
        jsr     rotational_offset_calc(pc); $4EBA $1AC2
        jsr     angle_to_sine(pc)       ; $4EBA $151A
        DC.W    $4EBA,$4D4C         ; JSR     $00A8E0(PC); $005B92
        jsr     set_camera_regs_to_invalid(pc); $4EBA $3FBC
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $35E6
        jsr     suspension_steering_damping(pc); $4EBA $3C62
        jsr     object_link_copy_table_lookup(pc); $4EBA $15A6
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $4126
        jsr     proximity_zone_multi+54(pc); $4EBA $2B52
        jsr     heading_from_position(pc); $4EBA $3490
        jsr     ai_target_check(pc)     ; $4EBA $5120
; --- Rendering ---
        jsr     obj_distance_calc(pc)   ; $4EBA $1A46
        jsr     object_visibility_collector(pc); $4EBA $15EA
        jsr     camera_param_calc(pc)   ; $4EBA $CDC4
        jsr     object_state_disp_0031a6(pc); $4EBA $D5E2
        jsr     object_table_sprite_param_update(pc); $4EBA $DB16
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $DBEA
        jsr     render_slot_setup+88(pc); $4EBA $E3B6
        jsr     sprite_hud_layout_builder+154(pc); $4EBA $E0F0
        MOVE.B  (-15612).W,(-15604).W           ; $005BD6 ; copy display flags
        jmp     object_bitmask_table_button_flag_handler+32(pc); $4EFA $100C ; tail call

; --- Variant C: Countdown timer variant ---
; Sets speed=0, render_state=0; runs physics with countdown.
        MOVE.W  #$0000,$0006(A0)                ; $005BE0 ; speed = 0
        MOVE.W  #$0000,$0074(A0)                ; $005BE6 ; render_state = 0
        jsr     camera_state_selector+12(pc); $4EBA $5B8E
        MOVEQ   #$00,D0                         ; $005BF0
        MOVE.W  D0,$0044(A0)                    ; $005BF2 ; clear display_offset
        MOVE.W  D0,$0046(A0)                    ; $005BF6 ; clear display_scale
        MOVE.W  D0,$004A(A0)                    ; $005BFA ; clear display_aux
        jsr     input_mask_both(pc)     ; $4EBA $EDEE
        jsr     speed_degrade_calc(pc)  ; $4EBA $2996
        jsr     effect_timer_mgmt(pc)   ; $4EBA $4748
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $2564
        jsr     field_check_guard(pc)   ; $4EBA $24BC
        jsr     timer_decrement_multi(pc); $4EBA $2934
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $38E2
        CMPI.W  #$0004,(-15764).W               ; $005C1A ; check game phase
        BEQ.S  .loc_0170                        ; $005C20 ; skip if phase 4
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $36EE
.loc_0170:
        jsr     entity_speed_clamp(pc)  ; $4EBA $3EEA
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $3556
        jsr     suspension_steering_damping(pc); $4EBA $3BD2
        jsr     position_velocity_update(pc); $4EBA $1450
        jsr     angle_to_sine(pc)       ; $4EBA $1472
        jsr     collision_response_surface_tracking+278(pc); $4EBA $1BDA
; --- Countdown timer ---
        SUBQ.W  #1,(-16340).W                   ; $005C3E ; decrement timer
        BGT.S  .loc_01A0                        ; $005C42 ; still counting?
        MOVE.W  #$0000,(-16340).W               ; $005C44 ; timer expired
        MOVE.W  #$0000,$0074(A0)                ; $005C4A ; reset render_state
        MOVE.W  (-16244).W,(-16262).W           ; $005C50 ; restore render mode
.loc_01A0:
; --- Jump into Variant A's rendering tail ---
        jmp     entity_render_pipeline+90(pc); $4EFA $FEB8

; --- Variant D: Minimal display pipeline ---
; No steering/drift; for spectator or replay entities.
        jsr     camera_state_selector+12(pc); $4EBA $5B20
        MOVEQ   #$00,D0                         ; $005C5E
        MOVE.W  D0,$0044(A0)                    ; $005C60 ; clear display_offset
        MOVE.W  D0,$0046(A0)                    ; $005C64 ; clear display_scale
        MOVE.W  D0,$004A(A0)                    ; $005C68 ; clear display_aux
        jsr     speed_degrade_calc(pc)  ; $4EBA $292C
        jsr     effect_timer_mgmt(pc)   ; $4EBA $46DE
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $24FA
        jsr     field_check_guard(pc)   ; $4EBA $2452
        jsr     timer_decrement_multi(pc); $4EBA $28CA
        jsr     suspension_steering_damping(pc); $4EBA $3B80
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $21F4
        jsr     entity_pos_update(pc)   ; $4EBA $130E
        jsr     multi_flag_test(pc)     ; $4EBA $204A
        jsr     ai_opponent_select(pc)  ; $4EBA $47A2
        jsr     angle_to_sine(pc)       ; $4EBA $1414
        jsr     object_heading_deviation_check_warning_flag+8(pc); $4EBA $226A
        jsr     proximity_trigger(pc)   ; $4EBA $41D0
        jsr     entity_speed_guard+4(pc); $4EBA $1FAC
        jsr     object_link_copy_table_lookup(pc); $4EBA $14A4
        jsr     rotational_offset_calc(pc); $4EBA $19A4
        jsr     position_threshold_check(pc); $4EBA $22A2
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $401C
        jsr     effect_countdown(pc)    ; $4EBA $4F88
        jsr     proximity_zone_multi+54(pc); $4EBA $2A44
        jsr     heading_from_position(pc); $4EBA $3382
        DC.W    $4EBA,$2516         ; JSR     $0081D8(PC); $005CC0
        jsr     race_start_countdown_sequence(pc); $4EBA $41FA
        jsr     tilt_adjust(pc)         ; $4EBA $3954
        jsr     obj_state_return(pc)    ; $4EBA $4C2A
; --- Check if render mode needs restoring ---
        BTST    #4,(-15602).W                   ; $005CD0 ; test mode flag bit 4
        BEQ.S  .loc_0228                        ; $005CD6
        MOVE.W  (-16244).W,(-16262).W           ; $005CD8 ; restore render mode
.loc_0228:
; --- Rendering output ---
        jsr     obj_distance_calc(pc)   ; $4EBA $191E
        jsr     object_visibility_collector(pc); $4EBA $14C2
        jsr     camera_param_calc(pc)   ; $4EBA $CC9C
        jsr     object_state_disp_0031a6(pc); $4EBA $D4BA
        jsr     object_table_sprite_param_update(pc); $4EBA $D9EE
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $DAC2
        TST.W  (-14180).W                       ; $005CF6 ; split screen active?
        BNE.S  .loc_024A                        ; $005CFA ; skip HUD if split
        jsr     sprite_hud_layout_builder+154(pc); $4EBA $DFC6
.loc_024A:
        MOVE.B  (-15612).W,(-15604).W           ; $005D00 ; copy display flags
        RTS                                     ; $005D06
