; ============================================================================
; Object Scoring + Lap Advance Check
; ROM Range: $008054-$0080AE (90 bytes)
; ============================================================================
; Category: game
; Purpose: Mid-function entry: if D0 >= $FF9C (-100) → returns to caller.
;   Increments position counter (A0+$2E), sets sprite=$0497.
;   If position matches lap target (A0+$2C): advances dispatch_idx ($C305)
;   to 4, increments lap, sets score flag (bit 14), starts timer ($C04E),
;   clears scene_state ($C8AA). If lap count exceeds total_laps ($C310):
;   clears score flag, zeroes timer, sets race_flags ($C30E) bit 5.
;
; Uses: D0, D1, A0
; RAM:
;   $C04E: timer (word, set to $0050)
;   $C305: dispatch_idx (byte, set to 4)
;   $C30E: race_flags (byte, bit 5 = scoring complete)
;   $C310: total_laps (byte)
;   $C8AA: scene_state (word, cleared)
; Object (A0):
;   +$02: flags (word, bit 14 = score flag)
;   +$08: sprite_index (word)
;   +$28: work field (word, cleared)
;   +$2C: current_lap (word)
;   +$2D: lap_limit (byte)
;   +$2E: position_counter (word)
; ============================================================================

object_scoring_lap_advance_check:
        cmpi.w  #$FF9C,D0                       ; $008054  D0 >= -100?
        bge.s   object_pos_compare_flag_set     ; $008058  D0 >= -100 → return to caller
        addq.w  #1,$002E(A0)                    ; $00805A  position_counter++
        move.w  #$0497,$0008(A0)                ; $00805E  sprite_index = $0497
        move.w  $002C(A0),D1                    ; $008064  D1 = current_lap
        addq.w  #1,D1                           ; $008068  D1++
        cmp.w   $002E(A0),D1                    ; $00806A  matches position?
        bne.s   .done                           ; $00806E  no → done
; --- lap complete ---
        move.b  #$04,($FFFFC305).w              ; $008070  dispatch_idx = 4
        addq.w  #1,$002C(A0)                    ; $008076  current_lap++
        clr.w   $0028(A0)                       ; $00807A  clear work field
        ori.w   #$4000,$0002(A0)                ; $00807E  set score flag (bit 14)
        move.w  #$0050,($FFFFC04E).w            ; $008084  timer = 80
        clr.w   ($FFFFC8AA).w                   ; $00808A  clear scene_state
        move.b  ($FFFFC310).w,D0                ; $00808E  D0 = total_laps
        subq.b  #1,D0                           ; $008092  D0--
        cmp.b   $002D(A0),D0                    ; $008094  laps remaining?
        bge.s   triple_guard_set_state_to_be    ; $008098  laps remaining → done
; --- all laps complete ---
        andi.w  #$BFFF,$0002(A0)                ; $00809A  clear score flag (bit 14)
        move.w  #$0000,($FFFFC04E).w            ; $0080A0  timer = 0
        bset    #5,($FFFFC30E).w                ; $0080A6  set scoring complete
.done:
        rts                                     ; $0080AC

