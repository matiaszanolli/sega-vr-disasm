; ============================================================================
; gfx_2_player_entity_frame_orch — 2-Player Entity Frame Orchestrator
; ROM Range: $006496-$00659C (262 bytes)
; Updates both player viewports in 2-player mode. Processes player 1
; (obj_table_1 at -24832) and player 2 (obj_table_2 at -28672) entity
; updates, copies object tables between viewports using 32x32-byte MOVEM
; transfers, and runs render/state subroutines for each.
;
; Entry: Called from 2-player race frame loop
; Uses: D0-D7, A0, A1, A2, A3, A4
; RAM: $9F00 obj_table_3
; Object fields: +$18 position, +$8A param, +$B2 stored_pos, +$E5 flags
; Confidence: high
; ============================================================================

gfx_2_player_entity_frame_orch:
        LEA     (-24576).W,A4                   ; $006496
        LEA     (-24832).W,A0                   ; $00649A
        MOVE.B  (-336).W,(-15601).W             ; $00649E
        jsr     object_bitmask_table_lookup+40(pc); $4EBA $0718
        MOVE.L  $00B2(A0),$0018(A0)             ; $0064A8
        MOVE.B  $00E5(A0),D1                    ; $0064AE
        ANDI.B  #$06,D1                         ; $0064B2
        BEQ.S  .loc_0028                        ; $0064B6
        MOVE.L  (-14580).W,$0018(A0)            ; $0064B8
.loc_0028:
        MOVE.W  (-16262).W,D0                   ; $0064BE
        lea     entity_render_pipeline_jump_table(pc),a1; $43FA $00D8
        MOVEA.L $00(A1,D0.W),A1                 ; $0064C6
        JSR     (A1)                            ; $0064CA
        jsr     timer_decrement_and_rank_check_guard(pc); $4EBA $398C
        jsr     object_heading_deviation_check_warning_flag(pc); $4EBA $1A2A
        jsr     object_spawn_counter_table_setup+20(pc); $4EBA $1F04
        jsr     race_pos_comparison_with_sound_triggers(pc); $4EBA $2308
        LEA     (-24832).W,A0                   ; $0064DC
        LEA     (-28672).W,A1                   ; $0064E0
        jsr     proximity_zone_simple(pc); $4EBA $218C
        LEA     (-31972).W,A1                   ; $0064E8
        jsr     heading_broadcast(pc)   ; $4EBA $2BE0
        LEA     (-28672).W,A0                   ; $0064F0
        jsr     timer_decrement_and_rank_check_guard(pc); $4EBA $3964
        jsr     object_collision_detection(pc); $4EBA $4A1E
        LEA     (-24832).W,A0                   ; $0064FC
        MOVE.W  #$0000,$008A(A0)                ; $006500
        DC.W    $4EBA,$3CF4         ; JSR     $00A1FC(PC); $006506
        jsr     obj_distance_calc(pc)   ; $4EBA $10F2
        jsr     framebuffer_setup(pc)   ; $4EBA $0D60
        jsr     object_render_disp+84(pc); $4EBA $C6F0
        jsr     lap_check_disp(pc)      ; $4EBA $CE62
        jsr     object_table_3_proximity_with_animation(pc); $4EBA $D60C
        jsr     render_slot_setup+44(pc); $4EBA $DA3A
        MOVE.B  (-15612).W,(-15604).W           ; $006522
        jsr     object_bitmask_table_button_flag_handler+32(pc); $4EBA $06C0
        LEA     (-16384).W,A2                   ; $00652C
        LEA     (-18432).W,A1                   ; $006530
        MOVEQ   #$1F,D7                         ; $006534
.loc_00A0:
        MOVEM.L (A2)+,D0/D1/D2/D3/D4/D5/D6/A3   ; $006536
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,-(A1)   ; $00653A
        DBRA    D7,.loc_00A0                    ; $00653E
        MOVE.L  (-13960).W,(-13968).W           ; $006542
        LEA     (-20480).W,A1                   ; $006548
        LEA     (-15360).W,A2                   ; $00654C
        MOVEQ   #$1F,D7                         ; $006550
.loc_00BC:
        MOVEM.L (A1)+,D0/D1/D2/D3/D4/D5/D6/A3   ; $006552
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,-(A2)   ; $006556
        DBRA    D7,.loc_00BC                    ; $00655A
        LEA     (-28672).W,A0                   ; $00655E
        LEA     (-24832).W,A1                   ; $006562
        jsr     dual_time_display_orch+52(pc); $4EBA $1EB0
        jsr     race_start_countdown_sequence(pc); $4EBA $3954
        MOVE.W  #$0000,$008A(A0)                ; $00656E
        DC.W    $4EBA,$3C86         ; JSR     $00A1FC(PC); $006574
        jsr     obj_distance_calc(pc)   ; $4EBA $1084
        jsr     vdp_nametable_setup_display_list_build+24(pc); $4EBA $0CE2
        jsr     object_render_disp(pc)  ; $4EBA $C62E
        jsr     lap_check_disp(pc)      ; $4EBA $CDF4
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $D22C
        jsr     render_slot_setup(pc)   ; $4EBA $D9A0
        MOVE.B  (-15612).W,(-15604).W           ; $006590
        jsr     object_bitmask_table_button_flag_handler+32(pc); $4EBA $0652
        RTS                                     ; $00659A
