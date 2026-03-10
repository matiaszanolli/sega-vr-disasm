; ============================================================================
; name_entry_screen_init — Name Entry Screen Initialization
; ROM Range: $010974-$01103E (1738 bytes)
; ============================================================================
; Large orchestrator that initializes the entire name entry screen for high
; score entry. Data prefix ($010974-$0109AB) contains the ASCII character set
; (A-Z, a-z, 0-9, punctuation) for the on-screen keyboard grid.
;
; Initialization sequence:
;   1. Configure VDP mode, adapter control, display parameters
;   2. Clear RAM regions (name buffers, score tables)
;   3. Set up graphics command for 38×26 tile region
;   4. Load palette data via sh2_palette_load
;   5. Load character tile assets to 6 SH2 framebuffer regions
;   6. Accumulate BCD scores from RAM ($C200) using ABCD/SBCD
;   7. Rank scores and find insertion point for new entry
;   8. Render existing high score times via name_digit_render
;   9. Set up COMM0/COMM4 for SH2 framebuffer page flip ($06020000)
;  10. Handle 1P/2P/3P variants (BTST #4/#5 on flags at $C90E)
;
; Entry: (no register parameters — uses global RAM state)
; Uses: D0, D1, D2, D3, D4, D5, D7, A0, A1, A2
; RAM:
;   $C87A: vint_dispatch_state
;   $C87E: game_state
;   $C90E: player mode flags (bit 4 = 2P, bit 5 = 1P)
; Calls:
;   $00E1BC: sh2_palette_load
;   $00E22C: sh2_graphics_cmd
;   $00E2F0: sh2_load_data
;   $00E316: sh2_send_cmd_wait
;   $011942: name_digit_render (lap_time_digit_renderer_b)
;   $011A98: name_entry_check
; ============================================================================

name_entry_screen_init:
        DC.W    $4142                           ; $010974
        DC.W    $4344                           ; $010976
        DC.W    $4546                           ; $010978
        DC.W    $4748                           ; $01097A
        DC.W    $494A                           ; $01097C
        DC.W    $4B4C                           ; $01097E
        DC.W    $4D4E                           ; $010980
        DC.W    $4F50                           ; $010982
        SUBQ.W  #8,(A2)                         ; $010984
        SUBQ.W  #1,(A4)                         ; $010986
        SUBQ.W  #2,(A6)                         ; $010988
        SUBQ.W  #3,(A0)+                        ; $01098A
        SUBQ.W  #4,(A2)+                        ; $01098C
        BSR.S  $0109F2                          ; $01098E
        BLS.S  .clear_ram_loop                        ; $010990
        BCS.S  $0109FA                          ; $010992
        BEQ.S  $0109FE                          ; $010994
        BVS.S  .clear_ext_ram                        ; $010996
        BMI.S  .clear_ext_done                        ; $010998
        BLT.S  .clear_vram                        ; $01099A
        BLE.S  $010A0E                          ; $01099C
        DC.W    $7172                           ; $01099E
        DC.W    $7374                           ; $0109A0
        DC.W    $7576                           ; $0109A2
        DC.W    $7778                           ; $0109A4
        DC.W    $797A                           ; $0109A6
        MOVE.L  -(A1),D7                        ; $0109A8
        MOVE.W  -(A0),-(A7)                     ; $0109AA
        DC.W    $0803                           ; $0109AC
        MOVE.W  #$002C,$00FF0008                ; $0109AE
        MOVE.W  #$002C,(-14214).W               ; $0109B6
        BCLR    #6,(-14219).W                   ; $0109BC
        MOVE.W  (-14220).W,(A5)                 ; $0109C2
        MOVE.W  #$0083,MARS_SYS_INTCTL                ; $0109C6
        ANDI.B  #$FC,MARS_VDP_MODE+1                  ; $0109CE
        JSR     $008826C8                       ; $0109D6
        MOVE.L  #$000A0907,D0                   ; $0109DC
        JSR     $008814BE                       ; $0109E2
        MOVE.B  #$01,(-14323).W                 ; $0109E8
        MOVEQ   #$00,D0                         ; $0109EE
        LEA     (-31616).W,A0                   ; $0109F0
        MOVEQ   #$1F,D1                         ; $0109F4
.clear_ram_loop:
        MOVE.L  D0,(A0)+                        ; $0109F6
        DBRA    D1,.clear_ram_loop                    ; $0109F8
        LEA     $00FF7B80,A0                    ; $0109FC
.clear_ext_ram:
        MOVEQ   #$7F,D1                         ; $010A02
.clear_ext_ram_loop:
        MOVE.L  D0,(A0)+                        ; $010A04
.clear_ext_done:
        DBRA    D1,.clear_ext_ram_loop                    ; $010A06
.clear_vram:
        MOVE.L  #$60000002,(A5)                 ; $010A0A
        MOVE.W  #$17FF,D1                       ; $010A10
.clear_vram_loop:
        MOVE.L  D0,(A6)                         ; $010A14
        DBRA    D1,.clear_vram_loop                    ; $010A16
        JSR     $008849AA                       ; $010A1A
        CLR.W  (-14208).W                       ; $010A20
        CLR.W  (-14206).W                       ; $010A24
        CLR.W  (-32768).W                       ; $010A28
        CLR.W  (-32766).W                       ; $010A2C
        CLR.W  (-24558).W                       ; $010A30
        CLR.B  (-24552).W                       ; $010A34
        JSR     $008849AA                       ; $010A38
        MOVE.L  #$008BB4FC,(-13972).W           ; $010A3E
        MOVE.B  #$01,(-14327).W                 ; $010A46
        MOVE.B  #$01,(-14326).W                 ; $010A4C
        BSET    #6,(-14322).W                   ; $010A52
        MOVE.B  #$01,(-14334).W                 ; $010A58
        MOVE.W  #$0001,(-24484).W               ; $010A5E
        LEA     $00FF1000,A0                    ; $010A64
        MOVE.W  #$037F,D0                       ; $010A6A
.clear_tilemap:
        CLR.L  (A0)+                            ; $010A6E
        DBRA    D0,.clear_tilemap                    ; $010A70
        MOVE.W  #$0001,D0                       ; $010A74
        MOVE.W  #$0001,D1                       ; $010A78
        MOVE.W  #$0001,D2                       ; $010A7C
        MOVE.W  #$0026,D3                       ; $010A80
        MOVE.W  #$001A,D4                       ; $010A84
        LEA     $00FF1000,A0                    ; $010A88
        jsr     sh2_graphics_cmd(pc)    ; $4EBA $D79C
        LEA     $00FF1000,A0                    ; $010A92
        jsr     sh2_load_data(pc)       ; $4EBA $D856
        DC.W    $4EBA,$D71E         ; JSR     $00E1BC(PC); $010A9C
        BCLR    #7,MARS_VDP_MODE+1                    ; $010AA0
        LEA     $00FF6E00,A0                    ; $010AA8
        ADDA.L  #$00000160,A0                   ; $010AAE
        LEA     $00891062,A1                    ; $010AB4
        MOVE.W  #$003F,D0                       ; $010ABA
.copy_palette_loop:
        MOVE.W  (A1)+,D1                        ; $010ABE
        BSET    #15,D1                          ; $010AC0
        MOVE.W  D1,(A0)+                        ; $010AC4
        DBRA    D0,.copy_palette_loop                    ; $010AC6
        BTST    #4,(-14322).W                   ; $010ACA
        BEQ.W  .skip_ext_palette                        ; $010AD0
        LEA     $00FF6E00,A0                    ; $010AD4
        ADDA.L  #$00000180,A0                   ; $010ADA
        LEA     $008910E2,A1                    ; $010AE0
        MOVE.W  #$000F,D0                       ; $010AE6
.copy_palette_ext_loop:
        MOVE.W  (A1)+,D1                        ; $010AEA
        BSET    #15,D1                          ; $010AEC
        MOVE.W  D1,(A0)+                        ; $010AF0
        DBRA    D0,.copy_palette_ext_loop                    ; $010AF2
.skip_ext_palette:
        LEA     $000EC980,A0                    ; $010AF6
        MOVEA.L #$06018000,A1                   ; $010AFC
        DC.W    $4EBA,$D812         ; JSR     $00E316(PC); $010B02
        LEA     $000ECC90,A0                    ; $010B06
        MOVEA.L #$06018500,A1                   ; $010B0C
        DC.W    $4EBA,$D802         ; JSR     $00E316(PC); $010B12
        LEA     $000ECE20,A0                    ; $010B16
        MOVEA.L #$06018C00,A1                   ; $010B1C
        DC.W    $4EBA,$D7F2         ; JSR     $00E316(PC); $010B22
        BTST    #4,(-14322).W                   ; $010B26
        BEQ.W  .skip_3p_tiles                        ; $010B2C
        LEA     $000ECAB0,A0                    ; $010B30
        MOVEA.L #$06018F80,A1                   ; $010B36
        DC.W    $4EBA,$D7D8         ; JSR     $00E316(PC); $010B3C
.skip_3p_tiles:
        LEA     $000EBB40,A0                    ; $010B40
        MOVEA.L #$0601AD00,A1                   ; $010B46
        DC.W    $4EBA,$D7C8         ; JSR     $00E316(PC); $010B4C
        LEA     $000EB980,A0                    ; $010B50
        MOVEA.L #$0601DF00,A1                   ; $010B56
        DC.W    $4EBA,$D7B8         ; JSR     $00E316(PC); $010B5C
        MOVEQ   #$00,D0                         ; $010B60
        MOVE.B  (-335).W,D0                     ; $010B62
        BTST    #5,(-14322).W                   ; $010B66
        BEQ.W  .check_3p_mode                        ; $010B6C
        MOVE.B  (-334).W,D0                     ; $010B70
.check_3p_mode:
        BTST    #4,(-14322).W                   ; $010B74
        BEQ.W  .lookup_tile_table                        ; $010B7A
        MOVE.B  (-333).W,D0                     ; $010B7E
.lookup_tile_table:
        ADD.L   D0,D0                           ; $010B82
        ADD.L   D0,D0                           ; $010B84
        LEA     $0089103E,A0                    ; $010B86
        MOVEA.L $00(A0,D0.W),A0                 ; $010B8C
        MOVEA.L #$0601E8C0,A1                   ; $010B90
        DC.W    $4EBA,$D77E         ; JSR     $00E316(PC); $010B96
        MOVEQ   #$00,D0                         ; $010B9A
        MOVE.B  (-347).W,D0                     ; $010B9C
        BTST    #5,(-14322).W                   ; $010BA0
        BEQ.W  .check_3p_track                        ; $010BA6
        MOVE.B  (-345).W,D0                     ; $010BAA
.check_3p_track:
        BTST    #4,(-14322).W                   ; $010BAE
        BEQ.W  .lookup_track_table                        ; $010BB4
        MOVE.B  (-341).W,D0                     ; $010BB8
.lookup_track_table:
        ADD.L   D0,D0                           ; $010BBC
        ADD.L   D0,D0                           ; $010BBE
        LEA     $0089104A,A0                    ; $010BC0
        MOVEA.L $00(A0,D0.W),A0                 ; $010BC6
        MOVEA.L #$0601EE40,A1                   ; $010BCA
        DC.W    $4EBA,$D744         ; JSR     $00E316(PC); $010BD0
        LEA     $000EDE10,A0                    ; $010BD4
        MOVEA.L #$06010000,A1                   ; $010BDA
        DC.W    $4EBA,$D734         ; JSR     $00E316(PC); $010BE0
        MOVE.B  #$00,(-24551).W                 ; $010BE4
        MOVE.B  #$00,(-24550).W                 ; $010BEA
        MOVE.B  #$02,(-24548).W                 ; $010BF0
        MOVE.L  #$00000000,(-24542).W           ; $010BF6
        MOVE.L  #$00000000,(-24538).W           ; $010BFE
        MOVE.B  #$00,(-24530).W                 ; $010C06
        MOVE.L  #$00000000,(-24526).W           ; $010C0C
        MOVE.L  #$00000000,(-24522).W           ; $010C14
        MOVE.B  #$00,(-24514).W                 ; $010C1C
        CLR.W  (-24496).W                       ; $010C22
        MOVE.W  #$0010,(-24494).W               ; $010C26
        MOVEQ   #$00,D0                         ; $010C2C
        MOVE.B  (-344).W,D0                     ; $010C2E
        LEA     $00891102,A0                    ; $010C32
        BTST    #5,(-14322).W                   ; $010C38
        BNE.S  .have_score_table                        ; $010C3E
        MOVE.B  (-340).W,D0                     ; $010C40
        LEA     $00891112,A0                    ; $010C44
        BTST    #4,(-14322).W                   ; $010C4A
        BNE.S  .have_score_table                        ; $010C50
        MOVE.B  #$00,D0                         ; $010C52
.have_score_table:
        ADD.W   D0,D0                           ; $010C56
        ADD.W   D0,D0                           ; $010C58
        MOVE.L  $00(A0,D0.W),(-24534).W         ; $010C5A
        MOVE.L  $00(A0,D0.W),(-24518).W         ; $010C60
        CLR.L  (-24506).W                       ; $010C66
        LEA     (-24506).W,A0                   ; $010C6A
        LEA     (-15872).W,A1                   ; $010C6E
        MOVE.W  #$0013,D2                       ; $010C72
.bcd_accum_loop:
        ADDI.B  #$00,D0                         ; $010C76
        MOVE.B  $0003(A0),D0                    ; $010C7A
        MOVE.B  $0003(A1),D1                    ; $010C7E
        ABCD    D1,D0                           ; $010C82
        MOVE.B  D0,$0003(A0)                    ; $010C84
        MOVE.B  $0002(A0),D0                    ; $010C88
        MOVE.B  $0002(A1),D1                    ; $010C8C
        ABCD    D1,D0                           ; $010C90
        MOVE.B  D0,D1                           ; $010C92
        ANDI.B  #$0F,D0                         ; $010C94
        MOVE.B  D0,$0002(A0)                    ; $010C98
        LSR.B  #4,D1                            ; $010C9C
        ADDI.B  #$00,D0                         ; $010C9E
        MOVE.B  $0001(A0),D0                    ; $010CA2
        ABCD    D1,D0                           ; $010CA6
        MOVE.B  $0001(A1),D1                    ; $010CA8
        ABCD    D1,D0                           ; $010CAC
        BCC.W  .no_carry                        ; $010CAE
        ADDI.B  #$00,D0                         ; $010CB2
        MOVE.B  #$40,D1                         ; $010CB6
        ABCD    D1,D0                           ; $010CBA
        MOVE.B  #$01,D1                         ; $010CBC
        BRA.S  .store_minutes                        ; $010CC0
.no_carry:
        CLR.B  D1                               ; $010CC2
        CMPI.B  #$60,D0                         ; $010CC4
        BCS.W  .store_minutes                        ; $010CC8
        ADDI.B  #$00,D0                         ; $010CCC
        MOVE.B  #$60,D1                         ; $010CD0
        SBCD    D1,D0                           ; $010CD4
        MOVE.B  #$01,D1                         ; $010CD6
.store_minutes:
        MOVE.B  D0,$0001(A0)                    ; $010CDA
        ADDI.B  #$00,D0                         ; $010CDE
        MOVE.B  (A0),D0                         ; $010CE2
        ABCD    D1,D0                           ; $010CE4
        MOVE.B  (A1),D1                         ; $010CE6
        ABCD    D1,D0                           ; $010CE8
        MOVE.B  D0,(A0)                         ; $010CEA
        ADDQ.L  #4,A1                           ; $010CEC
        DBRA    D2,.bcd_accum_loop                    ; $010CEE
        TST.L  (-24506).W                       ; $010CF2
        BNE.S  .score_valid                        ; $010CF6
        MOVE.L  #$CCCC0CCC,(-24506).W           ; $010CF8
.score_valid:
        LEA     (-15872).W,A0                   ; $010D00
        MOVE.W  #$0013,D0                       ; $010D04
.find_empty_slot:
        TST.L  (A0)                             ; $010D08
        BEQ.W  .fill_empty_slots                        ; $010D0A
        ADDQ.L  #4,A0                           ; $010D0E
        DBRA    D0,.find_empty_slot                    ; $010D10
        BRA.S  .check_rank_limit                        ; $010D14
.fill_empty_slots:
        MOVE.L  #$CCCC0CCC,(A0)+                ; $010D16
        DBRA    D0,.fill_empty_slots                    ; $010D1C
.check_rank_limit:
        MOVE.W  #$0000,(-24510).W               ; $010D20
        LEA     (-15872).W,A0                   ; $010D26
        MOVE.L  $0010(A0),D0                    ; $010D2A
        CMPI.L  #$CCCC0CCC,D0                   ; $010D2E
        BNE.S  .find_best_score                        ; $010D34
        MOVE.W  #$0001,(-24510).W               ; $010D36
.find_best_score:
        MOVEQ   #$00,D2                         ; $010D3C
        MOVE.L  D2,(-24546).W                   ; $010D3E
        LEA     (-15872).W,A0                   ; $010D42
        MOVE.L  #$60000000,D0                   ; $010D46
        MOVE.W  #$0013,D3                       ; $010D4C
.rank_scan_loop:
        MOVE.L  (A0)+,D1                        ; $010D50
        BEQ.S  .rank_next                        ; $010D52
        CMPI.L  #$CCCC0CCC,D1                   ; $010D54
        BEQ.S  .rank_next                        ; $010D5A
        CMP.L  D1,D0                            ; $010D5C
        BLE.S  .rank_next                        ; $010D5E
        MOVE.L  D1,D0                           ; $010D60
        MOVE.L  D2,(-24546).W                   ; $010D62
.rank_next:
        ADDI.L  #$00000D80,D2                   ; $010D66
        DBRA    D3,.rank_scan_loop                    ; $010D6C
.wait_comm_ready:
        TST.B  COMM0_HI                        ; $010D70
        BNE.S  .wait_comm_ready                        ; $010D76
        MOVE.L  #$06020000,COMM4            ; $010D78
        MOVE.B  #$26,COMM0_LO                  ; $010D82
        MOVE.B  #$01,COMM0_HI                  ; $010D8A
        BTST    #4,(-14322).W                   ; $010D92
        BNE.W  .init_3p_mode                        ; $010D98
        MOVEA.L #$0601AD00,A0                   ; $010D9C
        MOVEA.L #$06028000,A1                   ; $010DA2
        MOVE.W  #$0028,D0                       ; $010DA8
        MOVE.W  #$0140,D1                       ; $010DAC
        MOVE.W  #$00D8,D2                       ; $010DB0
        jsr     sh2_command_sender+40(pc); $4EBA $0CE2
        MOVEQ   #$00,D3                         ; $010DB8
        MOVEQ   #$00,D4                         ; $010DBA
        MOVE.W  #$0013,D5                       ; $010DBC
.render_scores_loop:
        MOVEA.L #$06028030,A1                   ; $010DC0
        ADDA.L  D3,A1                           ; $010DC6
        ADDI.L  #$00000D80,D3                   ; $010DC8
        LEA     (-15872).W,A2                   ; $010DCE
        ADDA.L  D4,A2                           ; $010DD2
        ADDQ.L  #4,D4                           ; $010DD4
        MOVE.W  #$00D8,D2                       ; $010DD6
        jsr     lap_time_digit_renderer_c(pc); $4EBA $0B66
        DBRA    D5,.render_scores_loop                    ; $010DDE
        CMPI.L  #$61000000,(-15788).W           ; $010DE2
        BEQ.W  .skip_to_finalize                        ; $010DEA
        LEA     (-15872).W,A2                   ; $010DEE
        MOVE.L  #$60000000,D1                   ; $010DF2
        CLR.W  D3                               ; $010DF8
        MOVE.W  #$0001,D2                       ; $010DFA
        MOVE.W  #$0013,D4                       ; $010DFE
.find_best_entry:
        MOVE.L  (A2)+,D0                        ; $010E02
        CMPI.L  #$CCCC0CCC,D0                   ; $010E04
        BEQ.S  .next_score_entry                        ; $010E0A
        CMP.L  D1,D0                            ; $010E0C
        BCC.S  .next_score_entry                        ; $010E0E
        MOVE.L  D0,D1                           ; $010E10
        MOVE.W  D2,D3                           ; $010E12
.next_score_entry:
        ADDQ.W  #1,D2                           ; $010E14
        DBRA    D4,.find_best_entry                    ; $010E16
        TST.W  D3                               ; $010E1A
        BEQ.S  .no_highlight                        ; $010E1C
        MOVEA.L #$06028030,A0                   ; $010E1E
        SUBQ.W  #1,D3                           ; $010E24
        ANDI.L  #$0000FFFF,D3                   ; $010E26
        LSL.L  #7,D3                            ; $010E2C
        MOVE.L  D3,D4                           ; $010E2E
        LSL.L  #1,D3                            ; $010E30
        ADD.L   D3,D4                           ; $010E32
        LSL.L  #2,D3                            ; $010E34
        ADD.L   D3,D4                           ; $010E36
        LSL.L  #1,D3                            ; $010E38
        ADD.L   D4,D3                           ; $010E3A
        ADDA.L  D3,A0                           ; $010E3C
        MOVE.W  #$0078,D0                       ; $010E3E
        MOVE.W  #$0010,D1                       ; $010E42
        MOVE.W  #$0008,D2                       ; $010E46
        MOVE.W  #$00D8,D3                       ; $010E4A
        JSR     $0088E406                       ; $010E4E
.no_highlight:
        MOVEA.L #$06019D00,A0                   ; $010E54
        MOVEA.L #$06028088,A1                   ; $010E5A
        ADDA.L  (-24546).W,A1                   ; $010E60
        MOVE.W  #$0050,D0                       ; $010E64
        MOVE.W  #$0010,D1                       ; $010E68
        MOVE.W  #$00D8,D2                       ; $010E6C
        ADDI.L  #$00000D80,D3                   ; $010E70
        jsr     sh2_command_sender+40(pc); $4EBA $0C20
.skip_to_finalize:
        BRA.W  .finalize_display                        ; $010E7A
.init_3p_mode:
        MOVEA.L #$0601AD00,A0                   ; $010E7E
        MOVEA.L #$06028000,A1                   ; $010E84
        MOVE.W  #$0028,D0                       ; $010E8A
        MOVE.W  #$0140,D1                       ; $010E8E
        MOVE.W  #$0080,D2                       ; $010E92
        jsr     sh2_command_sender+40(pc); $4EBA $0C00
        MOVEQ   #$00,D3                         ; $010E9A
        MOVEQ   #$00,D4                         ; $010E9C
        MOVE.W  #$0013,D5                       ; $010E9E
.render_3p_scores_loop:
        MOVEA.L #$06028030,A1                   ; $010EA2
        ADDA.L  D3,A1                           ; $010EA8
        ADDI.L  #$00000800,D3                   ; $010EAA
        LEA     (-15872).W,A2                   ; $010EB0
        ADDA.L  D4,A2                           ; $010EB4
        ADDQ.L  #4,D4                           ; $010EB6
        MOVE.W  #$0080,D2                       ; $010EB8
        jsr     lap_time_digit_renderer_c(pc); $4EBA $0A84
        DBRA    D5,.render_3p_scores_loop                    ; $010EC0
        LEA     (-15872).W,A2                   ; $010EC4
        MOVE.L  #$60000000,D1                   ; $010EC8
        CLR.W  D3                               ; $010ECE
        MOVE.W  #$0001,D2                       ; $010ED0
        MOVE.W  #$0013,D4                       ; $010ED4
.find_best_3p:
        MOVE.L  (A2)+,D0                        ; $010ED8
        CMPI.L  #$CCCC0CCC,D0                   ; $010EDA
        BEQ.S  .next_3p_entry                        ; $010EE0
        CMP.L  D1,D0                            ; $010EE2
        BCC.S  .next_3p_entry                        ; $010EE4
        MOVE.L  D0,D1                           ; $010EE6
        MOVE.W  D2,D3                           ; $010EE8
.next_3p_entry:
        ADDQ.W  #1,D2                           ; $010EEA
        DBRA    D4,.find_best_3p                    ; $010EEC
        TST.W  D3                               ; $010EF0
        BEQ.S  .no_3p_highlight                        ; $010EF2
        MOVEA.L #$06028000,A0                   ; $010EF4
        SUBQ.W  #1,D3                           ; $010EFA
        ANDI.L  #$0000FFFF,D3                   ; $010EFC
        LSL.L  #8,D3                            ; $010F02
        LSL.L  #3,D3                            ; $010F04
        ADDA.L  D3,A0                           ; $010F06
        MOVE.W  #$0080,D0                       ; $010F08
        MOVE.W  #$0010,D1                       ; $010F0C
        MOVE.W  #$0008,D2                       ; $010F10
        MOVE.W  #$0080,D3                       ; $010F14
        JSR     $0088E406                       ; $010F18
.no_3p_highlight:
        bsr.w   name_entry_bcd_score_cmp; $6100 $0C4A
        MOVEA.L #$2601AD00,A0                   ; $010F22
        MOVEA.L #$26032000,A1                   ; $010F28
        MOVE.W  #$0028,D0                       ; $010F2E
        MOVE.W  #$0140,D1                       ; $010F32
        MOVE.W  #$0080,D2                       ; $010F36
        jsr     sh2_command_sender+40(pc); $4EBA $0B5C
        MOVEQ   #$00,D3                         ; $010F3E
        MOVEQ   #$00,D4                         ; $010F40
        MOVE.W  #$0013,D5                       ; $010F42
.render_3p_page2_loop:
        MOVEA.L #$06032030,A1                   ; $010F46
        ADDA.L  D3,A1                           ; $010F4C
        ADDI.L  #$00000800,D3                   ; $010F4E
        LEA     (-15872).W,A2                   ; $010F54
        ADDA.L  D4,A2                           ; $010F58
        ADDQ.L  #4,D4                           ; $010F5A
        MOVE.W  #$0080,D2                       ; $010F5C
        jsr     lap_time_digit_renderer_c(pc); $4EBA $09E0
        DBRA    D5,.render_3p_page2_loop                    ; $010F64
        LEA     (-15872).W,A2                   ; $010F68
        MOVE.L  #$60000000,D1                   ; $010F6C
        CLR.W  D3                               ; $010F72
        MOVE.W  #$0001,D2                       ; $010F74
        MOVE.W  #$0013,D4                       ; $010F78
.find_best_page2:
        MOVE.L  (A2)+,D0                        ; $010F7C
        CMPI.L  #$CCCC0CCC,D0                   ; $010F7E
        BEQ.S  .next_page2_entry                        ; $010F84
        CMP.L  D1,D0                            ; $010F86
        BCC.S  .next_page2_entry                        ; $010F88
        MOVE.L  D0,D1                           ; $010F8A
        MOVE.W  D2,D3                           ; $010F8C
.next_page2_entry:
        ADDQ.W  #1,D2                           ; $010F8E
        DBRA    D4,.find_best_page2                    ; $010F90
        TST.W  D3                               ; $010F94
        BEQ.S  .no_page2_highlight                        ; $010F96
        MOVEA.L #$06032000,A0                   ; $010F98
        SUBQ.W  #1,D3                           ; $010F9E
        ANDI.L  #$0000FFFF,D3                   ; $010FA0
        LSL.L  #8,D3                            ; $010FA6
        LSL.L  #3,D3                            ; $010FA8
        ADDA.L  D3,A0                           ; $010FAA
        MOVE.W  #$0080,D0                       ; $010FAC
        MOVE.W  #$0010,D1                       ; $010FB0
        MOVE.W  #$0008,D2                       ; $010FB4
        MOVE.W  #$0080,D3                       ; $010FB8
        JSR     $0088E406                       ; $010FBC
.no_page2_highlight:
        JSR     $0088204A                       ; $010FC2
.finalize_display:
        MOVE.B  #$01,(-14303).W                 ; $010FC8
        ANDI.B  #$FC,MARS_VDP_MODE+1                  ; $010FCE
        ORI.B  #$01,MARS_VDP_MODE+1                   ; $010FD6
        MOVE.W  #$8083,MARS_SYS_INTCTL                ; $010FDE
        BSET    #6,(-14219).W                   ; $010FE6
        MOVE.W  (-14220).W,(A5)                 ; $010FEC
        MOVE.W  #$0018,$00FF0008                ; $010FF0
        JSR     $00884998                       ; $010FF8
        MOVE.W  #$0000,(-14210).W               ; $010FFE
        MOVE.L  #$00891166,$00FF0002            ; $011004
        BTST    #4,(-14322).W                   ; $01100E
        BNE.W  .set_handler                        ; $011014
        MOVE.L  #$00891142,$00FF0002            ; $011018
        BTST    #5,(-14322).W                   ; $011022
        BNE.W  .set_handler                        ; $011028
        MOVE.L  #$00891122,$00FF0002            ; $01102C
.set_handler:
        MOVE.B  #$8E,(-14171).W                 ; $011036
        RTS                                     ; $01103C
