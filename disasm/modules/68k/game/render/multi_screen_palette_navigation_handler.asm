; ============================================================================
; multi_screen_palette_navigation_handler — Multi-Screen Palette Navigation Handler
; ROM Range: $00F44C-$00F682 (566 bytes)
; Handles palette navigation for multi-screen (up to 3-panel) display
; modes. D-pad left/right cycles through palette entries with per-
; panel limits based on screen count. D-pad up/down switches active
; panel. Sends SH2 geometry data via sh2_send_cmd loop (8 command
; table entries at $0088F682). Advances state counter.
;
; Uses: D0, D1, D2, A0, A1, A2
; Calls: $00E35A (sh2_send_cmd), $00F88C (palette_switch)
; Confidence: high
; ============================================================================

multi_screen_palette_navigation_handler:
        CLR.W  D0                               ; $00F44C
        MOVE.B  (-24549).W,D0                   ; $00F44E
        bsr.w   palette_table_init      ; $6100 $0438
        JSR     $0088179E                       ; $00F456
        TST.W  (-24540).W                       ; $00F45C
        BNE.W  .send_sh2_geometry                ; $00F460
        MOVE.B  (-24551).W,D0                   ; $00F464
        MOVE.W  (-14228).W,D1                   ; $00F468
        BTST    #3,D1                           ; $00F46C
        BEQ.S  .p1_check_left                   ; $00F470
        MOVE.B  #$A9,(-14172).W                 ; $00F472
        TST.B  (-24549).W                       ; $00F478
        BEQ.W  .p1_right_1panel                  ; $00F47C
        CMPI.B  #$01,(-24549).W                 ; $00F480
        BEQ.W  .p1_right_2panel                 ; $00F486
        CMPI.B  #$04,D0                         ; $00F48A
        BLT.W  .p1_right_increment              ; $00F48E
        CLR.B  D0                               ; $00F492
        BRA.W  .p1_store_palette                ; $00F494
.p1_right_1panel:
        CMPI.B  #$02,D0                         ; $00F498
        BLT.W  .p1_right_increment              ; $00F49C
        CLR.B  D0                               ; $00F4A0
        BRA.W  .p1_store_palette                ; $00F4A2
.p1_right_2panel:
        CMPI.B  #$01,D0                         ; $00F4A6
        BLT.W  .p1_right_increment              ; $00F4AA
        CLR.B  D0                               ; $00F4AE
        BRA.W  .p1_store_palette                ; $00F4B0
.p1_right_increment:
        ADDQ.B  #1,D0                           ; $00F4B4
        BRA.W  .p1_store_palette                ; $00F4B6
.p1_check_left:
        BTST    #2,D1                           ; $00F4BA
        BEQ.S  .p1_check_down                   ; $00F4BE
        MOVE.B  #$A9,(-14172).W                 ; $00F4C0
        TST.B  D0                               ; $00F4C6
        BLE.W  .p1_left_wrap                    ; $00F4C8
        SUBQ.B  #1,D0                           ; $00F4CC
        BRA.W  .p1_store_palette                ; $00F4CE
.p1_left_wrap:
        TST.B  (-24549).W                       ; $00F4D2
        BEQ.W  .p1_left_wrap_1panel             ; $00F4D6
        CMPI.B  #$01,(-24549).W                 ; $00F4DA
        BEQ.W  .p1_left_wrap_2panel             ; $00F4E0
        MOVE.B  #$04,D0                         ; $00F4E4
        BRA.W  .p1_store_palette                ; $00F4E8
.p1_left_wrap_1panel:
        MOVE.B  #$02,D0                         ; $00F4EC
        BRA.W  .p1_store_palette                ; $00F4F0
.p1_left_wrap_2panel:
        MOVE.B  #$01,D0                         ; $00F4F4
        BRA.W  .p1_store_palette                ; $00F4F8
.p1_check_down:
        BTST    #0,D1                           ; $00F4FC
        BEQ.W  .p1_check_up                     ; $00F500
        TST.B  (-24549).W                       ; $00F504
        BEQ.W  .p1_store_palette                ; $00F508
        MOVE.B  #$A9,(-14172).W                 ; $00F50C
        CMPI.B  #$01,(-24549).W                 ; $00F512
        BEQ.S  .p1_down_from_panel1             ; $00F518
        MOVE.B  #$01,(-24549).W                 ; $00F51A
        MOVE.B  D0,(-24543).W                   ; $00F520
        MOVE.B  (-24544).W,D0                   ; $00F524
        BRA.W  .p1_store_palette                ; $00F528
.p1_down_from_panel1:
        CLR.B  (-24549).W                       ; $00F52C
        MOVE.B  D0,(-24544).W                   ; $00F530
        MOVE.B  (-24545).W,D0                   ; $00F534
        BRA.W  .p1_store_palette                ; $00F538
.p1_check_up:
        BTST    #1,D1                           ; $00F53C
        BEQ.W  .p1_store_palette                ; $00F540
        CMPI.B  #$02,(-24549).W                 ; $00F544
        BGE.W  .p1_store_palette                ; $00F54A
        MOVE.B  #$A9,(-14172).W                 ; $00F54E
        TST.B  (-24549).W                       ; $00F554
        BEQ.S  .p1_up_from_panel0               ; $00F558
        MOVE.B  #$02,(-24549).W                 ; $00F55A
        MOVE.B  D0,(-24544).W                   ; $00F560
        MOVE.B  (-24543).W,D0                   ; $00F564
        BRA.W  .p1_store_palette                ; $00F568
.p1_up_from_panel0:
        MOVE.B  #$01,(-24549).W                 ; $00F56C
        MOVE.B  D0,(-24545).W                   ; $00F572
        MOVE.B  (-24544).W,D0                   ; $00F576
.p1_store_palette:
        MOVE.B  D0,(-24551).W                   ; $00F57A
        MOVE.B  (-24550).W,D0                   ; $00F57E
        MOVE.W  (-14226).W,D1                   ; $00F582
        BTST    #3,D1                           ; $00F586
        BEQ.S  .p2_check_left                   ; $00F58A
        MOVE.B  #$A9,(-14172).W                 ; $00F58C
        CMPI.B  #$01,(-24548).W                 ; $00F592
        BEQ.W  .p2_right_2panel                 ; $00F598
        CMPI.B  #$04,D0                         ; $00F59C
        BLT.W  .p2_right_increment              ; $00F5A0
        CLR.B  D0                               ; $00F5A4
        BRA.W  .p2_store_palette                ; $00F5A6
.p2_right_2panel:
        CMPI.B  #$01,D0                         ; $00F5AA
        BLT.W  .p2_right_increment              ; $00F5AE
        CLR.B  D0                               ; $00F5B2
        BRA.W  .p2_store_palette                ; $00F5B4
.p2_right_increment:
        ADDQ.B  #1,D0                           ; $00F5B8
        BRA.W  .p2_store_palette                ; $00F5BA
.p2_check_left:
        BTST    #2,D1                           ; $00F5BE
        BEQ.S  .p2_check_down                   ; $00F5C2
        MOVE.B  #$A9,(-14172).W                 ; $00F5C4
        TST.B  D0                               ; $00F5CA
        BLE.W  .p2_left_wrap                    ; $00F5CC
        SUBQ.B  #1,D0                           ; $00F5D0
        BRA.W  .p2_store_palette                ; $00F5D2
.p2_left_wrap:
        CMPI.B  #$01,(-24548).W                 ; $00F5D6
        BEQ.W  .p2_left_wrap_2panel             ; $00F5DC
        MOVE.B  #$04,D0                         ; $00F5E0
        BRA.W  .p2_store_palette                ; $00F5E4
.p2_left_wrap_2panel:
        MOVE.B  #$01,D0                         ; $00F5E8
        BRA.W  .p2_store_palette                ; $00F5EC
.p2_check_down:
        BTST    #0,D1                           ; $00F5F0
        BEQ.W  .p2_check_up                     ; $00F5F4
        CMPI.B  #$01,(-24548).W                 ; $00F5F8
        BEQ.S  .p2_store_palette                ; $00F5FE
        MOVE.B  #$A9,(-14172).W                 ; $00F600
        MOVE.B  #$01,(-24548).W                 ; $00F606
        MOVE.B  D0,(-24541).W                   ; $00F60C
        MOVE.B  (-24542).W,D0                   ; $00F610
        BRA.W  .p2_store_palette                ; $00F614
.p2_check_up:
        BTST    #1,D1                           ; $00F618
        BEQ.W  .p2_store_palette                ; $00F61C
        CMPI.B  #$02,(-24548).W                 ; $00F620
        BGE.W  .p2_store_palette                ; $00F626
        MOVE.B  #$A9,(-14172).W                 ; $00F62A
        MOVE.B  #$02,(-24548).W                 ; $00F630
        MOVE.B  D0,(-24542).W                   ; $00F636
        MOVE.B  (-24541).W,D0                   ; $00F63A
.p2_store_palette:
        MOVE.B  D0,(-24550).W                   ; $00F63E
.send_sh2_geometry:
        MOVEA.L #$06038000,A0                   ; $00F642
        MOVEA.L #$04007010,A1                   ; $00F648
        MOVE.W  #$0120,D0                       ; $00F64E
        MOVE.W  #$0030,D1                       ; $00F652
        DC.W    $4EBA,$ED02         ; JSR     $00E35A(PC); $00F656
        LEA     $0088F682,A2                    ; $00F65A
        MOVE.W  #$0007,D2                       ; $00F660
.sh2_cmd_loop:
        MOVEA.L (A2)+,A0                        ; $00F664
        MOVEA.L (A2)+,A1                        ; $00F666
        MOVE.W  (A2)+,D0                        ; $00F668
        MOVE.W  (A2)+,D1                        ; $00F66A
        DC.W    $4EBA,$ECEC         ; JSR     $00E35A(PC); $00F66C
        DBRA    D2,.sh2_cmd_loop                    ; $00F670
        ADDQ.W  #4,(-14210).W                   ; $00F674
        MOVE.W  #$0020,$00FF0008                ; $00F678
        RTS                                     ; $00F680
