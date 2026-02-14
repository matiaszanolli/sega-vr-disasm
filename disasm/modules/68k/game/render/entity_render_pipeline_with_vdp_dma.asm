; ============================================================================
; entity_render_pipeline_with_vdp_dma — Entity Render Pipeline with VDP DMA
; ROM Range: $005EEA-$00617A (656 bytes)
; Extended entity render pipeline with VDP register writes and DMA transfers.
; Contains 4 entry point variants. Each clears display offsets, runs
; physics/movement/rendering subroutines, then performs VDP register writes
; ($003126) and DMA setup ($003160) before buffer/memory operations.
; Variant C includes countdown timer for state transitions.
;
; Entry: A0 = entity base pointer
; Uses: D0, A0
; RAM: $C89C sh2_comm_state
; Object fields: +$06 speed, +$44 display_offset, +$46 display_scale,
;   +$4A display_aux, +$74 render_state
; Confidence: high
; ============================================================================

entity_render_pipeline_with_vdp_dma:
        MOVEQ   #$00,D0                         ; $005EEA
        MOVE.W  D0,$0044(A0)                    ; $005EEC
        MOVE.W  D0,$0046(A0)                    ; $005EF0
        MOVE.W  D0,$004A(A0)                    ; $005EF4
        jsr     tire_squeal_check(pc)   ; $4EBA $26CA
        jsr     speed_degrade_calc(pc)  ; $4EBA $269C
        jsr     effect_timer_mgmt(pc)   ; $4EBA $444E
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $226A
        jsr     field_check_guard(pc)   ; $4EBA $21C2
        jsr     timer_decrement_multi(pc); $4EBA $263A
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $35E8
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $33FC
        jsr     entity_speed_clamp(pc)  ; $4EBA $3BF8
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $3264
        jsr     tilt_adjust(pc)         ; $4EBA $36FC
        jsr     drift_physics_and_camera_offset_calc(pc); $4EBA $3762
        jsr     suspension_steering_damping(pc); $4EBA $38D8
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $1F4C
        jsr     entity_pos_update(pc)   ; $4EBA $1066
        jsr     multi_flag_test(pc)     ; $4EBA $1DA2
        jsr     ai_opponent_select(pc)  ; $4EBA $44FA
        jsr     angle_to_sine(pc)       ; $4EBA $116C
        jsr     object_heading_deviation_check_warning_flag+8(pc); $4EBA $1FC2
        jsr     proximity_trigger(pc)   ; $4EBA $3F28
        jsr     entity_speed_guard+4(pc); $4EBA $1D04
        jsr     object_link_copy_table_lookup(pc); $4EBA $11FC
        jsr     rotational_offset_calc(pc); $4EBA $16FC
        jsr     position_threshold_check(pc); $4EBA $1FFA
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $3D74
        jsr     effect_countdown(pc)    ; $4EBA $4CE0
        jsr     set_camera_regs_to_invalid(pc); $4EBA $3BF2
        jsr     proximity_zone_multi(pc); $4EBA $2762
        jsr     ai_target_check(pc)     ; $4EBA $4D6A
        jsr     race_start_countdown_sequence(pc); $4EBA $3F52
        jsr     vdp_buffer_xfer_camera_offset_apply(pc); $4EBA $D1B4
        jsr     vdp_config_xfer_scaled_params(pc); $4EBA $D1EA
        jsr     conditional_object_velocity_negate(pc); $4EBA $16AA
        jsr     object_geometry_visibility_collect(pc); $4EBA $13D0
        jsr     object_table_sprite_param_update(pc); $4EBA $D75C
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $D830
        jsr     render_slot_setup+88(pc); $4EBA $DFFC
        jsr     scroll_pan_calc_vdp_write(pc); $4EBA $30D6
        MOVE.B  (-15612).W,(-15604).W           ; $005F90
        jmp     control_flag_check_cond_pos_copy(pc); $4EFA $0C70
        jsr     effect_timer_mgmt(pc)   ; $4EBA $43B4
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $21D0
        jsr     field_check_guard(pc)   ; $4EBA $2128
        jsr     timer_decrement_multi(pc); $4EBA $25A0
        jsr     tilt_adjust(pc)         ; $4EBA $3672
        jsr     collision_response_surface_tracking+278(pc); $4EBA $1866
        jsr     rotational_offset_calc(pc); $4EBA $169A
        jsr     angle_to_sine(pc)       ; $4EBA $10F2
        DC.W    $4EBA,$4924         ; JSR     $00A8E0(PC); $005FBA
        jsr     set_camera_regs_to_invalid(pc); $4EBA $3B94
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $31BE
        jsr     suspension_steering_damping(pc); $4EBA $383A
        jsr     object_link_copy_table_lookup(pc); $4EBA $117E
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $3CFE
        jsr     proximity_zone_multi(pc); $4EBA $26F4
        jsr     ai_target_check(pc)     ; $4EBA $4CFC
        jsr     vdp_buffer_xfer_camera_offset_apply(pc); $4EBA $D14A
        jsr     vdp_config_xfer_scaled_params(pc); $4EBA $D180
        jsr     conditional_object_velocity_negate(pc); $4EBA $1640
        jsr     object_geometry_visibility_collect(pc); $4EBA $1366
        jsr     object_table_sprite_param_update(pc); $4EBA $D6F2
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $D7C6
        jsr     render_slot_setup+88(pc); $4EBA $DF92
        jsr     sprite_hud_layout_builder+154(pc); $4EBA $DCCC
        jsr     scroll_pan_calc_vdp_write(pc); $4EBA $3068
        MOVE.B  (-15612).W,(-15604).W           ; $005FFE
        jmp     control_flag_check_cond_pos_copy(pc); $4EFA $0C02
        MOVE.W  #$0000,$0006(A0)                ; $006008
        MOVE.W  #$0000,$0074(A0)                ; $00600E
        MOVEQ   #$00,D0                         ; $006014
        MOVE.W  D0,$0044(A0)                    ; $006016
        MOVE.W  D0,$0046(A0)                    ; $00601A
        MOVE.W  D0,$004A(A0)                    ; $00601E
        jsr     input_mask_both(pc)     ; $4EBA $E9CA
        jsr     speed_degrade_calc(pc)  ; $4EBA $2572
        jsr     effect_timer_mgmt(pc)   ; $4EBA $4324
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $2140
        jsr     field_check_guard(pc)   ; $4EBA $2098
        jsr     timer_decrement_multi(pc); $4EBA $2510
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $34BE
        CMPI.W  #$0004,(-15764).W               ; $00603E
        BEQ.S  .loc_0160                        ; $006044
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $32CA
.loc_0160:
        jsr     entity_speed_clamp(pc)  ; $4EBA $3AC6
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $3132
        jsr     suspension_steering_damping(pc); $4EBA $37AE
        jsr     position_velocity_update(pc); $4EBA $102C
        jsr     angle_to_sine(pc)       ; $4EBA $104E
        jsr     collision_response_surface_tracking+278(pc); $4EBA $17B6
        SUBQ.W  #1,(-16340).W                   ; $006062
        BGT.S  .loc_0190                        ; $006066
        MOVE.W  #$0000,(-16340).W               ; $006068
        MOVE.W  #$0000,$0074(A0)                ; $00606E
        MOVE.W  (-16244).W,(-16262).W           ; $006074
.loc_0190:
        jsr     object_heading_deviation_check_warning_flag+8(pc); $4EBA $1E88
        jsr     proximity_trigger(pc)   ; $4EBA $3DEE
        jsr     entity_speed_guard+4(pc); $4EBA $1BCA
        jsr     object_link_copy_table_lookup(pc); $4EBA $10C2
        jsr     rotational_offset_calc(pc); $4EBA $15C2
        jsr     position_threshold_check(pc); $4EBA $1EC0
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $3C3A
        jsr     effect_countdown(pc)    ; $4EBA $4BA6
        jsr     set_camera_regs_to_invalid(pc); $4EBA $3AB8
        jsr     proximity_zone_multi(pc); $4EBA $2628
        jsr     ai_target_check(pc)     ; $4EBA $4C30
        jsr     race_start_countdown_sequence(pc); $4EBA $3E18
        jsr     vdp_buffer_xfer_camera_offset_apply(pc); $4EBA $D07A
        jsr     vdp_config_xfer_scaled_params(pc); $4EBA $D0B0
        jsr     conditional_object_velocity_negate(pc); $4EBA $1570
        jsr     object_geometry_visibility_collect(pc); $4EBA $1296
        jsr     object_table_sprite_param_update(pc); $4EBA $D622
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $D6F6
        jsr     render_slot_setup+88(pc); $4EBA $DEC2
        jsr     scroll_pan_calc_vdp_write(pc); $4EBA $2F9C
        MOVE.B  (-15612).W,(-15604).W           ; $0060CA
        jmp     control_flag_check_cond_pos_copy(pc); $4EFA $0B36
        MOVEQ   #$00,D0                         ; $0060D4
        MOVE.W  D0,$0044(A0)                    ; $0060D6
        MOVE.W  D0,$0046(A0)                    ; $0060DA
        MOVE.W  D0,$004A(A0)                    ; $0060DE
        jsr     speed_degrade_calc(pc)  ; $4EBA $24B6
        jsr     effect_timer_mgmt(pc)   ; $4EBA $4268
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $2084
        jsr     field_check_guard(pc)   ; $4EBA $1FDC
        jsr     timer_decrement_multi(pc); $4EBA $2454
        jsr     suspension_steering_damping(pc); $4EBA $370A
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $1D7E
        jsr     entity_pos_update(pc)   ; $4EBA $0E98
        jsr     multi_flag_test(pc)     ; $4EBA $1BD4
        jsr     ai_opponent_select(pc)  ; $4EBA $432C
        jsr     angle_to_sine(pc)       ; $4EBA $0F9E
        jsr     object_heading_deviation_check_warning_flag+8(pc); $4EBA $1DF4
        jsr     proximity_trigger(pc)   ; $4EBA $3D5A
        jsr     entity_speed_guard+4(pc); $4EBA $1B36
        jsr     object_link_copy_table_lookup(pc); $4EBA $102E
        jsr     rotational_offset_calc(pc); $4EBA $152E
        jsr     position_threshold_check(pc); $4EBA $1E2C
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $3BA6
        jsr     effect_countdown(pc)    ; $4EBA $4B12
        jsr     proximity_zone_multi(pc); $4EBA $2598
        jsr     race_start_countdown_sequence(pc); $4EBA $3D8C
        jsr     tilt_adjust(pc)         ; $4EBA $34E6
        jsr     obj_state_return(pc)    ; $4EBA $47BC
        BTST    #4,(-15602).W                   ; $00613E
        BEQ.S  .loc_0262                        ; $006144
        MOVE.W  (-16244).W,(-16262).W           ; $006146
.loc_0262:
        jsr     vdp_buffer_xfer_camera_offset_apply(pc); $4EBA $CFD8
        jsr     vdp_config_xfer_scaled_params(pc); $4EBA $D00E
        jsr     conditional_object_velocity_negate(pc); $4EBA $14CE
        jsr     object_geometry_visibility_collect(pc); $4EBA $11F4
        jsr     object_table_sprite_param_update(pc); $4EBA $D580
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $D654
        TST.W  (-14180).W                       ; $006164
        BNE.S  .loc_0284                        ; $006168
        jsr     sprite_hud_layout_builder+154(pc); $4EBA $DB58
.loc_0284:
        jsr     scroll_pan_calc_vdp_write(pc); $4EBA $2EF4
        MOVE.B  (-15612).W,(-15604).W           ; $006172
        RTS                                     ; $006178
