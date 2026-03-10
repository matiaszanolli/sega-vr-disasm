; ============================================================================
; steering_input_processing_and_velocity_update — Steering Input Processing and Velocity Update
; ROM Range: $0094F4-$00961E (298 bytes)
; Data prefix (2 bytes) at start. Reads controller button bits for left/right
; and up/down input, computes steering direction with acceleration and
; deadzone. Smooths steering velocity with damping, clamps to +/-$7F range.
; Applies integrated steering to entity field +$8E. Manages lateral drift
; accumulator at +$AA.
;
; Entry: A0 = entity pointer
; Uses: D0, D1, D2, D3, A0, A1
; Object fields: +$8E steering velocity, +$94 drift rate, +$AA drift accum
; Confidence: high
; ============================================================================

steering_input_processing_and_velocity_update:
        DC.W    $FFE8                           ; $0094F4
        ORI.B  #$18,D0                          ; $0094F6
        MOVE.B  (-15616).W,(-15615).W           ; $0094FA
        MOVE.B  (-13967).W,(-15616).W           ; $009500
        MOVEQ   #$02,D2                         ; $009506
        MOVEQ   #$03,D3                         ; $009508
        BTST    #7,(-600).W                     ; $00950A
        BEQ.S  .buttons_resolved                ; $009510
        EXG     D2,D3                           ; $009512
.buttons_resolved:
        LEA     (-15616).W,A1                   ; $009514
        MOVEQ   #$00,D0                         ; $009518
        MOVEQ   #$00,D1                         ; $00951A
        BTST    D2,$0001(A1)                    ; $00951C
        BEQ.S  .check_right                     ; $009520
        MOVEQ   #$01,D0                         ; $009522
.check_right:
        BTST    D3,$0001(A1)                    ; $009524
        BEQ.S  .check_up                        ; $009528
        SUBQ.W  #1,D0                           ; $00952A
.check_up:
        BTST    D2,(A1)                         ; $00952C
        BEQ.S  .check_down                      ; $00952E
        MOVEQ   #$01,D1                         ; $009530
.check_down:
        BTST    D3,(A1)                         ; $009532
        BEQ.S  .input_resolved                  ; $009534
        SUBQ.W  #1,D1                           ; $009536
.input_resolved:
        lea     steering_input_processing_and_velocity_update+2(pc),a1; $43FA $FFBC
        CMP.W  (-16378).W,D1                    ; $00953C
        BEQ.S  .same_direction                  ; $009540
        MOVE.W  D1,(-16378).W                   ; $009542
        MOVE.W  D1,D2                           ; $009546
        ADD.W   D2,D2                           ; $009548
        MOVE.W  $00(A1,D2.W),D2                 ; $00954A
        MOVE.W  D2,(-16384).W                   ; $00954E
        LSL.W  #8,D2                            ; $009552
        MOVE.W  D2,$008E(A0)                    ; $009554
        BRA.S  .clamp_velocity                  ; $009558
.same_direction:
        TST.W  D1                               ; $00955A
        BNE.S  .nonzero_input                   ; $00955C
        MOVE.W  (-16384).W,D2                   ; $00955E
        BEQ.S  .apply_damping                   ; $009562
        BPL.S  .apply_positive_damp             ; $009564
        MOVEQ   #-$02,D2                        ; $009566
        BRA.S  .apply_damping                   ; $009568
.apply_positive_damp:
        MOVEQ   #$02,D2                         ; $00956A
.apply_damping:
        MOVE.W  $00(A1,D2.W),D2                 ; $00956C
        SUB.W  D2,(-16384).W                    ; $009570
        BRA.S  .clamp_velocity                  ; $009574
.nonzero_input:
        MOVE.W  D1,(-16378).W                   ; $009576
        MOVE.W  D1,D2                           ; $00957A
        ADD.W   D2,D2                           ; $00957C
        MOVE.W  $00(A1,D2.W),D2                 ; $00957E
        TST.W  (-14136).W                       ; $009582
        BEQ.S  .add_acceleration                ; $009586
        MOVE.W  $0094(A0),D0                    ; $009588
        EOR.W   D2,D0                           ; $00958C
        BMI.S  .add_acceleration                ; $00958E
        ASR.W  #1,D2                            ; $009590
        MOVE.W  $0094(A0),D0                    ; $009592
        ASR.W  #3,D0                            ; $009596
        SUB.W  D0,$0094(A0)                     ; $009598
.add_acceleration:
        ADD.W  D2,(-16384).W                    ; $00959C
.clamp_velocity:
        CMPI.W  #$007F,(-16384).W               ; $0095A0
        BLE.S  .check_lower_clamp               ; $0095A6
        MOVE.W  #$007F,(-16384).W               ; $0095A8
.check_lower_clamp:
        CMPI.W  #$FF81,(-16384).W               ; $0095AE
        BGE.S  .apply_deadzone                  ; $0095B4
        MOVE.W  #$FF81,(-16384).W               ; $0095B6
.apply_deadzone:
        MOVE.W  (-16384).W,D2                   ; $0095BC
        MOVE.W  D2,D0                           ; $0095C0
        BPL.S  .check_deadzone_threshold        ; $0095C2
        NEG.W  D0                               ; $0095C4
        BVC.S  .integrate_steering              ; $0095C6
.check_deadzone_threshold:
        CMPI.W  #$0018,D0                       ; $0095C8
        BGE.S  .integrate_steering              ; $0095CC
        CLR.W  (-16384).W                       ; $0095CE
.integrate_steering:
        EXT.L   D2                              ; $0095D2
        LSL.L  #8,D2                            ; $0095D4
        MOVE.W  $008E(A0),D1                    ; $0095D6
        EXT.L   D1                              ; $0095DA
        ADD.L   D1,D2                           ; $0095DC
        ASR.L  #1,D2                            ; $0095DE
        MOVE.L  D2,D3                           ; $0095E0
        SUB.L   D1,D3                           ; $0095E2
        TST.W  D3                               ; $0095E4
        BPL.S  .abs_delta_done                  ; $0095E6
        NEG.W  D3                               ; $0095E8
.abs_delta_done:
        ASR.W  #8,D3                            ; $0095EA
        ADD.W  $00AA(A0),D3                     ; $0095EC
        CMPI.W  #$00C8,D3                       ; $0095F0
        BLE.S  .check_drift_lower               ; $0095F4
        MOVE.W  #$00C8,D3                       ; $0095F6
.check_drift_lower:
        CMPI.W  #$0000,D3                       ; $0095FA
        BGE.S  .store_drift                     ; $0095FE
        MOVE.W  #$0000,D3                       ; $009600
.store_drift:
        MOVE.W  D3,$00AA(A0)                    ; $009604
        MOVE.W  D2,D1                           ; $009608
        BPL.S  .check_final_deadzone            ; $00960A
        NEG.W  D1                               ; $00960C
        BVS.S  .store_steering                  ; $00960E
.check_final_deadzone:
        CMPI.W  #$0018,D1                       ; $009610
        BGE.S  .store_steering                  ; $009614
        MOVEQ   #$00,D2                         ; $009616
.store_steering:
        MOVE.W  D2,$008E(A0)                    ; $009618
        RTS                                     ; $00961C
