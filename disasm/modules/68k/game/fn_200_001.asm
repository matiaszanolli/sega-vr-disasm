; ============================================================================
; Vdp 001 (auto-analyzed)
; ROM Range: $000512-$0005CE (188 bytes)
; ============================================================================
; Category: vdp
; Purpose: Accesses VDP registers
;
; Uses: D0, D1, D2, D3, D4, D5, D7, A0
; Confidence: medium
; ============================================================================

fn_200_001:
        DC.W    $4D41                           ; $000512
        ADDQ.W  #1,(A3)                         ; $000514
        MOVEA.L A1,A0                           ; $000516
        DC.W    $6E69                           ; $000518
        MOVEQ   #$69,D2                         ; $00051A
        BSR.S  .loc_0078                        ; $00051C
        MOVE.L  -(A6),D0                        ; $00051E
        MOVEA.L (A3),A0                         ; $000520
        DC.W    $6563                           ; $000522
        DC.W    $7572                           ; $000524
        BVS.S  .loc_008A                        ; $000526
        DC.W    $7920                           ; $000528
        DC.W    $5072                           ; $00052A
        DC.W    $6F67                           ; $00052C
        MOVEQ   #$61,D1                         ; $00052E
        BLT.S  .loc_0040                        ; $000530
        MOVE.L  -(A0),D0                        ; $000532
        MOVE.L  -(A0),D0                        ; $000534
        MOVE.L  -(A0),D0                        ; $000536
        MOVE.L  -(A0),D0                        ; $000538
        MOVEA.L D3,A0                           ; $00053A
        BSR.S  .loc_009E                        ; $00053C
        MOVEQ   #$72,D2                         ; $00053E
        BVS.S  .loc_0094                        ; $000540
        DC.W    $6765                           ; $000542
        MOVEA.L (A6),A0                         ; $000544
        BCS.S  .loc_00A8                        ; $000546
        DC.W    $7369                           ; $000548
        BLE.S  .loc_00A8                        ; $00054A
        MOVE.L  -(A0),D0                        ; $00054C
        MOVE.L  -(A0),D0                        ; $00054E
        DC.W    $436F                           ; $000550
.loc_0040:
        MOVEQ   #$79,D0                         ; $000552
        MOVEQ   #$69,D1                         ; $000554
        BEQ.S  .loc_00AE                        ; $000556
        MOVEQ   #$20,D2                         ; $000558
        SUBQ.W  #1,D5                           ; $00055A
        DC.W    $4741                           ; $00055C
        MOVEA.L D5,A0                           ; $00055E
        LINK    A4,#$4552                       ; $000560
        ADDQ.W  #8,(A2)                         ; $000564
        DC.W    $4953                           ; $000566
        DC.W    $4553                           ; $000568
        MOVEA.L A4,A6                           ; $00056A
        ADDQ.W  #2,D4                           ; $00056C
        MOVE.L  -(A0),D7                        ; $00056E
        MOVE.W  $39342020,-(A0)                 ; $000570
        MOVE.L  -(A0),D0                        ; $000576
        MOVE.L  -(A0),D0                        ; $000578
        MOVE.L  -(A0),D0                        ; $00057A
        MOVE.L  -(A0),D0                        ; $00057C
        MOVE.L  -(A0),D0                        ; $00057E
        MOVE.L  -(A0),D0                        ; $000580
        MOVE.L  -(A0),D0                        ; $000582
        MOVE.L  -(A0),D0                        ; $000584
        MOVE.L  -(A0),D0                        ; $000586
        MOVE.L  -(A0),D0                        ; $000588
.loc_0078:
        MOVE.L  -(A0),D0                        ; $00058A
        MOVE.L  -(A0),D0                        ; $00058C
        MOVE.L  -(A0),D0                        ; $00058E
        MOVE.L  -(A0),D0                        ; $000590
        MOVE.L  -(A0),D0                        ; $000592
        MOVE.L  -(A0),D0                        ; $000594
        ADDQ.W  #1,A7                           ; $000596
        DC.W    $4D20                           ; $000598
        ADDQ.W  #3,-(A5)                        ; $00059A
.loc_008A:
        MOVEQ   #$73,D1                         ; $00059C
        DC.W    $696F               ; DC.W    $696F; $00059E
        BGT.S  .loc_00B0                        ; $0005A0
        MOVE.W  $3000(A6),-(A0)                 ; $0005A2
.loc_0094:
        MOVEM.L D0/D1/A1,-(A7)                  ; $0005A6
        LEA     $00C00004,A1                    ; $0005AA
.loc_009E:
        MOVE.W  (A1),D0                         ; $0005B0
        MOVE.W  #$8000,D0                       ; $0005B2
        MOVE.W  #$0100,D1                       ; $0005B6
.loc_00A8:
        MOVE.W  #$0012,D7                       ; $0005BA
.loc_00AC:
        MOVE.B  (A0)+,D0                        ; $0005BE
.loc_00AE:
        MOVE.W  D0,(A1)                         ; $0005C0
.loc_00B0:
        DC.W    $D041                           ; $0005C2
        DBRA    D7,.loc_00AC                    ; $0005C4
        MOVEM.L (A7)+,D0/D1/A1                  ; $0005C8
        RTS                                     ; $0005CC
