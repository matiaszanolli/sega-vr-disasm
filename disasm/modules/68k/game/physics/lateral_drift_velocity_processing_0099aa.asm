; ============================================================================
; lateral_drift_velocity_processing_0099aa — Lateral Drift Velocity Processing (B)
; ROM Range: $0099AA-$009B12 (360 bytes)
; Variant of lateral_drift_velocity_processing_00987e with speed-dependent grip reduction and AI boost.
; Same lateral drift physics: slip detection from +$4C, force integration
; to +$94, spin-out trigger with sound $B2. Writes final viewport scaling
; values to $FF617A/$FF618E.
;
; Entry: A0 = entity pointer
; Uses: D0, D1, D2, D6, D7, A0
; Object fields: +$02 flags, +$04 speed, +$0E force, +$10 drag,
;   +$3C heading, +$4C slip angle, +$62 collision, +$6A lateral collision,
;   +$78 grip, +$80 effect timer, +$8C lateral flag, +$92 slide,
;   +$94 lateral velocity, +$96 lateral display
; Confidence: high
; ============================================================================

lateral_drift_velocity_processing_0099aa:
        MOVE.W  #$00B5,D6                       ; $0099AA
        MOVE.W  D6,D7                           ; $0099AE
        MOVE.W  (-16384).W,D0                   ; $0099B0
        BPL.S  .abs_steering_done               ; $0099B4
        NEG.W  D0                               ; $0099B6
.abs_steering_done:
        MULS    $0010(A0),D0                    ; $0099B8
        ASR.L  #7,D0                            ; $0099BC
        MOVEQ   #$00,D1                         ; $0099BE
        CMPI.W  #$00C8,$0004(A0)                ; $0099C0
        BLE.S  .grip_reduction_done             ; $0099C6
        BTST    #4,(-13967).W                   ; $0099C8
        BEQ.S  .grip_reduction_done             ; $0099CE
        MOVE.W  #$00FF,D1                       ; $0099D0
        SUB.W  $000E(A0),D1                     ; $0099D4
        ASL.W  #3,D1                            ; $0099D8
.grip_reduction_done:
        ADD.W   D1,D0                           ; $0099DA
        MOVE.W  $0078(A0),D1                    ; $0099DC
        SUB.W   D0,D1                           ; $0099E0
        CMPI.W  #$00FF,D1                       ; $0099E2
        BLE.S  .check_grip_lower                ; $0099E6
        MOVE.W  #$00FF,D1                       ; $0099E8
.check_grip_lower:
        CMPI.W  #$0040,D1                       ; $0099EC
        BGE.S  .store_grip                      ; $0099F0
        MOVE.W  #$0040,D1                       ; $0099F2
.store_grip:
        MOVE.W  D1,$0078(A0)                    ; $0099F6
        MOVE.W  $0092(A0),D0                    ; $0099FA
        ADD.W  $0062(A0),D0                     ; $0099FE
        BNE.W  .natural_damping                 ; $009A02
        MOVE.W  $004C(A0),D0                    ; $009A06
        MOVE.W  D0,D1                           ; $009A0A
        BPL.S  .abs_slip_done                   ; $009A0C
        NEG.W  D1                               ; $009A0E
.abs_slip_done:
        CMPI.W  #$0037,D1                       ; $009A10
        BLE.W  .natural_damping                 ; $009A14
        MOVE.W  $0094(A0),D1                    ; $009A18
        BPL.S  .abs_lateral_done                ; $009A1C
        NEG.W  D1                               ; $009A1E
.abs_lateral_done:
        MOVE.W  #$0200,D2                       ; $009A20
        SUB.W  $0078(A0),D2                     ; $009A24
        MULS    D2,D0                           ; $009A28
        ASR.L  #8,D0                            ; $009A2A
        DIVS    (-16146).W,D0                   ; $009A2C
        CMP.W  (-16144).W,D1                    ; $009A30
        BLE.S  .apply_force                     ; $009A34
        ASR.W  #1,D0                            ; $009A36
.apply_force:
        ADD.W  D0,$0094(A0)                     ; $009A38
        MOVE.W  $0094(A0),D0                    ; $009A3C
        MOVE.W  D0,D2                           ; $009A40
        ADD.W   D2,D2                           ; $009A42
        MOVE.W  D2,$0096(A0)                    ; $009A44
        MOVE.W  D0,D1                           ; $009A48
        BPL.S  .abs_vel_for_spin                ; $009A4A
        NEG.W  D1                               ; $009A4C
.abs_vel_for_spin:
        CMPI.W  #$0100,D1                       ; $009A4E
        BLT.S  .apply_heading_correction        ; $009A52
        MOVEQ   #$7F,D2                         ; $009A54
        TST.W  D0                               ; $009A56
        BMI.S  .adjust_viewport                 ; $009A58
        NEG.W  D2                               ; $009A5A
.adjust_viewport:
        ADD.W   D2,D6                           ; $009A5C
        SUB.W   D2,D7                           ; $009A5E
        CMPI.W  #$000B,$0080(A0)                ; $009A60
        BGE.S  .apply_heading_correction        ; $009A66
        ADDQ.W  #4,$0080(A0)                    ; $009A68
.apply_heading_correction:
        MULS    (-16138).W,D0                   ; $009A6C
        ASR.L  #8,D0                            ; $009A70
        SUB.W  D0,$003C(A0)                     ; $009A72
        CMP.W  (-16142).W,D1                    ; $009A76
        BLT.W  .write_viewport                  ; $009A7A
        MOVE.W  $006A(A0),D2                    ; $009A7E
        ADD.W  $008C(A0),D2                     ; $009A82
        BNE.W  .write_viewport                  ; $009A86
        MOVE.W  #$2000,D2                       ; $009A8A
        TST.W  $0094(A0)                        ; $009A8E
        BMI.S  .spinout_flag_selected           ; $009A92
        MOVE.W  #$1000,D2                       ; $009A94
.spinout_flag_selected:
        MOVE.B  #$B2,(-14172).W                 ; $009A98
        OR.W   D2,$0002(A0)                     ; $009A9E
        BRA.W  .write_viewport                  ; $009AA2
.natural_damping:
        MOVE.W  $0094(A0),D0                    ; $009AA6
        MOVE.W  D0,D1                           ; $009AAA
        BMI.S  .negative_vel                    ; $009AAC
        CMPI.W  #$0200,D0                       ; $009AAE
        BGT.S  .apply_drag                      ; $009AB2
        MOVE.W  #$0200,D0                       ; $009AB4
        BRA.S  .apply_drag                      ; $009AB8
.negative_vel:
        CMPI.W  #$FE00,D0                       ; $009ABA
        BLT.S  .apply_drag                      ; $009ABE
        MOVE.W  #$FE00,D0                       ; $009AC0
.apply_drag:
        MOVE.W  D0,D1                           ; $009AC4
        MULS    (-16140).W,D0                   ; $009AC6
        ASR.L  #8,D0                            ; $009ACA
        SUB.W  D0,$0094(A0)                     ; $009ACC
        MOVE.W  $0094(A0),D2                    ; $009AD0
        EOR.W   D2,D0                           ; $009AD4
        BPL.S  .check_zero_crossing             ; $009AD6
        CLR.W  $0094(A0)                        ; $009AD8
.check_zero_crossing:
        MOVE.W  $0094(A0),D0                    ; $009ADC
        MOVE.W  D0,D2                           ; $009AE0
        ASR.W  #1,D2                            ; $009AE2
        ADD.W   D0,D2                           ; $009AE4
        MOVE.W  D2,$0096(A0)                    ; $009AE6
        TST.W  D1                               ; $009AEA
        BGE.S  .signs_normalized                ; $009AEC
        NEG.W  D0                               ; $009AEE
        NEG.W  D1                               ; $009AF0
.signs_normalized:
        CMP.W  D0,D1                            ; $009AF2
        BLT.S  .write_viewport                  ; $009AF4
        TST.W  D0                               ; $009AF6
        BLT.S  .write_viewport                  ; $009AF8
        CMPI.W  #$000F,D0                       ; $009AFA
        BGT.S  .write_viewport                  ; $009AFE
        CLR.W  $0094(A0)                        ; $009B00
.write_viewport:
        MOVE.W  D6,$00FF617A                    ; $009B04
        MOVE.W  D7,$00FF618E                    ; $009B0A
        RTS                                     ; $009B10
