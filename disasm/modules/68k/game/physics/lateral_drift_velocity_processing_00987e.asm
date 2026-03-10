; ============================================================================
; lateral_drift_velocity_processing_00987e — Lateral Drift Velocity Processing (A)
; ROM Range: $00987E-$0099AA (300 bytes)
; Processes lateral drift/slide physics. Reduces grip based on steering
; magnitude, handles slip angle detection from +$4C with threshold $0037,
; applies force integration to +$94 (lateral velocity). Triggers spin-out
; via flag OR on +$02 with sound $B2 when drift exceeds limit. Natural
; damping decays velocity toward zero with sign preservation.
;
; Entry: A0 = entity pointer
; Uses: D0, D1, D2, A0
; Object fields: +$02 flags, +$10 drag, +$3C heading, +$4C slip angle,
;   +$62 collision, +$6A lateral collision, +$78 grip, +$8C lateral flag,
;   +$92 slide, +$94 lateral velocity, +$96 lateral display
; Confidence: high
; ============================================================================

lateral_drift_velocity_processing_00987e:
        MOVE.W  (-16384).W,D0                   ; $00987E
        BPL.S  .abs_steering_done               ; $009882
        NEG.W  D0                               ; $009884
.abs_steering_done:
        MULS    $0010(A0),D0                    ; $009886
        ASR.W  #8,D0                            ; $00988A
        MOVE.W  $0078(A0),D1                    ; $00988C
        SUB.W   D0,D1                           ; $009890
        CMPI.W  #$007F,D1                       ; $009892
        BGE.S  .clamp_grip_lower                ; $009896
        MOVEQ   #$7F,D1                         ; $009898
.clamp_grip_lower:
        MOVE.W  D1,$0078(A0)                    ; $00989A
        CLR.B  (-15589).W                       ; $00989E
        MOVE.W  $0092(A0),D0                    ; $0098A2
        ADD.W  $0062(A0),D0                     ; $0098A6
        BNE.W  .natural_damping                 ; $0098AA
        MOVE.W  $004C(A0),D0                    ; $0098AE
        MOVE.W  D0,D1                           ; $0098B2
        BPL.S  .abs_slip_done                   ; $0098B4
        NEG.W  D1                               ; $0098B6
.abs_slip_done:
        CMPI.W  #$0037,D1                       ; $0098B8
        BLE.W  .natural_damping                 ; $0098BC
        MOVE.W  $0094(A0),D1                    ; $0098C0
        BPL.S  .abs_lateral_done                ; $0098C4
        NEG.W  D1                               ; $0098C6
.abs_lateral_done:
        EXT.L   D0                              ; $0098C8
        DIVS    (-16146).W,D0                   ; $0098CA
        CMP.W  (-16144).W,D1                    ; $0098CE
        BGT.S  .high_velocity_slide             ; $0098D2
        MOVE.W  #$0200,D2                       ; $0098D4
        SUB.W  $0078(A0),D2                     ; $0098D8
        MULS    D2,D0                           ; $0098DC
        ASR.L  #8,D0                            ; $0098DE
        ADD.W  D0,$0094(A0)                     ; $0098E0
        MOVE.W  $0094(A0),D0                    ; $0098E4
        ASR.W  #1,D0                            ; $0098E8
        MOVE.W  D0,$0096(A0)                    ; $0098EA
        BRA.W  .done                            ; $0098EE
.high_velocity_slide:
        MOVE.B  #$01,(-15589).W                 ; $0098F2
        ASR.W  #2,D0                            ; $0098F8
        MOVE.W  D0,D1                           ; $0098FA
        ASR.W  #1,D1                            ; $0098FC
        ADD.W   D1,D0                           ; $0098FE
        ADD.W  D0,$0094(A0)                     ; $009900
        MOVE.W  $0094(A0),D0                    ; $009904
        MOVE.W  D0,D1                           ; $009908
        BPL.S  .abs_vel_for_spin                ; $00990A
        NEG.W  D1                               ; $00990C
.abs_vel_for_spin:
        MOVE.W  D0,$0096(A0)                    ; $00990E
        MULS    (-16138).W,D0                   ; $009912
        ASR.L  #8,D0                            ; $009916
        SUB.W  D0,$003C(A0)                     ; $009918
        CMP.W  (-16142).W,D1                    ; $00991C
        BLT.W  .done                            ; $009920
        MOVE.W  $006A(A0),D2                    ; $009924
        ADD.W  $008C(A0),D2                     ; $009928
        BNE.W  .done                            ; $00992C
        MOVE.W  #$2000,D2                       ; $009930
        TST.W  $0094(A0)                        ; $009934
        BMI.S  .spinout_flag_selected           ; $009938
        MOVE.W  #$1000,D2                       ; $00993A
.spinout_flag_selected:
        MOVE.B  #$B2,(-14172).W                 ; $00993E
        OR.W   D2,$0002(A0)                     ; $009944
        CLR.B  (-15589).W                       ; $009948
        BRA.W  .done                            ; $00994C
.natural_damping:
        MOVE.W  $0094(A0),D0                    ; $009950
        MOVE.W  D0,D1                           ; $009954
        BMI.S  .negative_vel                    ; $009956
        CMPI.W  #$0100,D0                       ; $009958
        BGT.S  .apply_drag                      ; $00995C
        MOVE.W  #$0100,D0                       ; $00995E
        BRA.S  .apply_drag                      ; $009962
.negative_vel:
        CMPI.W  #$FF00,D0                       ; $009964
        BLT.S  .apply_drag                      ; $009968
        MOVE.W  #$FF00,D0                       ; $00996A
.apply_drag:
        MOVE.W  D0,D1                           ; $00996E
        MULS    (-16140).W,D0                   ; $009970
        ASR.L  #8,D0                            ; $009974
        SUB.W  D0,$0094(A0)                     ; $009976
        MOVE.W  $0094(A0),D2                    ; $00997A
        EOR.W   D2,D0                           ; $00997E
        BPL.S  .check_zero_crossing             ; $009980
        CLR.W  $0094(A0)                        ; $009982
.check_zero_crossing:
        MOVE.W  $0094(A0),D0                    ; $009986
        MOVE.W  D0,$0096(A0)                    ; $00998A
        TST.W  D1                               ; $00998E
        BGE.S  .signs_normalized                ; $009990
        NEG.W  D0                               ; $009992
        NEG.W  D1                               ; $009994
.signs_normalized:
        CMP.W  D0,D1                            ; $009996
        BLT.S  .done                            ; $009998
        TST.W  D0                               ; $00999A
        BLT.S  .done                            ; $00999C
        CMPI.W  #$000F,D0                       ; $00999E
        BGT.S  .done                            ; $0099A2
        CLR.W  $0094(A0)                        ; $0099A4
.done:
        RTS                                     ; $0099A8
