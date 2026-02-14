; ============================================================================
; race_scene_init_005100 — Race Scene Initialization (Grand Prix)
; ROM Range: $005100-$005308 (520 bytes)
; Initializes a Grand Prix race scene. Sets bit 5 ($20) of race options for
; GP mode, uses track index from (-345), configures extended object tables,
; and additional subsystem initialization. Sets main loop entry at $005308.
;
; Entry: Called as scene init orchestrator
; Uses: D0, D1, A0, A1, A2, A5
; MARS: adapter_ctrl, COMM0, COMM1, VDP_MODE, SYS_INTCTL
; RAM: $C87E game_state, $C8A0 race_state, $C8AA scene_state,
;      $C8C8 vint_state, $C8CC race_substate
; Confidence: high
; ============================================================================

race_scene_init_005100:
        MOVE    #$2700,SR                       ; $005100
        BCLR    #6,(-14219).W                   ; $005104
        MOVE.W  (-14220).W,(A5)                 ; $00510A
        MOVE.W  #$0083,MARS_SYS_INTCTL                ; $00510E
        ANDI.B  #$FC,MARS_VDP_MODE+1                  ; $005116
        jsr     mars_framebuffer_preparation(pc); $4EBA $D5EA
        MOVE.B  #$01,(-14323).W                 ; $005122
        MOVE.B  #$00,(-14322).W                 ; $005128
        ORI.B  #$20,(-14322).W                  ; $00512E
        BCLR    #7,(-600).W                     ; $005134
        MOVEQ   #$00,D0                         ; $00513A
        MOVEQ   #$00,D1                         ; $00513C
        MOVE.B  (-345).W,D0                     ; $00513E
        MOVE.B  (-334).W,D1                     ; $005142
        JSR     $0088D19C                       ; $005146
        MOVE.B  (-14135).W,D0                   ; $00514C
        ADDQ.B  #1,D0                           ; $005150
        MOVE.B  D0,COMM1_HI                    ; $005152
        MOVE.W  #$0103,(-14168).W               ; $005158
        MOVE.B  (-14167).W,COMM0_LO            ; $00515E
        MOVE.B  (-14168).W,COMM0_HI            ; $005166
        MOVE.B  #$00,(-14321).W                 ; $00516E
        MOVE.W  #$0000,(-14148).W               ; $005174
        JSR     $0088D1D4                       ; $00517A
        JSR     $0088D42C                       ; $005180
        LEA     $008BA220,A0                    ; $005186
        MOVE.W  (-14176).W,D0                   ; $00518C
        MOVEA.L $00(A0,D0.W),A2                 ; $005190
        jsr     palette_copy_full(pc)   ; $4EBA $D6B6
        LEA     $008BAE38,A0                    ; $005198
        MOVE.W  (-14132).W,D0                   ; $00519E
        MOVEA.L $00(A0,D0.W),A2                 ; $0051A2
        jsr     palette_copy_partial(pc); $4EBA $D6BA
        MOVE.W  #$0010,$00FF0008                ; $0051AA
        MOVE.W  #$0000,(-14166).W               ; $0051B2
        jsr     input_clear_both(pc)    ; $4EBA $F7F0
        jsr     scene_init_sh2_buffer_clear_loop(pc); $4EBA $7BD4
        MOVE.B  #$00,(-15596).W                 ; $0051C0
        BTST    #0,(-14312).W                   ; $0051C6
        BEQ.S  .loc_00D4                        ; $0051CC
        MOVE.B  #$01,(-15596).W                 ; $0051CE
.loc_00D4:
        MOVEQ   #$10,D0                         ; $0051D4
        jsr     scene_camera_init(pc)   ; $4EBA $7A9C
        jsr     track_graphics_and_sound_loader+174(pc); $4EBA $7694
        jsr     vdp_load_table_c(pc)    ; $4EBA $7820
        jsr     race_sprite_table_init+66(pc); $4EBA $7EE8
        TST.B  (-342).W                         ; $0051E6
        BEQ.S  .loc_00F0                        ; $0051EA
        jsr     vdp_slot_activation_config_a(pc); $4EBA $785E
.loc_00F0:
        JSR     $0088D450                       ; $0051F0
        JSR     $0088D054                       ; $0051F6
        jsr     race_track_overlay_config+6(pc); $4EBA $78A2
        MOVE.B  (-14310).W,(-15600).W           ; $005200
        jsr     scene_camera_init+20(pc); $4EBA $7A80
        MOVEQ   #$18,D0                         ; $00520A
        MOVEQ   #$00,D1                         ; $00520C
        jsr     object_entry_data_copy(pc); $4EBA $7C12
        MOVE.B  (-342).W,(-15601).W             ; $005212
        jsr     track_physics_param_table_loader+144(pc); $4EBA $4F2A
        LEA     (-28672).W,A0                   ; $00521C
        DC.W    $4EBA,$4FDA         ; JSR     $00A1FC(PC); $005220
        jsr     scene_dispatch_track_data_setup+142(pc); $4EBA $774E
        jsr     entity_heading_and_turn_rate_calculator+192(pc); $4EBA $7D84
        MOVE.B  #$00,(-14311).W                 ; $00522C
        MOVE.W  #$0000,(-14146).W               ; $005232
        MOVE.W  #$0000,(-14210).W               ; $005238
        jsr     entity_render_pipeline_with_2_player_dispatch+198(pc); $4EBA $1600
        ANDI.B  #$FC,MARS_VDP_MODE+1                  ; $005242
        ORI.B  #$01,MARS_VDP_MODE+1                   ; $00524A
        MOVE.W  #$8083,MARS_SYS_INTCTL                ; $005252
        jsr     clear_communication_state_variables(pc); $4EBA $CDEE
        jsr     sound_command_dispatch_sound_driver_call+70(pc); $4EBA $CE66
        BSET    #6,(-14219).W                   ; $005262
        MOVE.W  (-14220).W,(A5)                 ; $005268
        JSR     $00884998                       ; $00526C
        MOVE.W  (-14136).W,D0                   ; $005272
        lea     state_disp_004cb8(pc),a1; $43FA $FA40
        BTST    #0,(-14325).W                   ; $00527A
        BNE.S  .loc_0188                        ; $005280
        MOVE.B  $00(A1,D0.W),(-14171).W         ; $005282
.loc_0188:
        JSR     $00882080                       ; $005288
        JSR     $00884998                       ; $00528E
        DC.W    $4EBA,$CF58         ; JSR     $0021EE(PC); $005294
        MOVE.W  (-14176).W,D0                   ; $005298
        LEA     $008BB1C4,A0                    ; $00529C
        MOVE.L  $00(A0,D0.W),(-13972).W         ; $0052A2
        MOVE.B  #$01,(-14327).W                 ; $0052A8
        MOVE.B  #$02,(-14326).W                 ; $0052AE
        BSET    #6,(-14322).W                   ; $0052B4
        MOVE.B  #$01,(-14334).W                 ; $0052BA
        BTST    #7,(-600).W                     ; $0052C0
        BEQ.S  .loc_01D0                        ; $0052C6
        MOVE.B  #$01,$00FF60D4                  ; $0052C8
.loc_01D0:
        BTST    #0,COMM1_LO                    ; $0052D0
        BEQ.S  .loc_01D0                        ; $0052D8
        BCLR    #0,COMM1_LO                    ; $0052DA
        MOVE.W  #$0102,(-14168).W               ; $0052E2
        MOVE.L  #$00885308,$00FF0002            ; $0052E8
        MOVE.L  #$00000000,$00FF5FF8            ; $0052F2
        MOVE.L  #$00000000,$00FF5FFC            ; $0052FC
        RTS                                     ; $005306
