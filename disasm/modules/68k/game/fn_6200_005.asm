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
;   $00B770: fn_a200_026 (camera init)
;   $0080CC: load_object_params
;   $008548: fn_8200_038+offset
;   $009802: fn_8200_038 (state dispatch)
;   $007E7A: obj_velocity_y
;   $006F98: calc_steering
;   $007CD8: obj_position_x
;   $0070AA: angle_to_sine
;   $00714A: fn_6200_015
;   $00764E: fn_6200_029
;   $008032: race_position_check
;   $009B54: fn_8200_065
; Object fields (A0):
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: param_4a
; Confidence: high
; ============================================================================

fn_6200_005:
        dc.w    $4EBA,$5054         ; JSR     $00B770(PC); $00671A  camera init
        move.b  #$01,($FFFFC800).w              ; $00671E  race_init_flag = 1
        moveq   #$00,D0                         ; $006724  D0 = 0
        move.w  D0,$0044(A0)                    ; $006726  obj.display_offset = 0
        move.w  D0,$0046(A0)                    ; $00672A  obj.display_scale = 0
        move.w  D0,$004A(A0)                    ; $00672E  obj.param_4a = 0
        dc.w    $4EBA,$1998         ; JSR     $0080CC(PC); $006732  load_object_params
        dc.w    $4EBA,$1E10         ; JSR     $008548(PC); $006736
        dc.w    $4EBA,$30C6         ; JSR     $009802(PC); $00673A  state dispatch
        dc.w    $4EBA,$173A         ; JSR     $007E7A(PC); $00673E  obj_velocity_y
        dc.w    $4EBA,$0854         ; JSR     $006F98(PC); $006742  calc_steering
        dc.w    $4EBA,$1590         ; JSR     $007CD8(PC); $006746  obj_position_x
        dc.w    $4EBA,$095E         ; JSR     $0070AA(PC); $00674A  angle_to_sine
        dc.w    $4EBA,$09FA         ; JSR     $00714A(PC); $00674E
        dc.w    $4EBA,$0EFA         ; JSR     $00764E(PC); $006752
        dc.w    $4EBA,$18DA         ; JSR     $008032(PC); $006756  race_position_check
        dc.w    $4EBA,$33F8         ; JSR     $009B54(PC); $00675A
; --- check if init complete (frame 20) ---
        cmpi.w  #$0014,($FFFFC8AA).w            ; $00675E  frame_counter == 20?
        bne.s   .done                           ; $006764  no → done
        move.w  ($FFFFC092).w,($FFFFC07A).w     ; $006766  camera_target = camera_state
        move.b  #$00,($FFFFC800).w              ; $00676C  race_init_flag = 0
        move.w  #$0030,($FFFFC8AC).w            ; $006772  state_dispatch_idx = $30
.done:
        rts                                     ; $006778
