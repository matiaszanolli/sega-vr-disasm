; ============================================================================
; Init Dispatch 019 (auto-analyzed)
; ROM Range: $0011EE-$0012F4 (262 bytes)
; ============================================================================
; Category: boot
; Purpose: State dispatcher using jump table
;   Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_200_019:
        MOVE.W  D0,D7                           ; $0011EE
.loc_0002:
        MOVE.B  (A0)+,D0                        ; $0011F0
        CMPI.B  #$80,D0                         ; $0011F2
        DC.W    $64EE               ; BCC.S  $0011E6; $0011F6
        MOVE.B  D0,D1                           ; $0011F8
        ANDI.W  #$000F,D7                       ; $0011FA
        ANDI.W  #$0070,D1                       ; $0011FE
        DC.W    $8E41                           ; $001202
        ANDI.W  #$000F,D0                       ; $001204
        MOVE.B  D0,D1                           ; $001208
        LSL.W  #8,D1                            ; $00120A
        DC.W    $8E41                           ; $00120C
        MOVEQ   #$08,D1                         ; $00120E
        DC.W    $9240                           ; $001210
        BNE.S  .loc_0030                        ; $001212
        MOVE.B  (A0)+,D0                        ; $001214
        DC.W    $D040                           ; $001216
        MOVE.W  D7,$00(A1,D0.W)                 ; $001218
        BRA.S  .loc_0002                        ; $00121C
.loc_0030:
        MOVE.B  (A0)+,D0                        ; $00121E
        LSL.W  D1,D0                            ; $001220
        DC.W    $D040                           ; $001222
        MOVEQ   #$01,D5                         ; $001224
        LSL.W  D1,D5                            ; $001226
        SUBQ.W  #1,D5                           ; $001228
.loc_003C:
        MOVE.W  D7,$00(A1,D0.W)                 ; $00122A
        ADDQ.W  #2,D0                           ; $00122E
        DBRA    D5,.loc_003C                    ; $001230
        BRA.S  .loc_0002                        ; $001234
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A1/A2/A3/A4/A5,-(A7); $001236
        MOVEA.W D0,A3                           ; $00123A
        MOVE.B  (A0)+,D0                        ; $00123C
        EXT.W   D0                              ; $00123E
        MOVEA.W D0,A5                           ; $001240
        MOVE.B  (A0)+,D4                        ; $001242
        LSL.B  #3,D4                            ; $001244
        MOVEA.W (A0)+,A2                        ; $001246
        ADDA.W  A3,A2                           ; $001248
        MOVEA.W (A0)+,A4                        ; $00124A
        ADDA.W  A3,A4                           ; $00124C
        MOVE.B  (A0)+,D5                        ; $00124E
        ASL.W  #8,D5                            ; $001250
        MOVE.B  (A0)+,D5                        ; $001252
        MOVEQ   #$10,D6                         ; $001254
.loc_0068:
        MOVEQ   #$07,D0                         ; $001256
        MOVE.W  D6,D7                           ; $001258
        DC.W    $9E40                           ; $00125A
        MOVE.W  D5,D1                           ; $00125C
        LSR.W  D7,D1                            ; $00125E
        ANDI.W  #$007F,D1                       ; $001260
        MOVE.W  D1,D2                           ; $001264
        CMPI.W  #$0040,D1                       ; $001266
        BCC.S  .loc_0082                        ; $00126A
        MOVEQ   #$06,D0                         ; $00126C
        LSR.W  #1,D2                            ; $00126E
.loc_0082:
        DC.W    $6100,$0132         ; BSR.W  $0013A4; $001270
        ANDI.W  #$000F,D2                       ; $001274
        LSR.W  #4,D1                            ; $001278
        DC.W    $D241                           ; $00127A
        JMP     $0012CC(PC,D1.W)                ; $00127C
.loc_0092:
        MOVE.W  A2,(A1)+                        ; $001280
        ADDQ.W  #1,A2                           ; $001282
        DBRA    D2,.loc_0092                    ; $001284
        BRA.S  .loc_0068                        ; $001288
.loc_009C:
        MOVE.W  A4,(A1)+                        ; $00128A
        DBRA    D2,.loc_009C                    ; $00128C
        BRA.S  .loc_0068                        ; $001290
.loc_00A4:
        DC.W    $6100,$0060         ; BSR.W  $0012F4; $001292
.loc_00A8:
        MOVE.W  D1,(A1)+                        ; $001296
        DBRA    D2,.loc_00A8                    ; $001298
        BRA.S  .loc_0068                        ; $00129C
.loc_00B0:
        DC.W    $6100,$0054         ; BSR.W  $0012F4; $00129E
.loc_00B4:
        MOVE.W  D1,(A1)+                        ; $0012A2
        ADDQ.W  #1,D1                           ; $0012A4
        DBRA    D2,.loc_00B4                    ; $0012A6
        BRA.S  .loc_0068                        ; $0012AA
.loc_00BE:
        DC.W    $6100,$0046         ; BSR.W  $0012F4; $0012AC
.loc_00C2:
        MOVE.W  D1,(A1)+                        ; $0012B0
        SUBQ.W  #1,D1                           ; $0012B2
        DBRA    D2,.loc_00C2                    ; $0012B4
        BRA.S  .loc_0068                        ; $0012B8
.loc_00CC:
        CMPI.W  #$000F,D2                       ; $0012BA
        BEQ.S  .loc_00EE                        ; $0012BE
.loc_00D2:
        DC.W    $6100,$0032         ; BSR.W  $0012F4; $0012C0
        MOVE.W  D1,(A1)+                        ; $0012C4
        DBRA    D2,.loc_00D2                    ; $0012C6
        BRA.S  .loc_0068                        ; $0012CA
        BRA.S  .loc_0092                        ; $0012CC
        BRA.S  .loc_0092                        ; $0012CE
        BRA.S  .loc_009C                        ; $0012D0
        BRA.S  .loc_009C                        ; $0012D2
        BRA.S  .loc_00A4                        ; $0012D4
        BRA.S  .loc_00B0                        ; $0012D6
        BRA.S  .loc_00BE                        ; $0012D8
        BRA.S  .loc_00CC                        ; $0012DA
.loc_00EE:
        SUBQ.W  #1,A0                           ; $0012DC
        CMPI.W  #$0010,D6                       ; $0012DE
        BNE.S  .loc_00F8                        ; $0012E2
        SUBQ.W  #1,A0                           ; $0012E4
.loc_00F8:
        MOVE.W  A0,D0                           ; $0012E6
        LSR.W  #1,D0                            ; $0012E8
        BCC.S  .loc_0100                        ; $0012EA
        ADDQ.W  #1,A0                           ; $0012EC
.loc_0100:
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A1/A2/A3/A4/A5; $0012EE
        RTS                                     ; $0012F2
