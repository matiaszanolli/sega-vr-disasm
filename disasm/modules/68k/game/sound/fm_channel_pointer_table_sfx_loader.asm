; ============================================================================
; FM Channel Pointer Table + SFX Loader — $D6-$D7 sound effects
; ROM Range: $030852-$030936 (228 bytes)
; ============================================================================
; Data prefix: 16 longword pointers to channel structs within A6 sound
; driver state (used by fm_instrument_setup, fm_channel_reg_map_instrument_loader_b, fm_channel_stop_reg_map_stop_all).
; Code at $030892: Loads SFX instrument from ROM table $008B921C (indexed
; by D7-$D6). Sets up channels similarly to fm_channel_reg_map_instrument_loader_b but targets
; special effect channels ($0340/$0370). Handles PSG noise channels with
; direct PSG register writes ($C00011). Sets key-off flags for paired
; channels ($0250→$0340, $0310→$0370).
;
; Entry: A6 = sound driver state pointer
; Entry: D7 = sound command byte ($D6-$D7)
; Uses: D0, D2, D3, D4, D5, D6, D7, A0, A1, A2, A3, A5
; Confidence: medium
; ============================================================================

fm_channel_pointer_table_sfx_loader:
        DC.W    $00FF                           ; $030852
        DIVS    (A0),D2                         ; $030854
        ORI.B  #$00,D0                          ; $030856
        DC.W    $00FF                           ; $03085A
        or.b    d0,d3                   ; $8600
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
        MOVE.B  D4,PSG                    ; $030924
        BCHG    #5,D4                           ; $03092A
        MOVE.B  D4,PSG                    ; $03092E
.loc_00E2:
        RTS                                     ; $030934
