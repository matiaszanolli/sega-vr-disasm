; ============================================================================
; Obj Race 027 (auto-analyzed)
; ROM Range: $007280-$00734E (206 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8A0 (race_state)
;   Object (A0, A1, A3): +$00, +$30 (x_position), +$34 (y_position), +$CA, +$CC
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D6, D7, A0
; RAM:
;   $C8A0: race_state
; Object fields:
;   +$00: [unknown]
;   +$30: x_position
;   +$34: y_position
;   +$CA: [unknown]
;   +$CC: [unknown]
; Confidence: high
; ============================================================================

fn_6200_027:
        MOVE.L  A4,-(A7)                        ; $007280
        MOVE.W  #$0400,D1                       ; $007282
        MOVE.W  $0030(A0),D2                    ; $007286
        ASR.W  #4,D2                            ; $00728A
        DC.W    $D441                           ; $00728C
        MOVE.W  D2,D3                           ; $00728E
        MOVEQ   #$00,D6                         ; $007290
        ANDI.W  #$0020,D3                       ; $007292
        BNE.S  .loc_001A                        ; $007296
        MOVEQ   #$01,D6                         ; $007298
.loc_001A:
        ASR.W  #6,D2                            ; $00729A
        MOVE.W  $0034(A0),D3                    ; $00729C
        ASR.W  #4,D3                            ; $0072A0
        DC.W    $9243                           ; $0072A2
        MOVE.W  D1,D3                           ; $0072A4
        ANDI.W  #$0020,D3                       ; $0072A6
        BEQ.S  .loc_002E                        ; $0072AA
        ADDQ.B  #2,D6                           ; $0072AC
.loc_002E:
        ANDI.W  #$FFC0,D1                       ; $0072AE
        ASR.W  #1,D1                            ; $0072B2
        DC.W    $D242                           ; $0072B4
        DC.W    $D241                           ; $0072B6
        DC.W    $D241                           ; $0072B8
        MOVE.W  D1,$00CA(A0)                    ; $0072BA
        MOVEQ   #$00,D0                         ; $0072BE
        MOVE.W  $00CC(A0),D0                    ; $0072C0
        ADDI.W  #$1000,D0                       ; $0072C4
        ASL.L  #5,D0                            ; $0072C8
        SWAP    D0                              ; $0072CA
        ANDI.W  #$001C,D0                       ; $0072CC
        LEA     $0089A932,A3                    ; $0072D0
        MOVEA.L $00(A3,D0.W),A3                 ; $0072D6
        BTST    #2,D0                           ; $0072DA
        BNE.S  .loc_007C                        ; $0072DE
        ANDI.B  #$08,D0                         ; $0072E0
        BNE.S  .loc_0072                        ; $0072E4
        ANDI.B  #$02,D6                         ; $0072E6
        BEQ.S  .loc_0094                        ; $0072EA
        ADDI.W  #$0080,D1                       ; $0072EC
        BRA.S  .loc_0094                        ; $0072F0
.loc_0072:
        ANDI.B  #$01,D6                         ; $0072F2
        BEQ.S  .loc_0094                        ; $0072F6
        SUBQ.W  #4,D1                           ; $0072F8
        BRA.S  .loc_0094                        ; $0072FA
.loc_007C:
        ANDI.B  #$10,D0                         ; $0072FC
        BEQ.S  .loc_008C                        ; $007300
        ANDI.B  #$01,D6                         ; $007302
        BEQ.S  .loc_0094                        ; $007306
        SUBQ.W  #4,D1                           ; $007308
        BRA.S  .loc_0094                        ; $00730A
.loc_008C:
        ANDI.B  #$01,D6                         ; $00730C
        BNE.S  .loc_0094                        ; $007310
        ADDQ.W  #4,D1                           ; $007312
.loc_0094:
        MOVE.L  #$2207FFFE,D3                   ; $007314
        MOVE.W  (-14176).W,D0                   ; $00731A
        DC.W    $43FA,$FF28         ; LEA     $007248(PC),A1; $00731E
        MOVEA.L $00(A1,D0.W),A1                 ; $007322
        MOVEQ   #$00,D4                         ; $007326
        MOVEA.L $00(A1,D1.W),A4                 ; $007328
        CMPA.L  D3,A4                           ; $00732C
        BEQ.S  .loc_00B4                        ; $00732E
        MOVE.L  A4,(A2)+                        ; $007330
        ADDQ.W  #1,D4                           ; $007332
.loc_00B4:
        MOVEQ   #$0B,D7                         ; $007334
.loc_00B6:
        MOVE.W  D1,D0                           ; $007336
        ADD.W  (A3)+,D0                         ; $007338
        MOVEA.L $00(A1,D0.W),A4                 ; $00733A
        CMPA.L  D3,A4                           ; $00733E
        BEQ.S  .loc_00C6                        ; $007340
        MOVE.L  A4,(A2)+                        ; $007342
        ADDQ.W  #1,D4                           ; $007344
.loc_00C6:
        DBRA    D7,.loc_00B6                    ; $007346
        MOVEA.L (A7)+,A4                        ; $00734A
        RTS                                     ; $00734C
