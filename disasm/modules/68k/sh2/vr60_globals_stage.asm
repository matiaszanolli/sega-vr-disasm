; ============================================================================
; vr60_globals_stage — Stage Per-Frame Globals for SDRAM Transfer
; Size: ~120 bytes
; ============================================================================
;
; Gathers 48 bytes of scattered WRAM physics globals into a contiguous
; staging block at $FF6B00, immediately after the entity staging area
; ($FF6A00). The extended cmd $3E DREQ transfer sends 320 bytes total
; (256B entity + 64B globals), so globals land at $0600F30C in SDRAM.
;
; Layout matches VR60_ROADMAP.md §7.4 SDRAM globals block:
;   +$00  track_tilt (word)           from $FFC0AC
;   +$02  track_speed_factor (word)   from $FFC0E6
;   +$04  upper_accel_limit (word)    from $FFC0F8
;   +$06  lower_accel_limit (word)    from $FFC0FA
;   +$08  speed_table_ptr (long)      from $FFC27C
;   +$0C  gear_table_ptr (long)       from $FFC048
;   +$10  surface_drivability (byte)  from $FFC0D4
;   +$11  wind_active (byte)          from $FFC31B
;   +$12  has_boost_flag (byte)       from $FFC826
;   +$13  banking_direction (byte)    from $FFC971
;   +$14  steering_velocity (word)    from $FFC000
;   +$16  steering_direction (word)   from $FFC00A
;   +$18  input_state (byte)          from $FFC010
;   +$19  ai_control_flag (byte)      from $FFC018
;   +$1A  mode_flag (word)            from $FFC8C8
;   +$1C  race_substate_b (word)      from $FFC8CC
;   +$1E  heading_correction (word)   from $FFBBA0
;   +$20  lateral_drag (word)         from $FFBBA2
;   +$22  spin_threshold (word)       from $FFBBA4
;   +$24  high_vel_threshold (word)   from $FFBBA6
;   +$26  drift_divisor (word)        from $FFBBA8
;   +$28  min_speed_threshold (word)  from $FFBBB0
;   +$2A  max_speed_threshold (word)  from $FFBBB2
;   +$2C  sound_trigger_out (byte)    from $FFC8A4  (output: cleared after staging)
;   +$2D  ai_boost_control (byte)     from $FFBFC0
;   +$2E  slide_indicator (byte)      from $FFBF7B  (output)
;   +$2F  (padding byte)
;   +$30-$3F  reserved (16 bytes, zeroed)
;
; Called from: state4_epilogue (after vr60_entity_stage, before vr60_entity_transfer)
; Entry: none
; Preserves: A0 (entity pointer used by orchestrator)
; Clobbers: D0, A1
; ============================================================================

VR60_GLOBALS_DST        equ     $FF6B00         ; staging area (after entity at $FF6A00)

vr60_globals_stage:
        movem.l d0/a0-a1,-(sp)                 ; save regs
        lea     VR60_GLOBALS_DST,a1             ; A1 = destination

; --- Scene-init globals (offsets +$00 to +$0F) ---
        move.w  ($FFFFC0AC).w,d0                ; track_tilt
        move.w  d0,(a1)+                        ; +$00
        move.w  ($FFFFC0E6).w,d0                ; track_speed_factor
        move.w  d0,(a1)+                        ; +$02
        move.w  ($FFFFC0F8).w,d0                ; upper_accel_limit
        move.w  d0,(a1)+                        ; +$04
        move.w  ($FFFFC0FA).w,d0                ; lower_accel_limit
        move.w  d0,(a1)+                        ; +$06
        move.l  ($FFFFC27C).w,d0                ; speed_table_ptr
        move.l  d0,(a1)+                        ; +$08
        move.l  ($FFFFC048).w,d0                ; gear_table_ptr
        move.l  d0,(a1)+                        ; +$0C

; --- Mixed-frequency globals (offsets +$10 to +$13) ---
        move.b  ($FFFFC0D4).w,d0                ; surface_drivability
        move.b  d0,(a1)+                        ; +$10
        move.b  ($FFFFC31B).w,d0                ; wind_active
        move.b  d0,(a1)+                        ; +$11
        move.b  ($FFFFC826).w,d0                ; has_boost_flag
        move.b  d0,(a1)+                        ; +$12
        move.b  ($FFFFC971).w,d0                ; banking_direction
        move.b  d0,(a1)+                        ; +$13

; --- Per-frame globals (offsets +$14 to +$1D) ---
        move.w  ($FFFFC000).w,d0                ; steering_velocity
        move.w  d0,(a1)+                        ; +$14
        move.w  ($FFFFC00A).w,d0                ; steering_direction
        move.w  d0,(a1)+                        ; +$16
        move.b  ($FFFFC010).w,d0                ; input_state
        move.b  d0,(a1)+                        ; +$18
        move.b  ($FFFFC018).w,d0                ; ai_control_flag
        move.b  d0,(a1)+                        ; +$19
        move.w  ($FFFFC8C8).w,d0                ; mode_flag
        move.w  d0,(a1)+                        ; +$1A
        move.w  ($FFFFC8CC).w,d0                ; race_substate_b
        move.w  d0,(a1)+                        ; +$1C

; --- Drift parameters (offsets +$1E to +$2B) ---
; These are at $FFFFBBA0-$FFFFBBB2 (negative 16-bit range, below $FFFF8000).
; Use absolute long addressing since they don't fit in abs.w ($FFFF8000-$FFFFFFFF).
        lea     $FFFFBBA0,a0                    ; heading_correction base (abs.l)
        move.w  (a0)+,d0                        ; $FFFFBBA0 heading_correction
        move.w  d0,(a1)+                        ; +$1E
        move.w  (a0)+,d0                        ; $FFFFBBA2 lateral_drag
        move.w  d0,(a1)+                        ; +$20
        move.w  (a0)+,d0                        ; $FFFFBBA4 spin_threshold
        move.w  d0,(a1)+                        ; +$22
        move.w  (a0)+,d0                        ; $FFFFBBA6 high_vel_threshold
        move.w  d0,(a1)+                        ; +$24
        move.w  (a0)+,d0                        ; $FFFFBBA8 drift_divisor
        move.w  d0,(a1)+                        ; +$26
; Skip $FFFFBBAA-$FFFFBBAE (unused)
        lea     $FFFFBBB0,a0                    ; min_speed_threshold base (abs.l)
        move.w  (a0)+,d0                        ; $FFFFBBB0 min_speed_threshold
        move.w  d0,(a1)+                        ; +$28
        move.w  (a0)+,d0                        ; $FFFFBBB2 max_speed_threshold
        move.w  d0,(a1)+                        ; +$2A

; --- Output/misc globals (offsets +$2C to +$2F) ---
        move.b  ($FFFFC8A4).w,d0                ; sound_trigger_out
        move.b  d0,(a1)+                        ; +$2C
        move.b  ($FFFFBFC0).w,d0                ; ai_boost_control
        move.b  d0,(a1)+                        ; +$2D
        move.b  ($FFFFBF7B).w,d0                ; slide_indicator
        move.b  d0,(a1)+                        ; +$2E
        clr.b   (a1)+                           ; +$2F padding

; --- Phase 4 AI globals (offsets +$30 to +$37) ---
        clr.l   (a1)+                           ; +$30 (max_cam_dist / reserved)
        move.w  ($FFFFC83E).w,d0                ; difficulty_index
        move.w  d0,(a1)+                        ; +$34
        move.w  ($FFFFC840).w,d0                ; camera_mode
        move.w  d0,(a1)+                        ; +$36
; --- Collision inputs (offsets +$38 to +$3F) — VR60 Phase 5C ---
; +$38 (word) = race_state ($FFC8A0)  — read by SH2 track_data_index_calc
        move.w  ($FFFFC8A0).w,d0                ; race_state
        move.w  d0,(a1)+                        ; +$38
; +$3A (long) = track_seg_base ($FFC268) PRE-TRANSLATED to SH2 (+$01780000)
; A-2: $C268 is scene-init-stable; stage the live value each frame, translated
; once here so SH2 extract_033 dereferences it with NO further translation.
        move.l  ($FFFFC268).w,d0                ; track_seg_base (68K CPU addr)
        add.l   #$01780000,d0                   ; -> SH2 ROM addr (68K-$880000+$02000000)
        move.l  d0,(a1)+                        ; +$3A
; +$3E/$3F (2 bytes) spare in the staged window
        clr.w   (a1)+                           ; +$3E

        movem.l (sp)+,d0/a0-a1                  ; restore regs
        rts
