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
        BRA.S  .loc_000E                        ; $030404
        BRA.S  .loc_000E                        ; $030406
        MOVE.B  $0023(A5),$0024(A5)             ; $030408
        CLR.B  $0021(A5)                        ; $03040E
.loc_000E:
        MOVE.B  $0024(A5),D0                    ; $030412
        CMP.B  $0023(A5),D0                     ; $030416
        BNE.S  .loc_0036                        ; $03041A
        MOVE.B  $0022(A5),D3                    ; $03041C
        CMP.B  $0021(A5),D3                     ; $030420
        BPL.S  .loc_002E                        ; $030424
        CMPI.B  #$02,$0028(A5)                  ; $030426
        BEQ.S  .loc_0066                        ; $03042C
        CLR.B  $0021(A5)                        ; $03042E
.loc_002E:
        CLR.B  $0024(A5)                        ; $030432
        ADDQ.B  #1,$0021(A5)                    ; $030436
.loc_0036:
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
        DC.W    $4EBA,$083E         ; JSR     $030CA2(PC); $030462
        ADDQ.B  #1,$0024(A5)                    ; $030466
.loc_0066:
        RTS                                     ; $03046A
