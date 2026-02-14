; ============================================================================
; race_scene_init_004d98 — Race Scene Initialization (2-Player)
; ROM Range: $004D98-$005020 (648 bytes)
; Initializes a 2-player split-screen race scene. Similar to 1-player init
; but sets COMM1_HI=$04 (2-player mode flag), sets bit 4 of race options,
; clears bit 7 of flags(-600), and copies 32x32-byte blocks between object
; tables for the second player viewport. Sets main loop entry at $005024.
;
; Entry: Called as scene init orchestrator
; Uses: D0-D7, A0, A1, A2, A5
; MARS: adapter_ctrl, COMM0, COMM1, VDP_MODE, SYS_INTCTL
; RAM: $9F00 obj_table_3, $C87E game_state, $C8A0 race_state,
;      $C8AA scene_state, $C8C8 vint_state, $C8CC race_substate
; Confidence: high
; ============================================================================

race_scene_init_004d98:
        MOVE    #$2700,SR                       ; $004D98
        BCLR    #6,(-14219).W                   ; $004D9C
        MOVE.W  (-14220).W,(A5)                 ; $004DA2
        MOVE.W  #$0083,MARS_SYS_INTCTL                ; $004DA6
        ANDI.B  #$FC,MARS_VDP_MODE+1                  ; $004DAE
        jsr     mars_framebuffer_preparation(pc); $4EBA $D952
        MOVE.B  #$01,(-14323).W                 ; $004DBA
        MOVE.B  #$00,(-14322).W                 ; $004DC0
        ORI.B  #$10,(-14322).W                  ; $004DC6
        BCLR    #7,(-600).W                     ; $004DCC
        MOVEQ   #$00,D0                         ; $004DD2
        MOVEQ   #$00,D1                         ; $004DD4
        MOVE.B  (-341).W,D0                     ; $004DD6
        MOVE.B  (-333).W,D1                     ; $004DDA
        JSR     $0088D19C                       ; $004DDE
        MOVE.B  #$04,COMM1_HI                  ; $004DE4
        MOVE.W  #$0103,(-14168).W               ; $004DEC
        MOVE.B  (-14167).W,COMM0_LO            ; $004DF2
        MOVE.B  (-14168).W,COMM0_HI            ; $004DFA
        MOVE.B  #$01,(-14321).W                 ; $004E02
        MOVE.W  #$0040,(-14148).W               ; $004E08
        JSR     $0088D1D4                       ; $004E0E
        JSR     $0088D42C                       ; $004E14
        LEA     $008BA220,A0                    ; $004E1A
        MOVE.W  (-14176).W,D0                   ; $004E20
        MOVEA.L $00(A0,D0.W),A2                 ; $004E24
        jsr     palette_copy_full(pc)   ; $4EBA $DA22
        LEA     $008BAE38,A0                    ; $004E2C
        MOVE.W  (-14132).W,D0                   ; $004E32
        MOVEA.L $00(A0,D0.W),A2                 ; $004E36
        jsr     palette_copy_partial(pc); $4EBA $DA26
        MOVE.W  #$0010,$00FF0008                ; $004E3E
        MOVE.W  #$0000,(-14166).W               ; $004E46
        jsr     input_clear_both(pc)    ; $4EBA $FB5C
        jsr     scene_init_sh2_buffer_clear_loop(pc); $4EBA $7F40
        MOVEQ   #$10,D0                         ; $004E54
        jsr     scene_camera_init(pc)   ; $4EBA $7E1C
        jsr     track_graphics_and_sound_loader+174(pc); $4EBA $7A14
        jsr     vdp_reg_table_init_multi_entry_loader(pc); $4EBA $7B80
        TST.B  (-337).W                         ; $004E62
        BEQ.S  .loc_00D4                        ; $004E66
        jsr     vdp_slot_activation_config_b(pc); $4EBA $7BFC
.loc_00D4:
        TST.B  (-336).W                         ; $004E6C
        BEQ.S  .loc_00DE                        ; $004E70
        jsr     vdp_slot_activation_config_c(pc); $4EBA $7C0C
.loc_00DE:
        JSR     $0088D450                       ; $004E76
        JSR     $0088D08A                       ; $004E7C
        jsr     race_track_overlay_config+164(pc); $4EBA $7CBA
        jsr     scene_camera_init+20(pc); $4EBA $7E00
        LEA     (-24832).W,A0                   ; $004E8A
        jsr     scene_camera_init+30(pc); $4EBA $7E02
        MOVEQ   #$30,D0                         ; $004E92
        JSR     $0088CE02                       ; $004E94
        MOVE.B  (-336).W,(-15601).W             ; $004E9A
        jsr     track_physics_param_table_loader+144(pc); $4EBA $52A2
        LEA     (-24832).W,A0                   ; $004EA4
        DC.W    $4EBA,$5352         ; JSR     $00A1FC(PC); $004EA8
        jsr     scene_dispatch_track_data_setup+12(pc); $4EBA $7A44
        JSR     $0088CFD6                       ; $004EB0
        JSR     $0088CE76                       ; $004EB6
        JSR     $0088CECC                       ; $004EBC
        MOVE.B  #$00,(-15596).W                 ; $004EC2
        BTST    #1,(-14312).W                   ; $004EC8
        BEQ.S  .loc_013E                        ; $004ECE
        MOVE.B  #$01,(-15596).W                 ; $004ED0
.loc_013E:
        LEA     (-16384).W,A2                   ; $004ED6
        LEA     (-18432).W,A1                   ; $004EDA
        MOVEQ   #$1F,D7                         ; $004EDE
.loc_0148:
        MOVEM.L (A2)+,D0/D1/D2/D3/D4/D5/D6/A3   ; $004EE0
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,-(A1)   ; $004EE4
        DBRA    D7,.loc_0148                    ; $004EE8
        MOVE.B  #$00,(-15596).W                 ; $004EEC
        BTST    #0,(-14312).W                   ; $004EF2
        BEQ.S  .loc_0168                        ; $004EF8
        MOVE.B  #$01,(-15596).W                 ; $004EFA
.loc_0168:
        MOVE.B  (-337).W,(-15601).W             ; $004F00
        jsr     track_physics_param_table_loader+144(pc); $4EBA $523C
        LEA     (-28672).W,A0                   ; $004F0A
        DC.W    $4EBA,$52EC         ; JSR     $00A1FC(PC); $004F0E
        JSR     $0088CEC2                       ; $004F12
        MOVE.W  #$0000,(-14210).W               ; $004F18
        BSET    #4,(-14322).W                   ; $004F1E
        jsr     entity_render_pipeline_with_vdp_dma_2p_copy+462(pc); $4EBA $14E8
        jsr     gfx_2_player_entity_frame_orch(pc); $4EBA $156C
        ANDI.B  #$FC,MARS_VDP_MODE+1                  ; $004F2C
        ORI.B  #$01,MARS_VDP_MODE+1                   ; $004F34
        MOVE.W  #$8083,MARS_SYS_INTCTL                ; $004F3C
        jsr     clear_communication_state_variables(pc); $4EBA $D104
        jsr     sound_command_dispatch_sound_driver_call+70(pc); $4EBA $D17C
        BSET    #6,(-14219).W                   ; $004F4C
        MOVE.W  (-14220).W,(A5)                 ; $004F52
        JSR     $00884998                       ; $004F56
        MOVE.W  (-14136).W,D0                   ; $004F5C
        MOVE.W  #$0000,(-30832).W               ; $004F60
        lea     state_disp_004cb8(pc),a1; $43FA $FD50
        BTST    #0,(-14325).W                   ; $004F6A
        BNE.S  .loc_01E0                        ; $004F70
        MOVE.B  $00(A1,D0.W),(-14171).W         ; $004F72
.loc_01E0:
        JSR     $00882080                       ; $004F78
        JSR     $00884998                       ; $004F7E
        MOVE.W  (-14136).W,D0                   ; $004F84
        MOVE.W  #$0000,(-30880).W               ; $004F88
        lea     state_disp_005020(pc),a1; $43FA $0090
        BTST    #0,(-14325).W                   ; $004F92
        BNE.S  .loc_0208                        ; $004F98
        MOVE.B  $00(A1,D0.W),(-14171).W         ; $004F9A
.loc_0208:
        JSR     $00882080                       ; $004FA0
        JSR     $00884998                       ; $004FA6
        DC.W    $4EBA,$D240         ; JSR     $0021EE(PC); $004FAC
        MOVE.W  (-14176).W,D0                   ; $004FB0
        LEA     $008BB1C4,A0                    ; $004FB4
        MOVE.L  $00(A0,D0.W),(-13972).W         ; $004FBA
        MOVE.B  #$01,(-14327).W                 ; $004FC0
        MOVE.B  #$02,(-14326).W                 ; $004FC6
        BSET    #6,(-14322).W                   ; $004FCC
        MOVE.B  #$01,(-14334).W                 ; $004FD2
        BTST    #7,(-600).W                     ; $004FD8
        BEQ.S  .loc_0250                        ; $004FDE
        MOVE.B  #$01,$00FF60D4                  ; $004FE0
.loc_0250:
        BTST    #0,COMM1_LO                    ; $004FE8
        BEQ.S  .loc_0250                        ; $004FF0
        BCLR    #0,COMM1_LO                    ; $004FF2
        MOVE.W  #$0104,(-14168).W               ; $004FFA
        MOVE.L  #$00885024,$00FF0002            ; $005000
        MOVE.L  #$00000000,$00FF5FF8            ; $00500A
        MOVE.L  #$00000000,$00FF5FFC            ; $005014
        RTS                                     ; $00501E
