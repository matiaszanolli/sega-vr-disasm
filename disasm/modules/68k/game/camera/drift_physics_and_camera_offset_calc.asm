; ============================================================================
; drift_physics_and_camera_offset_calc — Drift Physics and Camera Offset Calculation
; ROM Range: $009688-$009802 (378 bytes)
; Computes lateral drift from steering velocity +$8E, applies speed-based
; scaling with sine lookup, updates heading mirror +$3C. Calculates camera
; follow distance from entity displacement fields +$5A/+$5C, speed +$06,
; and applies polynomial scaling. Manages drift accumulator +$AA with
; decay and heading snap-back toward target +$40.
;
; Entry: A0 = entity pointer
; Uses: D0, D1, D2, D3, A0
; Calls: $008F52 (sine_lookup)
; Object fields: +$04 speed, +$06 display speed, +$0C slope, +$1E target
;   heading, +$3C heading mirror, +$40 heading angle, +$5A trail X,
;   +$5C trail Y, +$76 camera dist, +$8E steer vel, +$90 drift rate,
;   +$92 slide, +$AA drift accum
; Confidence: high
; ============================================================================

drift_physics_and_camera_offset_calc:
        MOVE.W  $008E(A0),D0                    ; $009688
        ASR.W  #4,D0                            ; $00968C
        MOVE.W  #$0497,D1                       ; $00968E
        SUB.W  $0006(A0),D1                     ; $009692
        MULS    D0,D1                           ; $009696
        DIVS    #$0497,D1                       ; $009698
        ADD.W   D1,D0                           ; $00969C
        MOVE.W  D0,$0090(A0)                    ; $00969E
        CMPI.W  #$0080,$0004(A0)                ; $0096A2
        BGE.S  .loc_003E                        ; $0096A8
        MOVE.W  D0,D2                           ; $0096AA
        MOVE.W  $0004(A0),D0                    ; $0096AC
        LSL.W  #7,D0                            ; $0096B0
        ADDI.W  #$8000,D0                       ; $0096B2
        DC.W    $4EBA,$F89A         ; JSR     $008F52(PC); $0096B6
        ADDI.W  #$0100,D0                       ; $0096BA
        MULS    $0090(A0),D0                    ; $0096BE
        ASR.L  #6,D0                            ; $0096C2
        ADD.W   D2,D0                           ; $0096C4
.loc_003E:
        MULS    $0004(A0),D0                    ; $0096C6
        MOVEQ   #$0A,D2                         ; $0096CA
        ASR.L  D2,D0                            ; $0096CC
        MOVE.W  $0076(A0),D2                    ; $0096CE
        MOVE.W  $000C(A0),D3                    ; $0096D2
        BPL.S  .loc_0054                        ; $0096D6
        ADD.W   D3,D3                           ; $0096D8
        SUB.W   D3,D2                           ; $0096DA
.loc_0054:
        MULS    D2,D0                           ; $0096DC
        ASR.L  #8,D0                            ; $0096DE
        TST.W  $0092(A0)                        ; $0096E0
        BLE.S  .loc_006A                        ; $0096E4
        MOVE.W  #$0028,D1                       ; $0096E6
        SUB.W  $0092(A0),D1                     ; $0096EA
        MULS    D1,D0                           ; $0096EE
        ASR.L  #5,D0                            ; $0096F0
.loc_006A:
        MOVE.W  D0,D2                           ; $0096F2
        MOVE.W  D0,D1                           ; $0096F4
        ASR.W  #1,D1                            ; $0096F6
        ADD.W   D1,D0                           ; $0096F8
        TST.B  (-15589).W                       ; $0096FA
        BEQ.S  .loc_007C                        ; $0096FE
        ASR.W  #1,D2                            ; $009700
        ADD.W   D2,D0                           ; $009702
.loc_007C:
        ADD.W  D0,$003C(A0)                     ; $009704
        MOVE.W  $003C(A0),D0                    ; $009708
        SUB.W  $001E(A0),D0                     ; $00970C
        BPL.S  .loc_008C                        ; $009710
        NEG.W  D0                               ; $009712
.loc_008C:
        CMPI.W  #$0222,D0                       ; $009714
        BGE.S  .loc_00C0                        ; $009718
        ADDQ.W  #1,(-16382).W                   ; $00971A
        CMPI.W  #$0004,(-16382).W               ; $00971E
        BLT.S  .loc_00C4                        ; $009724
        MOVE.W  $001E(A0),D0                    ; $009726
        SUB.W  $0040(A0),D0                     ; $00972A
        CMPI.W  #$0012,D0                       ; $00972E
        BLE.S  .loc_00B0                        ; $009732
        MOVE.W  #$0012,D0                       ; $009734
.loc_00B0:
        CMPI.W  #$FFEE,D0                       ; $009738
        BGE.S  .loc_00BA                        ; $00973C
        MOVE.W  #$FFEE,D0                       ; $00973E
.loc_00BA:
        ADD.W  D0,$003C(A0)                     ; $009742
        BRA.S  .loc_00C4                        ; $009746
.loc_00C0:
        CLR.W  (-16382).W                       ; $009748
.loc_00C4:
        MOVE.W  $005C(A0),D0                    ; $00974C
        SUB.W  $005A(A0),D0                     ; $009750
        MOVE.W  $0090(A0),D1                    ; $009754
        BPL.S  .loc_00D6                        ; $009758
        NEG.W  D0                               ; $00975A
        NEG.W  D1                               ; $00975C
.loc_00D6:
        CMPI.W  #$0190,D0                       ; $00975E
        BLE.S  .loc_00E0                        ; $009762
        MOVE.W  #$0190,D0                       ; $009764
.loc_00E0:
        CMPI.W  #$FFCE,D0                       ; $009768
        BGE.S  .loc_00EA                        ; $00976C
        MOVE.W  #$FFCE,D0                       ; $00976E
.loc_00EA:
        LSL.W  #4,D0                            ; $009772
        MOVE.W  D0,D2                           ; $009774
        ADD.W   D0,D0                           ; $009776
        ADD.W   D0,D0                           ; $009778
        ADD.W   D2,D0                           ; $00977A
        ASR.W  #8,D0                            ; $00977C
        MOVE.W  $0006(A0),D2                    ; $00977E
        ADD.W   D2,D2                           ; $009782
        ADD.W   D2,D2                           ; $009784
        MOVE.W  D2,D3                           ; $009786
        ADD.W   D3,D3                           ; $009788
        ADD.W   D3,D3                           ; $00978A
        ADD.W   D3,D2                           ; $00978C
        MULS    D2,D2                           ; $00978E
        SWAP    D2                              ; $009790
        MULS    D1,D2                           ; $009792
        MOVEQ   #$0D,D1                         ; $009794
        ASR.L  D1,D2                            ; $009796
        ASR.W  #3,D2                            ; $009798
        MOVE.W  D2,D1                           ; $00979A
        ASR.W  #1,D1                            ; $00979C
        ADD.W   D1,D2                           ; $00979E
        ADDI.W  #$0188,D0                       ; $0097A0
        SUB.W   D2,D0                           ; $0097A4
        MOVE.W  $000C(A0),D1                    ; $0097A6
        NEG.W  D1                               ; $0097AA
        LSL.W  #4,D1                            ; $0097AC
        CMPI.W  #$0040,D1                       ; $0097AE
        BLE.S  .loc_0130                        ; $0097B2
        MOVE.W  #$0040,D1                       ; $0097B4
.loc_0130:
        CMPI.W  #$FFF0,D1                       ; $0097B8
        BGE.S  .loc_013A                        ; $0097BC
        MOVE.W  #$FFF0,D1                       ; $0097BE
.loc_013A:
        ADD.W   D1,D0                           ; $0097C2
        CMPI.W  #$0040,D0                       ; $0097C4
        BGE.S  .loc_0144                        ; $0097C8
        MOVEQ   #$40,D0                         ; $0097CA
.loc_0144:
        CMP.W  (-16152).W,D0                    ; $0097CC
        BLE.S  .loc_014E                        ; $0097D0
        MOVE.W  (-16152).W,D0                   ; $0097D2
.loc_014E:
        TST.W  $00AA(A0)                        ; $0097D6
        BLE.S  .loc_0158                        ; $0097DA
        SUBQ.W  #8,$00AA(A0)                    ; $0097DC
.loc_0158:
        CMPI.W  #$0050,$00AA(A0)                ; $0097E0
        BGT.S  .loc_0174                        ; $0097E6
        MOVE.W  $0076(A0),D1                    ; $0097E8
        SUB.W   D0,D1                           ; $0097EC
        CMPI.W  #$000C,D1                       ; $0097EE
        BLE.S  .loc_0174                        ; $0097F2
        SUBI.W  #$000C,$0076(A0)                ; $0097F4
        BRA.S  .loc_0178                        ; $0097FA
.loc_0174:
        MOVE.W  D0,$0076(A0)                    ; $0097FC
.loc_0178:
        RTS                                     ; $009800
