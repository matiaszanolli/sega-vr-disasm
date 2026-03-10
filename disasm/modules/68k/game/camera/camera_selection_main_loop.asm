; ============================================================================
; camera_selection_main_loop — Camera Selection Main Loop
; ROM Range: $012CC2-$012F0A (584 bytes)
; ============================================================================
; Per-frame update for the camera selection screen. Handles:
;   1. DMA transfer, object_update, sprite_update
;   2. Render main camera view ($06038000) and overlay ($0603DE80)
;   3. Camera selection via D-pad up/down (cycles through 6 cameras,
;      with skip logic for locked camera positions via bit 3 of $C958)
;   4. Optional replay mode toggle via left/right (with smooth scrolling)
;   5. Confirm selection (A button → state $0002), cancel (Start → exit)
;   6. State machine: browsing ($0000), confirming ($0001/$0002)
;
; Uses: D0, D1, D2, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; ============================================================================

camera_selection_main_loop:
        CLR.W  D0                               ; $012CC2
        bsr.w   MemoryInit              ; $6100 $B866
        jsr     object_update(pc)       ; $4EBA $89BA
        jsr     animated_seq_player+10(pc); $4EBA $8A0C
        JSR     $0088179E                       ; $012CD0
        TST.W  (-24518).W                       ; $012CD6
        BNE.W  .render_main_view                ; $012CDA
        TST.B  (-14309).W                       ; $012CDE
        BNE.W  .confirm_mode                    ; $012CE2
        MOVE.B  (-24551).W,D0                   ; $012CE6
        MOVE.W  (-14228).W,D1                   ; $012CEA
        TST.L  (-24540).W                       ; $012CEE
        BNE.W  .store_cam_index                 ; $012CF2
        BTST    #3,D1                           ; $012CF6
        BEQ.S  .check_down                      ; $012CFA
        MOVE.B  #$A9,(-14172).W                 ; $012CFC
        TST.B  (-600).W                         ; $012D02
        BEQ.S  .no_replay_up                    ; $012D06
        CMPI.B  #$05,D0                         ; $012D08
        BLT.S  .next_cam_up                     ; $012D0C
        CLR.B  D0                               ; $012D0E
        MOVE.L  #$00000004,(-24540).W           ; $012D10
        MOVE.W  #$0037,(-24536).W               ; $012D18
        BRA.W  .store_cam_index                 ; $012D1E
.next_cam_up:
        ADDQ.B  #1,D0                           ; $012D22
        BTST    #3,(-14312).W                   ; $012D24
        BEQ.S  .skip_locked_up                  ; $012D2A
        CMPI.B  #$02,D0                         ; $012D2C
        BNE.S  .skip_locked_up                  ; $012D30
        MOVE.B  #$03,D0                         ; $012D32
.skip_locked_up:
        CMPI.B  #$05,D0                         ; $012D36
        BNE.W  .store_cam_index                 ; $012D3A
        MOVE.L  #$FFFFFFFC,(-24540).W           ; $012D3E
        MOVE.W  #$0037,(-24536).W               ; $012D46
        BRA.W  .store_cam_index                 ; $012D4C
.no_replay_up:
        CMPI.B  #$04,D0                         ; $012D50
        BLT.S  .next_cam_up_no_replay           ; $012D54
        CLR.B  D0                               ; $012D56
        BRA.W  .store_cam_index                 ; $012D58
.next_cam_up_no_replay:
        ADDQ.B  #1,D0                           ; $012D5C
        BTST    #3,(-14312).W                   ; $012D5E
        BEQ.S  .skip_locked_up_no_replay        ; $012D64
        CMPI.B  #$02,D0                         ; $012D66
        BNE.S  .skip_locked_up_no_replay        ; $012D6A
        MOVE.B  #$03,D0                         ; $012D6C
.skip_locked_up_no_replay:
        BRA.W  .store_cam_index                 ; $012D70
.check_down:
        BTST    #2,D1                           ; $012D74
        BEQ.W  .store_cam_index                 ; $012D78
        MOVE.B  #$A9,(-14172).W                 ; $012D7C
        TST.B  D0                               ; $012D82
        BGT.S  .prev_cam_down                   ; $012D84
        MOVE.B  #$04,D0                         ; $012D86
        TST.B  (-600).W                         ; $012D8A
        BEQ.W  .store_cam_index                 ; $012D8E
        MOVE.B  #$05,D0                         ; $012D92
        MOVE.L  #$FFFFFFFC,(-24540).W           ; $012D96
        MOVE.W  #$0037,(-24536).W               ; $012D9E
        BRA.W  .store_cam_index                 ; $012DA4
.prev_cam_down:
        SUBQ.B  #1,D0                           ; $012DA8
        BTST    #3,(-14312).W                   ; $012DAA
        BEQ.S  .skip_locked_down                ; $012DB0
        CMPI.B  #$02,D0                         ; $012DB2
        BNE.S  .skip_locked_down                ; $012DB6
        MOVE.B  #$01,D0                         ; $012DB8
.skip_locked_down:
        TST.B  (-600).W                         ; $012DBC
        BEQ.W  .store_cam_index                 ; $012DC0
        CMPI.B  #$04,D0                         ; $012DC4
        BNE.W  .store_cam_index                 ; $012DC8
        MOVE.L  #$00000004,(-24540).W           ; $012DCC
        MOVE.W  #$0037,(-24536).W               ; $012DD4
        BRA.W  .store_cam_index                 ; $012DDA
.confirm_mode:
        MOVE.B  (-24551).W,D0                   ; $012DDE
        MOVE.W  (-14226).W,D1                   ; $012DE2
        BTST    #3,D1                           ; $012DE6
        BNE.S  .toggle_confirm                  ; $012DEA
        BTST    #2,D1                           ; $012DEC
        BNE.S  .toggle_confirm                  ; $012DF0
        BRA.W  .store_cam_index                 ; $012DF2
.toggle_confirm:
        MOVE.B  #$A9,(-14172).W                 ; $012DF6
        CMPI.B  #$02,D0                         ; $012DFC
        BEQ.S  .set_cam_4                       ; $012E00
        MOVE.B  #$02,D0                         ; $012E02
        BRA.W  .store_cam_index                 ; $012E06
.set_cam_4:
        MOVE.B  #$04,D0                         ; $012E0A
.store_cam_index:
        MOVE.B  D0,(-24551).W                   ; $012E0E
.render_main_view:
        MOVEA.L #$06038000,A0                   ; $012E12
        MOVEA.L #$04014000,A1                   ; $012E18
        ADDA.L  (-24544).W,A1                   ; $012E1E
        MOVE.W  #$0150,D0                       ; $012E22
        MOVE.W  #$0048,D1                       ; $012E26
        DC.W    $4EBA,$B52E         ; JSR     $00E35A(PC); $012E2A
        TST.L  (-24540).W                       ; $012E2E
        BNE.W  .render_overlay                  ; $012E32
.wait_comm_ready:
        TST.B  COMM0_HI                        ; $012E36
        BNE.S  .wait_comm_ready                 ; $012E3C
        bsr.w   camera_sh2_command_27_dispatch+28; $6100 $0132
.render_overlay:
        MOVEA.L #$0603DE80,A0                   ; $012E42
        MOVEA.L #$04004C60,A1                   ; $012E48
        MOVE.W  #$0080,D0                       ; $012E4E
        MOVE.W  #$0010,D1                       ; $012E52
        DC.W    $4EBA,$B502         ; JSR     $00E35A(PC); $012E56
.wait_comm_ready_2:
        TST.B  COMM0_HI                        ; $012E5A
        BNE.S  .wait_comm_ready_2               ; $012E60
        TST.L  (-24540).W                       ; $012E62
        BNE.W  .no_action_buttons               ; $012E66
        CMPI.W  #$0001,(-24518).W               ; $012E6A
        BEQ.W  .wait_anim_phase1                ; $012E70
        CMPI.W  #$0002,(-24518).W               ; $012E74
        BEQ.W  .wait_anim_phase2                ; $012E7A
        MOVE.W  (-14228).W,D1                   ; $012E7E
        TST.B  (-14309).W                       ; $012E82
        BEQ.W  .get_buttons                     ; $012E86
        MOVE.W  (-14226).W,D1                   ; $012E8A
.get_buttons:
        MOVE.W  D1,D2                           ; $012E8E
        ANDI.B  #$E0,D2                         ; $012E90
        BNE.S  .check_start                     ; $012E94
.no_action_buttons:
        SUBQ.W  #8,(-14210).W                   ; $012E96
        BRA.W  .frame_end                       ; $012E9A
.check_start:
        BTST    #0,D1                           ; $012E9E
        BEQ.S  .setup_confirm                   ; $012EA2
        BSET    #0,(-14325).W                   ; $012EA4
.setup_confirm:
        MOVE.B  #$A8,(-14172).W                 ; $012EAA
        MOVE.B  #$01,(-14327).W                 ; $012EB0
        MOVE.B  #$01,(-14326).W                 ; $012EB6
        BSET    #7,(-14322).W                   ; $012EBC
        MOVE.B  #$01,(-14334).W                 ; $012EC2
        MOVE.W  #$0002,(-24518).W               ; $012EC8
        BRA.W  .scroll_left                     ; $012ECE
.wait_anim_phase1:
        BTST    #6,(-14322).W                   ; $012ED2
        BNE.S  .scroll_left                     ; $012ED8
        CLR.W  (-24518).W                       ; $012EDA
        BRA.W  .scroll_left                     ; $012EDE
.wait_anim_phase2:
        BTST    #7,(-14322).W                   ; $012EE2
        BNE.S  .scroll_left                     ; $012EE8
        CLR.W  (-24518).W                       ; $012EEA
        ADDQ.W  #4,(-14210).W                   ; $012EEE
        BRA.W  .frame_end                       ; $012EF2
.scroll_left:
        SUBQ.W  #8,(-14210).W                   ; $012EF6
.frame_end:
        MOVE.W  #$0018,$00FF0008                ; $012EFA
        MOVE.B  #$01,(-14303).W                 ; $012F02
        RTS                                     ; $012F08
