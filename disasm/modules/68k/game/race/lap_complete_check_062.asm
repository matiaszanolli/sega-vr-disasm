; ============================================================================
; Lap Complete Check 062
; ROM Range: $007F64-$007FDA (118 bytes)
; ============================================================================
; Category: game
; Purpose: Processes lap completion and race finish conditions
;   Increments checkpoint counter, checks lap vs total_laps
;   On race finish: sets flags, timer, and phase
;   Also checks if current position exceeds total racers
;
; Entry: D0 = speed/proximity value
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0
; RAM:
;   $C305: race_phase
;   $C310: total_racers
;   $C30E: race_flags
;   $C80E: race_ctrl
;   $C04E: timer_countdown
;   $C8AA: scene_state
; Object fields (A0):
;   +$02: flags
;   +$08: sprite_id
;   +$1C: position
;   +$28: checkpoint_count
;   +$2C: lap_count
;   +$2D: racer_index
;   +$2E: checkpoint_total
;   +$AC: race_score
; Confidence: high
; ============================================================================

lap_complete_check_062:
        cmpi.w  #$FF9C,D0                       ; $007F64  speed < -100?
        dc.w    $6C00,$009A         ; BGE.W   $008004    ; $007F68  no → external handler
        addq.w  #1,$002E(A0)                     ; $007F6C  checkpoint_total++
        move.w  #$0497,$0008(A0)                 ; $007F70  sprite_id = $0497
        move.w  $002C(A0),D1                     ; $007F76  D1 = lap_count
        addq.w  #1,D1                            ; $007F7A  D1++ (next lap)
        cmp.w   $002E(A0),D1                     ; $007F7C  D1 == checkpoint_total?
        bne.s   .done                            ; $007F80  no → done
        move.b  #$04,($FFFFC305).w               ; $007F82  race_phase = 4
        addq.w  #1,$002C(A0)                     ; $007F88  lap_count++
        clr.w   $0028(A0)                        ; $007F8C  checkpoint_count = 0
        tst.w   $00AC(A0)                        ; $007F90  race_score > 0?
        ble.s   .set_finish                      ; $007F94  no → finish
        cmpi.w  #$0003,$001C(A0)                 ; $007F96  position > 3?
        bgt.s   .check_racers                    ; $007F9C  yes → check racers
.set_finish:
        ori.w   #$4000,$0002(A0)                 ; $007F9E  flags |= $4000 (race over)
        move.w  #$0050,($FFFFC04E).w             ; $007FA4  timer_countdown = 80
        clr.w   ($FFFFC8AA).w                    ; $007FAA  scene_state = 0
.check_racers:
        move.b  ($FFFFC310).w,D0                 ; $007FAE  D0 = total_racers
        subq.b  #1,D0                            ; $007FB2  D0-- (last racer index)
        cmp.b   $002D(A0),D0                     ; $007FB4  D0 >= racer_index?
        bge.s   conditional_set_state_byte_object_cmp ; $007FB8  D0>=racer_index → handler
        bset    #5,($FFFFC30E).w                 ; $007FBA  race_flags |= bit 5
        btst    #5,($FFFFC80E).w                 ; $007FC0  race_ctrl bit 5?
        beq.s   clear_object_flags_reset_state   ; $007FC6  bit clear → next fn
        ori.w   #$4000,$0002(A0)                 ; $007FC8  flags |= $4000 (race over)
        move.w  #$0050,($FFFFC04E).w             ; $007FCE  timer_countdown = 80
        clr.w   ($FFFFC8AA).w                    ; $007FD4  scene_state = 0
.done:
        rts                                     ; $007FD8
