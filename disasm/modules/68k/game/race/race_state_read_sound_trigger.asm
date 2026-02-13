; ============================================================================
; Race State Read + Sound Trigger
; ROM Range: $007D82-$007E0C (138 bytes)
; ============================================================================
; Checks race_substate, handles camera state transitions, reads
; object position data, applies speed multiplier via shift lookup
; table, loads velocity parameters, copies camera state, then
; calls race state read and triggers sound $B0.
;
; Entry: A0 = object pointer (+$14, +$24, +$8A, +$8C, +$E5)
; Uses: D0, D1, D6, A0, A1
; RAM:
;   $C004: camera_transition_flag
;   $C048: camera_position
;   $C04C: camera_state_timer
;   $C09A: camera_copy_src
;   $C07A: camera_copy_dest
;   $C312: terrain_type
;   $C708: speed_shift_table_ptr
;   $C826: sound_enable
;   $C89C: race_substate
;   $C8A4: sound_command
; Calls:
;   $007EB8: speed_calc (JSR PC-relative)
;   $00A1FC: race_state_read (JSR PC-relative)
; ============================================================================

race_state_read_sound_trigger:
        cmpi.w  #$0001,($FFFFC89C).w            ; race_substate = 1?
        bne.s   .no_camera_check
        btst    #2,$00E5(a0)                    ; object flag bit 2?
        dc.w    $6600,$009E                      ; bne.w $007E30 → external handler
.no_camera_check:
        tst.w   ($FFFFC04C).w                   ; camera_state_timer active?
        beq.s   .setup_position
        move.w  #$0001,($FFFFC004).w            ; set camera_transition_flag
        move.w  #$0001,($FFFFC048).w            ; camera_position = 1
.setup_position:
        move.w  $0024(a0),d0                    ; read object position
        addq.w  #2,d0                           ; offset adjust
        tst.b   ($FFFFC312).w                   ; terrain_type set?
        beq.s   .apply_shift
        subq.w  #4,d0                           ; terrain correction
.apply_shift:
        dc.w    $43FA,$00BE                      ; lea shift_table(pc),a1 → $007E74
        move.w  ($FFFFC89C).w,d6                ; race_substate as index
        move.b  $00(a1,d6.w),d6                 ; load shift count
        lsl.w   d6,d0                           ; apply speed multiplier
        move.b  $00E5(a0),d1                    ; object flags
        andi.b  #$06,d1                         ; extract bits 1-2
        beq.s   .load_params
        addq.w  #1,d0                           ; bump position
.load_params:
        movea.l ($FFFFC708).w,a1                ; speed_shift_table_ptr
        move.b  $00(a1,d0.w),d0                 ; read speed value
        andi.w  #$00FF,d0                       ; mask to byte
        moveq   #$28,d1                         ; velocity constant
        move.w  d1,$008C(a0)                    ; set velocity_x
        move.w  d1,$0014(a0)                    ; set effect_duration
        move.w  ($FFFFC09A).w,($FFFFC07A).w     ; copy camera state
; --- call speed calc + race state read ---
        dc.w    $4EBA,$00CC                      ; jsr speed_calc(pc) → $007EB8
        tst.b   ($FFFFC826).w                   ; sound enabled?
        beq.s   .done
        cmpi.w  #$000F,$008A(a0)                ; param_8a >= 15?
        bge.s   .done
        addq.w  #1,$008A(a0)                    ; increment param_8a
        dc.w    $4EBA,$23FA                      ; jsr race_state_read(pc) → $00A1FC
.done:
        move.b  #$B0,($FFFFC8A4).w              ; trigger sound $B0
        rts
