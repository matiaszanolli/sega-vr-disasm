; ============================================================================
; race_scene_init_004a32 — Race Scene Initialization (1-Player)
; ROM Range: $004A32-$004C8A (600 bytes)
; Initializes a 1-player race scene. Disables interrupts, configures MARS
; adapter control and VDP mode, loads track/car data, sets up rendering
; pipelines, object tables, and SH2 communication. Waits for SH2 handshake
; via COMM1 bit 0, then sets main loop entry at $004CBC.
;
; Entry: Called as scene init orchestrator
; Uses: D0, D1, A0, A1, A2, A5
; MARS: adapter_ctrl, COMM0, COMM1, VDP_MODE, SYS_INTCTL
; RAM: $C87E game_state, $C89C sh2_comm_state, $C8A0 race_state,
;      $C8AA scene_state, $C8C8 vint_state, $C8CC race_substate
; Confidence: high
; ============================================================================

race_scene_init_004a32:
        MOVEQ   #$00,D1                         ; $004A32
        LEA     $00FF7B80,A1                    ; $004A34
        jmp     quad_memory_fill+8(pc)  ; $4EFA $FE02
        MOVE    #$2700,SR                       ; $004A3E
        BCLR    #6,(-14219).W                   ; $004A42
        MOVE.W  (-14220).W,(A5)                 ; $004A48
        MOVE.W  #$0083,MARS_SYS_INTCTL                ; $004A4C
        ANDI.B  #$FC,MARS_VDP_MODE+1                  ; $004A54
        jsr     mars_framebuffer_preparation(pc); $4EBA $DCAC
        MOVE.B  #$01,(-14323).W                 ; $004A60
        ANDI.B  #$09,(-14322).W                 ; $004A66
        MOVEQ   #$00,D0                         ; $004A6C
        MOVEQ   #$00,D1                         ; $004A6E
        MOVE.B  (-347).W,D0                     ; $004A70
        MOVE.B  (-335).W,D1                     ; $004A74
        BTST    #7,(-600).W                     ; $004A78
        BEQ.S  .loc_0052                        ; $004A7E
        MOVE.B  (-346).W,D0                     ; $004A80
.loc_0052:
        JSR     $0088D19C                       ; $004A84
        MOVE.B  (-14135).W,D0                   ; $004A8A
        ADDQ.B  #1,D0                           ; $004A8E
        MOVE.B  D0,COMM1_HI                    ; $004A90
        MOVE.W  #$0103,(-14168).W               ; $004A96
        MOVE.B  (-14167).W,COMM0_LO            ; $004A9C
        MOVE.B  (-14168).W,COMM0_HI            ; $004AA4
        MOVE.B  #$00,(-14321).W                 ; $004AAC
        MOVE.W  #$0000,(-14148).W               ; $004AB2
        JSR     $0088D1D4                       ; $004AB8
        JSR     $0088D42C                       ; $004ABE
        LEA     $008BA220,A0                    ; $004AC4
        MOVE.W  (-14176).W,D0                   ; $004ACA
        MOVEA.L $00(A0,D0.W),A2                 ; $004ACE
        jsr     palette_copy_full(pc)   ; $4EBA $DD78
        LEA     $008BAE38,A0                    ; $004AD6
        MOVE.W  (-14132).W,D0                   ; $004ADC
        MOVEA.L $00(A0,D0.W),A2                 ; $004AE0
        jsr     palette_copy_partial(pc); $4EBA $DD7C
        MOVE.W  #$0010,$00FF0008                ; $004AE8
        MOVE.W  #$0000,(-14166).W               ; $004AF0
        jsr     input_clear_both(pc)    ; $4EBA $FEB2
        JSR     $0088CD92                       ; $004AFA
        MOVE.B  #$00,(-15596).W                 ; $004B00
        BTST    #0,(-14312).W                   ; $004B06
        BEQ.S  .loc_00E2                        ; $004B0C
        MOVE.B  #$01,(-15596).W                 ; $004B0E
.loc_00E2:
        MOVEQ   #$00,D0                         ; $004B14
        JSR     $0088CC74                       ; $004B16
        jsr     track_graphics_and_sound_loader+174(pc); $4EBA $7D52
        jsr     vdp_reg_table_copy(pc)  ; $4EBA $7E94
        TST.B  (-343).W                         ; $004B24
        BEQ.S  .loc_00FC                        ; $004B28
        jsr     vdp_slot_activation_config_a(pc); $4EBA $7F20
.loc_00FC:
        BTST    #7,(-600).W                     ; $004B2E
        BEQ.S  .loc_010E                        ; $004B34
        MOVE.L  #$0403131C,$00FF69B4            ; $004B36
.loc_010E:
        JSR     $0088D054                       ; $004B40
        JSR     $0088CA9A                       ; $004B46
        MOVE.B  #$05,(-15600).W                 ; $004B4C
        JSR     $0088CC88                       ; $004B52
        MOVEQ   #$18,D0                         ; $004B58
        MOVEQ   #-$01,D1                        ; $004B5A
        TST.W  (-14180).W                       ; $004B5C
        BEQ.S  .loc_0132                        ; $004B60
        MOVEQ   #$00,D1                         ; $004B62
.loc_0132:
        JSR     $0088CDD2                       ; $004B64
        JSR     $0088CD4C                       ; $004B6A
        jsr     entity_table_load_mode(pc); $4EBA $5C98
        jsr     track_physics_param_table_loader+144(pc); $4EBA $55CE
        LEA     (-28672).W,A0                   ; $004B78
        DC.W    $4EBA,$567E         ; JSR     $00A1FC(PC); $004B7C
        jsr     scene_dispatch_track_data_setup+142(pc); $4EBA $7DF2
        JSR     $0088CF0C                       ; $004B84
        JSR     $0088CC06                       ; $004B8A
        JSR     $0088CFAE                       ; $004B90
        MOVE.W  #$0000,(-14210).W               ; $004B96
        MOVE.W  #$C9A0,(-14144).W               ; $004B9C
        MOVE.B  #$02,(-14326).W                 ; $004BA2
        BTST    #3,(-14322).W                   ; $004BA8
        BEQ.S  .loc_0184                        ; $004BAE
        JSR     $0088D0F6                       ; $004BB0
.loc_0184:
        jsr     sh2_handler_dispatch_scene_init+98(pc); $4EBA $0D10
        jsr     sh2_comm_check_cond_guard(pc); $4EBA $0D4C
        jsr     race_entity_update_loop(pc); $4EBA $0D7C
        ANDI.B  #$FC,MARS_VDP_MODE+1                  ; $004BC2
        ORI.B  #$01,MARS_VDP_MODE+1                   ; $004BCA
        MOVE.W  #$8083,MARS_SYS_INTCTL                ; $004BD2
        jsr     clear_communication_state_variables(pc); $4EBA $D46E
        jsr     sound_command_dispatch_sound_driver_call+70(pc); $4EBA $D4E6
        BSET    #6,(-14219).W                   ; $004BE2
        MOVE.W  (-14220).W,(A5)                 ; $004BE8
        jsr     wait_for_vblank(pc)     ; $4EBA $FDAA
        MOVE.W  (-14176).W,D0                   ; $004BF0
        LEA     $008BB1C4,A0                    ; $004BF4
        MOVE.L  $00(A0,D0.W),(-13972).W         ; $004BFA
        MOVE.B  #$01,(-14327).W                 ; $004C00
        BSET    #6,(-14322).W                   ; $004C06
        MOVE.B  #$01,(-14334).W                 ; $004C0C
        BTST    #7,(-600).W                     ; $004C12
        BEQ.S  .loc_01F0                        ; $004C18
        MOVE.B  #$01,$00FF60D4                  ; $004C1A
.loc_01F0:
        BTST    #0,COMM1_LO                    ; $004C22
        BEQ.S  .loc_01F0                        ; $004C2A
        BCLR    #0,COMM1_LO                    ; $004C2C
        MOVE.W  #$0102,(-14168).W               ; $004C34
        BTST    #3,(-14322).W                   ; $004C3A
        DC.W    $6648               ; BNE.S  $004C8A; $004C40
        MOVE.W  (-14136).W,D0                   ; $004C42
        MOVE.W  #$0000,(-30832).W               ; $004C46
        lea     state_disp_004cb8(pc),a1; $43FA $006A
        BTST    #0,(-14325).W                   ; $004C50
        BNE.S  .loc_022C                        ; $004C56
        MOVE.B  $00(A1,D0.W),(-14171).W         ; $004C58
.loc_022C:
        jsr     sound_command_dispatch_sound_driver_call(pc); $4EBA $D420
        jsr     wait_for_vblank(pc)     ; $4EBA $FD34
        DC.W    $4EBA,$D586         ; JSR     $0021EE(PC); $004C66
        MOVE.L  #$00884CBC,$00FF0002            ; $004C6A
        MOVE.L  #$00000000,$00FF5FF8            ; $004C74
        MOVE.L  #$00000000,$00FF5FFC            ; $004C7E
        RTS                                     ; $004C88
