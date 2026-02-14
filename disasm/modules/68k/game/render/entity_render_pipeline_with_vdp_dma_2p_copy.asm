; ============================================================================
; entity_render_pipeline_with_vdp_dma_2p_copy — Entity Render Pipeline with VDP DMA + 2P Copy
; ROM Range: $006240-$006496 (598 bytes)
; Multi-entry entity render pipeline with VDP register writes and DMA.
; Contains data table prefix (3 longword ROM addresses), 4 pipeline variants
; (full with palette, reduced, stripped, 2-player with MOVEM block copy),
; and 2-player object table duplication using 32x32-byte MOVEM transfers.
;
; Entry: A0 = entity base pointer
; Uses: D0-D7, A0, A1, A4, A6
; RAM: $9F00 obj_table_3
; Object fields: +$18 position, +$44 display_offset, +$46 display_scale,
;   +$4A display_aux, +$88 animation, +$92 render_mode, +$B2 stored_pos
; Confidence: high
; ============================================================================

entity_render_pipeline_with_vdp_dma_2p_copy:
        DC.W    $0088                           ; $006240
        DC.W    $3C7E                           ; $006242
        DC.W    $0088                           ; $006244
        MOVE.W  (A2)+,$0088(A6)                 ; $006246
        MOVE.W  (A2)+,$0088(A6)                 ; $00624A
        MOVE.W  (A2)+,$0088(A6)                 ; $00624E
        MOVE.W  (A2)+,$0088(A6)                 ; $006252
        MOVE.W  (A2)+,$7000(A6)                 ; $006256
        MOVE.W  D0,$0044(A0)                    ; $00625A
        MOVE.W  D0,$0046(A0)                    ; $00625E
        MOVE.W  D0,$004A(A0)                    ; $006262
        jsr     object_link_copy_table_lookup(pc); $4EBA $0EE2
        jsr     rotational_offset_calc(pc); $4EBA $13E2
        jsr     proximity_zone_multi(pc); $4EBA $2458
        jsr     vdp_buffer_xfer_camera_offset_apply(pc); $4EBA $CEB2
        jsr     vdp_config_xfer_scaled_params(pc); $4EBA $CEE8
        jsr     conditional_object_velocity_negate(pc); $4EBA $13A8
        jsr     object_geometry_visibility_collect(pc); $4EBA $10CE
        MOVE.B  (-15612).W,(-15604).W           ; $006282
        JSR     $00886C88                       ; $006288
        jmp     input_clear_both(pc)    ; $4EFA $E71A
        MOVEQ   #$00,D0                         ; $006292
        MOVE.W  D0,$0044(A0)                    ; $006294
        MOVE.W  D0,$0046(A0)                    ; $006298
        MOVE.W  D0,$004A(A0)                    ; $00629C
        MOVE.L  #$00100010,(-13968).W           ; $0062A0
        MOVE.W  #$0002,$0092(A0)                ; $0062A8
        jsr     speed_degrade_calc(pc)  ; $4EBA $22EA
        jsr     effect_timer_mgmt(pc)   ; $4EBA $409C
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $1EB8
        jsr     field_check_guard(pc)   ; $4EBA $1E10
        jsr     timer_decrement_multi(pc); $4EBA $2288
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $3236
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $304A
        jsr     entity_speed_clamp(pc)  ; $4EBA $3846
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $2EB2
        jsr     tilt_adjust(pc)         ; $4EBA $334A
        jsr     drift_physics_and_camera_offset_calc(pc); $4EBA $33B0
        jsr     suspension_steering_damping(pc); $4EBA $3526
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $1B9A
        jsr     entity_pos_update(pc)   ; $4EBA $0CB4
        jsr     multi_flag_test(pc)     ; $4EBA $19F0
        jsr     ai_opponent_select(pc)  ; $4EBA $4148
        jsr     angle_to_sine(pc)       ; $4EBA $0DBA
        jsr     object_heading_deviation_check_warning_flag+8(pc); $4EBA $1C10
        jsr     entity_speed_guard+4(pc); $4EBA $1956
        jsr     object_link_copy_table_lookup(pc); $4EBA $0E4E
        jsr     rotational_offset_calc(pc); $4EBA $134E
        jsr     position_threshold_check(pc); $4EBA $1C4C
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $39C6
        jsr     set_camera_regs_to_invalid(pc); $4EBA $3848
        jsr     proximity_zone_multi(pc); $4EBA $23B8
        jsr     ai_target_check(pc)     ; $4EBA $49C0
        jsr     game_init_state_dispatch_002+94(pc); $4EBA $E116
        jsr     vdp_buffer_xfer_camera_offset_apply(pc); $4EBA $CE0A
        jsr     vdp_config_xfer_scaled_params(pc); $4EBA $CE40
        jsr     conditional_object_velocity_negate(pc); $4EBA $1300
        jsr     object_geometry_visibility_collect(pc); $4EBA $1026
        jsr     object_table_sprite_param_update(pc); $4EBA $D3B2
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $D486
        jsr     render_slot_setup+88(pc); $4EBA $DC52
        jmp     scroll_pan_calc_vdp_write(pc); $4EFA $2D2C
        MOVEQ   #$00,D0                         ; $00633A
        MOVE.W  D0,$0044(A0)                    ; $00633C
        MOVE.W  D0,$0046(A0)                    ; $006340
        MOVE.W  D0,$004A(A0)                    ; $006344
        jsr     field_check_guard(pc)   ; $4EBA $1D82
        jsr     timer_decrement_multi(pc); $4EBA $21FA
        jsr     suspension_steering_damping(pc); $4EBA $34B0
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $1B24
        jsr     entity_pos_update(pc)   ; $4EBA $0C3E
        jsr     multi_flag_test(pc)     ; $4EBA $197A
        jsr     angle_to_sine(pc)       ; $4EBA $0D48
        jsr     object_link_copy_table_lookup(pc); $4EBA $0DE4
        jsr     rotational_offset_calc(pc); $4EBA $12E4
        jsr     position_threshold_check(pc); $4EBA $1BE2
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $395C
        jsr     set_camera_regs_to_invalid(pc); $4EBA $37DE
        jsr     proximity_zone_loop(pc) ; $4EBA $2400
        jsr     heading_with_camera(pc) ; $4EBA $2D26
        jsr     vdp_buffer_xfer_camera_offset_apply(pc); $4EBA $CDA4
        jsr     obj_distance_calc(pc)   ; $4EBA $1278
        jsr     object_visibility_collector(pc); $4EBA $0E1C
        jsr     object_table_sprite_param_update(pc); $4EBA $D350
        jmp     object_proximity_check_jump_table_dispatch(pc); $4EFA $D424
        MOVEQ   #$00,D0                         ; $006394
        MOVE.W  D0,$0044(A0)                    ; $006396
        MOVE.W  D0,$0046(A0)                    ; $00639A
        MOVE.W  D0,$004A(A0)                    ; $00639E
        MOVE.L  #$00100010,(-13968).W           ; $0063A2
        MOVE.W  #$0002,$0092(A0)                ; $0063AA
        BCLR    #4,(-15602).W                   ; $0063B0
        jsr     speed_degrade_calc(pc)  ; $4EBA $21E2
        jsr     timer_decrement_multi(pc); $4EBA $218C
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $2F52
        jsr     entity_speed_clamp(pc)  ; $4EBA $374E
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $2DBA
        jsr     tilt_adjust(pc)         ; $4EBA $3252
        jsr     entity_pos_update(pc)   ; $4EBA $0BC8
        jsr     ai_opponent_select(pc)  ; $4EBA $4060
        jsr     angle_to_sine(pc)       ; $4EBA $0CD2
        jsr     entity_speed_guard+4(pc); $4EBA $1872
        jsr     object_link_copy_table_lookup(pc); $4EBA $0D6A
        jsr     rotational_offset_calc(pc); $4EBA $126A
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $38E6
        jsr     set_camera_regs_to_invalid(pc); $4EBA $3768
        jsr     proximity_zone_loop(pc) ; $4EBA $238A
        jsr     heading_with_camera(pc) ; $4EBA $2CB0
        jsr     vdp_buffer_xfer_camera_offset_apply(pc); $4EBA $CD2E
        jsr     obj_distance_calc(pc)   ; $4EBA $1202
        jsr     object_visibility_collector(pc); $4EBA $0DA6
        jsr     object_table_sprite_param_update(pc); $4EBA $D2DA
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $D3AE
        jmp     render_slot_setup+88(pc); $4EFA $DB7A
        LEA     (-24576).W,A4                   ; $00640E
        LEA     (-28672).W,A0                   ; $006412
        MOVE.B  (-337).W,(-15601).W             ; $006416
        jsr     object_bitmask_table_lookup+40(pc); $4EBA $07A0
        MOVE.L  $00B2(A0),$0018(A0)             ; $006420
        MOVE.B  $00E5(A0),D1                    ; $006426
        ANDI.B  #$06,D1                         ; $00642A
        BEQ.S  .loc_01F6                        ; $00642E
        MOVE.L  (-14580).W,$0018(A0)            ; $006430
.loc_01F6:
        MOVE.W  (-16262).W,D0                   ; $006436
        lea     entity_render_pipeline_jump_table(pc),a1; $43FA $0160
        MOVEA.L $00(A1,D0.W),A1                 ; $00643E
        JSR     (A1)                            ; $006442
        jsr     object_heading_deviation_check_warning_flag+8(pc); $4EBA $1ABE
        jsr     entity_flag_bit_test_guard(pc); $4EBA $1F72
        LEA     (-24832).W,A1                   ; $00644C
        jsr     proximity_zone_simple(pc); $4EBA $2220
        LEA     (-32356).W,A1                   ; $006454
        jsr     heading_broadcast(pc)   ; $4EBA $2C74
        LEA     (-16384).W,A2                   ; $00645C
        LEA     (-19456).W,A1                   ; $006460
        MOVEQ   #$1F,D7                         ; $006464
.loc_0226:
        MOVEM.L (A2)+,D0/D1/D2/D3/D4/D5/D6/A3   ; $006466
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,-(A1)   ; $00646A
        DBRA    D7,.loc_0226                    ; $00646E
        MOVE.L  (-13968).W,(-13960).W           ; $006472
        MOVE.L  (-13964).W,(-13968).W           ; $006478
        LEA     (-19456).W,A1                   ; $00647E
        LEA     (-15360).W,A2                   ; $006482
        MOVEQ   #$1F,D7                         ; $006486
.loc_0248:
        MOVEM.L (A1)+,D0/D1/D2/D3/D4/D5/D6/A3   ; $006488
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,-(A2)   ; $00648C
        DBRA    D7,.loc_0248                    ; $006490
        RTS                                     ; $006494
