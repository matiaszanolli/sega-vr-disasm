; ============================================================================
; Vdp Dispatch 015 (auto-analyzed)
; ROM Range: $03078C-$030852 (198 bytes)
; ============================================================================
; Category: vdp
; Purpose: State dispatcher using jump table
;   Accesses VDP registers
;   Object (A0, A1, A5): +$00, +$01, +$02 (flags/type), +$04 (speed_index/velocity), +$08, +$0D
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A5 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$08: [unknown]
;   +$0D: [unknown]
;   +$0E: param_e
;   +$20: [unknown]
; Confidence: medium
; ============================================================================

fn_30200_015:
        DC.W    $0600                           ; $03078C
        BTST    D0,D2                           ; $03078E
        DC.W    $0405                           ; $030790
        DC.W    $0600                           ; $030792
        OR.L   -(A0),D0                         ; $030794
        DC.W    $C000                           ; $030796
        LEA     $008B9150,A0                    ; $030798
        SUBI.B  #$A0,D7                         ; $03079E
        LSL.W  #2,D7                            ; $0307A2
        MOVEA.L $00(A0,D7.W),A3                 ; $0307A4
        MOVEA.L A3,A1                           ; $0307A8
        MOVEQ   #$00,D1                         ; $0307AA
        MOVE.W  (A1)+,D1                        ; $0307AC
        ADD.L  A3,D1                            ; $0307AE
        MOVE.B  (A1)+,D5                        ; $0307B0
        MOVE.B  (A1)+,D7                        ; $0307B2
        SUBQ.B  #1,D7                           ; $0307B4
        MOVEQ   #$30,D6                         ; $0307B6
.loc_002C:
        MOVEQ   #$00,D3                         ; $0307B8
        MOVE.B  $0001(A1),D3                    ; $0307BA
        MOVE.B  D3,D4                           ; $0307BE
        BMI.S  .loc_0048                        ; $0307C0
        SUBQ.W  #2,D3                           ; $0307C2
        LSL.W  #2,D3                            ; $0307C4
        DC.W    $4BFA,$008A         ; LEA     $030852(PC),A5; $0307C6
        MOVEA.L $00(A5,D3.W),A5                 ; $0307CA
        BSET    #2,(A5)                         ; $0307CE
        BRA.S  .loc_006E                        ; $0307D2
.loc_0048:
        LSR.W  #3,D3                            ; $0307D4
        MOVEA.L $030852(PC,D3.W),A5             ; $0307D6
        BSET    #2,(A5)                         ; $0307DA
        CMPI.B  #$C0,D4                         ; $0307DE
        BNE.S  .loc_006E                        ; $0307E2
        MOVE.B  D4,D0                           ; $0307E4
        ORI.B  #$1F,D0                          ; $0307E6
        MOVE.B  D0,$00C00011                    ; $0307EA
        BCHG    #5,D0                           ; $0307F0
        MOVE.B  D0,$00C00011                    ; $0307F4
.loc_006E:
        MOVEA.L $030872(PC,D3.W),A5             ; $0307FA
        MOVEA.L A5,A2                           ; $0307FE
        MOVEQ   #$0B,D0                         ; $030800
.loc_0076:
        CLR.L  (A2)+                            ; $030802
        DBRA    D0,.loc_0076                    ; $030804
        MOVE.L  D1,$0020(A5)                    ; $030808
        MOVE.W  (A1)+,(A5)                      ; $03080C
        MOVE.B  D5,$0002(A5)                    ; $03080E
        MOVEQ   #$00,D0                         ; $030812
        MOVE.W  (A1)+,D0                        ; $030814
        ADD.L  A3,D0                            ; $030816
        MOVE.L  D0,$0004(A5)                    ; $030818
        MOVE.W  (A1)+,$0008(A5)                 ; $03081C
        MOVE.B  #$01,$000E(A5)                  ; $030820
        MOVE.B  D6,$000D(A5)                    ; $030826
        TST.B  D4                               ; $03082A
        BMI.S  .loc_00A8                        ; $03082C
        MOVE.B  #$C0,$0027(A5)                  ; $03082E
.loc_00A8:
        DBRA    D7,.loc_002C                    ; $030834
        TST.B  $0250(A6)                        ; $030838
        BPL.S  .loc_00B8                        ; $03083C
        BSET    #2,$0340(A6)                    ; $03083E
.loc_00B8:
        TST.B  $0310(A6)                        ; $030844
        BPL.S  .loc_00C4                        ; $030848
        BSET    #2,$0370(A6)                    ; $03084A
.loc_00C4:
        RTS                                     ; $030850
