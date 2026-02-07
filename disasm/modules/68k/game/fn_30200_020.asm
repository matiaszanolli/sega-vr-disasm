; ============================================================================
; Fm Z80 Dac Write 020 (auto-analyzed)
; ROM Range: $030A86-$030AF8 (114 bytes)
; ============================================================================
; Category: sound
; Purpose: Orchestrator calling 3 subroutines
;   Calls: z80_dac_write
;   Object (A5, A6): +$04 (speed_index/velocity), +$06 (speed), +$09, +$40 (heading_angle), +$70
;
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D6, D7, A5, A6
; Calls:
;   $030DF4: z80_dac_write
; Object fields:
;   +$04: speed_index/velocity
;   +$06: speed
;   +$09: [unknown]
;   +$40: heading_angle
;   +$70: [unknown]
; Confidence: medium
; ============================================================================

fn_30200_020:
        SUBQ.B  #1,$0004(A6)                    ; $030A86
        DC.W    $6700,$0104         ; BEQ.W  $030B90; $030A8A
        MOVE.B  #$01,$0006(A6)                  ; $030A8E
        LEA     $0040(A6),A5                    ; $030A94
        TST.B  (A5)                             ; $030A98
        BPL.S  .loc_0026                        ; $030A9A
        ADDQ.B  #4,$0009(A5)                    ; $030A9C
        BPL.S  .loc_0022                        ; $030AA0
        BCLR    #7,(A5)                         ; $030AA2
        BRA.S  .loc_0026                        ; $030AA6
.loc_0022:
        DC.W    $4EBA,$034A         ; JSR     $030DF4(PC); $030AA8
.loc_0026:
        LEA     $0070(A6),A5                    ; $030AAC
        MOVEQ   #$05,D7                         ; $030AB0
.loc_002C:
        TST.B  (A5)                             ; $030AB2
        BPL.S  .loc_0040                        ; $030AB4
        ADDQ.B  #1,$0009(A5)                    ; $030AB6
        BPL.S  .loc_003C                        ; $030ABA
        BCLR    #7,(A5)                         ; $030ABC
        BRA.S  .loc_0040                        ; $030AC0
.loc_003C:
        DC.W    $4EBA,$0896         ; JSR     $03135A(PC); $030AC2
.loc_0040:
        ADDA.W  #$0030,A5                       ; $030AC6
        DBRA    D7,.loc_002C                    ; $030ACA
        MOVEQ   #$02,D7                         ; $030ACE
.loc_004A:
        TST.B  (A5)                             ; $030AD0
        BPL.S  .loc_0068                        ; $030AD2
        ADDQ.B  #1,$0009(A5)                    ; $030AD4
        CMPI.B  #$10,$0009(A5)                  ; $030AD8
        BCS.S  .loc_0060                        ; $030ADE
        BCLR    #7,(A5)                         ; $030AE0
        BRA.S  .loc_0068                        ; $030AE4
.loc_0060:
        MOVE.B  $0009(A5),D6                    ; $030AE6
        DC.W    $4EBA,$0474         ; JSR     $030F60(PC); $030AEA
.loc_0068:
        ADDA.W  #$0030,A5                       ; $030AEE
        DBRA    D7,.loc_004A                    ; $030AF2
        RTS                                     ; $030AF6
