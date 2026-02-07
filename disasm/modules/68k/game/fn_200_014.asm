; ============================================================================
; Init 014 (auto-analyzed)
; ROM Range: $001140-$0011C2 (130 bytes)
; ============================================================================
; Category: boot
; Purpose: Object (A1): +$00, +$01
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D3, D4, D5, D6, D7, A0
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
; Confidence: low
; ============================================================================

fn_200_014:
.loc_0000:
        MOVE.W  D6,D7                           ; $001140
        SUBQ.W  #8,D7                           ; $001142
        MOVE.W  D5,D1                           ; $001144
        LSR.W  D7,D1                            ; $001146
        CMPI.B  #$FC,D1                         ; $001148
        BCC.S  .loc_004C                        ; $00114C
        ANDI.W  #$00FF,D1                       ; $00114E
        DC.W    $D241                           ; $001152
        MOVE.B  $00(A1,D1.W),D0                 ; $001154
        EXT.W   D0                              ; $001158
        DC.W    $9C40                           ; $00115A
        CMPI.W  #$0009,D6                       ; $00115C
        BCC.S  .loc_0028                        ; $001160
        ADDQ.W  #8,D6                           ; $001162
        ASL.W  #8,D5                            ; $001164
        MOVE.B  (A0)+,D5                        ; $001166
.loc_0028:
        MOVE.B  $01(A1,D1.W),D1                 ; $001168
        MOVE.W  D1,D0                           ; $00116C
        ANDI.W  #$000F,D1                       ; $00116E
        ANDI.W  #$00F0,D0                       ; $001172
.loc_0036:
        LSR.W  #4,D0                            ; $001176
.loc_0038:
        LSL.L  #4,D4                            ; $001178
        DC.W    $8801                           ; $00117A
        SUBQ.W  #1,D3                           ; $00117C
        BNE.S  .loc_0046                        ; $00117E
        JMP     (A3)                            ; $001180
.loc_0042:
        MOVEQ   #$00,D4                         ; $001182
        MOVEQ   #$08,D3                         ; $001184
.loc_0046:
        DBRA    D0,.loc_0038                    ; $001186
        BRA.S  .loc_0000                        ; $00118A
.loc_004C:
        SUBQ.W  #6,D6                           ; $00118C
        CMPI.W  #$0009,D6                       ; $00118E
        BCC.S  .loc_005A                        ; $001192
        ADDQ.W  #8,D6                           ; $001194
        ASL.W  #8,D5                            ; $001196
        MOVE.B  (A0)+,D5                        ; $001198
.loc_005A:
        SUBQ.W  #7,D6                           ; $00119A
        MOVE.W  D5,D1                           ; $00119C
        LSR.W  D6,D1                            ; $00119E
        MOVE.W  D1,D0                           ; $0011A0
        ANDI.W  #$000F,D1                       ; $0011A2
        ANDI.W  #$0070,D0                       ; $0011A6
        CMPI.W  #$0009,D6                       ; $0011AA
        BCC.S  .loc_0036                        ; $0011AE
        ADDQ.W  #8,D6                           ; $0011B0
        ASL.W  #8,D5                            ; $0011B2
        MOVE.B  (A0)+,D5                        ; $0011B4
        BRA.S  .loc_0036                        ; $0011B6
        MOVE.L  D4,(A4)                         ; $0011B8
        SUBQ.W  #1,A5                           ; $0011BA
        MOVE.W  A5,D4                           ; $0011BC
        BNE.S  .loc_0042                        ; $0011BE
        RTS                                     ; $0011C0
