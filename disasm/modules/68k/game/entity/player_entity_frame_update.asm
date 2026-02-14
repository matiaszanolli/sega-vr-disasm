; ============================================================================
; player_entity_frame_update — Player Entity Frame Update
; ROM Range: $005D08-$005DC8 (192 bytes)
; Per-frame player entity update. Sets player-active flag, clears display
; offsets, runs steering/physics/rendering pipeline (20 subroutines), then
; dispatches to mode-specific handler via jump table indexed by race state.
; Transitions to race start when frame counter reaches $0014.
;
; Entry: A0 = player entity pointer
; Uses: D0, A0, A1
; RAM: $C89C sh2_comm_state, $C8A0 race_state, $C8AA scene_state,
;      $C8AC state_dispatch_idx
; Object fields: +$44 display_offset, +$46 display_scale, +$4A display_aux
; Confidence: high
; ============================================================================

player_entity_frame_update:
        MOVE.B  #$01,(-14336).W                 ; $005D08
        MOVEQ   #$00,D0                         ; $005D0E
        MOVE.W  D0,$0044(A0)                    ; $005D10
        MOVE.W  D0,$0046(A0)                    ; $005D14
        MOVE.W  D0,$004A(A0)                    ; $005D18
        jsr     field_check_guard(pc)   ; $4EBA $23AE
        jsr     timer_decrement_multi(pc); $4EBA $2826
        jsr     suspension_steering_damping(pc); $4EBA $3ADC
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $2150
        jsr     entity_pos_update(pc)   ; $4EBA $126A
        jsr     multi_flag_test(pc)     ; $4EBA $1FA6
        jsr     angle_to_sine(pc)       ; $4EBA $1374
        jsr     object_link_copy_table_lookup(pc); $4EBA $1410
        jsr     rotational_offset_calc(pc); $4EBA $1910
        jsr     position_threshold_check(pc); $4EBA $220E
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $3F88
        jsr     effect_countdown(pc)    ; $4EBA $4EF4
        jsr     set_camera_regs_to_invalid(pc); $4EBA $3E06
        jsr     proximity_zone_multi+54(pc); $4EBA $29AC
        jsr     heading_from_position(pc); $4EBA $32EA
        DC.W    $4EBA,$247E         ; JSR     $0081D8(PC); $005D58
        jsr     obj_distance_calc(pc)   ; $4EBA $18A0
        jsr     object_visibility_collector(pc); $4EBA $1444
        jsr     camera_param_calc(pc)   ; $4EBA $CC1E
        jsr     object_state_disp_0031a6(pc); $4EBA $D43C
        jsr     object_table_sprite_param_update(pc); $4EBA $D970
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $DA44
        jsr     render_slot_setup+88(pc); $4EBA $E210
        MOVE.B  (-15612).W,(-15604).W           ; $005D78
        MOVE.W  (-14176).W,D0                   ; $005D7E
        BTST    #7,(-14308).W                   ; $005D82
        BEQ.S  .loc_0084                        ; $005D88
        MOVEQ   #$04,D0                         ; $005D8A
.loc_0084:
        MOVEA.L $005DC8(PC,D0.W),A1             ; $005D8C
        JSR     (A1)                            ; $005D90
        CMPI.W  #$0014,(-14166).W               ; $005D92
        BNE.S  .loc_00BE                        ; $005D98
        MOVE.B  #$00,(-14336).W                 ; $005D9A
        MOVE.W  (-16238).W,(-16262).W           ; $005DA0
        MOVE.W  #$0004,(-14164).W               ; $005DA6
        TST.W  (-14180).W                       ; $005DAC
        BEQ.S  .loc_00B0                        ; $005DB0
        MOVE.W  #$0020,(-14164).W               ; $005DB2
.loc_00B0:
        BTST    #7,(-14308).W                   ; $005DB8
        BEQ.S  .loc_00BE                        ; $005DBE
        MOVE.W  #$0020,(-14164).W               ; $005DC0
.loc_00BE:
        RTS                                     ; $005DC6
