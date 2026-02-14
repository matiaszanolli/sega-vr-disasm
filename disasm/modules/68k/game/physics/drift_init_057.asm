; ============================================================================
; Drift Init 057
; ROM Range: $007E0C-$007E74 (104 bytes)
; ============================================================================
; Category: game
; Purpose: Initiates drift/skid sequence when conditions met
;   Checks race state, collision state, and speed threshold
;   On trigger: computes drift direction, angle delta, and duration
;
; Entry: D0 = current speed value
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0
; RAM:
;   $C89C: race_substate
; Calls:
;   $007EA4: obj_collision_response (tail call via JMP)
; Object fields (A0):
;   +$14: effect_duration
;   +$1C: collision_param
;   +$1D: collision_type
;   +$40: heading_angle
;   +$56: collision_state_a
;   +$57: collision_state_b
;   +$62: drift_active (counter)
;   +$64: drift_angle_delta
;   +$66: drift_target_angle
;   +$68: drift_direction
;   +$72: lateral_velocity
;   +$92: drift_cooldown
; Confidence: medium
; ============================================================================

drift_init_057:
        cmpi.w  #$0001,($FFFFC89C).w            ; $007E0C  race_substate == 1?
        bne.s   .check_collision                 ; $007E12  no → check collision
        cmpi.b  #$B1,$001D(A0)                   ; $007E14  collision_type == $B1?
        beq.s   .abort_to_response               ; $007E1A  yes → abort to response
.check_collision:
        move.b  $0057(A0),D1                     ; $007E1C  D1 = collision_state_b
        and.b   $0056(A0),D1                     ; $007E20  D1 &= collision_state_a
        andi.b  #$01,D1                          ; $007E24  bit 0 set?
        bne.s   .abort_to_response               ; $007E28  yes → abort to response
        cmpi.w  #$3000,D0                        ; $007E2A  speed <= $3000?
        ble.s   .init_drift                      ; $007E2E  yes → init drift
.abort_to_response:
        move.w  $001C(A0),D0                     ; $007E30  D0 = collision_param
        jmp     conditional_return_on_state_match(pc); $4EFA $006E
.init_drift:
        tst.w   $0092(A0)                        ; $007E38  drift_cooldown > 0?
        bgt.s   .done                            ; $007E3C  yes → skip
        addi.w  #$1000,D0                        ; $007E3E  D0 += $1000
        asl.w   #1,D0                            ; $007E42  D0 *= 2
        move.w  #$FFFF,$0068(A0)                 ; $007E44  drift_direction = -1 (left)
        tst.w   $0072(A0)                        ; $007E4A  lateral_velocity > 0?
        ble.s   .store_drift                     ; $007E4E  no → keep left
        move.w  #$0001,$0068(A0)                 ; $007E50  drift_direction = +1 (right)
        neg.w   D0                               ; $007E56  negate angle
.store_drift:
        move.w  D0,$0066(A0)                     ; $007E58  drift_target_angle = D0
        sub.w   $0040(A0),D0                     ; $007E5C  D0 -= heading_angle
        neg.w   D0                               ; $007E60  negate delta
        move.w  D0,$0064(A0)                     ; $007E62  drift_angle_delta = D0
        move.w  #$0004,$0062(A0)                 ; $007E66  drift_active = 4 (frames)
        move.w  #$0004,$0014(A0)                 ; $007E6C  effect_duration = 4
.done:
        rts                                     ; $007E72
