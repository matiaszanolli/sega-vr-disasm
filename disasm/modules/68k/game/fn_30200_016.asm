; ============================================================================
; Vdp 016 (auto-analyzed)
; ROM Range: $030852-$030936 (228 bytes)
; ============================================================================
; Category: vdp
; Purpose: Accesses VDP registers
;   Object (A0, A1, A5, A6): +$00, +$01, +$02 (flags/type), +$04 (speed_index/velocity), +$08, +$0D
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D2, D3, D4, D5, D6, D7, A0
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$08: [unknown]
;   +$0D: [unknown]
;   +$0E: param_e
;   +$27: [unknown]
; Confidence: medium
; ============================================================================

fn_30200_016:
        DC.W    $00FF                           ; $030852
        DIVS    (A0),D2                         ; $030854
        ORI.B  #$00,D0                          ; $030856
        DC.W    $00FF                           ; $03085A
        DC.W    $8600                           ; $03085C
        DC.W    $00FF                           ; $03085E
        OR.B   -$01(A0,D0.W),D3                 ; $030860
        DC.W    $8540                           ; $030864
        DC.W    $00FF                           ; $030866
        DIVU    D0,D3                           ; $030868
        DC.W    $00FF                           ; $03086A
        DIVU    -$01(A0,D0.W),D3                ; $03086C
        DIVU    -$01(A0,D0.W),D3                ; $030870
        OR.B   D3,-(A0)                         ; $030874
        ORI.B  #$00,D0                          ; $030876
        DC.W    $00FF                           ; $03087A
        OR.W   D3,(A0)                          ; $03087C
        DC.W    $00FF                           ; $03087E
        DC.W    $8780                           ; $030880
        DC.W    $00FF                           ; $030882
        OR.L   D3,-$01(A0,D0.W)                 ; $030884
        DIVS    -(A0),D3                        ; $030888
        DC.W    $00FF                           ; $03088A
        OR.B   (A0),D4                          ; $03088C
        DC.W    $00FF                           ; $03088E
        OR.B   (A0),D4                          ; $030890
        LEA     $008B921C,A0                    ; $030892
        SUBI.B  #$D6,D7                         ; $030898
        LSL.W  #2,D7                            ; $03089C
        MOVEA.L $00(A0,D7.W),A3                 ; $03089E
        MOVEA.L A3,A1                           ; $0308A2
        MOVEQ   #$00,D0                         ; $0308A4
        MOVE.W  (A1)+,D0                        ; $0308A6
        ADD.L  A3,D0                            ; $0308A8
        MOVE.L  D0,$0034(A6)                    ; $0308AA
        MOVE.B  (A1)+,D5                        ; $0308AE
        MOVE.B  (A1)+,D7                        ; $0308B0
        SUBQ.B  #1,D7                           ; $0308B2
        MOVEQ   #$30,D6                         ; $0308B4
.loc_0064:
        MOVE.B  $0001(A1),D4                    ; $0308B6
        BMI.S  .loc_0076                        ; $0308BA
        BSET    #2,$0100(A6)                    ; $0308BC
        LEA     $0340(A6),A5                    ; $0308C2
        BRA.S  .loc_0080                        ; $0308C6
.loc_0076:
        BSET    #2,$01F0(A6)                    ; $0308C8
        LEA     $0370(A6),A5                    ; $0308CE
.loc_0080:
        MOVEA.L A5,A2                           ; $0308D2
        MOVEQ   #$0B,D0                         ; $0308D4
.loc_0084:
        CLR.L  (A2)+                            ; $0308D6
        DBRA    D0,.loc_0084                    ; $0308D8
        MOVE.W  (A1)+,(A5)                      ; $0308DC
        MOVE.B  D5,$0002(A5)                    ; $0308DE
        MOVEQ   #$00,D0                         ; $0308E2
        MOVE.W  (A1)+,D0                        ; $0308E4
        ADD.L  A3,D0                            ; $0308E6
        MOVE.L  D0,$0004(A5)                    ; $0308E8
        MOVE.W  (A1)+,$0008(A5)                 ; $0308EC
        MOVE.B  #$01,$000E(A5)                  ; $0308F0
        MOVE.B  D6,$000D(A5)                    ; $0308F6
        TST.B  D4                               ; $0308FA
        BMI.S  .loc_00B2                        ; $0308FC
        MOVE.B  #$C0,$0027(A5)                  ; $0308FE
.loc_00B2:
        DBRA    D7,.loc_0064                    ; $030904
        TST.B  $0250(A6)                        ; $030908
        BPL.S  .loc_00C2                        ; $03090C
        BSET    #2,$0340(A6)                    ; $03090E
.loc_00C2:
        TST.B  $0310(A6)                        ; $030914
        BPL.S  .loc_00E2                        ; $030918
        BSET    #2,$0370(A6)                    ; $03091A
        ORI.B  #$1F,D4                          ; $030920
        MOVE.B  D4,$00C00011                    ; $030924
        BCHG    #5,D4                           ; $03092A
        MOVE.B  D4,$00C00011                    ; $03092E
.loc_00E2:
        RTS                                     ; $030934
