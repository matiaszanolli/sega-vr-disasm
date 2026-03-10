; ============================================================================
; sh2_multi_panel_tile_renderer — SH2 Multi-Panel Tile Renderer
; ROM Range: $00F8F6-$00FB24 (558 bytes)
; Data prefix (32 bytes: default palette color data, same as
; default_palette_color_data). Renders tile overlays to SH2 framebuffer via
; sh2_cmd_27 for up to 3 screen panels. Computes tile addresses
; from palette index with bit-shift multiplication. Panel 1 renders
; main view, panel 2 renders comparison view (optional), panel 3
; renders stats overlay. Two identical rendering blocks handle
; P1 and P2 viewports.
;
; Uses: D0, D1, D2, A0, A1
; Calls: $00E3B4 (sh2_cmd_27)
; Confidence: high
; ============================================================================

sh2_multi_panel_tile_renderer:
        DC.W    $0EEE                           ; $00F8F6
        DC.W    $0EEE                           ; $00F8F8
        DC.W    $0EEE                           ; $00F8FA
        DC.W    $0EEE                           ; $00F8FC
        ORI.B  #$00,D0                          ; $00F8FE
        ORI.B  #$00,D0                          ; $00F902
        DC.W    $0EEE                           ; $00F906
        DC.W    $0EEE                           ; $00F908
        DC.W    $0EEE                           ; $00F90A
        DC.W    $0EEE                           ; $00F90C
        ORI.B  #$00,D0                          ; $00F90E
        ORI.B  #$00,D0                          ; $00F912
        MOVEQ   #$00,D0                         ; $00F916
        TST.B  (-24549).W                       ; $00F918
        BNE.S  .p1_multi_panel_index             ; $00F91C
        MOVE.B  (-24551).W,D0                   ; $00F91E
        BRA.S  .p1_lookup_tile                   ; $00F922
.p1_multi_panel_index:
        MOVE.B  (-24545).W,D0                   ; $00F924
.p1_lookup_tile:
        LEA     $0088FB24,A1                    ; $00F928
        ADD.W  D0,D0                           ; $00F92E
        MOVE.W  D0,D1                           ; $00F930
        ADD.W  D0,D0                           ; $00F932
        ADD.W  D1,D0                           ; $00F934
        MOVEA.L $00(A1,D0.W),A0                 ; $00F936
        MOVE.W  $04(A1,D0.W),D0                 ; $00F93A
        MOVE.W  #$0030,D1                       ; $00F93E
        MOVE.W  #$0010,D2                       ; $00F942
        jsr     sh2_cmd_27(pc)          ; $4EBA $EA6C
        MOVEQ   #$00,D0                         ; $00F94A
        CMPI.B  #$01,(-24549).W                 ; $00F94C
        BNE.S  .p1_not_2panel                    ; $00F952
        MOVEA.L #$04012024,A0                   ; $00F954
        MOVE.W  #$0060,D0                       ; $00F95A
        MOVE.W  #$0010,D1                       ; $00F95E
        MOVE.W  #$0010,D2                       ; $00F962
.p1_wait_panel2:
        TST.B  COMM0_HI                        ; $00F966
        BNE.S  .p1_wait_panel2                  ; $00F96C
        jsr     sh2_cmd_27(pc)          ; $4EBA $EA44
        MOVE.B  (-24551).W,D0                   ; $00F972
        BRA.S  .p1_render_comparison             ; $00F976
.p1_not_2panel:
        MOVE.B  (-24544).W,D0                   ; $00F978
.p1_render_comparison:
        MOVEA.L #$04014014,A0                   ; $00F97C
        TST.B  D0                               ; $00F982
        BNE.S  .p1_comparison_nonzero            ; $00F984
        MOVE.W  #$0048,D0                       ; $00F986
        BRA.S  .p1_comparison_params_ready       ; $00F98A
.p1_comparison_nonzero:
        ADDA.L  #$00000047,A0                   ; $00F98C
        MOVE.W  #$0039,D0                       ; $00F992
.p1_comparison_params_ready:
        MOVE.W  #$0010,D1                       ; $00F996
        MOVE.W  #$0010,D2                       ; $00F99A
.p1_wait_comparison:
        TST.B  COMM0_HI                        ; $00F99E
        BNE.S  .p1_wait_comparison               ; $00F9A4
        jsr     sh2_cmd_27(pc)          ; $4EBA $EA0C
        MOVEQ   #$00,D0                         ; $00F9AA
        CMPI.B  #$02,(-24549).W                 ; $00F9AC
        BNE.S  .p1_not_3panel                    ; $00F9B2
        MOVEA.L #$04017030,A0                   ; $00F9B4
        MOVE.W  #$0048,D0                       ; $00F9BA
        MOVE.W  #$0010,D1                       ; $00F9BE
        MOVE.W  #$0010,D2                       ; $00F9C2
.p1_wait_panel3a:
        TST.B  COMM0_HI                        ; $00F9C6
        BNE.S  .p1_wait_panel3a                 ; $00F9CC
        jsr     sh2_cmd_27(pc)          ; $4EBA $E9E4
        MOVEA.L #$04019018,A0                   ; $00F9D2
        MOVE.W  #$0078,D0                       ; $00F9D8
        MOVE.W  #$0010,D1                       ; $00F9DC
        MOVE.W  #$0010,D2                       ; $00F9E0
.p1_wait_panel3b:
        TST.B  COMM0_HI                        ; $00F9E4
        BNE.S  .p1_wait_panel3b                 ; $00F9EA
        jsr     sh2_cmd_27(pc)          ; $4EBA $E9C6
        MOVE.B  (-24551).W,D0                   ; $00F9F0
        BRA.S  .p1_stats_overlay                 ; $00F9F4
.p1_not_3panel:
        MOVE.B  (-24543).W,D0                   ; $00F9F6
.p1_stats_overlay:
        MOVE.B  D0,D2                           ; $00F9FA
        MOVEA.L #$0401B018,A0                   ; $00F9FC
        ADD.W  D0,D0                           ; $00FA02
        ADD.W  D0,D0                           ; $00FA04
        ADD.W  D0,D0                           ; $00FA06
        MOVE.W  D0,D1                           ; $00FA08
        ADD.W  D0,D0                           ; $00FA0A
        ADD.W  D1,D0                           ; $00FA0C
        LEA     $00(A0,D0.W),A0                 ; $00FA0E
        MOVE.W  #$0018,D0                       ; $00FA12
        TST.B  D2                               ; $00FA16
        BEQ.W  .p1_stats_params_ready            ; $00FA18
        SUBQ.L  #1,A0                           ; $00FA1C
        MOVE.W  #$0019,D0                       ; $00FA1E
.p1_stats_params_ready:
        MOVE.W  #$0010,D1                       ; $00FA22
        MOVE.W  #$0010,D2                       ; $00FA26
.p1_wait_stats:
        TST.B  COMM0_HI                        ; $00FA2A
        BNE.S  .p1_wait_stats                   ; $00FA30
        jsr     sh2_cmd_27(pc)          ; $4EBA $E980
        MOVEQ   #$00,D0                         ; $00FA36
        CMPI.B  #$01,(-24548).W                 ; $00FA38
        BNE.S  .p2_not_2panel                    ; $00FA3E
        MOVEA.L #$040120BC,A0                   ; $00FA40
        MOVE.W  #$0060,D0                       ; $00FA46
        MOVE.W  #$0010,D1                       ; $00FA4A
        MOVE.W  #$0010,D2                       ; $00FA4E
.p2_wait_panel2:
        TST.B  COMM0_HI                        ; $00FA52
        BNE.S  .p2_wait_panel2                  ; $00FA58
        jsr     sh2_cmd_27(pc)          ; $4EBA $E958
        MOVE.B  (-24550).W,D0                   ; $00FA5E
        BRA.S  .p2_render_comparison             ; $00FA62
.p2_not_2panel:
        MOVE.B  (-24542).W,D0                   ; $00FA64
.p2_render_comparison:
        MOVEA.L #$040140AC,A0                   ; $00FA68
        TST.B  D0                               ; $00FA6E
        BNE.S  .p2_comparison_nonzero            ; $00FA70
        MOVE.W  #$0048,D0                       ; $00FA72
        BRA.S  .p2_comparison_params_ready       ; $00FA76
.p2_comparison_nonzero:
        ADDA.L  #$00000047,A0                   ; $00FA78
        MOVE.W  #$0039,D0                       ; $00FA7E
.p2_comparison_params_ready:
        MOVE.W  #$0010,D1                       ; $00FA82
        MOVE.W  #$0010,D2                       ; $00FA86
.p2_wait_comparison:
        TST.B  COMM0_HI                        ; $00FA8A
        BNE.S  .p2_wait_comparison               ; $00FA90
        jsr     sh2_cmd_27(pc)          ; $4EBA $E920
        MOVEQ   #$00,D0                         ; $00FA96
        CMPI.B  #$02,(-24548).W                 ; $00FA98
        BNE.S  .p2_not_3panel                    ; $00FA9E
        MOVEA.L #$040170C8,A0                   ; $00FAA0
        MOVE.W  #$0048,D0                       ; $00FAA6
        MOVE.W  #$0010,D1                       ; $00FAAA
        MOVE.W  #$0010,D2                       ; $00FAAE
.p2_wait_panel3a:
        TST.B  COMM0_HI                        ; $00FAB2
        BNE.S  .p2_wait_panel3a                 ; $00FAB8
        jsr     sh2_cmd_27(pc)          ; $4EBA $E8F8
        MOVEA.L #$040190B0,A0                   ; $00FABE
        MOVE.W  #$0078,D0                       ; $00FAC4
        MOVE.W  #$0010,D1                       ; $00FAC8
        MOVE.W  #$0010,D2                       ; $00FACC
.p2_wait_panel3b:
        TST.B  COMM0_HI                        ; $00FAD0
        BNE.S  .p2_wait_panel3b                 ; $00FAD6
        jsr     sh2_cmd_27(pc)          ; $4EBA $E8DA
        MOVE.B  (-24550).W,D0                   ; $00FADC
        BRA.S  .p2_stats_overlay                 ; $00FAE0
.p2_not_3panel:
        MOVE.B  (-24541).W,D0                   ; $00FAE2
.p2_stats_overlay:
        MOVE.B  D0,D2                           ; $00FAE6
        MOVEA.L #$0401B0B0,A0                   ; $00FAE8
        ADD.W  D0,D0                           ; $00FAEE
        ADD.W  D0,D0                           ; $00FAF0
        ADD.W  D0,D0                           ; $00FAF2
        MOVE.W  D0,D1                           ; $00FAF4
        ADD.W  D0,D0                           ; $00FAF6
        ADD.W  D1,D0                           ; $00FAF8
        LEA     $00(A0,D0.W),A0                 ; $00FAFA
        MOVE.W  #$0018,D0                       ; $00FAFE
        TST.B  D2                               ; $00FB02
        BEQ.W  .p2_stats_params_ready            ; $00FB04
        SUBQ.L  #1,A0                           ; $00FB08
        MOVE.W  #$0019,D0                       ; $00FB0A
.p2_stats_params_ready:
        MOVE.W  #$0010,D1                       ; $00FB0E
        MOVE.W  #$0010,D2                       ; $00FB12
.p2_wait_stats:
        TST.B  COMM0_HI                        ; $00FB16
        BNE.S  .p2_wait_stats                   ; $00FB1C
        jsr     sh2_cmd_27(pc)          ; $4EBA $E894
        RTS                                     ; $00FB22
