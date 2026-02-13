; ============================================================================
; FM Operator Register Write — load and write 4 operator values
; ROM Range: $03124A-$0312A6 (92 bytes)
; ============================================================================
; Loads instrument data from A6+$30 pointer (or A5+$20 if set). Reads
; control byte from sequence: bit 7 of each nibble selects which operators
; to write. Iterates 4 operators using register table at $031298, writes
; values via fm_conditional_write. Then reads feedback/algorithm byte and
; writes register $22 via fm_write_wrapper. Finally reads panning byte,
; merges with existing (A5+$27 AND $C0), writes register $B4.
; Data suffix at $031298: 4 FM register bytes, then 2 data bytes at
; $03129C (used as entry for fn_30200_049's set-tempo-and-multiplier).
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Entry: A6 = sound driver state pointer
; Uses: D0, D1, D3, D6, A0, A1, A2, A4
; Calls:
;   $030CA2: fm_conditional_write
;   $030CBA: fm_write_wrapper
; Confidence: high
; ============================================================================

fn_30200_048:
        MOVEA.L $0030(A6),A1                    ; $03124A
        BEQ.S  .loc_000A                        ; $03124E
        MOVEA.L $0020(A5),A1                    ; $031250
.loc_000A:
        MOVE.B  (A4),D3                         ; $031254
        ADDA.W  #$0009,A0                       ; $031256
        DC.W    $45FA,$003C         ; LEA     $031298(PC),A2; $03125A
        MOVEQ   #$03,D6                         ; $03125E
.loc_0016:
        MOVE.B  (A1)+,D1                        ; $031260
        MOVE.B  (A2)+,D0                        ; $031262
        BTST    #7,D3                           ; $031264
        BEQ.S  .loc_0028                        ; $031268
        BSET    #7,D1                           ; $03126A
        DC.W    $4EBA,$FA32         ; JSR     $030CA2(PC); $03126E
.loc_0028:
        LSL.W  #1,D3                            ; $031272
        DBRA    D6,.loc_0016                    ; $031274
        MOVE.B  (A4)+,D1                        ; $031278
        MOVEQ   #$22,D0                         ; $03127A
        DC.W    $4EBA,$FA3C         ; JSR     $030CBA(PC); $03127C
        MOVE.B  (A4)+,D1                        ; $031280
        MOVE.B  $0027(A5),D0                    ; $031282
        ANDI.B  #$C0,D0                         ; $031286
        OR.B    D0,D1                           ; $03128A
        MOVE.B  D1,$0027(A5)                    ; $03128C
        MOVE.B  #$B4,D0                         ; $031290
        DC.W    $6000,$FA0C         ; BRA.W  $030CA2; $031294
        DC.W    $6068               ; BRA.S  $031302; $031298
        DC.W    $646C               ; BCC.S  $031308; $03129A
        MOVE.B  (A4),$0002(A6)                  ; $03129C
        MOVE.B  (A4)+,$0001(A6)                 ; $0312A0
        RTS                                     ; $0312A4
