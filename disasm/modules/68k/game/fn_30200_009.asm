; ============================================================================
; Fm Dispatch 009 (auto-analyzed)
; ROM Range: $030404-$03046C (104 bytes)
; ============================================================================
; Category: sound
; Purpose: State dispatcher using jump table
;   Calls: fm_conditional_write
;   Object (A0, A5): +$00, +$20, +$21, +$22, +$23, +$24
;
; Entry: A0 = object/entity pointer
; Entry: A5 = object/entity pointer
; Uses: D0, D1, D3, A0, A5
; Calls:
;   $030CA2: fm_conditional_write
; Object fields:
;   +$00: [unknown]
;   +$20: [unknown]
;   +$21: [unknown]
;   +$22: [unknown]
;   +$23: [unknown]
;   +$24: [unknown]
;   +$27: [unknown]
;   +$28: [unknown]
; Confidence: medium
; ============================================================================

fn_30200_009:
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
        DC.W    $8200                           ; $03045C
        MOVE.B  #$B4,D0                         ; $03045E
        DC.W    $4EBA,$083E         ; JSR     $030CA2(PC); $030462
        ADDQ.B  #1,$0024(A5)                    ; $030466
.loc_0066:
        RTS                                     ; $03046A
