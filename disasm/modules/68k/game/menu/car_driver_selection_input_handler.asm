; ============================================================================
; car_driver_selection_input_handler — Car/Driver Selection Input Handler
; ROM Range: $013FE0-$01418E (430 bytes)
; ============================================================================
; Processes input for car/driver selection on the race config screen.
;   - D-pad up/down: cycle through car choices (0-4 or 0-7 depending on D0)
;   - D-pad left/right: cycle through color/driver variants with wrap
;   - Button A+B: confirm selection → copy choice to output buffer
;   - Button C: toggle manual/auto transmission
;   - Start (bit 7): signal ready for race start
; Uses lookup tables at $0089AB8E/$0089ABBE for car graphics data.
;
; Entry: D0 = max car count flag, D1 = button state, D2 = player index,
;        D3 = repeat timer flag, A0 = car index ptr, A1 = saved choices,
;        A2 = output buffer, A3 = current selection ptr, A4 = ready flag
; Uses: D0, D1, D2, D3, D4, A0, A1, A2
; ============================================================================

car_driver_selection_input_handler:
        TST.W  D3                               ; $013FE0
        BNE.W  .update_graphics                        ; $013FE2
        BTST    #7,D1                           ; $013FE6
        BNE.W  .start_pressed                        ; $013FEA
        MOVE.B  D1,D3                           ; $013FEE
        ANDI.B  #$60,D3                         ; $013FF0
        BNE.W  .button_ab_confirm                        ; $013FF4
        BTST    #4,D1                           ; $013FF8
        BNE.W  .button_c_toggle                        ; $013FFC
        BTST    #0,D1                           ; $014000
        BEQ.S  .check_down                        ; $014004
        TST.W  (A4)                             ; $014006
        BEQ.W  .check_left                        ; $014008
        MOVE.B  #$A9,(-14172).W                 ; $01400C
        SUBQ.B  #1,(A3)                         ; $014012
        BCC.W  .done                        ; $014014
        CLR.B  (A3)                             ; $014018
        BRA.W  .done                        ; $01401A
.check_down:
        BTST    #1,D1                           ; $01401E
        BEQ.S  .check_left                        ; $014022
        TST.W  (A4)                             ; $014024
        BEQ.W  .check_left                        ; $014026
        MOVE.B  #$A9,(-14172).W                 ; $01402A
        ADDQ.B  #1,(A3)                         ; $014030
        MOVE.B  (A3),D3                         ; $014032
        MOVE.B  #$04,D4                         ; $014034
        TST.W  D0                               ; $014038
        BEQ.S  .use_default_max                        ; $01403A
        MOVE.B  #$07,D4                         ; $01403C
.use_default_max:
        CMP.B  D4,D3                            ; $014040
        BLE.W  .check_max_car_index                        ; $014042
        MOVE.B  D4,(A3)                         ; $014046
.check_max_car_index:
        LEA     (-24549).W,A4                   ; $014048
        TST.W  D2                               ; $01404C
        BEQ.S  .use_player1_slot                        ; $01404E
        LEA     (-24548).W,A4                   ; $014050
.use_player1_slot:
        MOVE.B  (A3),D0                         ; $014054
        CMP.B  (A4),D0                          ; $014056
        BLT.W  .done                        ; $014058
        MOVE.B  D0,(A4)                         ; $01405C
        BRA.W  .done                        ; $01405E
.check_left:
        BTST    #2,D1                           ; $014062
        BEQ.S  .check_right                        ; $014066
        MOVE.B  #$A9,(-14172).W                 ; $014068
        TST.W  (A4)                             ; $01406E
        BNE.W  .left_with_ready                        ; $014070
        SUBQ.B  #1,(A0)                         ; $014074
        BCC.W  .update_graphics                        ; $014076
        MOVE.B  #$06,(A0)                       ; $01407A
        BRA.W  .update_graphics                        ; $01407E
.left_with_ready:
        LEA     (-24549).W,A4                   ; $014082
        TST.W  D2                               ; $014086
        BEQ.S  .left_use_p1_slot                        ; $014088
        LEA     (-24548).W,A4                   ; $01408A
.left_use_p1_slot:
        bsr.w   table_entry_swap_by_index; $6100 $00FE
        SUBQ.B  #1,(A4)                         ; $014092
        MOVE.B  (A4),D3                         ; $014094
        CMP.B  (A3),D3                          ; $014096
        BGE.W  .left_clamp_done                        ; $014098
        MOVE.B  #$04,(A4)                       ; $01409C
        TST.W  D0                               ; $0140A0
        BEQ.W  .left_clamp_done                        ; $0140A2
        MOVE.B  #$07,(A4)                       ; $0140A6
.left_clamp_done:
        bsr.w   table_entry_swap_by_index; $6100 $00E2
        BRA.W  .done                        ; $0140AE
.check_right:
        BTST    #3,D1                           ; $0140B2
        BEQ.W  .done                        ; $0140B6
        MOVE.B  #$A9,(-14172).W                 ; $0140BA
        TST.W  (A4)                             ; $0140C0
        BNE.W  .right_with_ready                        ; $0140C2
        ADDQ.B  #1,(A0)                         ; $0140C6
        CMPI.B  #$06,(A0)                       ; $0140C8
        BLE.W  .update_graphics                        ; $0140CC
        CLR.B  (A0)                             ; $0140D0
        BRA.W  .update_graphics                        ; $0140D2
.right_with_ready:
        LEA     (-24549).W,A4                   ; $0140D6
        TST.W  D2                               ; $0140DA
        BEQ.S  .right_use_p1_slot                        ; $0140DC
        LEA     (-24548).W,A4                   ; $0140DE
.right_use_p1_slot:
        bsr.w   table_entry_swap_by_index; $6100 $00AA
        ADDQ.B  #1,(A4)                         ; $0140E6
        MOVE.B  #$04,D3                         ; $0140E8
        TST.W  D0                               ; $0140EC
        BEQ.W  .right_clamp_max                        ; $0140EE
        MOVE.B  #$07,D3                         ; $0140F2
.right_clamp_max:
        CMP.B  (A4),D3                          ; $0140F6
        BGE.W  .right_clamp_done                        ; $0140F8
        MOVE.B  (A3),(A4)                       ; $0140FC
.right_clamp_done:
        bsr.w   table_entry_swap_by_index; $6100 $008E
        BRA.W  .done                        ; $014102
.button_ab_confirm:
        CMPI.B  #$06,(A0)                       ; $014106
        BNE.W  .done                        ; $01410A
        TST.W  (A4)                             ; $01410E
        BNE.W  .done                        ; $014110
        MOVE.W  #$0001,(A4)                     ; $014114
        CLR.B  (A3)                             ; $014118
        LEA     (-24549).W,A4                   ; $01411A
        TST.W  D2                               ; $01411E
        BEQ.S  .confirm_use_p1_slot                        ; $014120
        LEA     (-24548).W,A4                   ; $014122
.confirm_use_p1_slot:
        CLR.B  (A4)                             ; $014126
        BRA.W  .done                        ; $014128
.button_c_toggle:
        CLR.W  (A4)                             ; $01412C
        MOVE.W  #$0007,D0                       ; $01412E
.copy_saved_loop:
        MOVE.B  (A1)+,(A2)+                     ; $014132
        DBRA    D0,.copy_saved_loop                    ; $014134
        BRA.W  .done                        ; $014138
.start_pressed:
        MOVE.B  #$A8,(-14172).W                 ; $01413C
        MOVE.W  #$0001,(-24546).W               ; $014142
        BRA.W  .done                        ; $014148
.update_graphics:
        CMPI.B  #$06,(A0)                       ; $01414C
        BNE.S  .load_car_graphics                        ; $014150
        MOVEA.L A2,A3                           ; $014152
        MOVE.W  #$0007,D2                       ; $014154
        BRA.W  .copy_graphics_loop                        ; $014158
.load_car_graphics:
        CLR.W  D3                               ; $01415C
        MOVE.B  (A0),D3                         ; $01415E
        ADD.W   D3,D3                           ; $014160
        ADD.W   D3,D3                           ; $014162
        ADD.W   D3,D3                           ; $014164
        LEA     $0089AB8E,A3                    ; $014166
        LEA     $00(A3,D3.W),A3                 ; $01416C
        MOVE.W  #$0004,D2                       ; $014170
        TST.W  D0                               ; $014174
        BEQ.S  .copy_graphics_loop                        ; $014176
        LEA     $0089ABBE,A3                    ; $014178
        LEA     $00(A3,D3.W),A3                 ; $01417E
        MOVE.W  #$0007,D2                       ; $014182
.copy_graphics_loop:
        MOVE.B  (A3)+,(A1)+                     ; $014186
        DBRA    D2,.copy_graphics_loop                    ; $014188
.done:
        RTS                                     ; $01418C
