; ============================================================================
; Scene Camera Init
; ROM Range: $00CC74-$00CD4C (216 bytes)
; ============================================================================
; Category: game
; Purpose: Initializes camera/scene for race start. First entry copies ROM
;   segment data to $C08C via segment_copy. Main body sets up object A0
;   with animation params, loads track and road segment data from ROM
;   tables indexed by sh2_comm_state ($C89C), configures camera scale/
;   repeat/zoom fields, sets initial frame countdown ($001E), and adjusts
;   scene_timer based on race mode (vint_state $C8C8).
;
; Entry: D0 = ROM table offset (first entry only)
;        A0 = object/entity pointer (main entry)
; Uses: D0, A0, A1, A2
; RAM:
;   $C048: camera_state (word, set to 1)
;   $C05A: camera_state_end (word, set to $FFFF)
;   $C07A: camera_target_x (word)
;   $C086: camera_flags (word, cleared)
;   $C08C: camera_segment_buffer
;   $C094: camera_source_x (word, copied to $C07A)
;   $C0AC: frame_countdown (word, set to $001E)
;   $C0E4: camera_viewport_size (word, set to $0040)
;   $C268: road_segment_ptr (longword)
;   $C302: animation_speed (byte, set to $04)
;   $C311: animation_index (byte, cleared)
;   $C700: track_data_buffer
;   $C819: scene_active (byte, cleared)
;   $C824: scene_timer (byte, $14 or $1E)
;   $C89C: sh2_comm_state (word, ×$14 for track table)
;   $C8C8: vint_state (word, race mode check)
;   $C8CC: race_substate (word, indexes road segment table)
;   $C8E4: road_data_buffer
;   $FEA9: system_flags (byte)
; ROM tables:
;   $008997EC: camera_segment_rom_table (indexed by D0)
;   $00898A04: track_param_table (stride $14, indexed by sh2_comm_state)
;   $00930612: road_segment_ptr_table (longword, indexed by race_substate)
;   $009305D6: road_data_table (longword, indexed by race_substate)
; Calls:
;   $00884922: segment_copy_to_buffer (JMP/JSR target)
; Object fields:
;   +$18: base_position (longword)
;   +$2A: repeat_count (word, set to 1)
;   +$76: scale_x (word, set to $0100)
;   +$78: scale_y (word, set to $0100)
;   +$A4: zoom_frames (word, set to $000F)
;   +$A6: zoom_step (word, set to 1)
;   +$AC: zoom_rate (word, set to 3)
;   +$B2: base_position_copy (longword)
; ============================================================================

scene_camera_init:
; --- first entry: copy segment data to $C08C ---
        lea     $008997EC,A1                    ; $00CC74  camera_segment_rom_table
        lea     $00(A1,D0.W),A1                 ; $00CC7A  index by D0
        lea     ($FFFFC08C).w,A2                    ; $00CC7E  camera_segment_buffer
        jmp     $00884922                       ; $00CC82  segment_copy_to_buffer
; --- main entry: scene camera setup ---
        move.b  ($FFFFFEA9).w,($FFFFC30F).w             ; $00CC88  system_flags → animation_state
        lea     ($FFFF9000).w,A0                    ; $00CC8E  object base
        move.b  #$00,($FFFFC819).w                  ; $00CC92  scene_active = 0
        move.w  ($FFFFC094).w,($FFFFC07A).w             ; $00CC98  camera_source_x → camera_target_x
        move.b  #$00,($FFFFC311).w                  ; $00CC9E  animation_index = 0
        move.w  #$0001,($FFFFC048).w                ; $00CCA4  camera_state = 1
        move.b  #$04,($FFFFC302).w                  ; $00CCAA  animation_speed = 4
        move.w  #$0000,($FFFFC086).w                ; $00CCB0  camera_flags = 0
        move.w  #$0040,($FFFFC0E4).w                ; $00CCB6  camera_viewport_size = 64
; --- load track params from sh2_comm_state ---
        lea     $00898A04,A1                    ; $00CCBC  track_param_table
        move.w  ($FFFFC89C).w,D0                    ; $00CCC2  sh2_comm_state
        mulu    #$0014,D0                       ; $00CCC6  stride = 20 bytes
        adda.l  D0,A1                           ; $00CCCA  A1 = track entry
        lea     ($FFFFC700).w,A2                    ; $00CCCC  track_data_buffer
        jsr     $00884922                       ; $00CCD0  segment_copy_to_buffer
; --- copy base position to object ---
        move.l  (A1),$0018(A0)                  ; $00CCD6  base_position
        move.l  (A1),$00B2(A0)                  ; $00CCDA  base_position_copy
; --- load road segment pointer ---
        lea     $00930612,A1                    ; $00CCDE  road_segment_ptr_table
        move.w  ($FFFFC8CC).w,D0                    ; $00CCE4  race_substate
        movea.l $00(A1,D0.W),A1                 ; $00CCE8  road segment ptr
        move.l  A1,($FFFFC268).w                    ; $00CCEC  road_segment_ptr
; --- load road data ---
        lea     $009305D6,A1                    ; $00CCF0  road_data_table
        movea.l $00(A1,D0.W),A1                 ; $00CCF6  road data ptr
        lea     ($FFFFC8E4).w,A2                    ; $00CCFA  road_data_buffer
        jsr     $00884922                       ; $00CCFE  segment_copy_to_buffer
; --- set camera animation params ---
        move.w  #$0001,$002A(A0)                ; $00CD04  repeat_count = 1
        move.w  #$0001,$00A6(A0)                ; $00CD0A  zoom_step = 1
        move.w  #$000F,$00A4(A0)                ; $00CD10  zoom_frames = 15
        move.w  #$0003,$00AC(A0)                ; $00CD16  zoom_rate = 3
        move.w  #$0100,$0076(A0)                ; $00CD1C  scale_x = 256 (1.0)
        move.w  #$0100,$0078(A0)                ; $00CD22  scale_y = 256 (1.0)
        moveq   #$00,D0                         ; $00CD28
; --- frame countdown + scene timer ---
        move.w  #$001E,($FFFFC0AC).w                ; $00CD2A  frame_countdown = 30
        move.b  #$14,($FFFFC824).w                  ; $00CD30  scene_timer = 20
        cmpi.w  #$0001,($FFFFC8C8).w                ; $00CD36  vint_state == 1 (time attack)?
        bne.s   .done                           ; $00CD3C
        move.b  #$1E,($FFFFC824).w                  ; $00CD3E  scene_timer = 30 (longer for time attack)
.done:
        move.w  #$FFFF,($FFFFC05A).w                ; $00CD44  camera_state_end = $FFFF
        rts                                     ; $00CD4A
