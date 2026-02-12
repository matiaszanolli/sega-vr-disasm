; ============================================================================
; Object Camera Position Update
; ROM Range: $0080D6-$008170 (154 bytes)
; ============================================================================
; Updates object camera/position state from ROM parameter table.
; Loads 4 parameter words from table indexed by D2×8. Decrements
; velocity_x timer; when expired, clears all motion fields, clamps
; minimum speed to $011C, checks race_substate for special position
; range ($0069-$0071), then sets steering target + heading copy.
;
; Entry: A0 = object pointer, D2 = table index
; Uses: D0, D2, A0, A1
; RAM:
;   $C004: camera_transition_flag
;   $C048: camera_position
;   $C04C: camera_state_timer
;   $C0AC: steering_target
;   $C89C: race_substate
; ============================================================================

fn_6200_069:
        tst.w   ($FFFFC04C).w                   ; camera_state_timer active?
        beq.s   .load_params
        move.w  #$0001,($FFFFC004).w            ; set camera_transition_flag
        move.w  #$0001,($FFFFC048).w            ; camera_position = 1
.load_params:
        lea     $00939EEC,a1                    ; ROM parameter table
        lsl.w   #3,d2                           ; D2 ×8 for table stride
        adda.l  d2,a1                           ; table + index
        move.w  (a1)+,$009C(a0)                 ; load param → field +$9C
        move.w  (a1)+,$009E(a0)                 ; load param → field +$9E
        move.w  (a1)+,$00A0(a0)                 ; load param → field +$A0
        move.w  (a1),$00A2(a0)                  ; load param → field +$A2
; --- decrement velocity timer ---
        subq.w  #1,$008C(a0)                    ; velocity_x countdown
        bgt.s   .done                            ; still active → return
; --- timer expired: clear all motion ---
        tst.w   ($FFFFC004).w                   ; camera transition active?
        beq.s   .clear_fields
        clr.w   ($FFFFC048).w                   ; reset camera_position
        clr.w   ($FFFFC004).w                   ; clear transition flag
.clear_fields:
        moveq   #$00,d0
        move.w  d0,$008C(a0)                    ; clear velocity_x
        move.w  d0,$009E(a0)                    ; clear motion fields
        move.w  d0,$00A0(a0)
        move.w  d0,$00A2(a0)
        move.w  d0,$009C(a0)
; --- clamp minimum speed ---
        cmpi.w  #$011C,$0006(a0)                ; speed < $011C?
        bge.s   .check_substate
        move.w  #$011C,$0006(a0)                ; clamp to minimum
.check_substate:
        cmpi.w  #$0001,($FFFFC89C).w            ; race_substate = 1?
        bne.s   .set_steering
        move.b  $00E5(a0),d0                    ; object flags
        andi.b  #$06,d0                         ; extract bits 1-2
        beq.s   .set_steering
        move.w  $0024(a0),d0                    ; position field
        cmpi.w  #$0069,d0                       ; in range [$0069..$0071]?
        blt.s   .set_steering
        cmpi.w  #$0071,d0
        ble.s   .done                            ; yes → skip steering update
.set_steering:
        move.w  #$0027,($FFFFC0AC).w            ; set steering_target
        move.w  #$0028,$0092(a0)                ; set param_92
        move.w  $003C(a0),$0040(a0)             ; copy heading_mirror → heading_angle
.done:
        rts
