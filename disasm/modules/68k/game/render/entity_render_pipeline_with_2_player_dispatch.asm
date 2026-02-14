; ============================================================================
; entity_render_pipeline_with_2_player_dispatch — Entity Render Pipeline with 2-Player Dispatch
; ROM Range: $00677A-$006A3A (704 bytes)
; Large multi-entry entity render pipeline with 2-player dispatch.
; Contains 6 variants: full pipeline (43 calls + VDP), reduced (17 calls),
; 2-player dispatch with 8-entry jump table, full with countdown timer,
; display-only, and minimal render. Includes MOVEM-based object table
; copying and entity position/heading updates per viewport.
;
; Entry: A0 = entity base pointer
; Uses: D0, D1, A0, A1, A4
; RAM: $9F00 obj_table_3
; Object fields: +$06 speed, +$18 position, +$44 display_offset,
;   +$46 display_scale, +$4A display_aux, +$74 render_state,
;   +$92 render_mode, +$AC param
; Confidence: high
; ============================================================================

entity_render_pipeline_with_2_player_dispatch:
        MOVEQ   #$00,D0                         ; $00677A
        MOVE.W  D0,$0044(A0)                    ; $00677C
        MOVE.W  D0,$0046(A0)                    ; $006780
        MOVE.W  D0,$004A(A0)                    ; $006784
        MOVE.L  #$00100010,(-13968).W           ; $006788
        MOVE.B  #$00,(-15601).W                 ; $006790
        jsr     camera_state_selector(pc); $4EBA $4FD8
        MOVE.W  #$0002,$0092(A0)                ; $00679A
        jsr     speed_degrade_calc(pc)  ; $4EBA $1DF8
        jsr     effect_timer_mgmt(pc)   ; $4EBA $3BAA
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $19C6
        jsr     field_check_guard(pc)   ; $4EBA $191E
        jsr     timer_decrement_multi(pc); $4EBA $1D96
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $2D44
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $2B58
        jsr     entity_speed_clamp(pc)  ; $4EBA $3354
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $29C0
        jsr     tilt_adjust(pc)         ; $4EBA $2E58
        jsr     drift_physics_and_camera_offset_calc(pc); $4EBA $2EBE
        jsr     suspension_steering_damping(pc); $4EBA $3034
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $16A8
        jsr     entity_pos_update(pc)   ; $4EBA $07C2
        jsr     multi_flag_test(pc)     ; $4EBA $14FE
        jsr     ai_opponent_select(pc)  ; $4EBA $3C56
        jsr     angle_to_sine(pc)       ; $4EBA $08C8
        jsr     entity_speed_guard+4(pc); $4EBA $1468
        jsr     object_link_copy_table_lookup(pc); $4EBA $0960
        jsr     rotational_offset_calc(pc); $4EBA $0E60
        jsr     input_guard_cond_dec(pc); $4EBA $1840
        jsr     set_camera_regs_to_invalid(pc); $4EBA $335E
        jsr     display_state_disp(pc)  ; $4EBA $DCEE
        jsr     camera_offset_check(pc) ; $4EBA $C918
        jmp     display_state_disp+52(pc); $4EFA $DD1A
        jsr     camera_state_selector(pc); $4EBA $4F6A
        jsr     effect_timer_mgmt(pc)   ; $4EBA $3B46
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $1962
        jsr     field_check_guard(pc)   ; $4EBA $18BA
        jsr     timer_decrement_multi(pc); $4EBA $1D32
        jsr     tilt_adjust(pc)         ; $4EBA $2E04
        jsr     collision_response_surface_tracking+278(pc); $4EBA $0FF8
        jsr     rotational_offset_calc(pc); $4EBA $0E2C
        jsr     angle_to_sine(pc)       ; $4EBA $0884
        DC.W    $4EBA,$40B6         ; JSR     $00A8E0(PC); $006828
        jsr     set_camera_regs_to_invalid(pc); $4EBA $3326
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $2950
        jsr     suspension_steering_damping(pc); $4EBA $2FCC
        jsr     object_link_copy_table_lookup(pc); $4EBA $0910
        jmp     sprite_hud_layout_builder+154(pc); $4EFA $D486
        LEA     (-24576).W,A4                   ; $006840
        LEA     (-28672).W,A0                   ; $006844
        MOVE.W  #$0002,$00AC(A0)                ; $006848
        MOVE.B  (-342).W,(-15601).W             ; $00684E
        jsr     object_bitmask_table_lookup+40(pc); $4EBA $0368
        MOVE.L  $00B2(A0),$0018(A0)             ; $006858
        MOVE.B  $00E5(A0),D1                    ; $00685E
        ANDI.B  #$06,D1                         ; $006862
        BEQ.S  .loc_00F4                        ; $006866
        MOVE.L  (-14580).W,$0018(A0)            ; $006868
.loc_00F4:
        MOVE.W  (-16262).W,D0                   ; $00686E
        MOVEA.L $0068A8(PC,D0.W),A1             ; $006872
        JSR     (A1)                            ; $006876
        jsr     object_heading_deviation_check_warning_flag+8(pc); $4EBA $168A
.loc_0102:
        jsr     heading_from_position(pc); $4EBA $27C2
        jsr     object_flag_process_cond_clear+6(pc); $4EBA $19DA
        jsr     race_start_countdown_sequence(pc); $4EBA $363A
.loc_010E:
        jsr     obj_distance_calc(pc)   ; $4EBA $0D74
        jsr     object_visibility_collector(pc); $4EBA $0918
        jsr     camera_param_calc(pc)   ; $4EBA $C0F2
        jsr     object_state_disp_0034e8(pc); $4EBA $CC52
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $CF1C
        jsr     render_slot_setup+88(pc); $4EBA $D6E8
        jsr     sprite_hud_layout_builder+154(pc); $4EBA $D422
        jmp     object_bitmask_table_button_flag_handler+32(pc); $4EFA $0344
        DC.W    $0088                           ; $0068A8
        BVC.S  $006874                          ; $0068AA
        DC.W    $0088                           ; $0068AC
        BPL.S  .loc_0102                        ; $0068AE
        DC.W    $0088                           ; $0068B0
        BVS.S  .loc_0178                        ; $0068B2
        DC.W    $0088                           ; $0068B4
        BVS.S  .loc_010E                        ; $0068B6
        DC.W    $0088                           ; $0068B8
        BPL.S  .loc_017C                        ; $0068BA
        DC.W    $0088                           ; $0068BC
        BPL.S  $0068F8                          ; $0068BE
        DC.W    $0088                           ; $0068C0
        BMI.S  .loc_014E                        ; $0068C2
        DC.W    $0088                           ; $0068C4
        BVS.S  .loc_0198                        ; $0068C6
.loc_014E:
        jsr     camera_state_selector(pc); $4EBA $4EA6
        MOVEQ   #$00,D0                         ; $0068CC
        MOVE.W  D0,$0044(A0)                    ; $0068CE
        MOVE.W  D0,$0046(A0)                    ; $0068D2
        MOVE.W  D0,$004A(A0)                    ; $0068D6
        jsr     tire_squeal_check(pc)   ; $4EBA $1CE8
        jsr     speed_degrade_calc(pc)  ; $4EBA $1CBA
        jsr     effect_timer_mgmt(pc)   ; $4EBA $3A6C
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $1888
        jsr     field_check_guard(pc)   ; $4EBA $17E0
        jsr     timer_decrement_multi(pc); $4EBA $1C58
.loc_0178:
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $2C06
.loc_017C:
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $2A1A
        jsr     entity_speed_clamp(pc)  ; $4EBA $3216
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $2882
        jsr     tilt_adjust(pc)         ; $4EBA $2D1A
        jsr     drift_physics_and_camera_offset_calc(pc); $4EBA $2D80
        jsr     suspension_steering_damping(pc); $4EBA $2EF6
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $156A
.loc_0198:
        jsr     entity_pos_update(pc)   ; $4EBA $0684
        jsr     multi_flag_test(pc)     ; $4EBA $13C0
        jsr     ai_opponent_select(pc)  ; $4EBA $3B18
        jsr     angle_to_sine(pc)       ; $4EBA $078A
        jsr     proximity_trigger(pc)   ; $4EBA $354A
        jsr     entity_speed_guard+4(pc); $4EBA $1326
        jsr     object_link_copy_table_lookup(pc); $4EBA $081E
        jsr     rotational_offset_calc(pc); $4EBA $0D1E
        jsr     position_threshold_check(pc); $4EBA $161C
        jsr     effect_countdown(pc)    ; $4EBA $4306
        jmp     set_camera_regs_to_invalid(pc); $4EFA $3218
        MOVE.W  #$0000,$0006(A0)                ; $00693E
        MOVE.W  #$0000,$0074(A0)                ; $006944
        jsr     camera_state_selector(pc); $4EBA $4E24
        MOVEQ   #$00,D0                         ; $00694E
        MOVE.W  D0,$0044(A0)                    ; $006950
        MOVE.W  D0,$0046(A0)                    ; $006954
        MOVE.W  D0,$004A(A0)                    ; $006958
        jsr     input_mask_partial_a(pc); $4EBA $E0AE
        jsr     speed_degrade_calc(pc)  ; $4EBA $1C38
        jsr     effect_timer_mgmt(pc)   ; $4EBA $39EA
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $1806
        jsr     field_check_guard(pc)   ; $4EBA $175E
        jsr     timer_decrement_multi(pc); $4EBA $1BD6
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $2B84
        CMPI.W  #$0004,(-15764).W               ; $006978
        BEQ.S  .loc_020A                        ; $00697E
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $2990
.loc_020A:
        jsr     entity_speed_clamp(pc)  ; $4EBA $318C
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $27F8
        jsr     suspension_steering_damping(pc); $4EBA $2E74
        jsr     position_velocity_update(pc); $4EBA $06F2
        jsr     angle_to_sine(pc)       ; $4EBA $0714
        jsr     collision_response_surface_tracking+278(pc); $4EBA $0E7C
        SUBQ.W  #1,(-16340).W                   ; $00699C
        BGT.S  .loc_023A                        ; $0069A0
        MOVE.W  #$0000,(-16340).W               ; $0069A2
        MOVE.W  #$0000,$0074(A0)                ; $0069A8
        MOVE.W  (-16244).W,(-16262).W           ; $0069AE
.loc_023A:
        jsr     proximity_trigger(pc)   ; $4EBA $34B8
        jsr     entity_speed_guard+4(pc); $4EBA $1294
        jsr     object_link_copy_table_lookup(pc); $4EBA $078C
        jsr     rotational_offset_calc(pc); $4EBA $0C8C
        jsr     position_threshold_check(pc); $4EBA $158A
        jsr     effect_countdown(pc)    ; $4EBA $4274
        jmp     set_camera_regs_to_invalid(pc); $4EFA $3186
        jsr     camera_state_selector(pc); $4EBA $4D9E
        MOVEQ   #$00,D0                         ; $0069D4
        MOVE.W  D0,$0044(A0)                    ; $0069D6
        MOVE.W  D0,$0046(A0)                    ; $0069DA
        MOVE.W  D0,$004A(A0)                    ; $0069DE
        jsr     speed_degrade_calc(pc)  ; $4EBA $1BB6
        jsr     effect_timer_mgmt(pc)   ; $4EBA $3968
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $1784
        jsr     field_check_guard(pc)   ; $4EBA $16DC
        jsr     timer_decrement_multi(pc); $4EBA $1B54
        jsr     suspension_steering_damping(pc); $4EBA $2E0A
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $147E
        jsr     entity_pos_update(pc)   ; $4EBA $0598
        jsr     multi_flag_test(pc)     ; $4EBA $12D4
        jsr     ai_opponent_select(pc)  ; $4EBA $3A2C
        jsr     angle_to_sine(pc)       ; $4EBA $069E
        jsr     proximity_trigger(pc)   ; $4EBA $345E
        jsr     entity_speed_guard+4(pc); $4EBA $123A
        jsr     object_link_copy_table_lookup(pc); $4EBA $0732
        jsr     rotational_offset_calc(pc); $4EBA $0C32
        jsr     position_threshold_check(pc); $4EBA $1530
        jsr     tilt_adjust(pc)         ; $4EBA $2BFA
        jsr     obj_state_return(pc)    ; $4EBA $3ED0
        BTST    #4,(-15602).W                   ; $006A2A
        BEQ.S  .loc_02BE                        ; $006A30
        MOVE.W  (-16244).W,(-16262).W           ; $006A32
.loc_02BE:
        RTS                                     ; $006A38
