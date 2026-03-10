; ============================================================================
; track_boundary_collision_detection — Track Boundary Collision Detection
; ROM Range: $00789C-$007A40 (420 bytes)
; Probes 4 points around entity for track boundary collisions. For each
; probe: computes position with offset, calls tile_position_calc to find
; road segment, checks if segment matches current tile (angle_normalize),
; tests collision via velocity_apply, and stores result in entity fields
; +$55 through +$59. Final combined collision flag written to +$55.
;
; Entry: A0 = entity base pointer, A4 = scratch buffer pointer
; Uses: D0, D1, D2, A0, A1, A2, A3, A4
; Object fields: +$30 x_position, +$34 y_position, +$40 heading,
;   +$46 scale, +$55-$59 collision flags per probe,
;   +$CE/+$D2/+$D6/+$DA tile data pointers
; Confidence: high
; ============================================================================

track_boundary_collision_detection:
        MOVE.B  #$00,(-15590).W                 ; $00789C
        MOVE.W  $0040(A0),D0                    ; $0078A2
        ADD.W  $0046(A0),D0                     ; $0078A6
        jsr     track_data_extract_033(pc); $4EBA $FDF6
        MOVE.W  $0030(A0),D1                    ; $0078AE
        MOVE.W  $0034(A0),D2                    ; $0078B2
        jsr     track_data_index_calc_table_lookup(pc); $4EBA $FB30
        MOVE.L  A1,(A4)                         ; $0078BA
        jsr     angle_normalize(pc)     ; $4EBA $FBCE
        BNE.S  .center_hit                        ; $0078C0
        MOVE.L  #$00000000,(A4)                 ; $0078C2
        MOVE.L  #$00000000,$0004(A4)            ; $0078C8
        BRA.S  .probe_1                        ; $0078D0
.center_hit:
        MOVE.L  A2,$0004(A4)                    ; $0078D2
        MOVE.L  A2,$00CE(A0)                    ; $0078D6
        MOVE.B  $0018(A2),D0                    ; $0078DA
        MOVE.B  D0,(-15591).W                   ; $0078DE
        MOVE.W  D1,(-16176).W                   ; $0078E2
        MOVE.W  D2,(-16174).W                   ; $0078E6
.probe_1:
        MOVE.W  $0030(A0),D1                    ; $0078EA
        ADD.W  (-16338).W,D1                    ; $0078EE
        MOVE.W  $0034(A0),D2                    ; $0078F2
        ADD.W  (-16334).W,D2                    ; $0078F6
        MOVE.B  #$01,$0056(A0)                  ; $0078FA
        jsr     track_data_index_calc_table_lookup(pc); $4EBA $FAE6
        MOVE.L  (A4),D0                         ; $007904
        BEQ.S  .probe_1_new_tile                        ; $007906
        CMPA.L  D0,A1                           ; $007908
        BNE.S  .probe_1_new_tile                        ; $00790A
        MOVEA.L A1,A3                           ; $00790C
        MOVEA.L $0004(A4),A1                    ; $00790E
        jsr     angle_normalize+168(pc) ; $4EBA $FC20
        BNE.S  .probe_1_collision                        ; $007916
        MOVEA.L A3,A1                           ; $007918
        jsr     angle_normalize+24(pc)  ; $4EBA $FB88
        BRA.S  .probe_1_check_result                        ; $00791E
.probe_1_new_tile:
        jsr     angle_normalize(pc)     ; $4EBA $FB6A
.probe_1_check_result:
        BEQ.S  .probe_2                        ; $007924
.probe_1_collision:
        MOVE.L  A2,$00D2(A0)                    ; $007926
        MOVE.W  D1,(-16172).W                   ; $00792A
        MOVE.W  D2,(-16170).W                   ; $00792E
        jsr     object_type_dispatch(pc); $4EBA $010C
        MOVE.B  D0,$0056(A0)                    ; $007936
.probe_2:
        MOVE.W  $0030(A0),D1                    ; $00793A
        ADD.W  (-16332).W,D1                    ; $00793E
        MOVE.W  $0034(A0),D2                    ; $007942
        ADD.W  (-16328).W,D2                    ; $007946
        MOVE.B  #$01,$0057(A0)                  ; $00794A
        jsr     track_data_index_calc_table_lookup(pc); $4EBA $FA96
        MOVE.L  (A4),D0                         ; $007954
        BEQ.S  .probe_2_new_tile                        ; $007956
        CMPA.L  D0,A1                           ; $007958
        BNE.S  .probe_2_new_tile                        ; $00795A
        MOVEA.L A1,A3                           ; $00795C
        MOVEA.L $0004(A4),A1                    ; $00795E
        jsr     angle_normalize+168(pc) ; $4EBA $FBD0
        BNE.S  .probe_2_collision                        ; $007966
        MOVEA.L A3,A1                           ; $007968
        jsr     angle_normalize+24(pc)  ; $4EBA $FB38
        BRA.S  .probe_2_check_result                        ; $00796E
.probe_2_new_tile:
        jsr     angle_normalize(pc)     ; $4EBA $FB1A
.probe_2_check_result:
        BEQ.S  .probe_3                        ; $007974
.probe_2_collision:
        MOVE.L  A2,$00D6(A0)                    ; $007976
        MOVE.W  D1,(-16168).W                   ; $00797A
        MOVE.W  D2,(-16166).W                   ; $00797E
        jsr     object_type_dispatch(pc); $4EBA $00BC
        MOVE.B  D0,$0057(A0)                    ; $007986
.probe_3:
        MOVE.W  $0030(A0),D1                    ; $00798A
        ADD.W  (-16326).W,D1                    ; $00798E
        MOVE.W  $0034(A0),D2                    ; $007992
        ADD.W  (-16322).W,D2                    ; $007996
        MOVE.B  #$01,$0058(A0)                  ; $00799A
        jsr     track_data_index_calc_table_lookup(pc); $4EBA $FA46
        MOVE.L  (A4),D0                         ; $0079A4
        BEQ.S  .probe_3_new_tile                        ; $0079A6
        CMPA.L  D0,A1                           ; $0079A8
        BNE.S  .probe_3_new_tile                        ; $0079AA
        MOVEA.L A1,A3                           ; $0079AC
        MOVEA.L $0004(A4),A1                    ; $0079AE
        jsr     angle_normalize+168(pc) ; $4EBA $FB80
        BNE.S  .probe_3_collision                        ; $0079B6
        MOVEA.L A3,A1                           ; $0079B8
        jsr     angle_normalize+24(pc)  ; $4EBA $FAE8
        BRA.S  .probe_3_check_result                        ; $0079BE
.probe_3_new_tile:
        jsr     angle_normalize(pc)     ; $4EBA $FACA
.probe_3_check_result:
        BEQ.S  .probe_4                        ; $0079C4
.probe_3_collision:
        MOVE.L  A2,$00DA(A0)                    ; $0079C6
        MOVE.W  D1,(-16164).W                   ; $0079CA
        MOVE.W  D2,(-16162).W                   ; $0079CE
        jsr     object_type_dispatch(pc); $4EBA $006C
        MOVE.B  D0,$0058(A0)                    ; $0079D6
.probe_4:
        MOVE.W  $0030(A0),D1                    ; $0079DA
        ADD.W  (-16320).W,D1                    ; $0079DE
        MOVE.W  $0034(A0),D2                    ; $0079E2
        ADD.W  (-16316).W,D2                    ; $0079E6
        MOVE.B  #$01,$0059(A0)                  ; $0079EA
        jsr     track_data_index_calc_table_lookup(pc); $4EBA $F9F6
        MOVE.L  (A4),D0                         ; $0079F4
        BEQ.S  .probe_4_new_tile                        ; $0079F6
        CMPA.L  D0,A1                           ; $0079F8
        BNE.S  .probe_4_new_tile                        ; $0079FA
        MOVEA.L A1,A3                           ; $0079FC
        MOVEA.L $0004(A4),A1                    ; $0079FE
        jsr     angle_normalize+168(pc) ; $4EBA $FB30
        BNE.S  .probe_4_collision                        ; $007A06
        MOVEA.L A3,A1                           ; $007A08
        jsr     angle_normalize+24(pc)  ; $4EBA $FA98
        BRA.S  .probe_4_check_result                        ; $007A0E
.probe_4_new_tile:
        jsr     angle_normalize(pc)     ; $4EBA $FA7A
.probe_4_check_result:
        BEQ.S  .combine_flags                        ; $007A14
.probe_4_collision:
        MOVE.L  A2,$00DE(A0)                    ; $007A16
        MOVE.W  D1,(-16160).W                   ; $007A1A
        MOVE.W  D2,(-16158).W                   ; $007A1E
        jsr     object_type_dispatch(pc); $4EBA $001C
        MOVE.B  D0,$0059(A0)                    ; $007A26
.combine_flags:
        MOVE.B  $0056(A0),D0                    ; $007A2A
        OR.B   $0057(A0),D0                     ; $007A2E
        OR.B   $0058(A0),D0                     ; $007A32
        OR.B   $0059(A0),D0                     ; $007A36
        MOVE.B  D0,$0055(A0)                    ; $007A3A
        RTS                                     ; $007A3E
