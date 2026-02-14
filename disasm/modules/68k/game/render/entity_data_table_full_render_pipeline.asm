; ============================================================================
; entity_data_table_full_render_pipeline — Entity Data Table + Full Render Pipeline
; ROM Range: $006AB4-$006B96 (226 bytes)
; ROM address lookup table (3 longword entries) followed by a reduced render
; pipeline and a full render pipeline variant. The reduced variant handles
; movement, collision, and display (15 calls). The full variant adds
; physics, sorting, and palette (30 calls).
;
; Entry: A0 = entity base pointer
; Uses: D0, A0, A2, A6
; Object fields: +$44 display_offset, +$46 display_scale, +$4A display_aux,
;   +$88 animation, +$92 render_mode
; Confidence: high
; ============================================================================

entity_data_table_full_render_pipeline:
        DC.W    $0088                           ; $006AB4
        DC.W    $3C7E                           ; $006AB6
        DC.W    $0088                           ; $006AB8
        MOVE.W  (A2)+,$0088(A6)                 ; $006ABA
        MOVE.W  (A2)+,$0088(A6)                 ; $006ABE
        MOVE.W  (A2)+,$0088(A6)                 ; $006AC2
        MOVE.W  (A2)+,$0088(A6)                 ; $006AC6
        MOVE.W  (A2)+,$4EBA(A6)                 ; $006ACA
        DC.W    $4CA2                           ; $006ACE
        jsr     effect_timer_mgmt(pc)   ; $4EBA $387E
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $169A
        jsr     field_check_guard(pc)   ; $4EBA $15F2
        jsr     timer_decrement_multi(pc); $4EBA $1A6A
        jsr     tilt_adjust(pc)         ; $4EBA $2B3C
        jsr     collision_response_surface_tracking+278(pc); $4EBA $0D30
        jsr     rotational_offset_calc(pc); $4EBA $0B64
        jsr     angle_to_sine(pc)       ; $4EBA $05BC
        DC.W    $4EBA,$3DEE         ; JSR     $00A8E0(PC); $006AF0
        jsr     set_camera_regs_to_invalid(pc); $4EBA $305E
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $2688
        jsr     suspension_steering_damping(pc); $4EBA $2D04
        jmp     object_link_copy_table_lookup(pc); $4EFA $0648
        MOVEQ   #$00,D0                         ; $006B04
        MOVE.W  D0,$0044(A0)                    ; $006B06
        MOVE.W  D0,$0046(A0)                    ; $006B0A
        MOVE.W  D0,$004A(A0)                    ; $006B0E
        MOVE.L  #$00100010,(-13968).W           ; $006B12
        MOVE.B  #$00,(-15601).W                 ; $006B1A
        jsr     camera_state_selector(pc); $4EBA $4C4E
        MOVE.W  #$0002,$0092(A0)                ; $006B24
        jsr     speed_degrade_calc(pc)  ; $4EBA $1A6E
        jsr     effect_timer_mgmt(pc)   ; $4EBA $3820
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $163C
        jsr     field_check_guard(pc)   ; $4EBA $1594
        jsr     timer_decrement_multi(pc); $4EBA $1A0C
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $29BA
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $27CE
        jsr     entity_speed_clamp(pc)  ; $4EBA $2FCA
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $2636
        jsr     tilt_adjust(pc)         ; $4EBA $2ACE
        jsr     drift_physics_and_camera_offset_calc(pc); $4EBA $2B34
        jsr     suspension_steering_damping(pc); $4EBA $2CAA
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $131E
        jsr     entity_pos_update(pc)   ; $4EBA $0438
        jsr     multi_flag_test(pc)     ; $4EBA $1174
        jsr     ai_opponent_select(pc)  ; $4EBA $38CC
        jsr     angle_to_sine(pc)       ; $4EBA $053E
        jsr     entity_speed_guard+4(pc); $4EBA $10DE
        jsr     object_link_copy_table_lookup(pc); $4EBA $05D6
        jsr     rotational_offset_calc(pc); $4EBA $0AD6
        jsr     position_threshold_check(pc); $4EBA $13D4
        jsr     set_camera_regs_to_invalid(pc); $4EBA $2FD4
        jsr     game_logic_init_state_dispatch+76(pc); $4EBA $DBE6
        jmp     camera_offset_check(pc) ; $4EFA $C58E
        MOVE.W  (-16262).W,D0                   ; $006B8A
        MOVE.W  $006B96(PC,D0.W),(-15764).W     ; $006B8E
        RTS                                     ; $006B94
