; ============================================================================
; Race Init Orchestrator 005
; ROM Range: $00671A-$00677A (96 bytes)
; ============================================================================
; Category: game
; Purpose: Initializes race frame — calls 12 subroutines sequentially
;   Sets up camera, loads params, runs steering/position/velocity calcs
;   On frame 20 ($14): copies camera state, clears init flag, advances state
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; RAM:
;   $C800: race_init_flag
;   $C89A: scene_state
;   $C8AA: frame_counter
;   $C8AC: state_dispatch_idx
;   $C092: camera_state
;   $C07A: camera_target
; Calls:
;   $00B770: camera_state_selector (camera init)
;   $0080CC: load_object_params
;   $008548: suspension_steering_damping+offset
;   $009802: suspension_steering_damping (state dispatch)
;   $007E7A: obj_velocity_y
;   $006F98: calc_steering
;   $007CD8: obj_position_x
;   $0070AA: angle_to_sine
;   $00714A: conditional_pos_add
;   $00764E: track_data_index_calc_table_lookup
;   $008032: race_position_check
;   $009B54: fn_8200_065
; Object fields (A0):
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: param_4a
; Confidence: high
; ============================================================================

race_init_orch_005:
        jsr     camera_state_selector(pc); $4EBA $5054
        move.b  #$01,($FFFFC800).w              ; $00671E  race_init_flag = 1
        moveq   #$00,D0                         ; $006724  D0 = 0
        move.w  D0,$0044(A0)                    ; $006726  obj.display_offset = 0
        move.w  D0,$0046(A0)                    ; $00672A  obj.display_scale = 0
        move.w  D0,$004A(A0)                    ; $00672E  obj.param_4a = 0
        jsr     field_check_guard(pc)   ; $4EBA $1998
        jsr     timer_decrement_multi(pc); $4EBA $1E10
        jsr     suspension_steering_damping(pc); $4EBA $30C6
        jsr     object_anim_timer_speed_clear+6(pc); $4EBA $173A
        jsr     entity_pos_update(pc)   ; $4EBA $0854
        jsr     multi_flag_test(pc)     ; $4EBA $1590
        jsr     angle_to_sine(pc)       ; $4EBA $095E
        jsr     object_link_copy_table_lookup(pc); $4EBA $09FA
        jsr     rotational_offset_calc(pc); $4EBA $0EFA
        jsr     input_guard_cond_dec(pc); $4EBA $18DA
        jsr     set_camera_regs_to_invalid(pc); $4EBA $33F8
; --- check if init complete (frame 20) ---
        cmpi.w  #$0014,($FFFFC8AA).w            ; $00675E  frame_counter == 20?
        bne.s   .done                           ; $006764  no → done
        move.w  ($FFFFC092).w,($FFFFC07A).w     ; $006766  camera_target = camera_state
        move.b  #$00,($FFFFC800).w              ; $00676C  race_init_flag = 0
        move.w  #$0030,($FFFFC8AC).w            ; $006772  state_dispatch_idx = $30
.done:
        rts                                     ; $006778
