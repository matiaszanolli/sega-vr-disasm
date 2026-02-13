; ============================================================================
; Math Sine Lookup 056 (auto-analyzed)
; ROM Range: $003866-$003924 (190 bytes)
; ============================================================================
; Category: math
; Purpose: Calls: sine_lookup
;   Object (A0, A1, A2): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 (speed), +$0A (param_a), +$0E (param_e)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, A0, A1
; Calls:
;   $008F52: sine_lookup
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$06: speed
;   +$0A: param_a
;   +$0E: param_e
;   +$10: [unknown]
;   +$14: effect_duration
; Confidence: medium
; ============================================================================

fn_2200_056:
        LEA     $00883924,A1                    ; $003866
        LEA     $00FF65B0,A2                    ; $00386C
        ADDQ.W  #3,(-14110).W                   ; $003872
        MOVE.W  #$0C80,D1                       ; $003876
        MOVE.W  #$1400,D3                       ; $00387A
        MOVE.W  #$0000,$0000(A2)                ; $00387E
        MOVE.W  #$0000,$0014(A2)                ; $003884
        MOVE.W  (-14110).W,D0                   ; $00388A
        ANDI.W  #$1FFF,D0                       ; $00388E
        MOVE.W  D0,$0020(A2)                    ; $003892
        BSR.S  .loc_005A                        ; $003896
        LEA     $0028(A2),A2                    ; $003898
        MOVE.W  (-14110).W,D0                   ; $00389C
        LSL.W  #8,D0                            ; $0038A0
        MOVEM.L D1/A1,-(A7)                     ; $0038A2
        DC.W    $4EBA,$56AA         ; JSR     $008F52(PC); $0038A6
        MOVEM.L (A7)+,D1/A1                     ; $0038AA
        ASL.W  #2,D0                            ; $0038AE
        MOVE.W  D0,$0020(A2)                    ; $0038B0
        MOVE.W  #$0000,$0000(A2)                ; $0038B4
        MOVE.W  #$0000,$0010(A2)                ; $0038BA
.loc_005A:
        MOVE.W  $0030(A0),D2                    ; $0038C0
        MOVE.W  $0034(A0),D4                    ; $0038C4
        MOVE.W  $0032(A0),D5                    ; $0038C8
        SUB.W  (A1),D2                          ; $0038CC
        BPL.S  .loc_006C                        ; $0038CE
        NEG.W  D2                               ; $0038D0
.loc_006C:
        CMP.W  D1,D2                            ; $0038D2
        BGT.S  .loc_00BC                        ; $0038D4
        SUB.W  $0002(A1),D5                     ; $0038D6
        BPL.S  .loc_0078                        ; $0038DA
        NEG.W  D5                               ; $0038DC
.loc_0078:
        CMP.W  D3,D5                            ; $0038DE
        BGT.S  .loc_00BC                        ; $0038E0
        SUB.W  $0004(A1),D4                     ; $0038E2
        BPL.S  .loc_0084                        ; $0038E6
        NEG.W  D4                               ; $0038E8
.loc_0084:
        CMP.W  D1,D4                            ; $0038EA
        BGT.S  .loc_00BC                        ; $0038EC
        MOVE.W  #$0002,$0000(A2)                ; $0038EE
        MOVE.L  (A1)+,$0002(A2)                 ; $0038F4
        MOVE.W  (A1)+,$0006(A2)                 ; $0038F8
        MOVE.W  (A1)+,$000A(A2)                 ; $0038FC
        MOVE.W  (A1)+,$000E(A2)                 ; $003900
        MOVE.L  (A1)+,$0010(A2)                 ; $003904
        MOVE.W  #$0002,$0014(A2)                ; $003908
        MOVE.L  (A1)+,$0016(A2)                 ; $00390E
        MOVE.W  (A1)+,$001A(A2)                 ; $003912
        MOVE.W  (A1)+,$001E(A2)                 ; $003916
        MOVE.W  (A1)+,$0022(A2)                 ; $00391A
        MOVE.L  (A1)+,$0024(A2)                 ; $00391E
.loc_00BC:
        RTS                                     ; $003922
