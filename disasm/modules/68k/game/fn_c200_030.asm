; ============================================================================
; Sh2 Comm Cmd 27 030 (auto-analyzed)
; ROM Range: $00E118-$00E19E (134 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: COMM0
;   Calls: sh2_cmd_27
;   Object (A0, A1): +$00, +$04 (speed_index/velocity)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, A0, A1
; Calls:
;   $00E3B4: sh2_cmd_27
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
; Confidence: high
; ============================================================================

fn_c200_030:
        MOVEQ   #$00,D0                         ; $00E118
        TST.B  (-24537).W                       ; $00E11A
        BNE.S  .loc_000E                        ; $00E11E
        MOVE.B  (-24551).W,D0                   ; $00E120
        BRA.S  .loc_0012                        ; $00E124
.loc_000E:
        MOVE.B  (-24539).W,D0                   ; $00E126
.loc_0012:
        LEA     $0088E19E,A1                    ; $00E12A
        DC.W    $D040                           ; $00E130
        MOVE.W  D0,D1                           ; $00E132
        DC.W    $D040                           ; $00E134
        DC.W    $D041                           ; $00E136
        MOVEA.L $00(A1,D0.W),A0                 ; $00E138
        MOVE.W  $04(A1,D0.W),D0                 ; $00E13C
        MOVE.W  #$0030,D1                       ; $00E140
        MOVE.W  #$0010,D2                       ; $00E144
        DC.W    $4EBA,$026A         ; JSR     $00E3B4(PC); $00E148
        MOVEQ   #$00,D0                         ; $00E14C
        TST.B  (-24537).W                       ; $00E14E
        BEQ.S  .loc_0042                        ; $00E152
        MOVE.B  (-24551).W,D0                   ; $00E154
        BRA.S  .loc_0046                        ; $00E158
.loc_0042:
        MOVE.B  (-24538).W,D0                   ; $00E15A
.loc_0046:
        MOVE.B  D0,D3                           ; $00E15E
        MOVEA.L #$0401C010,A0                   ; $00E160
        DC.W    $D040                           ; $00E166
        DC.W    $D040                           ; $00E168
        DC.W    $D040                           ; $00E16A
        MOVE.W  D0,D1                           ; $00E16C
        DC.W    $D040                           ; $00E16E
        DC.W    $D040                           ; $00E170
        DC.W    $D040                           ; $00E172
        DC.W    $D041                           ; $00E174
        LEA     $00(A0,D0.W),A0                 ; $00E176
        MOVE.W  #$0049,D0                       ; $00E17A
        MOVE.W  #$0010,D1                       ; $00E17E
        MOVE.W  #$0010,D2                       ; $00E182
        TST.B  D3                               ; $00E186
        BEQ.S  .loc_0078                        ; $00E188
        MOVE.W  #$0048,D0                       ; $00E18A
        SUBQ.L  #1,A0                           ; $00E18E
.loc_0078:
        TST.B  $00A15120                        ; $00E190
        BNE.S  .loc_0078                        ; $00E196
        DC.W    $4EBA,$021A         ; JSR     $00E3B4(PC); $00E198
        RTS                                     ; $00E19C
