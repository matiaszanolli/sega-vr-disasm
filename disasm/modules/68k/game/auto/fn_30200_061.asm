; ============================================================================
; Fm Init Channel 061 (auto-analyzed)
; ROM Range: $031590-$0315F4 (100 bytes)
; ============================================================================
; Category: sound
; Purpose: Orchestrator calling 3 subroutines
;   Calls: fm_conditional_write, fm_init_channel, fm_set_volume
;   Object (A6): +$40 (heading_angle)
;
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D6, A0, A3
; Calls:
;   $030C8A: fm_init_channel
;   $030CA2: fm_conditional_write
;   $030FB2: fm_set_volume
; Object fields:
;   +$40: heading_angle
; Confidence: high
; ============================================================================

fn_30200_061:
        SUB.W  (A0),D0                          ; $031590
        SUB.W  (A0)+,D4                         ; $031592
        SUB.W  (A4),D2                          ; $031594
        SUB.W  (A4)+,D6                         ; $031596
        MOVEQ   #$30,D3                         ; $031598
        MOVE.B  (A4)+,D0                        ; $03159A
        DC.W    $6756               ; BEQ.S  $0315F4; $03159C
        MOVEA.L A5,A3                           ; $03159E
        LEA     $0040(A6),A5                    ; $0315A0
        BTST    #7,(A5)                         ; $0315A4
        BEQ.S  .loc_0022                        ; $0315A8
        BCLR    #7,(A5)                         ; $0315AA
        BSET    #0,(A5)                         ; $0315AE
.loc_0022:
        MOVEQ   #$05,D4                         ; $0315B2
.loc_0024:
        ADDA.W  D3,A5                           ; $0315B4
        BTST    #7,(A5)                         ; $0315B6
        BEQ.S  .loc_0042                        ; $0315BA
        BCLR    #7,(A5)                         ; $0315BC
        BSET    #0,(A5)                         ; $0315C0
        MOVE.B  #$B4,D0                         ; $0315C4
        MOVEQ   #$00,D1                         ; $0315C8
        DC.W    $4EBA,$F6D6         ; JSR     $030CA2(PC); $0315CA
        DC.W    $4EBA,$F6BA         ; JSR     $030C8A(PC); $0315CE
.loc_0042:
        DBRA    D4,.loc_0024                    ; $0315D2
        MOVEQ   #$02,D4                         ; $0315D6
.loc_0048:
        ADDA.W  D3,A5                           ; $0315D8
        BTST    #7,(A5)                         ; $0315DA
        BEQ.S  .loc_005C                        ; $0315DE
        BCLR    #7,(A5)                         ; $0315E0
        BSET    #0,(A5)                         ; $0315E4
        DC.W    $4EBA,$F9C8         ; JSR     $030FB2(PC); $0315E8
.loc_005C:
        DBRA    D4,.loc_0048                    ; $0315EC
        MOVEA.L A3,A5                           ; $0315F0
        RTS                                     ; $0315F2
