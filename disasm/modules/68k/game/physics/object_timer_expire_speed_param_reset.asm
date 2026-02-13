; ============================================================================
; Object Timer Expire + Speed Parameter Reset
; ROM Range: $008170-$0081C0 (80 bytes)
; ============================================================================
; Category: game
; Purpose: Decrements object timer (A0+$62). On expiry (→0):
;   If sh2_comm_state ($C89C) == 1 AND A0+$E5 bits 1-2 nonzero
;   AND A0+$24 in range [$69,$6F] → skip (protected range).
;   Otherwise: sets speed_frames ($C0AC) = $F (or $4 if boost_flag
;   $C8C8 == 2), sets A0+$92 = $28, copies heading_mirror → heading.
;
; Uses: D0, A0
; RAM:
;   $C0AC: speed_frames (word)
;   $C89C: sh2_comm_state (word)
;   $C8C8: boost_flag (word)
; Object (A0):
;   +$24: object_id (word)
;   +$3C: heading_mirror (word)
;   +$40: heading_angle (word, set from mirror)
;   +$62: timer (word, countdown)
;   +$92: speed_param (word, set to $28)
;   +$E5: type_flags (byte, bits 1-2)
; ============================================================================

object_timer_expire_speed_param_reset:
        tst.w   $0062(A0)                       ; $008170  timer active?
        ble.s   .done                           ; $008174  no → done
        subq.w  #1,$0062(A0)                    ; $008176  timer--
        bne.s   .done                           ; $00817A  not zero → done
; --- timer expired ---
        cmpi.w  #$0001,($FFFFC89C).w            ; $00817C  comm_state == 1?
        bne.s   .set_speed                      ; $008182  no → set speed
        move.b  $00E5(A0),D0                    ; $008184  D0 = type_flags
        andi.b  #$06,D0                         ; $008188  check bits 1-2
        beq.s   .set_speed                      ; $00818C  clear → set speed
        move.w  $0024(A0),D0                    ; $00818E  D0 = object_id
        cmpi.w  #$0069,D0                       ; $008192  id < $69?
        blt.s   .set_speed                      ; $008196  yes → set speed
        cmpi.w  #$006F,D0                       ; $008198  id <= $6F?
        ble.s   .done                           ; $00819C  yes → protected (skip)
.set_speed:
        move.w  #$000F,($FFFFC0AC).w            ; $00819E  speed_frames = 15
        cmpi.w  #$0002,($FFFFC8C8).w            ; $0081A4  boost level 2?
        bne.s   .set_param                      ; $0081AA  no → keep 15
        move.w  #$0004,($FFFFC0AC).w            ; $0081AC  speed_frames = 4
.set_param:
        move.w  #$0028,$0092(A0)                ; $0081B2  speed_param = $28
        move.w  $003C(A0),$0040(A0)             ; $0081B8  heading_angle = mirror
.done:
        rts                                     ; $0081BE

