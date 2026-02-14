; ============================================================================
; Scene Orchestrator (5 Subroutines + Controller Decode, 2 Entry Points)
; ROM Range: $00C390-$00C416 (134 bytes)
; ============================================================================
; Category: game
; Purpose: Entry 1 ($C390): calls init ($21CA), poll_controllers ($179E),
;   increments frame_counter ($C080) and scene_state, decodes controller
;   byte from RAM pointer ($C8C0) to AI flags ($C971/$C973), calls
;   sprite handlers, object/sprite_update, increments scene_counter,
;   advances state, writes $38 to SH2 COMM, calls 3 handlers, tail-jumps
;   to $C662. Entry 2 ($C3FC): calls init, poll_controllers, increments
;   scene_counter, writes $38, returns.
;
; Uses: D0, D1, A0
; RAM:
;   $C080: frame_counter (word)
;   $C87E: state_dispatch_idx (word)
;   $C8C0: controller_ptr (word)
;   $C886: scene_counter (byte)
;   $C8AA: scene_state (word)
;   $C970: work_param (longword)
;   $C971: ai_input_flags (byte)
;   $C973: ai_direction_flags (byte)
; Calls:
;   $00179E: poll_controllers
;   $0021CA: init handler
;   $0024CA: scene handler
;   $00593C: sprite_state_process
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00C070: handler A
;   $00C416: handler B
;   $00C5AE: handler C
; ============================================================================

scene_orch:
; --- entry 1: full orchestrator ---
        jsr     $008821CA                       ; $00C390  init handler
        jsr     $0088179E                       ; $00C396  poll_controllers
        addq.w  #1,($FFFFC080).w                ; $00C39C  frame_counter++
        addq.w  #1,($FFFFC8AA).w                ; $00C3A0  scene_state++
        move.l  #$FFFF0000,($FFFFC970).w        ; $00C3A4  clear work param
        movea.w ($FFFFC8C0).w,A0                ; $00C3AC  A0 = controller_ptr
        move.b  (A0)+,D0                        ; $00C3B0  D0 = controller byte
        move.b  D0,D1                           ; $00C3B2  D1 = copy
        andi.b  #$5C,D0                         ; $00C3B4  extract bits 2,3,4,6
        move.b  D0,($FFFFC971).w                ; $00C3B8  ai_input_flags
        andi.b  #$03,D1                         ; $00C3BC  extract bits 0-1
        move.b  D1,($FFFFC973).w                ; $00C3C0  ai_direction_flags
        move.w  A0,($FFFFC8C0).w                ; $00C3C4  advance controller_ptr
        jsr     $0088593C                       ; $00C3C8  sprite_state_process
        jsr     $008824CA                       ; $00C3CE  scene handler
        jsr     animated_seq_player+10(pc); $4EBA $F304
        jsr     object_update(pc)       ; $4EBA $F2AA
        addq.b  #1,($FFFFC886).w                ; $00C3DC  scene_counter++
        addq.w  #4,($FFFFC87E).w                ; $00C3E0  advance state
        move.w  #$0038,$00FF0008                ; $00C3E4  SH2 COMM = $38
        jsr     scene_dispatch(pc)      ; $4EBA $0028
        jsr     countdown_timer_setup_race_start_init(pc); $4EBA $01BC
        jsr     display_list_builder+20(pc); $4EBA $FC7A
        jmp     scene_state_disp_race_init_phases(pc); $4EFA $0268
; --- entry 2: reduced orchestrator ---
        jsr     $008821CA                       ; $00C3FC  init handler
        jsr     $0088179E                       ; $00C402  poll_controllers
        addq.b  #1,($FFFFC886).w                ; $00C408  scene_counter++
        move.w  #$0038,$00FF0008                ; $00C40C  SH2 COMM = $38
        rts                                     ; $00C414

