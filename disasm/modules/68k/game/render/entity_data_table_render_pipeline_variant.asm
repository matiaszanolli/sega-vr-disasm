; ============================================================================
; entity_data_table_render_pipeline_variant — Entity Data Table + Render Pipeline Variant
; ROM Range: $005DC8-$005E38 (112 bytes)
; ROM address lookup table (3 longword entries) followed by a render pipeline
; variant. The pipeline clears display offsets (+$44/+$46/+$4A) and calls
; 17 subroutines for angle computation, screen coordinate mapping, palette
; update, display mode, buffer operations, and overlay rendering.
;
; Entry: A0 = entity base pointer
; Uses: D0, A0, A2, A6
; Object fields: +$44 display_offset, +$46 display_scale, +$4A display_aux,
;   +$88 animation data
; Confidence: high
; ============================================================================

entity_data_table_render_pipeline_variant:
        DC.W    $0088                           ; $005DC8
        DC.W    $3C7E                           ; $005DCA
        DC.W    $0088                           ; $005DCC
        MOVE.W  (A2)+,$0088(A6)                 ; $005DCE
        MOVE.W  (A2)+,$0088(A6)                 ; $005DD2
        MOVE.W  (A2)+,$0088(A6)                 ; $005DD6
        MOVE.W  (A2)+,$0088(A6)                 ; $005DDA
        MOVE.W  (A2)+,$4EBA(A6)                 ; $005DDE
        DC.W    $EBC8                           ; $005DE2
        jsr     camera_state_selector+12(pc); $4EBA $5996
        MOVEQ   #$00,D0                         ; $005DE8
        MOVE.W  D0,$0044(A0)                    ; $005DEA
        MOVE.W  D0,$0046(A0)                    ; $005DEE
        MOVE.W  D0,$004A(A0)                    ; $005DF2
        jsr     angle_to_sine(pc)       ; $4EBA $12B2
        jsr     object_link_copy_table_lookup(pc); $4EBA $134E
        jsr     rotational_offset_calc(pc); $4EBA $184E
        jsr     position_threshold_check(pc); $4EBA $214C
        jsr     race_pos_sorting_and_rank_assignment+50(pc); $4EBA $3EC6
        jsr     proximity_zone_multi+54(pc); $4EBA $28F2
        jsr     heading_from_position(pc); $4EBA $3230
        DC.W    $4EBA,$23C4         ; JSR     $0081D8(PC); $005E12
        jsr     display_state_disp_004084(pc); $4EBA $E26C
        jsr     obj_distance_calc(pc)   ; $4EBA $17E2
        jsr     object_visibility_collector(pc); $4EBA $1386
        jsr     camera_param_calc(pc)   ; $4EBA $CB60
        jsr     object_state_disp_0031a6(pc); $4EBA $D37E
        jsr     object_table_sprite_param_update(pc); $4EBA $D8B2
        jsr     object_proximity_check_jump_table_dispatch(pc); $4EBA $D986
        jsr     camera_offset_clamping(pc); $4EBA $D292
        RTS                                     ; $005E36
