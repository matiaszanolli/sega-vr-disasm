; ============================================================================
; Collision Flag Check 054
; ROM Range: $007CF0-$007D56 (102 bytes)
; ============================================================================
; Category: game
; Purpose: Checks collision conditions and sets object flags
;   Tests speed threshold, lateral position, and collision state
;   On collision: sets flag bits $1000/$2000 in obj.flags, sets sound $B2
;   On active collision sequence: tail-calls obj_collision_response
;
; Entry: D0 = input flags
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0
; RAM:
;   $C8D2: lateral_threshold
;   $C8A4: sound_command
; Calls:
;   $007EA4: obj_collision_response (tail call via JMP)
; Object fields (A0):
;   +$02: flags
;   +$04: speed
;   +$1C: collision_param
;   +$55: collision_mask
;   +$56: collision_state_a
;   +$57: collision_state_b
;   +$62: collision_active
;   +$6A: collision_cooldown
;   +$8C: collision_lock
;   +$94: lateral_position
; Confidence: medium
; ============================================================================

collision_flag_check_054:
        andi.b  #$0C,D0                         ; $007CF0  isolate collision bits
        beq.s   .check_sequence                  ; $007CF4  none set → skip
        cmpi.w  #$0064,$0004(A0)                ; $007CF6  speed <= 100?
        ble.s   .check_sequence                  ; $007CFC  yes → skip
        tst.w   $006A(A0)                        ; $007CFE  cooldown active?
        bne.s   .check_sequence                  ; $007D02  yes → skip
        tst.w   $008C(A0)                        ; $007D04  collision locked?
        bne.s   .check_sequence                  ; $007D08  yes → skip
        move.w  ($FFFFC8D2).w,D0                ; $007D0A  D0 = lateral_threshold
        cmp.w   $0094(A0),D0                     ; $007D0E  threshold > lateral_pos?
        bgt.s   .set_right                       ; $007D12  yes → right collision
        ori.w   #$1000,$0002(A0)                 ; $007D14  flags |= $1000 (left collision)
        bra.s   .play_sound                      ; $007D1A
.set_right:
        neg.w   D0                               ; $007D1C  negate threshold
        cmp.w   $0094(A0),D0                     ; $007D1E  -threshold < lateral_pos?
        blt.s   .check_sequence                  ; $007D22  yes → no collision
        ori.w   #$2000,$0002(A0)                 ; $007D24  flags |= $2000 (right collision)
.play_sound:
        move.b  #$B2,($FFFFC8A4).w              ; $007D2A  sound_command = $B2 (crash)
.check_sequence:
        tst.w   $0062(A0)                        ; $007D30  collision_active?
        beq.s   .check_mask                      ; $007D34  no → check mask
        move.b  $0057(A0),D1                     ; $007D36  D1 = collision_state_b
        and.b   $0056(A0),D1                     ; $007D3A  D1 &= collision_state_a
        andi.b  #$01,D1                          ; $007D3E  bit 0 set?
        beq.s   .done                            ; $007D42  no → done
        move.w  $001C(A0),D0                     ; $007D44  D0 = collision_param
        jmp     conditional_return_on_state_match(pc); $4EFA $015A
.check_mask:
        btst    #0,$0055(A0)                     ; $007D4C  collision_mask bit 0?
        dc.w    $6602               ; BNE.S   $007D56    ; $007D52  yes → next fn
.done:
        rts                                     ; $007D54
