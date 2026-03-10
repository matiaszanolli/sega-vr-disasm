; ============================================================================
; FM Envelope Tick Update — advance all channel envelopes per frame
; ROM Range: $030A86-$030AF8 (114 bytes)
; ============================================================================
; Decrements frame counter (A6+$04); if zero, branches to silence handler
; ($030B90). Sets tempo=1 (A6+$06). Iterates all channel types:
;   DAC ($0040): advances envelope +$09 by 4, overflow→silence, else
;     calls z80_dac_write ($030DF4).
;   FM ($0070, 6 channels): advances +$09 by 1, overflow→silence, else
;     calls $03135A.
;   PSG ($0220+, 3 channels): advances +$09 by 1, limit=$10→silence,
;     else calls $030F60 with position in D6.
;
; Entry: A6 = sound driver state pointer
; Uses: D6, D7, A5, A6
; Calls:
;   $030DF4: z80_dac_write
;   $03135A: [fm_envelope_write]
;   $030F60: [psg_envelope_write]
; Confidence: medium
; ============================================================================

fm_envelope_tick_update:
        SUBQ.B  #1,$0004(A6)                    ; $030A86
        DC.W    $6700,$0104         ; BEQ.W  $030B90; $030A8A
        MOVE.B  #$01,$0006(A6)                  ; $030A8E
        LEA     $0040(A6),A5                    ; $030A94
        TST.B  (A5)                             ; $030A98
        BPL.S  .dac_done                        ; $030A9A
        ADDQ.B  #4,$0009(A5)                    ; $030A9C
        BPL.S  .dac_write                       ; $030AA0
        BCLR    #7,(A5)                         ; $030AA2
        BRA.S  .dac_done                        ; $030AA6
.dac_write:
        jsr     z80_sound_write(pc)     ; $4EBA $034A
.dac_done:
        LEA     $0070(A6),A5                    ; $030AAC
        MOVEQ   #$05,D7                         ; $030AB0
.fm_channel_loop:
        TST.B  (A5)                             ; $030AB2
        BPL.S  .fm_next_channel                 ; $030AB4
        ADDQ.B  #1,$0009(A5)                    ; $030AB6
        BPL.S  .fm_write                        ; $030ABA
        BCLR    #7,(A5)                         ; $030ABC
        BRA.S  .fm_next_channel                 ; $030AC0
.fm_write:
        jsr     fm_tl_scaling_table_volume_reg_writer+8(pc); $4EBA $0896
.fm_next_channel:
        ADDA.W  #$0030,A5                       ; $030AC6
        DBRA    D7,.fm_channel_loop              ; $030ACA
        MOVEQ   #$02,D7                         ; $030ACE
.psg_channel_loop:
        TST.B  (A5)                             ; $030AD0
        BPL.S  .psg_next_channel                ; $030AD2
        ADDQ.B  #1,$0009(A5)                    ; $030AD4
        CMPI.B  #$10,$0009(A5)                  ; $030AD8
        BCS.S  .psg_write                       ; $030ADE
        BCLR    #7,(A5)                         ; $030AE0
        BRA.S  .psg_next_channel                ; $030AE4
.psg_write:
        MOVE.B  $0009(A5),D6                    ; $030AE6
        jsr     psg_volume_envelope_proc+82(pc); $4EBA $0474
.psg_next_channel:
        ADDA.W  #$0030,A5                       ; $030AEE
        DBRA    D7,.psg_channel_loop             ; $030AF2
        RTS                                     ; $030AF6
