; ============================================================================
; Fm Conditional Write 048 (auto-analyzed)
; ROM Range: $03124A-$0312A6 (92 bytes)
; ============================================================================
; Category: sound
; Purpose: Calls: fm_conditional_write, fm_write_wrapper
;   Object (A5, A6): +$01, +$02 (flags/type), +$20, +$27, +$30 (x_position)
;
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D3, D6, A0, A1, A2, A4
; Calls:
;   $030CA2: fm_conditional_write
;   $030CBA: fm_write_wrapper
; Object fields:
;   +$01: [unknown]
;   +$02: flags/type
;   +$20: [unknown]
;   +$27: [unknown]
;   +$30: x_position
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
        DC.W    $8200                           ; $03128A
        MOVE.B  D1,$0027(A5)                    ; $03128C
        MOVE.B  #$B4,D0                         ; $031290
        DC.W    $6000,$FA0C         ; BRA.W  $030CA2; $031294
        DC.W    $6068               ; BRA.S  $031302; $031298
        DC.W    $646C               ; BCC.S  $031308; $03129A
        MOVE.B  (A4),$0002(A6)                  ; $03129C
        MOVE.B  (A4)+,$0001(A6)                 ; $0312A0
        RTS                                     ; $0312A4
