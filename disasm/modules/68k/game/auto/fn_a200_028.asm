; ============================================================================
; Display Dispatch 028 (auto-analyzed)
; ROM Range: $00B7EE-$00B964 (374 bytes)
; ============================================================================
; Category: display
; Purpose: State dispatcher using jump table
;   RAM: $C048 (camera_state)
;   Object (A0, A1, A2): +$00, +$10, +$14 (effect_duration), +$16 (calc_speed), +$18, +$1A (direction)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D2, D4, A0, A1, A2, A4
; RAM:
;   $C048: camera_state
; Object fields:
;   +$00: [unknown]
;   +$10: [unknown]
;   +$14: effect_duration
;   +$16: calc_speed
;   +$18: [unknown]
;   +$1A: direction
;   +$24: [unknown]
;   +$28: [unknown]
; Confidence: medium
; ============================================================================

fn_a200_028:
        MOVEQ   #$00,D0                         ; $00B7EE
        MOVE.B  (-16283).W,D0                   ; $00B7F0
        MOVEA.L $00B864(PC,D0.W),A1             ; $00B7F4
        JMP     (A1)                            ; $00B7F8
        MOVEQ   #$00,D2                         ; $00B7FA
        MOVE.B  (-15614).W,D2                   ; $00B7FC
        BRA.S  .loc_0056                        ; $00B800
        MOVEQ   #$00,D0                         ; $00B802
        MOVE.B  (-15614).W,D0                   ; $00B804
        MOVE.W  D0,D2                           ; $00B808
        TST.B  (-15599).W                       ; $00B80A
        BEQ.S  .loc_003C                        ; $00B80E
        SUBQ.W  #4,D0                           ; $00B810
        SUBQ.W  #1,(-16312).W                   ; $00B812
        TST.W  D0                               ; $00B816
        BGE.S  .loc_0056                        ; $00B818
        MOVE.B  #$00,(-15599).W                 ; $00B81A
        MOVE.W  #$0001,(-16312).W               ; $00B820
        MOVEQ   #$04,D0                         ; $00B826
        BRA.S  .loc_0056                        ; $00B828
.loc_003C:
        ADDQ.W  #4,D0                           ; $00B82A
        ADDQ.W  #1,(-16312).W                   ; $00B82C
        CMPI.W  #$0010,D0                       ; $00B830
        BLT.S  .loc_0056                        ; $00B834
        MOVE.B  #$01,(-15599).W                 ; $00B836
        MOVE.W  #$0002,(-16312).W               ; $00B83C
        MOVEQ   #$08,D0                         ; $00B842
.loc_0056:
        MOVE.B  D0,(-15614).W                   ; $00B844
        DC.W    $D442                           ; $00B848
        DC.W    $D442                           ; $00B84A
        DC.W    $D042                           ; $00B84C
        MOVE.B  #$01,(-16284).W                 ; $00B84E
        MOVE.B  D0,(-16283).W                   ; $00B854
        MOVE.B  #$14,(-15613).W                 ; $00B858
        MOVEA.L $00B864(PC,D0.W),A1             ; $00B85E
        JMP     (A1)                            ; $00B862
        DC.W    $0088                           ; $00B864
        CMP.L  -(A4),D4                         ; $00B866
        DC.W    $0088                           ; $00B868
        EOR.W  D4,-(A4)                         ; $00B86A
        DC.W    $0088                           ; $00B86C
        EOR.W  D4,-(A4)                         ; $00B86E
        DC.W    $0088                           ; $00B870
        DC.W    $B97A                           ; $00B872
        DC.W    $0088                           ; $00B874
        CMP.L  -(A4),D4                         ; $00B876
        DC.W    $0088                           ; $00B878
        CMP.L  -(A4),D4                         ; $00B87A
        DC.W    $0088                           ; $00B87C
        EOR.W  D4,-(A4)                         ; $00B87E
        DC.W    $0088                           ; $00B880
        DC.W    $B97A                           ; $00B882
        DC.W    $0088                           ; $00B884
        CMP.L  -(A4),D4                         ; $00B886
        DC.W    $0088                           ; $00B888
        EOR.W  D4,-(A4)                         ; $00B88A
        DC.W    $0088                           ; $00B88C
        CMP.L  -(A4),D4                         ; $00B88E
        DC.W    $0088                           ; $00B890
        DC.W    $B97A                           ; $00B892
        DC.W    $0088                           ; $00B894
        CMP.L  -(A4),D4                         ; $00B896
        DC.W    $0088                           ; $00B898
        EOR.W  D4,-(A4)                         ; $00B89A
        DC.W    $0088                           ; $00B89C
        EOR.W  D4,-(A4)                         ; $00B89E
        DC.W    $0088                           ; $00B8A0
        CMP.L  -(A4),D4                         ; $00B8A2
        MOVEA.L (-14524).W,A1                   ; $00B8A4
        ADD.W  (-14148).W,D0                    ; $00B8A8
        MOVEA.L $00(A1,D0.W),A1                 ; $00B8AC
        MOVEQ   #$00,D0                         ; $00B8B0
        MOVE.B  (-15613).W,D0                   ; $00B8B2
        DC.W    $D040                           ; $00B8B6
        DC.W    $D040                           ; $00B8B8
        MOVE.L  $00(A1,D0.W),D0                 ; $00B8BA
        MOVE.W  D0,(-16298).W                   ; $00B8BE
        SWAP    D0                              ; $00B8C2
        MOVE.W  D0,(-16300).W                   ; $00B8C4
        MOVE.B  #$00,(-15588).W                 ; $00B8C8
        SUBQ.B  #1,(-15613).W                   ; $00B8CE
        BNE.W  .loc_0174                        ; $00B8D2
        MOVE.B  #$00,(-16284).W                 ; $00B8D6
        MOVE.L  (-14512).W,$0010(A2)            ; $00B8DC
        TST.W  $008A(A0)                        ; $00B8E2
        BNE.S  .loc_0100                        ; $00B8E6
        MOVE.L  (-14556).W,$0010(A2)            ; $00B8E8
.loc_0100:
        MOVEQ   #$00,D2                         ; $00B8EE
        MOVE.L  (-14552).W,D1                   ; $00B8F0
        BEQ.S  .loc_0114                        ; $00B8F4
        MOVE.L  D1,$0024(A2)                    ; $00B8F6
        MOVE.L  (-14548).W,$0038(A2)            ; $00B8FA
        MOVEQ   #$01,D2                         ; $00B900
.loc_0114:
        MOVE.W  D2,$0014(A2)                    ; $00B902
        MOVE.W  D2,$0028(A2)                    ; $00B906
        MOVE.W  #$0001,(-16308).W               ; $00B90A
        MOVE.W  #$0002,$0000(A2)                ; $00B910
        MOVEA.L (-14536).W,A1                   ; $00B916
        MOVE.W  (A1)+,$0016(A2)                 ; $00B91A
        MOVE.W  (A1)+,$0018(A2)                 ; $00B91E
        MOVE.W  (A1)+,$001A(A2)                 ; $00B922
        MOVE.W  (A1)+,$002A(A2)                 ; $00B926
        MOVE.W  (A1)+,$002C(A2)                 ; $00B92A
        MOVE.W  (A1),$002E(A2)                  ; $00B92E
        MOVE.W  #$0000,$003C(A2)                ; $00B932
        MOVE.W  #$0000,$0050(A2)                ; $00B938
        MOVEA.L (-14528).W,A1                   ; $00B93E
        CMPA.L  #$00000000,A1                   ; $00B942
        BEQ.S  .loc_0174                        ; $00B948
        MOVE.W  (A1)+,$0052(A2)                 ; $00B94A
        MOVE.W  (A1)+,$0054(A2)                 ; $00B94E
        MOVE.W  (A1),$0056(A2)                  ; $00B952
        MOVE.W  #$0001,$0050(A2)                ; $00B956
        MOVE.L  (-14544).W,$0060(A2)            ; $00B95C
.loc_0174:
        RTS                                     ; $00B962
