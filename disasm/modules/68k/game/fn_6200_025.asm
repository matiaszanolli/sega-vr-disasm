; ============================================================================
; Obj Race 025 (auto-analyzed)
; ROM Range: $0071A6-$007248 (162 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8A0 (race_state)
;   Object (A0, A1, A3): +$00, +$1D, +$30 (x_position), +$34 (y_position), +$CA, +$CC
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D7, A0, A1
; RAM:
;   $C8A0: race_state
; Object fields:
;   +$00: [unknown]
;   +$1D: [unknown]
;   +$30: x_position
;   +$34: y_position
;   +$CA: [unknown]
;   +$CC: [unknown]
; Confidence: high
; ============================================================================

fn_6200_025:
        MOVE.L  A4,-(A7)                        ; $0071A6
        MOVE.W  #$0400,D1                       ; $0071A8
        MOVE.W  $0030(A0),D2                    ; $0071AC
        ASR.W  #4,D2                            ; $0071B0
        DC.W    $D441                           ; $0071B2
        ASR.W  #6,D2                            ; $0071B4
        MOVE.W  $0034(A0),D3                    ; $0071B6
        ASR.W  #4,D3                            ; $0071BA
        DC.W    $9243                           ; $0071BC
        ANDI.W  #$FFC0,D1                       ; $0071BE
        ASR.W  #1,D1                            ; $0071C2
        DC.W    $D242                           ; $0071C4
        DC.W    $D241                           ; $0071C6
        DC.W    $D241                           ; $0071C8
        MOVE.W  D1,$00CA(A0)                    ; $0071CA
        MOVEQ   #$00,D0                         ; $0071CE
        MOVE.W  $00CC(A0),D0                    ; $0071D0
        ASL.L  #6,D0                            ; $0071D4
        SWAP    D0                              ; $0071D6
        ANDI.W  #$003C,D0                       ; $0071D8
        LEA     $0089A0D4,A3                    ; $0071DC
        MOVE.W  (-14176).W,D2                   ; $0071E2
        CMPI.W  #$0004,D2                       ; $0071E6
        BNE.S  .loc_005C                        ; $0071EA
        CMPI.B  #$88,$001D(A0)                  ; $0071EC
        BLT.S  .loc_005C                        ; $0071F2
        CMPI.B  #$98,$001D(A0)                  ; $0071F4
        BGT.S  .loc_005C                        ; $0071FA
        LEA     $0089A434,A3                    ; $0071FC
.loc_005C:
        MOVEA.L $00(A3,D0.W),A3                 ; $007202
        MOVE.L  #$2207FFFE,D3                   ; $007206
        DC.W    $43FA,$003A         ; LEA     $007248(PC),A1; $00720C
        MOVEA.L $00(A1,D2.W),A1                 ; $007210
        LEA     $00FF6000,A2                    ; $007214
        MOVEQ   #$00,D4                         ; $00721A
        MOVEA.L $00(A1,D1.W),A4                 ; $00721C
        CMPA.L  D3,A4                           ; $007220
        BEQ.S  .loc_0082                        ; $007222
        MOVE.L  A4,(A2)+                        ; $007224
        ADDQ.W  #1,D4                           ; $007226
.loc_0082:
        MOVE.W  (A3)+,D7                        ; $007228
.loc_0084:
        MOVE.W  D1,D0                           ; $00722A
        ADD.W  (A3)+,D0                         ; $00722C
        MOVEA.L $00(A1,D0.W),A4                 ; $00722E
        CMPA.L  D3,A4                           ; $007232
        BEQ.S  .loc_0094                        ; $007234
        MOVE.L  A4,(A2)+                        ; $007236
        ADDQ.W  #1,D4                           ; $007238
.loc_0094:
        DBRA    D7,.loc_0084                    ; $00723A
        MOVE.W  D4,$00FF610E                    ; $00723E
        MOVEA.L (A7)+,A4                        ; $007244
        RTS                                     ; $007246
