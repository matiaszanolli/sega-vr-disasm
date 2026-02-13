; ============================================================================
; sprite_strip_renderer_via_sh2_cmd_27 — Sprite Strip Renderer via SH2 Cmd 27
; ROM Range: $014200-$014262 (98 bytes)
; ============================================================================
; Data prefix: DC.W $AB6E (2 bytes, likely a constant or flags word).
;
; Renders a multi-row sprite strip to SH2 by looping through entity table
; entries. For each row: computes entry address via D2×4 index into (A1),
; adds vertical offset (D1 first row, D5 subsequent), sends 80×7 tile data
; via sh2_cmd_27. Loop count from D3 (default 6 rows).
;
; Entry: A0 = base data, A1 = entity table, D1 = initial Y offset,
;        D3 = row count, D5 = per-row Y offset
; Uses: D0, D1, D2, D3, D4, D5, A0, A1
; Calls:
;   $00E3B4: sh2_cmd_27
; ============================================================================

sprite_strip_renderer_via_sh2_cmd_27:
        DC.W    $AB6E                           ; $014200
        MOVE.W  #$0006,D3                       ; $014202
        CLR.W  D2                               ; $014206
        MOVE.B  (A0),D2                         ; $014208
        MOVE.W  D2,D4                           ; $01420A
        ADD.W   D2,D2                           ; $01420C
        ADD.W   D2,D2                           ; $01420E
        MOVEA.L $00(A1,D2.W),A0                 ; $014210
        ADDA.L  D1,A0                           ; $014214
        MOVE.W  #$0050,D0                       ; $014216
        MOVE.W  #$0007,D1                       ; $01421A
        MOVE.W  #$003C,D2                       ; $01421E
.loc_0022:
        TST.B  COMM0_HI                        ; $014222
        BNE.S  .loc_0022                        ; $014228
        DC.W    $4EBA,$A188         ; JSR     $00E3B4(PC); $01422A
        SUB.W   D4,D3                           ; $01422E
        BCS.W  .loc_0060                        ; $014230
        ADDQ.W  #1,D4                           ; $014234
.loc_0036:
        MOVE.B  D4,D2                           ; $014236
        ADD.W   D2,D2                           ; $014238
        ADD.W   D2,D2                           ; $01423A
        MOVEA.L $00(A1,D2.W),A0                 ; $01423C
        ADDA.L  D5,A0                           ; $014240
        MOVE.W  #$0050,D0                       ; $014242
        MOVE.W  #$0007,D1                       ; $014246
        MOVE.W  #$0040,D2                       ; $01424A
.loc_004E:
        TST.B  COMM0_HI                        ; $01424E
        BNE.S  .loc_004E                        ; $014254
        DC.W    $4EBA,$A15C         ; JSR     $00E3B4(PC); $014256
        ADDQ.W  #1,D4                           ; $01425A
        DBRA    D3,.loc_0036                    ; $01425C
.loc_0060:
        RTS                                     ; $014260
