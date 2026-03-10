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
        BGE.S  .apply_speed_scale               ; $0096A8
        MOVE.W  D0,D2                           ; $0096AA
        MOVE.W  $0004(A0),D0                    ; $0096AC
        LSL.W  #7,D0                            ; $0096B0
        ADDI.W  #$8000,D0                       ; $0096B2
        jsr     sine_cosine_quadrant_lookup+4(pc); $4EBA $F89A
        ADDI.W  #$0100,D0                       ; $0096BA
        MULS    $0090(A0),D0                    ; $0096BE
        ASR.L  #6,D0                            ; $0096C2
        ADD.W   D2,D0                           ; $0096C4
.apply_speed_scale:
        MULS    $0004(A0),D0                    ; $0096C6
        MOVEQ   #$0A,D2                         ; $0096CA
        ASR.L  D2,D0                            ; $0096CC
        MOVE.W  $0076(A0),D2                    ; $0096CE
        MOVE.W  $000C(A0),D3                    ; $0096D2
        BPL.S  .after_slope_adjust              ; $0096D6
        ADD.W   D3,D3                           ; $0096D8
        SUB.W   D3,D2                           ; $0096DA
.after_slope_adjust:
        MULS    D2,D0                           ; $0096DC
        ASR.L  #8,D0                            ; $0096DE
        TST.W  $0092(A0)                        ; $0096E0
        BLE.S  .after_slide_scale               ; $0096E4
        MOVE.W  #$0028,D1                       ; $0096E6
        SUB.W  $0092(A0),D1                     ; $0096EA
        MULS    D1,D0                           ; $0096EE
        ASR.L  #5,D0                            ; $0096F0
.after_slide_scale:
        MOVE.W  D0,D2                           ; $0096F2
        MOVE.W  D0,D1                           ; $0096F4
        ASR.W  #1,D1                            ; $0096F6
        ADD.W   D1,D0                           ; $0096F8
        TST.B  (-15589).W                       ; $0096FA
        BEQ.S  .update_heading                  ; $0096FE
        ASR.W  #1,D2                            ; $009700
        ADD.W   D2,D0                           ; $009702
.update_heading:
        ADD.W  D0,$003C(A0)                     ; $009704
        MOVE.W  $003C(A0),D0                    ; $009708
        SUB.W  $001E(A0),D0                     ; $00970C
        BPL.S  .heading_abs_diff                ; $009710
        NEG.W  D0                               ; $009712
.heading_abs_diff:
        CMPI.W  #$0222,D0                       ; $009714
        BGE.S  .reset_snap_counter              ; $009718
        ADDQ.W  #1,(-16382).W                   ; $00971A
        CMPI.W  #$0004,(-16382).W               ; $00971E
        BLT.S  .calc_trail_delta                ; $009724
        MOVE.W  $001E(A0),D0                    ; $009726
        SUB.W  $0040(A0),D0                     ; $00972A
        CMPI.W  #$0012,D0                       ; $00972E
        BLE.S  .clamp_snap_high                 ; $009732
        MOVE.W  #$0012,D0                       ; $009734
.clamp_snap_high:
        CMPI.W  #$FFEE,D0                       ; $009738
        BGE.S  .apply_snap                      ; $00973C
        MOVE.W  #$FFEE,D0                       ; $00973E
.apply_snap:
        ADD.W  D0,$003C(A0)                     ; $009742
        BRA.S  .calc_trail_delta                ; $009746
.reset_snap_counter:
        CLR.W  (-16382).W                       ; $009748
.calc_trail_delta:
        MOVE.W  $005C(A0),D0                    ; $00974C
        SUB.W  $005A(A0),D0                     ; $009750
        MOVE.W  $0090(A0),D1                    ; $009754
        BPL.S  .trail_signs_ok                  ; $009758
        NEG.W  D0                               ; $00975A
        NEG.W  D1                               ; $00975C
.trail_signs_ok:
        CMPI.W  #$0190,D0                       ; $00975E
        BLE.S  .clamp_trail_high                ; $009762
        MOVE.W  #$0190,D0                       ; $009764
.clamp_trail_high:
        CMPI.W  #$FFCE,D0                       ; $009768
        BGE.S  .clamp_trail_low_done            ; $00976C
        MOVE.W  #$FFCE,D0                       ; $00976E
.clamp_trail_low_done:
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
        BLE.S  .clamp_slope_high                ; $0097B2
        MOVE.W  #$0040,D1                       ; $0097B4
.clamp_slope_high:
        CMPI.W  #$FFF0,D1                       ; $0097B8
        BGE.S  .clamp_slope_low_done            ; $0097BC
        MOVE.W  #$FFF0,D1                       ; $0097BE
.clamp_slope_low_done:
        ADD.W   D1,D0                           ; $0097C2
        CMPI.W  #$0040,D0                       ; $0097C4
        BGE.S  .clamp_dist_min                  ; $0097C8
        MOVEQ   #$40,D0                         ; $0097CA
.clamp_dist_min:
        CMP.W  (-16152).W,D0                    ; $0097CC
        BLE.S  .clamp_dist_max                  ; $0097D0
        MOVE.W  (-16152).W,D0                   ; $0097D2
.clamp_dist_max:
        TST.W  $00AA(A0)                        ; $0097D6
        BLE.S  .check_drift_accum               ; $0097DA
        SUBQ.W  #8,$00AA(A0)                    ; $0097DC
.check_drift_accum:
        CMPI.W  #$0050,$00AA(A0)                ; $0097E0
        BGT.S  .set_cam_dist                    ; $0097E6
        MOVE.W  $0076(A0),D1                    ; $0097E8
        SUB.W   D0,D1                           ; $0097EC
        CMPI.W  #$000C,D1                       ; $0097EE
        BLE.S  .set_cam_dist                    ; $0097F2
        SUBI.W  #$000C,$0076(A0)                ; $0097F4
        BRA.S  .done                            ; $0097FA
.set_cam_dist:
        MOVE.W  D0,$0076(A0)                    ; $0097FC
.done:
        RTS                                     ; $009800
