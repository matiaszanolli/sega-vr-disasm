; ============================================================================
; FM Fade In/Out Processor — adjust all channel volumes per frame
; ROM Range: $030D4E-$030DEE (160 bytes)
; ============================================================================
; Checks fade state at A6+$38 (0=off, 2=done → skip). For active fades:
; adjusts envelope position (A5+$09) for all channel types using per-type
; fade rates stored at A6+$39 (DAC), $3A (FM), $3B (PSG):
;   Fade out (negative $38): subtracts rate, calls write on underflow
;   Fade in (positive $38): adds rate, silences on overflow
;   DAC ($0040): calls z80_dac_write ($030DF4)
;   FM ($0070, 6 channels): calls $03135A
;   PSG ($0220+, 3 channels): limit $10, calls $030F60
; After fade-in cycle completes, sets state to $02 (done).
;
; Entry: A6 = sound driver state pointer
; Uses: D5, D6, D7, A5, A6
; Confidence: medium
; ============================================================================

fm_fade_in_out_proc:
        TST.B  $0038(A6)                        ; $030D4E
        DC.W    $6700,$009E         ; BEQ.W  $030DF2; $030D52
        CMPI.B  #$02,$0038(A6)                  ; $030D56
        DC.W    $6700,$0094         ; BEQ.W  $030DF2; $030D5C
        MOVE.B  $0039(A6),D6                    ; $030D60
        LEA     $0040(A6),A5                    ; $030D64
        TST.B  (A5)                             ; $030D68
        BPL.S  .dac_done                        ; $030D6A
        TST.B  $0038(A6)                        ; $030D6C
        BPL.S  .dac_fade_in                     ; $030D70
        SUB.B  D6,$0009(A5)                     ; $030D72
        BRA.S  .dac_write                       ; $030D76
.dac_fade_in:
        ADD.B  D6,$0009(A5)                     ; $030D78
        BMI.S  .dac_done                        ; $030D7C
.dac_write:
        jsr     z80_sound_write(pc)     ; $4EBA $0074
.dac_done:
        MOVE.B  $003A(A6),D6                    ; $030D82
        LEA     $0070(A6),A5                    ; $030D86
        MOVEQ   #$05,D7                         ; $030D8A
.fm_channel_loop:
        TST.B  (A5)                             ; $030D8C
        BPL.S  .fm_next_channel                 ; $030D8E
        TST.B  $0038(A6)                        ; $030D90
        BPL.S  .fm_fade_in                      ; $030D94
        SUB.B  D6,$0009(A5)                     ; $030D96
        BRA.S  .fm_write                        ; $030D9A
.fm_fade_in:
        ADD.B  D6,$0009(A5)                     ; $030D9C
        BMI.S  .fm_next_channel                 ; $030DA0
.fm_write:
        jsr     fm_tl_scaling_table_volume_reg_writer+8(pc); $4EBA $05B6
.fm_next_channel:
        ADDA.W  #$0030,A5                       ; $030DA6
        DBRA    D7,.fm_channel_loop              ; $030DAA
        MOVE.B  $003B(A6),D5                    ; $030DAE
        MOVEQ   #$02,D7                         ; $030DB2
.psg_channel_loop:
        TST.B  (A5)                             ; $030DB4
        BPL.S  .psg_next_channel                ; $030DB6
        TST.B  $0038(A6)                        ; $030DB8
        BPL.S  .psg_fade_in                     ; $030DBC
        SUB.B  D5,$0009(A5)                     ; $030DBE
        BRA.S  .psg_write                       ; $030DC2
.psg_fade_in:
        ADD.B  D5,$0009(A5)                     ; $030DC4
        CMPI.B  #$10,$0009(A5)                  ; $030DC8
        BCC.S  .psg_next_channel                ; $030DCE
.psg_write:
        MOVE.B  $0009(A5),D6                    ; $030DD0
        jsr     psg_volume_envelope_proc+82(pc); $4EBA $018A
.psg_next_channel:
        ADDA.W  #$0030,A5                       ; $030DD8
        DBRA    D7,.psg_channel_loop             ; $030DDC
        TST.B  $0038(A6)                        ; $030DE0
        DC.W    $6B08               ; BMI.S  $030DEE; $030DE4
        MOVE.B  #$02,$0038(A6)                  ; $030DE6
        RTS                                     ; $030DEC
