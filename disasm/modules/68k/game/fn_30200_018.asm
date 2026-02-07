; ============================================================================
; Vdp 018 (auto-analyzed)
; ROM Range: $0309F2-$030A5C (106 bytes)
; ============================================================================
; Category: vdp
; Purpose: Orchestrator calling 3 subroutines
;   Accesses VDP registers
;   Object (A5, A6): +$01, +$0B, +$25, +$30 (x_position), +$100
;
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, A1, A5, A6
; Object fields:
;   +$01: [unknown]
;   +$0B: [unknown]
;   +$25: [unknown]
;   +$30: x_position
;   +$100: [unknown]
; Confidence: medium
; ============================================================================

fn_30200_018:
        LEA     $0340(A6),A5                    ; $0309F2
        TST.B  (A5)                             ; $0309F6
        BPL.S  .loc_0032                        ; $0309F8
        BCLR    #7,(A5)                         ; $0309FA
        BTST    #2,(A5)                         ; $0309FE
        BNE.S  .loc_0032                        ; $030A02
        DC.W    $4EBA,$0290         ; JSR     $030C96(PC); $030A04
        LEA     $0100(A6),A5                    ; $030A08
        BCLR    #2,(A5)                         ; $030A0C
        BSET    #1,(A5)                         ; $030A10
        TST.B  (A5)                             ; $030A14
        BPL.S  .loc_0032                        ; $030A16
        MOVEA.L $0030(A6),A1                    ; $030A18
        MOVE.B  $000B(A5),D0                    ; $030A1C
        DC.W    $4EBA,$08C6         ; JSR     $0312E8(PC); $030A20
.loc_0032:
        LEA     $0370(A6),A5                    ; $030A24
        TST.B  (A5)                             ; $030A28
        BPL.S  .loc_0068                        ; $030A2A
        BCLR    #7,(A5)                         ; $030A2C
        BTST    #2,(A5)                         ; $030A30
        BNE.S  .loc_0068                        ; $030A34
        DC.W    $4EBA,$0580         ; JSR     $030FB8(PC); $030A36
        LEA     $01F0(A6),A5                    ; $030A3A
        BCLR    #2,(A5)                         ; $030A3E
        BSET    #1,(A5)                         ; $030A42
        TST.B  (A5)                             ; $030A46
        BPL.S  .loc_0068                        ; $030A48
        CMPI.B  #$E0,$0001(A5)                  ; $030A4A
        BNE.S  .loc_0068                        ; $030A50
        MOVE.B  $0025(A5),$00C00011             ; $030A52
.loc_0068:
        RTS                                     ; $030A5A
