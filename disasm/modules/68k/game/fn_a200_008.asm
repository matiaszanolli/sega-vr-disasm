; ============================================================================
; Ai 008 (auto-analyzed)
; ROM Range: $00B25E-$00B2D8 (122 bytes)
; ============================================================================
; Category: game
; Purpose: Function in a200 section (122 bytes)
;
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; Confidence: low
; ============================================================================

fn_a200_008:
        MOVEQ   #$12,D3                         ; $00B25E
        LEA     (-15872).W,A1                   ; $00B260
        MOVE.L  #$00010060,D7                   ; $00B264
        MOVEQ   #$00,D0                         ; $00B26A
        MOVE.B  (A1)+,D0                        ; $00B26C
        MOVE.B  (A1)+,D1                        ; $00B26E
        MOVE.B  (A1)+,D2                        ; $00B270
        MOVE.B  (A1)+,D6                        ; $00B272
.loc_0016:
        SWAP    D3                              ; $00B274
        MOVE.B  (A1)+,D3                        ; $00B276
        MOVE.B  (A1)+,D4                        ; $00B278
        MOVE.B  (A1)+,D5                        ; $00B27A
        SWAP    D5                              ; $00B27C
        MOVE.B  (A1)+,D5                        ; $00B27E
        DC.W    $023C                           ; $00B280
        DC.W    $00EF                           ; $00B282
        DC.W    $CD05                           ; $00B284
        SWAP    D5                              ; $00B286
        DC.W    $C505                           ; $00B288
        CMPI.B  #$10,D2                         ; $00B28A
        BLT.S  .loc_003A                        ; $00B28E
        SUBI.B  #$10,D2                         ; $00B290
        DC.W    $003C                           ; $00B294
        DC.W    $0010                           ; $00B296
.loc_003A:
        DC.W    $C304                           ; $00B298
        BCC.S  .loc_0048                        ; $00B29A
        DC.W    $C103                           ; $00B29C
        BCS.S  .loc_0064                        ; $00B29E
        ADDI.B  #$40,D1                         ; $00B2A0
        BRA.S  .loc_004C                        ; $00B2A4
.loc_0048:
        DC.W    $C103                           ; $00B2A6
        BCS.S  .loc_0064                        ; $00B2A8
.loc_004C:
        CMP.B  D7,D1                            ; $00B2AA
        BCS.S  .loc_005A                        ; $00B2AC
        DC.W    $8307                           ; $00B2AE
        SWAP    D7                              ; $00B2B0
        DC.W    $C107                           ; $00B2B2
        BCS.S  .loc_0064                        ; $00B2B4
        SWAP    D7                              ; $00B2B6
.loc_005A:
        SWAP    D3                              ; $00B2B8
        DBRA    D3,.loc_0016                    ; $00B2BA
        CMP.W  D7,D0                            ; $00B2BE
        BCS.S  .loc_006C                        ; $00B2C0
.loc_0064:
        MOVEQ   #$60,D0                         ; $00B2C2
        MOVEQ   #$00,D1                         ; $00B2C4
        MOVEQ   #$00,D2                         ; $00B2C6
        MOVEQ   #$00,D6                         ; $00B2C8
.loc_006C:
        LEA     (-15776).W,A1                   ; $00B2CA
        MOVE.B  D0,(A1)+                        ; $00B2CE
        MOVE.B  D1,(A1)+                        ; $00B2D0
        MOVE.B  D2,(A1)+                        ; $00B2D2
        MOVE.B  D6,(A1)                         ; $00B2D4
        RTS                                     ; $00B2D6
