; ============================================================================
; FM TL Scaling Table + Volume Register Writer — update TL with volume
; ROM Range: $031352-$0313CA (120 bytes)
; ============================================================================
; Data prefix: 8-byte key scaling table at $031352 (operator TL scaling
; bits for 8 algorithm types). Code at $03135A: Updates FM Total Level
; registers with current volume. Checks key-off (bit 2). Resolves
; instrument data pointer, advances past 21 header bytes to TL data.
; Reads scaling table by algorithm (A5+$25), gets volume (A5+$09).
; For each of 4 operators: reads base TL from instrument, adds channel
; volume if carry bit set in scaling table, writes via fm_write_conditional.
; Releases Z80 bus when done.
;
; Entry: A5 = channel structure pointer
; Entry: A6 = sound driver state pointer
; Uses: D0, D1, D3, D4, D5, A1, A2
; Calls:
;   $030CCC: fm_write_conditional
;   $030D1C: z80_bus_request
; Confidence: high
; ============================================================================

fm_tl_scaling_table_volume_reg_writer:
        DC.W    $0808                           ; $031352
        DC.W    $0808                           ; $031354
        DC.W    $0A0E                           ; $031356
        DC.W    $0E0F                           ; $031358
        BTST    #2,(A5)                         ; $03135A
        BNE.S  .loc_0076                        ; $03135E
        MOVEQ   #$00,D0                         ; $031360
        MOVE.B  $000B(A5),D0                    ; $031362
        MOVEA.L $0030(A6),A1                    ; $031366
        TST.B  $000E(A6)                        ; $03136A
        BEQ.S  .loc_002C                        ; $03136E
        MOVEA.L $0020(A5),A1                    ; $031370
        TST.B  $000E(A6)                        ; $031374
        BMI.S  .loc_002C                        ; $031378
        MOVEA.L $0034(A6),A1                    ; $03137A
.loc_002C:
        SUBQ.W  #1,D0                           ; $03137E
        BMI.S  .loc_003A                        ; $031380
        MOVE.W  #$0019,D1                       ; $031382
.loc_0034:
        ADDA.W  D1,A1                           ; $031386
        DBRA    D0,.loc_0034                    ; $031388
.loc_003A:
        ADDA.W  #$0015,A1                       ; $03138C
        lea     fm_reg_table_vibrato_setup+20(pc),a2; $45FA $004C
        MOVE.B  $0025(A5),D0                    ; $031394
        ANDI.W  #$0007,D0                       ; $031398
        MOVE.B  $031352(PC,D0.W),D4             ; $03139C
        MOVE.B  $0009(A5),D3                    ; $0313A0
        BMI.S  .loc_0076                        ; $0313A4
        MOVEQ   #$03,D5                         ; $0313A6
        jsr     z80_bus_wait(pc)        ; $4EBA $F972
.loc_005A:
        MOVE.B  (A2)+,D0                        ; $0313AC
        MOVE.B  (A1)+,D1                        ; $0313AE
        LSR.B  #1,D4                            ; $0313B0
        BCC.S  .loc_006A                        ; $0313B2
        ADD.B   D3,D1                           ; $0313B4
        BCS.S  .loc_006A                        ; $0313B6
        jsr     fm_write_cond(pc)       ; $4EBA $F912
.loc_006A:
        DBRA    D5,.loc_005A                    ; $0313BC
        MOVE.W  #$0000,Z80_BUSREQ                ; $0313C0
.loc_0076:
        RTS                                     ; $0313C8
