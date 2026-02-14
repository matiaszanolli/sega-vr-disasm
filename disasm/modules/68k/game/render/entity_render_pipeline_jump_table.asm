; ============================================================================
; entity_render_pipeline_jump_table — Entity Render Pipeline Jump Table
; ROM Range: $00659C-$00671A (382 bytes)
; Jump table (8 longword ROM addresses) followed by 4 render pipeline
; variants. Variant A: full pipeline with sprite buffer, physics, steering
; (27 calls). Variant B: extended with speed=0 init + countdown timer.
; Variant C: reduced display-only. Variant D: minimal with state check.
;
; Entry: A0 = entity base pointer
; Uses: D0, A0
; Object fields: +$06 speed, +$44 display_offset, +$46 display_scale,
;   +$4A display_aux, +$74 render_state
; Confidence: high
; ============================================================================

entity_render_pipeline_jump_table:
        DC.W    $0088                           ; $00659C
        DC.W    $65BC               ; BCS.S  $00655C; $00659E
        DC.W    $0088                           ; $0065A0
        BVC.S  .loc_000C                        ; $0065A2
        DC.W    $0088                           ; $0065A4
        BNE.S  .loc_0036                        ; $0065A6
.loc_000C:
        DC.W    $0088                           ; $0065A8
        DC.W    $66B4               ; BNE.S  $006560; $0065AA
        DC.W    $0088                           ; $0065AC
        BEQ.S  .loc_002E                        ; $0065AE
        DC.W    $0088                           ; $0065B0
        BEQ.S  $0065CC                          ; $0065B2
        DC.W    $0088                           ; $0065B4
        BEQ.S  $006632                          ; $0065B6
        DC.W    $0088                           ; $0065B8
        BNE.S  .loc_0056                        ; $0065BA
        jsr     camera_state_selector(pc); $4EBA $51B2
        MOVEQ   #$00,D0                         ; $0065C0
        MOVE.W  D0,$0044(A0)                    ; $0065C2
        MOVE.W  D0,$0046(A0)                    ; $0065C6
.loc_002E:
        MOVE.W  D0,$004A(A0)                    ; $0065CA
        jsr     tire_squeal_check_2p(pc); $4EBA $2040
.loc_0036:
        jsr     speed_degrade_calc(pc)  ; $4EBA $1FC6
        jsr     effect_timer_mgmt(pc)   ; $4EBA $3D78
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $1B94
        jsr     field_check_guard(pc)   ; $4EBA $1AEC
        jsr     timer_decrement_multi(pc); $4EBA $1F64
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $2F12
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $2D26
        jsr     entity_speed_clamp(pc)  ; $4EBA $3522
.loc_0056:
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $2B8E
        jsr     tilt_adjust(pc)         ; $4EBA $3026
        jsr     drift_physics_and_camera_offset_calc(pc); $4EBA $308C
        jsr     suspension_steering_damping(pc); $4EBA $3202
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $1876
        jsr     entity_pos_update(pc)   ; $4EBA $0990
        jsr     multi_flag_test(pc)     ; $4EBA $16CC
        jsr     ai_opponent_select(pc)  ; $4EBA $3E24
        jsr     angle_to_sine(pc)       ; $4EBA $0A96
        jsr     entity_speed_guard+4(pc); $4EBA $1636
        jsr     object_link_copy_table_lookup(pc); $4EBA $0B2E
        jsr     rotational_offset_calc(pc); $4EBA $102E
        jsr     input_guard_cond_dec(pc); $4EBA $1A0E
        jmp     set_camera_regs_to_invalid(pc); $4EFA $352C
        MOVE.W  #$0000,$0006(A0)                ; $00662A
        MOVE.W  #$0000,$0074(A0)                ; $006630
        jsr     camera_state_selector(pc); $4EBA $5138
        MOVEQ   #$00,D0                         ; $00663A
        MOVE.W  D0,$0044(A0)                    ; $00663C
        MOVE.W  D0,$0046(A0)                    ; $006640
        MOVE.W  D0,$004A(A0)                    ; $006644
        jsr     input_mask_partial_a(pc); $4EBA $E3C2
        jsr     speed_degrade_calc(pc)  ; $4EBA $1F4C
        jsr     effect_timer_mgmt(pc)   ; $4EBA $3CFE
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $1B1A
        jsr     field_check_guard(pc)   ; $4EBA $1A72
        jsr     timer_decrement_multi(pc); $4EBA $1EEA
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $2E98
        CMPI.W  #$0004,(-15764).W               ; $006664
        BEQ.S  .loc_00D4                        ; $00666A
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $2CA4
.loc_00D4:
        jsr     entity_speed_clamp(pc)  ; $4EBA $34A0
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $2B0C
        jsr     suspension_steering_damping(pc); $4EBA $3188
        jsr     position_velocity_update(pc); $4EBA $0A06
        jsr     angle_to_sine(pc)       ; $4EBA $0A28
        jsr     collision_response_surface_tracking+278(pc); $4EBA $1190
        SUBQ.W  #1,(-16340).W                   ; $006688
        BGT.S  .loc_0104                        ; $00668C
        MOVE.W  #$0000,(-16340).W               ; $00668E
        MOVE.W  #$0000,$0074(A0)                ; $006694
        MOVE.W  (-16244).W,(-16262).W           ; $00669A
.loc_0104:
        jsr     entity_speed_guard+4(pc); $4EBA $15AC
        jsr     object_link_copy_table_lookup(pc); $4EBA $0AA4
        jsr     rotational_offset_calc(pc); $4EBA $0FA4
        jsr     input_guard_cond_dec(pc); $4EBA $1984
        jmp     set_camera_regs_to_invalid(pc); $4EFA $34A2
        jsr     camera_state_selector(pc); $4EBA $50BA
        MOVEQ   #$00,D0                         ; $0066B8
        MOVE.W  D0,$0044(A0)                    ; $0066BA
        MOVE.W  D0,$0046(A0)                    ; $0066BE
        MOVE.W  D0,$004A(A0)                    ; $0066C2
        jsr     speed_degrade_calc(pc)  ; $4EBA $1ED2
        jsr     effect_timer_mgmt(pc)   ; $4EBA $3C84
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $1AA0
        jsr     field_check_guard(pc)   ; $4EBA $19F8
        jsr     timer_decrement_multi(pc); $4EBA $1E70
        jsr     suspension_steering_damping(pc); $4EBA $3126
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $179A
        jsr     entity_pos_update(pc)   ; $4EBA $08B4
        jsr     multi_flag_test(pc)     ; $4EBA $15F0
        jsr     ai_opponent_select(pc)  ; $4EBA $3D48
        jsr     angle_to_sine(pc)       ; $4EBA $09BA
        jsr     entity_speed_guard+4(pc); $4EBA $155A
        jsr     object_link_copy_table_lookup(pc); $4EBA $0A52
        jsr     rotational_offset_calc(pc); $4EBA $0F52
        jsr     input_guard_cond_dec(pc); $4EBA $1932
        jsr     tilt_adjust(pc)         ; $4EBA $2F1A
        jsr     obj_state_return(pc)    ; $4EBA $41F0
        BTST    #4,(-15602).W                   ; $00670A
        BEQ.S  .loc_017C                        ; $006710
        MOVE.W  (-16244).W,(-16262).W           ; $006712
.loc_017C:
        RTS                                     ; $006718
