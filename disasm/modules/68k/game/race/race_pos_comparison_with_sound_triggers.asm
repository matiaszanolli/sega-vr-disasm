; ============================================================================
; race_pos_comparison_with_sound_triggers — Race Position Comparison with Sound Triggers
; ROM Range: $0087E2-$0088BE (220 bytes)
; Compares race positions of two entities (A0, A2) using segment/position
; indices. When tied, uses trig-based distance calculation with sine/cosine
; lookups to break the tie. Updates rank fields +$2A and triggers sound
; effects ($CC/$CF/$B3) on position changes.
;
; Entry: A0 = player 1 entity, A2 = player 2/AI entity
; Uses: D0, D1, D2, D3, D4, A0, A2
; Calls: $008F4E (cosine_lookup), $008F52 (sine_lookup)
; Object fields: +$04 speed, +$1E heading, +$24 segment, +$2A rank,
;   +$2E lap segment, +$30 x_pos, +$34 y_pos, +$E5 AI flags
; Confidence: high
; ============================================================================

race_pos_comparison_with_sound_triggers:
        LEA     (-28672).W,A0                   ; $0087E2
        LEA     (-24832).W,A2                   ; $0087E6
        MOVE.W  $002E(A0),D0                    ; $0087EA
        LSL.W  #8,D0                            ; $0087EE
        ADD.W  $0024(A0),D0                     ; $0087F0
        MOVE.W  $002E(A2),D1                    ; $0087F4
        LSL.W  #8,D1                            ; $0087F8
        ADD.W  $0024(A2),D1                     ; $0087FA
        MOVEQ   #$02,D2                         ; $0087FE
        MOVEQ   #$01,D3                         ; $008800
        CMP.W  D0,D1                            ; $008802
        BGT.S  .loc_0076                        ; $008804
        BNE.S  .loc_0072                        ; $008806
        MOVE.W  $001E(A0),D0                    ; $008808
        NEG.W  D0                               ; $00880C
        MOVE.W  D0,D2                           ; $00880E
        jsr     sine_cosine_quadrant_lookup+4(pc); $4EBA $0740
        ASR.W  #4,D0                            ; $008814
        MULS    $0030(A0),D0                    ; $008816
        MOVE.L  D0,D4                           ; $00881A
        MOVE.W  D2,D0                           ; $00881C
        jsr     sine_cosine_quadrant_lookup(pc); $4EBA $072E
        ASR.W  #4,D0                            ; $008822
        MULS    $0034(A0),D0                    ; $008824
        ADD.L   D0,D4                           ; $008828
        MOVE.W  $001E(A2),D0                    ; $00882A
        NEG.W  D0                               ; $00882E
        MOVE.W  D0,D2                           ; $008830
        jsr     sine_cosine_quadrant_lookup+4(pc); $4EBA $071E
        ASR.W  #4,D0                            ; $008836
        MULS    $0030(A2),D0                    ; $008838
        MOVE.L  D0,D3                           ; $00883C
        MOVE.W  D2,D0                           ; $00883E
        jsr     sine_cosine_quadrant_lookup(pc); $4EBA $070C
        ASR.W  #4,D0                            ; $008844
        MULS    $0034(A2),D0                    ; $008846
        ADD.L   D3,D0                           ; $00884A
        MOVEQ   #$02,D2                         ; $00884C
        MOVEQ   #$01,D3                         ; $00884E
        CMP.L  D4,D0                            ; $008850
        BGT.S  .loc_0076                        ; $008852
.loc_0072:
        MOVEQ   #$01,D2                         ; $008854
        MOVEQ   #$02,D3                         ; $008856
.loc_0076:
        CMP.W  $002A(A0),D2                     ; $008858
        BEQ.S  .loc_00D2                        ; $00885C
        MOVE.W  $0004(A0),D4                    ; $00885E
        SUB.W  $0004(A2),D4                     ; $008862
        BPL.S  .loc_0088                        ; $008866
        NEG.W  D4                               ; $008868
.loc_0088:
        CMPI.W  #$0014,D4                       ; $00886A
        BLE.S  .loc_00D2                        ; $00886E
        MOVE.W  $0004(A0),D4                    ; $008870
        ADD.W  $0004(A2),D4                     ; $008874
        CMPI.W  #$0064,D4                       ; $008878
        BLE.S  .loc_00D2                        ; $00887C
        CMPI.W  #$0004,(-14180).W               ; $00887E
        BNE.S  .loc_00B0                        ; $008884
        MOVE.B  $00E5(A0),D1                    ; $008886
        EOR.B   D1,D2                           ; $00888A
        ANDI.B  #$06,D2                         ; $00888C
        BNE.S  .loc_00D2                        ; $008890
.loc_00B0:
        MOVE.B  #$CC,(-14172).W                 ; $008892
        CMPI.W  #$0001,(-14136).W               ; $008898
        BEQ.S  .loc_00D2                        ; $00889E
        MOVE.B  #$CF,(-14172).W                 ; $0088A0
        CMPI.W  #$0002,(-14136).W               ; $0088A6
        BEQ.S  .loc_00D2                        ; $0088AC
        MOVE.B  #$B3,(-14172).W                 ; $0088AE
.loc_00D2:
        MOVE.W  D2,$002A(A0)                    ; $0088B4
        MOVE.W  D3,$002A(A2)                    ; $0088B8
        RTS                                     ; $0088BC
