; ============================================================================
; Sh2 Comm Cmd 27 038 (auto-analyzed)
; ROM Range: $014200-$014262 (98 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: COMM0
;   Calls: sh2_cmd_27
;   Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, A0, A1
; Calls:
;   $00E3B4: sh2_cmd_27
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_14200_038:
        DC.W    $AB6E                           ; $014200
        MOVE.W  #$0006,D3                       ; $014202
        CLR.W  D2                               ; $014206
        MOVE.B  (A0),D2                         ; $014208
        MOVE.W  D2,D4                           ; $01420A
        DC.W    $D442                           ; $01420C
        DC.W    $D442                           ; $01420E
        MOVEA.L $00(A1,D2.W),A0                 ; $014210
        ADDA.L  D1,A0                           ; $014214
        MOVE.W  #$0050,D0                       ; $014216
        MOVE.W  #$0007,D1                       ; $01421A
        MOVE.W  #$003C,D2                       ; $01421E
.loc_0022:
        TST.B  $00A15120                        ; $014222
        BNE.S  .loc_0022                        ; $014228
        DC.W    $4EBA,$A188         ; JSR     $00E3B4(PC); $01422A
        DC.W    $9644                           ; $01422E
        BCS.W  .loc_0060                        ; $014230
        ADDQ.W  #1,D4                           ; $014234
.loc_0036:
        MOVE.B  D4,D2                           ; $014236
        DC.W    $D442                           ; $014238
        DC.W    $D442                           ; $01423A
        MOVEA.L $00(A1,D2.W),A0                 ; $01423C
        ADDA.L  D5,A0                           ; $014240
        MOVE.W  #$0050,D0                       ; $014242
        MOVE.W  #$0007,D1                       ; $014246
        MOVE.W  #$0040,D2                       ; $01424A
.loc_004E:
        TST.B  $00A15120                        ; $01424E
        BNE.S  .loc_004E                        ; $014254
        DC.W    $4EBA,$A15C         ; JSR     $00E3B4(PC); $014256
        ADDQ.W  #1,D4                           ; $01425A
        DBRA    D3,.loc_0036                    ; $01425C
.loc_0060:
        RTS                                     ; $014260
