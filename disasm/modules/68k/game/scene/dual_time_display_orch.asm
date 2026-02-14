; ============================================================================
; dual_time_display_orch — Dual Time Display Orchestrator
; ROM Range: $0083E4-$0084F4 (272 bytes)
; Main time display handler for 1P and 2P modes. Manages lap/race time
; display for both players. Reads scene state index, extracts timing data
; from object tables, calls num_to_decimal for digit rendering, and writes
; status codes for HUD updates. Two parallel processing blocks handle
; player 1 (A0) and player 2 (A1) independently.
;
; Entry: A0 = player 1 entity, A1 = player 2 entity
; Uses: D0, D1, D7, A0, A1, A2, A3
; RAM: $68F0 (status_code), $68F8 (time_display_buf), $9F00 (obj_table_3)
; Calls: $00839A (num_to_decimal), $00B3CE, $00B3BC, $0084F4 (time_array_entry_comparison),
;        $00850E (fixed_point_threshold_state_marker)
; Object fields: +$02 flags (bit 6 = update trigger), +$07 display param
; Confidence: high
; ============================================================================

dual_time_display_orch:
        MOVEQ   #$00,D0                         ; $0083E4
        MOVE.B  (-22047).W,D0                   ; $0083E6
        ADDQ.B  #1,(-22047).W                   ; $0083EA
        LEA     (-22041).W,A1                   ; $0083EE
        LEA     (-22288).W,A2                   ; $0083F2
        LSL.W  #2,D0                            ; $0083F6
        LEA     $00(A2,D0.W),A2                 ; $0083F8
        MOVE.L  A2,-(A7)                        ; $0083FC
        jsr     sequence_data_word_decoder(pc); $4EBA $2FCE
        MOVEA.L (A7)+,A1                        ; $008402
        MOVEQ   #$00,D0                         ; $008404
        MOVE.B  (-15591).W,D0                   ; $008406
        ANDI.W  #$00C0,D0                       ; $00840A
        LSR.W  #6,D0                            ; $00840E
        SUBQ.W  #1,D0                           ; $008410
        ADD.W   D0,D0                           ; $008412
        jmp     ai_param_lookup_threshold_check_00b398+36(pc); $4EFA $2FA6
        BTST    #6,$0002(A0)                    ; $008418
        BEQ.S  .loc_0088                        ; $00841E
        ANDI.W  #$BFFF,$0002(A0)                ; $008420
        CLR.W  (-14166).W                       ; $008426
        LEA     (-22528).W,A2                   ; $00842A
        LEA     (-22288).W,A3                   ; $00842E
        MOVEQ   #$00,D1                         ; $008432
        MOVE.B  (-22048).W,D1                   ; $008434
        jsr     time_array_entry_comparison(pc); $4EBA $00BA
        BEQ.S  .loc_0062                        ; $00843C
        MOVE.W  #$0000,(-16306).W               ; $00843E
        BRA.S  .loc_00A6                        ; $008444
.loc_0062:
        ANDI.W  #$BFFF,$0002(A1)                ; $008446
        jsr     fixed_point_threshold_state_marker(pc); $4EBA $00C0
        LEA     $00FF68F8,A1                    ; $008450
        MOVE.L  #$04028070,-$0004(A1)           ; $008456
        MOVE.B  D0,-$0007(A1)                   ; $00845E
        MOVE.B  D1,(A1)+                        ; $008462
        jsr     nibble_unpack(pc)       ; $4EBA $FF34
        LEA     (-24832).W,A1                   ; $008468
.loc_0088:
        TST.W  (-16306).W                       ; $00846C
        BEQ.S  .loc_00A6                        ; $008470
        MOVEQ   #$00,D7                         ; $008472
        SUBQ.W  #1,(-16306).W                   ; $008474
        BEQ.S  .loc_00A0                        ; $008478
        BTST    #2,(-14165).W                   ; $00847A
        BNE.S  .loc_00A0                        ; $008480
        MOVEQ   #$03,D7                         ; $008482
.loc_00A0:
        MOVE.B  D7,$00FF68F0                    ; $008484
.loc_00A6:
        BTST    #6,$0002(A1)                    ; $00848A
        BEQ.S  .loc_00F0                        ; $008490
        ANDI.W  #$BFFF,$0002(A1)                ; $008492
        CLR.W  (-14166).W                       ; $008498
        LEA     (-22288).W,A2                   ; $00849C
        LEA     (-22528).W,A3                   ; $0084A0
        MOVEQ   #$00,D1                         ; $0084A4
        MOVE.B  (-22047).W,D1                   ; $0084A6
        jsr     time_array_entry_comparison(pc); $4EBA $0048
        BEQ.S  .loc_00D4                        ; $0084AE
        MOVE.W  #$0000,(-18514).W               ; $0084B0
        BRA.S  .loc_010E                        ; $0084B6
.loc_00D4:
        jsr     fixed_point_threshold_state_marker(pc); $4EBA $0054
        LEA     $00FF68F8,A1                    ; $0084BC
        MOVE.L  #$04034070,-$0004(A1)           ; $0084C2
        MOVE.B  D0,-$0007(A1)                   ; $0084CA
        MOVE.B  D1,(A1)+                        ; $0084CE
        jsr     nibble_unpack(pc)       ; $4EBA $FEC8
.loc_00F0:
        TST.W  (-18514).W                       ; $0084D4
        BEQ.S  .loc_010E                        ; $0084D8
        MOVEQ   #$00,D7                         ; $0084DA
        SUBQ.W  #1,(-18514).W                   ; $0084DC
        BEQ.S  .loc_0108                        ; $0084E0
        BTST    #2,(-14165).W                   ; $0084E2
        BNE.S  .loc_0108                        ; $0084E8
        MOVEQ   #$03,D7                         ; $0084EA
.loc_0108:
        MOVE.B  D7,$00FF68F0                    ; $0084EC
.loc_010E:
        RTS                                     ; $0084F2
