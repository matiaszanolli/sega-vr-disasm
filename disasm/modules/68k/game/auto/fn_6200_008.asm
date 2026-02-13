; ============================================================================
; Obj Dispatch 008 (auto-analyzed)
; ROM Range: $006AB4-$006B96 (226 bytes)
; ============================================================================
; Category: object
; Purpose: State dispatcher using jump table
;   Calls: effect_timer_mgmt, object_frame_timer, load_object_params, timer_countdown
;   Object (A0, A6): +$44 (display_offset), +$46 (display_scale), +$4A, +$88, +$92 (param_92)
;
; Entry: A0 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, A0, A2, A6
; Calls:
;   $006F98: calc_steering
;   $0070AA: angle_to_sine
;   $007816: obj_collision_test
;   $007C4E: obj_position_y
;   $007CD8: obj_position_x
;   $007E7A: obj_velocity_y
; Object fields:
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: [unknown]
;   +$88: [unknown]
;   +$92: param_92
; Confidence: high
; ============================================================================

fn_6200_008:
        DC.W    $0088                           ; $006AB4
        DC.W    $3C7E                           ; $006AB6
        DC.W    $0088                           ; $006AB8
        MOVE.W  (A2)+,$0088(A6)                 ; $006ABA
        MOVE.W  (A2)+,$0088(A6)                 ; $006ABE
        MOVE.W  (A2)+,$0088(A6)                 ; $006AC2
        MOVE.W  (A2)+,$0088(A6)                 ; $006AC6
        MOVE.W  (A2)+,$4EBA(A6)                 ; $006ACA
        DC.W    $4CA2                           ; $006ACE
        DC.W    $4EBA,$387E         ; JSR     $00A350(PC); $006AD0
        DC.W    $4EBA,$169A         ; JSR     $008170(PC); $006AD4
        DC.W    $4EBA,$15F2         ; JSR     $0080CC(PC); $006AD8
        DC.W    $4EBA,$1A6A         ; JSR     $008548(PC); $006ADC
        DC.W    $4EBA,$2B3C         ; JSR     $00961E(PC); $006AE0
        DC.W    $4EBA,$0D30         ; JSR     $007816(PC); $006AE4
        DC.W    $4EBA,$0B64         ; JSR     $00764E(PC); $006AE8
        DC.W    $4EBA,$05BC         ; JSR     $0070AA(PC); $006AEC
        DC.W    $4EBA,$3DEE         ; JSR     $00A8E0(PC); $006AF0
        DC.W    $4EBA,$305E         ; JSR     $009B54(PC); $006AF4
        DC.W    $4EBA,$2688         ; JSR     $009182(PC); $006AF8
        DC.W    $4EBA,$2D04         ; JSR     $009802(PC); $006AFC
        DC.W    $4EFA,$0648         ; JMP     $00714A(PC); $006B00
        MOVEQ   #$00,D0                         ; $006B04
        MOVE.W  D0,$0044(A0)                    ; $006B06
        MOVE.W  D0,$0046(A0)                    ; $006B0A
        MOVE.W  D0,$004A(A0)                    ; $006B0E
        MOVE.L  #$00100010,(-13968).W           ; $006B12
        MOVE.B  #$00,(-15601).W                 ; $006B1A
        DC.W    $4EBA,$4C4E         ; JSR     $00B770(PC); $006B20
        MOVE.W  #$0002,$0092(A0)                ; $006B24
        DC.W    $4EBA,$1A6E         ; JSR     $00859A(PC); $006B2A
        DC.W    $4EBA,$3820         ; JSR     $00A350(PC); $006B2E
        DC.W    $4EBA,$163C         ; JSR     $008170(PC); $006B32
        DC.W    $4EBA,$1594         ; JSR     $0080CC(PC); $006B36
        DC.W    $4EBA,$1A0C         ; JSR     $008548(PC); $006B3A
        DC.W    $4EBA,$29BA         ; JSR     $0094FA(PC); $006B3E
        DC.W    $4EBA,$27CE         ; JSR     $009312(PC); $006B42
        DC.W    $4EBA,$2FCA         ; JSR     $009B12(PC); $006B46
        DC.W    $4EBA,$2636         ; JSR     $009182(PC); $006B4A
        DC.W    $4EBA,$2ACE         ; JSR     $00961E(PC); $006B4E
        DC.W    $4EBA,$2B34         ; JSR     $009688(PC); $006B52
        DC.W    $4EBA,$2CAA         ; JSR     $009802(PC); $006B56
        DC.W    $4EBA,$131E         ; JSR     $007E7A(PC); $006B5A
        DC.W    $4EBA,$0438         ; JSR     $006F98(PC); $006B5E
        DC.W    $4EBA,$1174         ; JSR     $007CD8(PC); $006B62
        DC.W    $4EBA,$38CC         ; JSR     $00A434(PC); $006B66
        DC.W    $4EBA,$053E         ; JSR     $0070AA(PC); $006B6A
        DC.W    $4EBA,$10DE         ; JSR     $007C4E(PC); $006B6E
        DC.W    $4EBA,$05D6         ; JSR     $00714A(PC); $006B72
        DC.W    $4EBA,$0AD6         ; JSR     $00764E(PC); $006B76
        DC.W    $4EBA,$13D4         ; JSR     $007F50(PC); $006B7A
        DC.W    $4EBA,$2FD4         ; JSR     $009B54(PC); $006B7E
        DC.W    $4EBA,$DBE6         ; JSR     $00476A(PC); $006B82
        DC.W    $4EFA,$C58E         ; JMP     $003116(PC); $006B86
        MOVE.W  (-16262).W,D0                   ; $006B8A
        MOVE.W  $006B96(PC,D0.W),(-15764).W     ; $006B8E
        RTS                                     ; $006B94
