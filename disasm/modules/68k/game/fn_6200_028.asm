; ============================================================================
; Obj Race 028 (auto-analyzed)
; ROM Range: $00734E-$0073E8 (154 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8A0 (race_state)
;   Object (A0, A1, A3): +$00, +$CC
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D7, A0, A1
; RAM:
;   $C8A0: race_state
; Object fields:
;   +$00: [unknown]
;   +$CC: [unknown]
; Confidence: medium
; ============================================================================

fn_6200_028:
        TST.W  (-16198).W                       ; $00734E
        DC.W    $6700,$FE52         ; BEQ.W  $0071A6; $007352
        MOVE.L  A4,-(A7)                        ; $007356
        MOVE.W  #$0400,D1                       ; $007358
        MOVE.W  $00FF6102,D2                    ; $00735C
        ASR.W  #4,D2                            ; $007362
        DC.W    $D441                           ; $007364
        ASR.W  #6,D2                            ; $007366
        MOVE.W  $00FF6106,D3                    ; $007368
        ASR.W  #4,D3                            ; $00736E
        DC.W    $9243                           ; $007370
        ANDI.W  #$FFC0,D1                       ; $007372
        ASR.W  #1,D1                            ; $007376
        DC.W    $D242                           ; $007378
        DC.W    $D241                           ; $00737A
        DC.W    $D241                           ; $00737C
        MOVEQ   #$00,D0                         ; $00737E
        MOVE.W  $00CC(A0),D0                    ; $007380
        ASL.L  #6,D0                            ; $007384
        SWAP    D0                              ; $007386
        ANDI.W  #$003C,D0                       ; $007388
        LEA     $0089A5D2,A3                    ; $00738C
        TST.W  (-16198).W                       ; $007392
        BNE.S  .loc_0050                        ; $007396
        LEA     $0089A0D4,A3                    ; $007398
.loc_0050:
        MOVEA.L $00(A3,D0.W),A3                 ; $00739E
        MOVE.L  #$2207FFFE,D3                   ; $0073A2
        MOVE.W  (-14176).W,D0                   ; $0073A8
        DC.W    $43FA,$FE9A         ; LEA     $007248(PC),A1; $0073AC
        MOVEA.L $00(A1,D0.W),A1                 ; $0073B0
        LEA     $00FF6000,A2                    ; $0073B4
        MOVEQ   #$00,D4                         ; $0073BA
        MOVEA.L $00(A1,D1.W),A4                 ; $0073BC
        CMPA.L  D3,A4                           ; $0073C0
        BEQ.S  .loc_007A                        ; $0073C2
        MOVE.L  A4,(A2)+                        ; $0073C4
        ADDQ.W  #1,D4                           ; $0073C6
.loc_007A:
        MOVE.W  (A3)+,D7                        ; $0073C8
.loc_007C:
        MOVE.W  D1,D0                           ; $0073CA
        ADD.W  (A3)+,D0                         ; $0073CC
        MOVEA.L $00(A1,D0.W),A4                 ; $0073CE
        CMPA.L  D3,A4                           ; $0073D2
        BEQ.S  .loc_008C                        ; $0073D4
        MOVE.L  A4,(A2)+                        ; $0073D6
        ADDQ.W  #1,D4                           ; $0073D8
.loc_008C:
        DBRA    D7,.loc_007C                    ; $0073DA
        MOVE.W  D4,$00FF610E                    ; $0073DE
        MOVEA.L (A7)+,A4                        ; $0073E4
        RTS                                     ; $0073E6
