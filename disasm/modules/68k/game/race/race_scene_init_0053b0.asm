; ============================================================================
; race_scene_init_0053b0 — Race Scene Initialization (Free Run)
; ROM Range: $0053B0-$005586 (470 bytes)
; Initializes a Free Run / Time Attack race scene. Allocates 7 object slots,
; clamps track index to <=5, sends sound command $9B, sets COMM mode $0105.
; Includes additional calls for timer and replay setup. Sets main loop
; entry at $005586.
;
; Entry: Called as scene init orchestrator
; Uses: D0, D1, A0, A2, A5
; MARS: adapter_ctrl, COMM0, COMM1, VDP_MODE, SYS_INTCTL
; RAM: $C87E game_state, $C8A0 race_state, $C8AA scene_state,
;      $C8CC race_substate
; Confidence: high
; ============================================================================

race_scene_init_0053b0:
        MOVE    #$2700,SR                       ; $0053B0
        BCLR    #6,(-14219).W                   ; $0053B4
        MOVE.W  (-14220).W,(A5)                 ; $0053BA
        MOVE.W  #$0083,MARS_SYS_INTCTL                ; $0053BE
        ANDI.B  #$FC,MARS_VDP_MODE+1                  ; $0053C6
        jsr     mars_framebuffer_preparation(pc); $4EBA $D33A
        MOVEQ   #$07,D0                         ; $0053D2
        JSR     $008814BE                       ; $0053D4
        MOVEQ   #$00,D1                         ; $0053DA
        MOVE.B  (-330).W,D0                     ; $0053DC
        CMPI.B  #$05,D0                         ; $0053E0
        BCS.S  .loc_0038                        ; $0053E4
        MOVEQ   #$00,D0                         ; $0053E6
.loc_0038:
        MOVE.B  (-331).W,D1                     ; $0053E8
        MOVE.B  #$01,(-14323).W                 ; $0053EC
        jsr     game_mode_track_config(pc); $4EBA $7DA8
        MOVE.B  (-14135).W,D0                   ; $0053F6
        ADDQ.B  #1,D0                           ; $0053FA
        MOVE.B  D0,COMM1_HI                    ; $0053FC
        MOVE.W  #$0103,(-14168).W               ; $005402
        MOVE.B  (-14167).W,COMM0_LO            ; $005408
        MOVE.B  (-14168).W,COMM0_HI            ; $005410
        MOVE.B  #$00,(-14321).W                 ; $005418
        MOVE.W  #$0000,(-14148).W               ; $00541E
        JSR     $0088D1D4                       ; $005424
        JSR     $0088D42C                       ; $00542A
        LEA     $008BA220,A0                    ; $005430
        MOVE.W  (-14176).W,D0                   ; $005436
        MOVEA.L $00(A0,D0.W),A2                 ; $00543A
        jsr     palette_copy_full(pc)   ; $4EBA $D40C
        LEA     $008BAE38,A0                    ; $005442
        MOVE.W  (-14132).W,D0                   ; $005448
        MOVEA.L $00(A0,D0.W),A2                 ; $00544C
        jsr     palette_copy_partial(pc); $4EBA $D410
        MOVE.W  #$0010,$00FF0008                ; $005454
        MOVE.W  #$0000,(-14166).W               ; $00545C
        MOVE.W  #$0000,(-16256).W               ; $005462
        jsr     input_clear_both(pc)    ; $4EBA $F540
        jsr     scene_init_sh2_buffer_clear_loop(pc); $4EBA $7924
        MOVE.B  #$00,(-15596).W                 ; $005470
        BTST    #0,(-14312).W                   ; $005476
        BEQ.S  .loc_00D4                        ; $00547C
        MOVE.B  #$01,(-15596).W                 ; $00547E
.loc_00D4:
        MOVEQ   #$00,D0                         ; $005484
        jsr     scene_camera_init(pc)   ; $4EBA $77EC
        jsr     track_graphics_and_sound_loader+174(pc); $4EBA $73E4
        jsr     vdp_load_table_d(pc)    ; $4EBA $7580
        jsr     scene_camera_init+20(pc); $4EBA $77F4
        jsr     scene_menu_init_and_input_handler(pc); $4EBA $65C6
        MOVEQ   #$00,D0                         ; $00549A
        MOVEQ   #$00,D1                         ; $00549C
        jsr     object_entry_loader_loop_table_lookup(pc); $4EBA $7932
        jsr     object_table_init_entry_array(pc); $4EBA $78A8
        jsr     entity_table_load(pc)   ; $4EBA $533A
        jsr     track_physics_param_table_loader+144(pc); $4EBA $4C98
        LEA     (-28672).W,A0                   ; $0054AE
        DC.W    $4EBA,$4D48         ; JSR     $00A1FC(PC); $0054B2
        jsr     scene_dispatch_track_data_setup+142(pc); $4EBA $74BC
        jsr     entity_heading_and_turn_rate_calculator+30(pc); $4EBA $7A50
        jsr     object_array_init_rom_tables(pc); $4EBA $7746
        jsr     entity_heading_and_turn_rate_calculator+192(pc); $4EBA $7AEA
        DC.W    $4EBA,$77AA         ; JSR     $00CC72(PC); $0054C6
        MOVE.W  #$0090,$00FF60CC                ; $0054CA
        MOVE.W  #$0000,(-14210).W               ; $0054D2
        jsr     sh2_handler_dispatch_scene_init+98(pc); $4EBA $03EE
        jsr     sh2_comm_check_cond_guard(pc); $4EBA $042A
        jsr     race_entity_update_loop(pc); $4EBA $045A
        ANDI.B  #$FC,MARS_VDP_MODE+1                  ; $0054E4
        ORI.B  #$01,MARS_VDP_MODE+1                   ; $0054EC
        MOVE.W  #$8083,MARS_SYS_INTCTL                ; $0054F4
        jsr     clear_communication_state_variables(pc); $4EBA $CB4C
        jsr     sound_command_dispatch_sound_driver_call+70(pc); $4EBA $CBC4
        BSET    #6,(-14219).W                   ; $005504
        MOVE.W  (-14220).W,(A5)                 ; $00550A
        JSR     $00884998                       ; $00550E
        MOVE.W  (-14176).W,D0                   ; $005514
        LEA     $008BB1C4,A0                    ; $005518
        MOVE.L  $00(A0,D0.W),(-13972).W         ; $00551E
        MOVE.B  #$01,(-14327).W                 ; $005524
        MOVE.B  #$02,(-14326).W                 ; $00552A
        BSET    #6,(-14322).W                   ; $005530
        MOVE.B  #$01,(-14334).W                 ; $005536
.loc_018C:
        BTST    #0,COMM1_LO                    ; $00553C
        BEQ.S  .loc_018C                        ; $005544
        BCLR    #0,COMM1_LO                    ; $005546
        MOVE.B  #$9B,(-14171).W                 ; $00554E
        JSR     $00882080                       ; $005554
        JSR     $00884998                       ; $00555A
        MOVE.W  #$0105,(-14168).W               ; $005560
        MOVE.L  #$00885586,$00FF0002            ; $005566
        MOVE.L  #$00000000,$00FF5FF8            ; $005570
        MOVE.L  #$00000000,$00FF5FFC            ; $00557A
        RTS                                     ; $005584
