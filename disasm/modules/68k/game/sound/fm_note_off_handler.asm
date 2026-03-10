; ============================================================================
; FM Note-Off Handler — key-off channel and cleanup related channels
; ROM Range: $031418-$0314DC (196 bytes)
; ============================================================================
; Clears active (bit 7) and sustain (bit 4) flags. Routes by channel type:
;   FM (positive A5+$01): calls fm_init_channel, then if multi-channel
;     mode (A6+$0E set): resolves related channel struct via $030852
;     table, clears key-off/sets mute, writes instrument registers. For
;     channel type 2: writes key-off-all ($27=$00) via fm_write_wrapper.
;   PSG (negative): calls fm_set_volume for silence, resolves PSG channel
;     struct ($0370 or from table), clears key-off/sets mute. $E0 type
;     writes PSG silence byte.
; Pops 2 return addresses (ADDQ.W #8,A7) — exits both caller and
; grandparent.
;
; Entry: A5 = channel structure pointer
; Entry: A6 = sound driver state pointer
; Uses: D0, D1, A0, A1, A3, A5
; Calls:
;   $030C8A: fm_init_channel
;   $030CBA: fm_write_wrapper
;   $030FB2: fm_set_volume
; Confidence: high
; ============================================================================

fm_note_off_handler:
        BCLR    #7,(A5)                         ; $031418
        BCLR    #4,(A5)                         ; $03141C
        TST.B  $0001(A5)                        ; $031420
        BMI.S  .psg_silence                     ; $031424
        TST.B  $0008(A6)                        ; $031426
        BMI.W  .done                            ; $03142A
        jsr     fm_init_channel(pc)     ; $4EBA $F85A
        BRA.S  .check_multi_channel             ; $031432
.psg_silence:
        jsr     psg_set_pos_silence+16(pc); $4EBA $FB7C
.check_multi_channel:
        TST.B  $000E(A6)                        ; $031438
        BPL.W  .done                            ; $03143C
        CLR.B  $0000(A6)                        ; $031440
        MOVEQ   #$00,D0                         ; $031444
        MOVE.B  $0001(A5),D0                    ; $031446
        BMI.S  .psg_related                     ; $03144A
        lea     fm_channel_pointer_table_sfx_loader(pc),a0; $41FA $F404
        MOVEA.L A5,A3                           ; $031450
        CMPI.B  #$04,D0                         ; $031452
        BNE.S  .resolve_fm_channel              ; $031456
        TST.B  $0340(A6)                        ; $031458
        BPL.S  .resolve_fm_channel              ; $03145C
        LEA     $0340(A6),A5                    ; $03145E
        MOVEA.L $0034(A6),A1                    ; $031462
        BRA.S  .clear_keyoff_set_mute           ; $031466
.resolve_fm_channel:
        SUBQ.B  #2,D0                           ; $031468
        LSL.B  #2,D0                            ; $03146A
        MOVEA.L $00(A0,D0.W),A5                 ; $03146C
        TST.B  (A5)                             ; $031470
        BPL.S  .restore_a5                      ; $031472
        MOVEA.L $0030(A6),A1                    ; $031474
.clear_keyoff_set_mute:
        BCLR    #2,(A5)                         ; $031478
        BSET    #1,(A5)                         ; $03147C
        MOVE.B  $000B(A5),D0                    ; $031480
        jsr     fm_instrument_reg_write+52(pc); $4EBA $FE62
.restore_a5:
        MOVEA.L A3,A5                           ; $031488
        CMPI.B  #$02,$0001(A5)                  ; $03148A
        BNE.S  .done                            ; $031490
        TST.B  $000F(A6)                        ; $031492
        BNE.S  .done                            ; $031496
        MOVEQ   #$00,D1                         ; $031498
        MOVEQ   #$27,D0                         ; $03149A
        jsr     fm_write_wrapper(pc)    ; $4EBA $F81C
        BRA.S  .done                            ; $0314A0
.psg_related:
        LEA     $0370(A6),A0                    ; $0314A2
        TST.B  (A0)                             ; $0314A6
        BPL.S  .resolve_psg_from_table          ; $0314A8
        CMPI.B  #$E0,D0                         ; $0314AA
        BEQ.S  .clear_psg_keyoff                ; $0314AE
        CMPI.B  #$C0,D0                         ; $0314B0
        BEQ.S  .clear_psg_keyoff                ; $0314B4
.resolve_psg_from_table:
        lea     fm_channel_pointer_table_sfx_loader(pc),a0; $41FA $F39A
        LSR.B  #3,D0                            ; $0314BA
        MOVEA.L $00(A0,D0.W),A0                 ; $0314BC
.clear_psg_keyoff:
        BCLR    #2,(A0)                         ; $0314C0
        BSET    #1,(A0)                         ; $0314C4
        CMPI.B  #$E0,$0001(A0)                  ; $0314C8
        BNE.S  .done                            ; $0314CE
        MOVE.B  $0025(A0),PSG             ; $0314D0
.done:
        ADDQ.W  #8,A7                           ; $0314D8
        RTS                                     ; $0314DA
