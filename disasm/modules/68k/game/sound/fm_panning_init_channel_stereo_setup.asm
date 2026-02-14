; ============================================================================
; FM Panning Init + Channel Stereo Setup — initialize panning for all channels
; ROM Range: $03046C-$030536 (202 bytes)
; ============================================================================
; Data prefix: 4 longword pointers to panning envelope tables (used by
; fm_panning_envelope_proc). Code begins at $030480 with two paths:
;   Positive: Writes panning register $B4 with D1=0 (center) for 3 FM
;     channels via fm_write_port0, then writes key-on register $28 for
;     each, branches to $030FC8.
;   Negative: Iterates all sound channels in A6 structure ($0040 stride
;     for 7 channels, $0220 offset for 3 more, $0340 for 1), reads each
;     channel's panning value (A5+$27), writes to register $B4 via
;     fm_write_conditional. Releases Z80 bus when done.
;
; Entry: A6 = sound driver state pointer
; Uses: D0, D1, D2, D3, D4, A5, A6
; Calls:
;   $030CCC: fm_write_conditional
;   $030CD8: fm_write_port0
;   $030D1C: z80_bus_request
; Confidence: medium
; ============================================================================

fm_panning_init_channel_stereo_setup:
        DC.W    $008B                           ; $03046C
        SUBI.W  #$008B,($047A).W                ; $03046E
        DC.W    $008B                           ; $030474
        DC.W    $047D                           ; $030476
        NEGX.L D0                               ; $030478
        MOVE    SR,D0                           ; $03047A
        DIVU    D0,D0                           ; $03047C
        DIVU    D0,D0                           ; $03047E
        NEGX.B D0                               ; $030480
        BMI.S  .loc_0052                        ; $030482
        MOVEQ   #$02,D2                         ; $030484
        MOVE.B  #$B4,D0                         ; $030486
        MOVEQ   #$00,D1                         ; $03048A
        jsr     z80_bus_wait(pc)        ; $4EBA $088E
.loc_0024:
        jsr     fm_write_cond+12(pc)    ; $4EBA $0846
        jsr     fm_write_port_0_1+10(pc); $4EBA $0868
        ADDQ.B  #1,D0                           ; $030498
        DBRA    D2,.loc_0024                    ; $03049A
        MOVEQ   #$02,D2                         ; $03049E
        MOVEQ   #$28,D0                         ; $0304A0
.loc_0036:
        MOVE.B  D2,D1                           ; $0304A2
        jsr     fm_write_cond+12(pc)    ; $4EBA $0832
        ADDQ.B  #4,D1                           ; $0304A8
        jsr     fm_write_cond+12(pc)    ; $4EBA $082C
        DBRA    D2,.loc_0036                    ; $0304AE
        MOVE.W  #$0000,Z80_BUSREQ                ; $0304B2
        DC.W    $6000,$0B0C         ; BRA.W  $030FC8; $0304BA
.loc_0052:
        CLR.B  $0007(A6)                        ; $0304BE
        MOVEQ   #$30,D3                         ; $0304C2
        LEA     $0040(A6),A5                    ; $0304C4
        MOVEQ   #$06,D4                         ; $0304C8
        jsr     z80_bus_wait(pc)        ; $4EBA $0850
.loc_0062:
        BTST    #7,(A5)                         ; $0304CE
        BEQ.S  .loc_007A                        ; $0304D2
        BTST    #2,(A5)                         ; $0304D4
        BNE.S  .loc_007A                        ; $0304D8
        MOVE.B  #$B4,D0                         ; $0304DA
        MOVE.B  $0027(A5),D1                    ; $0304DE
        jsr     fm_write_cond(pc)       ; $4EBA $07E8
.loc_007A:
        ADDA.W  D3,A5                           ; $0304E6
        DBRA    D4,.loc_0062                    ; $0304E8
        LEA     $0220(A6),A5                    ; $0304EC
        MOVEQ   #$02,D4                         ; $0304F0
.loc_0086:
        BTST    #7,(A5)                         ; $0304F2
        BEQ.S  .loc_009E                        ; $0304F6
        BTST    #2,(A5)                         ; $0304F8
        BNE.S  .loc_009E                        ; $0304FC
        MOVE.B  #$B4,D0                         ; $0304FE
        MOVE.B  $0027(A5),D1                    ; $030502
        jsr     fm_write_cond(pc)       ; $4EBA $07C4
.loc_009E:
        ADDA.W  D3,A5                           ; $03050A
        DBRA    D4,.loc_0086                    ; $03050C
        LEA     $0340(A6),A5                    ; $030510
        BTST    #7,(A5)                         ; $030514
        BEQ.S  .loc_00C0                        ; $030518
        BTST    #2,(A5)                         ; $03051A
        BNE.S  .loc_00C0                        ; $03051E
        MOVE.B  #$B4,D0                         ; $030520
        MOVE.B  $0027(A5),D1                    ; $030524
        jsr     fm_write_cond(pc)       ; $4EBA $07A2
.loc_00C0:
        MOVE.W  #$0000,Z80_BUSREQ                ; $03052C
        RTS                                     ; $030534
