; ============================================================================
; Obj Calc Steering 005 (auto-analyzed)
; ROM Range: $00671A-$00677A (96 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 12 subroutines
;   RAM: $C8AA (scene_state), $C8AC (state_dispatch_idx)
;   Calls: select_sprite_buffer, load_object_params, timer_countdown, game_update
;   Object (A0): +$44 (display_offset), +$46 (display_scale), +$4A
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; RAM:
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
; Calls:
;   $006F98: calc_steering
;   $0070AA: angle_to_sine
;   $007CD8: obj_position_x
;   $007E7A: obj_velocity_y
;   $008032: race_position_check
;   $0080CC: load_object_params
; Object fields:
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: [unknown]
; Confidence: high
; ============================================================================

fn_6200_005:
        DC.W    $4EBA,$5054         ; JSR     $00B770(PC); $00671A
        MOVE.B  #$01,(-14336).W                 ; $00671E
        MOVEQ   #$00,D0                         ; $006724
        MOVE.W  D0,$0044(A0)                    ; $006726
        MOVE.W  D0,$0046(A0)                    ; $00672A
        MOVE.W  D0,$004A(A0)                    ; $00672E
        DC.W    $4EBA,$1998         ; JSR     $0080CC(PC); $006732
        DC.W    $4EBA,$1E10         ; JSR     $008548(PC); $006736
        DC.W    $4EBA,$30C6         ; JSR     $009802(PC); $00673A
        DC.W    $4EBA,$173A         ; JSR     $007E7A(PC); $00673E
        DC.W    $4EBA,$0854         ; JSR     $006F98(PC); $006742
        DC.W    $4EBA,$1590         ; JSR     $007CD8(PC); $006746
        DC.W    $4EBA,$095E         ; JSR     $0070AA(PC); $00674A
        DC.W    $4EBA,$09FA         ; JSR     $00714A(PC); $00674E
        DC.W    $4EBA,$0EFA         ; JSR     $00764E(PC); $006752
        DC.W    $4EBA,$18DA         ; JSR     $008032(PC); $006756
        DC.W    $4EBA,$33F8         ; JSR     $009B54(PC); $00675A
        CMPI.W  #$0014,(-14166).W               ; $00675E
        BNE.S  .loc_005E                        ; $006764
        MOVE.W  (-16238).W,(-16262).W           ; $006766
        MOVE.B  #$00,(-14336).W                 ; $00676C
        MOVE.W  #$0030,(-14164).W               ; $006772
.loc_005E:
        RTS                                     ; $006778
