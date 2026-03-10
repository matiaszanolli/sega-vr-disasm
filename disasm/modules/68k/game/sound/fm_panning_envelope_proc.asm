; ============================================================================
; FM Panning Envelope Processor — step through panning envelope data
; ROM Range: $030404-$03046C (104 bytes)
; ============================================================================
; Processes FM panning envelope: reads envelope position (A5+$21) against
; envelope length (A5+$22), advances through repeat cycles (A5+$23/$24).
; Looks up envelope data table via ROM pointer at fm_panning_init_channel_stereo_setup's table,
; indexed by instrument number (A5+$20). Combines envelope value with
; channel flags (A5+$27 AND $37) using OR, writes to panning register
; $B4 via fm_conditional_write.
;
; Entry: A5 = FM channel structure pointer
; Uses: D0, D1, D3, A0, A5
; Calls:
;   $030CA2: fm_conditional_write
; Confidence: medium
; ============================================================================

fm_panning_envelope_proc:
        BRA.S  .process                         ; $030404
        BRA.S  .process                         ; $030406
        MOVE.B  $0023(A5),$0024(A5)             ; $030408
        CLR.B  $0021(A5)                        ; $03040E
.process:
        MOVE.B  $0024(A5),D0                    ; $030412
        CMP.B  $0023(A5),D0                     ; $030416
        BNE.S  .load_envelope                   ; $03041A
        MOVE.B  $0022(A5),D3                    ; $03041C
        CMP.B  $0021(A5),D3                     ; $030420
        BPL.S  .reset_position                  ; $030424
        CMPI.B  #$02,$0028(A5)                  ; $030426
        BEQ.S  .done                            ; $03042C
        CLR.B  $0021(A5)                        ; $03042E
.reset_position:
        CLR.B  $0024(A5)                        ; $030432
        ADDQ.B  #1,$0021(A5)                    ; $030436
.load_envelope:
        MOVEQ   #$00,D0                         ; $03043A
        MOVE.B  $0020(A5),D0                    ; $03043C
        SUBQ.W  #1,D0                           ; $030440
        LSL.W  #2,D0                            ; $030442
        MOVEA.L $03046C(PC,D0.W),A0             ; $030444
        MOVEQ   #$00,D0                         ; $030448
        MOVE.B  $0021(A5),D0                    ; $03044A
        SUBQ.W  #1,D0                           ; $03044E
        MOVE.B  $00(A0,D0.W),D1                 ; $030450
        MOVE.B  $0027(A5),D0                    ; $030454
        ANDI.B  #$37,D0                         ; $030458
        OR.B    D0,D1                           ; $03045C
        MOVE.B  #$B4,D0                         ; $03045E
        jsr     fm_cond_write_with_bus(pc); $4EBA $083E
        ADDQ.B  #1,$0024(A5)                    ; $030466
.done:
        RTS                                     ; $03046A
