; ============================================================================
; race_frame_main_dispatch_entity_updates — Race Frame Main Dispatch + Entity Updates
; ROM Range: $006D9C-$006F98 (508 bytes)
; Main race frame dispatch. First updates state index, then calls
; table_lookup for 6-8 entities in obj_table_3/obj_table_2. Main section
; dispatches through 10-entry jump table indexed by state, running full
; render pipeline (30+ subs) with countdown timer variant. Ends with
; tile block copy setup (2 entries via FastCopy16).
;
; Entry: A0 = entity base pointer
; Uses: D0, D1, D6, D7, A0, A1, A2, A3
; RAM: $9100 obj_table_1, $9700 obj_table_2, $9F00 obj_table_3
; Object fields: +$06 speed, +$18 position, +$44 display_offset,
;   +$46 display_scale, +$4A display_aux, +$74 render_state,
;   +$B2 stored_pos, +$E5 flags
; Confidence: high
; ============================================================================

race_frame_main_dispatch_entity_updates:
        jsr     entity_data_table_full_render_pipeline+214(pc); $4EBA $FDEC
        LEA     (-24576).W,A4                   ; $006DA0
        MOVE.B  #$00,$00FF5FFE                  ; $006DA4
        LEA     (-28416).W,A0                   ; $006DAC
        jsr     race_entity_update_loop+176(pc); $4EBA $EC3A
        jsr     race_entity_update_loop+176(pc); $4EBA $EC36
        jsr     race_entity_update_loop+176(pc); $4EBA $EC32
        jsr     race_entity_update_loop+176(pc); $4EBA $EC2E
        jsr     race_entity_update_loop+176(pc); $4EBA $EC2A
        jmp     race_entity_update_loop+176(pc); $4EFA $EC26
        LEA     (-24576).W,A4                   ; $006DC8
        LEA     (-26880).W,A0                   ; $006DCC
        jsr     race_entity_update_loop+176(pc); $4EBA $EC1A
.loc_0038:
        jsr     race_entity_update_loop+176(pc); $4EBA $EC16
        jsr     race_entity_update_loop+176(pc); $4EBA $EC12
        jsr     race_entity_update_loop+176(pc); $4EBA $EC0E
        jsr     race_entity_update_loop+176(pc); $4EBA $EC0A
        jsr     race_entity_update_loop+176(pc); $4EBA $EC06
        jsr     race_entity_update_loop+176(pc); $4EBA $EC02
        jmp     race_entity_update_loop+176(pc); $4EFA $EBFE
        LEA     (-24576).W,A4                   ; $006DF0
        LEA     (-24832).W,A0                   ; $006DF4
        jsr     race_entity_update_loop+176(pc); $4EBA $EBF2
        LEA     (-28672).W,A0                   ; $006DFC
        MOVE.L  $00B2(A0),$0018(A0)             ; $006E00
        MOVE.B  $00E5(A0),D1                    ; $006E06
        ANDI.B  #$06,D1                         ; $006E0A
        BEQ.S  .loc_007A                        ; $006E0E
        MOVE.L  (-14580).W,$0018(A0)            ; $006E10
.loc_007A:
        MOVE.W  (-16262).W,D0                   ; $006E16
        MOVEA.L $006E20(PC,D0.W),A1             ; $006E1A
        JMP     (A1)                            ; $006E1E
        DC.W    $0088                           ; $006E20
        BGT.S  $006E6C                          ; $006E22
        DC.W    $0088                           ; $006E24
        SUBQ.L  #7,(A2)+                        ; $006E26
        DC.W    $0088                           ; $006E28
        BGT.S  $006DEA                          ; $006E2A
        DC.W    $0088                           ; $006E2C
        BRA.S  $006E04                          ; $006E2E
        DC.W    $0088                           ; $006E30
        BSR.S  .loc_0112                        ; $006E32
        DC.W    $0088                           ; $006E34
        SLT     -(A0)                           ; $006E36
        DC.W    $0088                           ; $006E38
        BHI.S  $006DCE                          ; $006E3A
        DC.W    $0088                           ; $006E3C
        BLS.S  .loc_0038                        ; $006E3E
        DC.W    $0088                           ; $006E40
        BLS.S  .loc_00E2                        ; $006E42
        DC.W    $0088                           ; $006E44
        BGT.S  $006E12                          ; $006E46
        MOVEQ   #$00,D0                         ; $006E48
        MOVE.W  D0,$0044(A0)                    ; $006E4A
        MOVE.W  D0,$0046(A0)                    ; $006E4E
        MOVE.W  D0,$004A(A0)                    ; $006E52
        jsr     effect_timer_mgmt(pc)   ; $4EBA $34F8
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $1314
        jsr     field_check_guard(pc)   ; $4EBA $126C
        jsr     timer_decrement_multi(pc); $4EBA $16E4
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $2692
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $24A6
        jsr     entity_speed_clamp(pc)  ; $4EBA $2CA2
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $230E
        jsr     tilt_adjust(pc)         ; $4EBA $27A6
        jsr     drift_physics_and_camera_offset_calc(pc); $4EBA $280C
.loc_00E2:
        jsr     suspension_steering_damping(pc); $4EBA $2982
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $0FF6
        jsr     entity_pos_update(pc)   ; $4EBA $0110
        jsr     multi_flag_test(pc)     ; $4EBA $0E4C
        jsr     ai_opponent_select(pc)  ; $4EBA $35A4
        jsr     angle_to_sine(pc)       ; $4EBA $0216
        jsr     object_heading_deviation_check_warning_flag+8(pc); $4EBA $106C
        jsr     proximity_trigger(pc)   ; $4EBA $2FD2
        jsr     entity_speed_guard+4(pc); $4EBA $0DAE
        jsr     object_link_copy_table_lookup(pc); $4EBA $02A6
        jsr     rotational_offset_calc(pc); $4EBA $07A6
        jsr     position_threshold_check(pc); $4EBA $10A4
.loc_0112:
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $2E1E
        jsr     set_camera_regs_to_invalid(pc); $4EBA $2CA0
        jsr     proximity_zone_multi(pc); $4EBA $1810
        jmp     ai_target_check(pc)     ; $4EFA $3E18
        MOVE.W  #$0000,$0006(A0)                ; $006EBE
        MOVE.W  #$0000,$0074(A0)                ; $006EC4
        MOVEQ   #$00,D0                         ; $006ECA
        MOVE.W  D0,$0044(A0)                    ; $006ECC
        MOVE.W  D0,$0046(A0)                    ; $006ED0
        MOVE.W  D0,$004A(A0)                    ; $006ED4
        jsr     input_mask_both(pc)     ; $4EBA $DB14
        jsr     speed_degrade_calc(pc)  ; $4EBA $16BC
        jsr     effect_timer_mgmt(pc)   ; $4EBA $346E
        jsr     object_timer_expire_speed_param_reset(pc); $4EBA $128A
        jsr     field_check_guard(pc)   ; $4EBA $11E2
        jsr     timer_decrement_multi(pc); $4EBA $165A
        jsr     steering_input_processing_and_velocity_update+6(pc); $4EBA $2608
        CMPI.W  #$0004,(-15764).W               ; $006EF4
        BEQ.S  .loc_0164                        ; $006EFA
        jsr     entity_force_integration_and_speed_calc+18(pc); $4EBA $2414
.loc_0164:
        jsr     entity_speed_clamp(pc)  ; $4EBA $2C10
        jsr     entity_speed_acceleration_and_braking(pc); $4EBA $227C
        jsr     suspension_steering_damping(pc); $4EBA $28F8
        jsr     position_velocity_update(pc); $4EBA $0176
        jsr     angle_to_sine(pc)       ; $4EBA $0198
        jsr     collision_response_surface_tracking+278(pc); $4EBA $0900
        SUBQ.W  #1,(-16340).W                   ; $006F18
        BGT.S  .loc_0194                        ; $006F1C
        MOVE.W  #$0000,(-16340).W               ; $006F1E
        MOVE.W  #$0000,$0074(A0)                ; $006F24
        MOVE.W  (-16244).W,(-16262).W           ; $006F2A
.loc_0194:
        jsr     object_heading_deviation_check_warning_flag+8(pc); $4EBA $0FD2
        jsr     proximity_trigger(pc)   ; $4EBA $2F38
        jsr     entity_speed_guard+4(pc); $4EBA $0D14
        jsr     object_link_copy_table_lookup(pc); $4EBA $020C
        jsr     rotational_offset_calc(pc); $4EBA $070C
        jsr     position_threshold_check(pc); $4EBA $100A
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $2D84
        jsr     effect_countdown(pc)    ; $4EBA $3CF0
        jsr     set_camera_regs_to_invalid(pc); $4EBA $2C02
        jsr     proximity_zone_multi(pc); $4EBA $1772
        jmp     ai_target_check(pc)     ; $4EFA $3D7A
        MOVE.L  A4,-(A7)                        ; $006F5C
        MOVE.W  #$0001,$00FF3000                ; $006F5E
        LEA     $0089C064,A1                    ; $006F66
        LEA     $00FF3022,A2                    ; $006F6C
        LEA     $00FF301A,A3                    ; $006F72
        LEA     $00FF3002,A4                    ; $006F78
        MOVEQ   #$01,D6                         ; $006F7E
.loc_01E4:
        MOVE.L  A2,(A3)+                        ; $006F80
        MOVE.W  (A1),D7                         ; $006F82
        MOVE.W  (A1)+,(A2)+                     ; $006F84
.loc_01EA:
        jsr     triple_memory_copy+88(pc); $4EBA $D99A
        DBRA    D7,.loc_01EA                    ; $006F8A
        DBRA    D6,.loc_01E4                    ; $006F8E
        MOVE.L  A2,(A4)+                        ; $006F92
        MOVEA.L (A7)+,A4                        ; $006F94
        RTS                                     ; $006F96
