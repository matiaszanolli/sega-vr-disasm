; ============================================================================
; Sh2 Comm Send Cmd 030 (auto-analyzed)
; ROM Range: $013346-$0134C8 (386 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 3 subroutines
;   Accesses 32X registers: COMM0
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, sh2_send_cmd, sh2_cmd_27
;   Object (A0, A1): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 (speed)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $00E35A: sh2_send_cmd
;   $00E3B4: sh2_cmd_27
;   $00E52C: dma_transfer
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$06: speed
; Confidence: high
; ============================================================================

fn_12200_030:
        CLR.W  D0                               ; $013346
        DC.W    $4EBA,$B1E2         ; JSR     $00E52C(PC); $013348
        MOVEA.L #$06018000,A0                   ; $01334C
        MOVEA.L #$04004C74,A1                   ; $013352
        MOVE.W  #$0058,D0                       ; $013358
        MOVE.W  #$0010,D1                       ; $01335C
        DC.W    $4EBA,$AFF8         ; JSR     $00E35A(PC); $013360
        MOVEA.L #$0601AD00,A0                   ; $013364
        MOVEA.L #$04009038,A1                   ; $01336A
        MOVE.W  #$0048,D0                       ; $013370
        MOVE.W  #$00A0,D1                       ; $013374
        DC.W    $4EBA,$AFE0         ; JSR     $00E35A(PC); $013378
        MOVEA.L #$0601DA00,A0                   ; $01337C
        MOVEA.L #$04015088,A1                   ; $013382
        MOVE.W  #$0098,D0                       ; $013388
        MOVE.W  #$0020,D1                       ; $01338C
        DC.W    $4EBA,$AFC8         ; JSR     $00E35A(PC); $013390
        LEA     $0089ABEE,A0                    ; $013394
        MOVE.W  (-24550).W,D0                   ; $01339A
        DC.W    $D040                           ; $01339E
        DC.W    $D040                           ; $0133A0
        MOVEA.L $00(A0,D0.W),A0                 ; $0133A2
        MOVEA.L #$04009088,A1                   ; $0133A6
        MOVE.W  #$0040,D0                       ; $0133AC
        MOVE.W  #$0010,D1                       ; $0133B0
        DC.W    $4EBA,$AFA4         ; JSR     $00E35A(PC); $0133B4
        LEA     $0089ABFA,A0                    ; $0133B8
        MOVE.W  (-24548).W,D0                   ; $0133BE
        DC.W    $D040                           ; $0133C2
        DC.W    $D040                           ; $0133C4
        MOVEA.L $00(A0,D0.W),A0                 ; $0133C6
        MOVEA.L #$0400C088,A1                   ; $0133CA
        MOVE.W  #$0078,D0                       ; $0133D0
        MOVE.W  #$0010,D1                       ; $0133D4
        DC.W    $4EBA,$AF80         ; JSR     $00E35A(PC); $0133D8
        LEA     $0089AC7C,A0                    ; $0133DC
        MOVE.W  (-24546).W,D0                   ; $0133E2
        DC.W    $D040                           ; $0133E6
        DC.W    $D040                           ; $0133E8
        MOVEA.L $00(A0,D0.W),A0                 ; $0133EA
        MOVEA.L #$0400F088,A1                   ; $0133EE
        MOVE.W  #$0068,D0                       ; $0133F4
        MOVE.W  #$0010,D1                       ; $0133F8
        DC.W    $4EBA,$AF5C         ; JSR     $00E35A(PC); $0133FC
        LEA     $0089ACBE,A0                    ; $013400
        MOVE.W  (-24544).W,D0                   ; $013406
        DC.W    $D040                           ; $01340A
        DC.W    $D040                           ; $01340C
        MOVEA.L $00(A0,D0.W),A0                 ; $01340E
        MOVEA.L #$04012088,A1                   ; $013412
        MOVE.W  #$0088,D0                       ; $013418
        MOVE.W  #$0010,D1                       ; $01341C
        DC.W    $4EBA,$AF38         ; JSR     $00E35A(PC); $013420
        TST.W  (-24538).W                       ; $013424
        BEQ.S  .loc_0110                        ; $013428
        MOVEQ   #$00,D0                         ; $01342A
        MOVE.B  (-24551).W,D0                   ; $01342C
        LEA     $008934C8,A1                    ; $013430
        DC.W    $D040                           ; $013436
        DC.W    $D040                           ; $013438
        MOVEA.L $00(A1,D0.W),A0                 ; $01343A
        MOVE.W  #$0048,D0                       ; $01343E
        MOVE.W  #$0010,D1                       ; $013442
        MOVE.W  #$0010,D2                       ; $013446
.loc_0104:
        TST.B  $00A15120                        ; $01344A
        BNE.S  .loc_0104                        ; $013450
        DC.W    $4EBA,$AF60         ; JSR     $00E3B4(PC); $013452
.loc_0110:
        LEA     $00FF6E00,A1                    ; $013456
        ADDA.L  #$00000178,A1                   ; $01345C
        MOVE.W  #$0004,D2                       ; $013462
.loc_0120:
        LEA     $008934E8,A0                    ; $013466
        MOVE.W  (A0)+,(A1)+                     ; $01346C
        MOVE.W  (A0)+,(A1)+                     ; $01346E
        MOVE.W  (A0)+,(A1)+                     ; $013470
        MOVE.W  (A0),(A1)+                      ; $013472
        DBRA    D2,.loc_0120                    ; $013474
        TST.W  (-24538).W                       ; $013478
        BEQ.S  .loc_016E                        ; $01347C
        CMPI.B  #$05,(-24551).W                 ; $01347E
        BEQ.S  .loc_016E                        ; $013484
        CLR.W  D0                               ; $013486
        MOVE.B  (-24551).W,D0                   ; $013488
        DC.W    $D040                           ; $01348C
        DC.W    $D040                           ; $01348E
        DC.W    $D040                           ; $013490
        LEA     $00FF6E00,A1                    ; $013492
        ADDA.L  #$00000178,A1                   ; $013498
        LEA     $008934E0,A0                    ; $01349E
        MOVE.W  (A0)+,$00(A1,D0.W)              ; $0134A4
        MOVE.W  (A0)+,$02(A1,D0.W)              ; $0134A8
        MOVE.W  (A0)+,$04(A1,D0.W)              ; $0134AC
        MOVE.W  (A0),$06(A1,D0.W)               ; $0134B0
.loc_016E:
        MOVE.B  #$01,(-14303).W                 ; $0134B4
        ADDQ.W  #4,(-14210).W                   ; $0134BA
        MOVE.W  #$0020,$00FF0008                ; $0134BE
        RTS                                     ; $0134C6
