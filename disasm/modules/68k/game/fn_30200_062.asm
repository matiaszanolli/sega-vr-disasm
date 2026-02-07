; ============================================================================
; Fm Conditional Write 062 (auto-analyzed)
; ROM Range: $0315F4-$031650 (92 bytes)
; ============================================================================
; Category: sound
; Purpose: Calls: fm_conditional_write
;   Object (A5, A6): +$27, +$40 (heading_angle)
;
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D3, D4, A3, A5, A6
; Calls:
;   $030CA2: fm_conditional_write
; Object fields:
;   +$27: [unknown]
;   +$40: heading_angle
; Confidence: medium
; ============================================================================

fn_30200_062:
        MOVEA.L A5,A3                           ; $0315F4
        LEA     $0040(A6),A5                    ; $0315F6
        BTST    #0,(A5)                         ; $0315FA
        BEQ.S  .loc_0020                        ; $0315FE
        BSET    #7,(A5)                         ; $031600
        BCLR    #0,(A5)                         ; $031604
        MOVE.B  #$B4,D0                         ; $031608
        MOVE.B  $0027(A5),D1                    ; $03160C
        DC.W    $4EBA,$F690         ; JSR     $030CA2(PC); $031610
.loc_0020:
        MOVEQ   #$05,D4                         ; $031614
.loc_0022:
        ADDA.W  D3,A5                           ; $031616
        BTST    #0,(A5)                         ; $031618
        BEQ.S  .loc_003E                        ; $03161C
        BSET    #7,(A5)                         ; $03161E
        BCLR    #0,(A5)                         ; $031622
        MOVE.B  #$B4,D0                         ; $031626
        MOVE.B  $0027(A5),D1                    ; $03162A
        DC.W    $4EBA,$F672         ; JSR     $030CA2(PC); $03162E
.loc_003E:
        DBRA    D4,.loc_0022                    ; $031632
        MOVEQ   #$02,D4                         ; $031636
.loc_0044:
        ADDA.W  D3,A5                           ; $031638
        BTST    #0,(A5)                         ; $03163A
        BEQ.S  .loc_0054                        ; $03163E
        BSET    #7,(A5)                         ; $031640
        BCLR    #0,(A5)                         ; $031644
.loc_0054:
        DBRA    D4,.loc_0044                    ; $031648
        MOVEA.L A3,A5                           ; $03164C
        RTS                                     ; $03164E
