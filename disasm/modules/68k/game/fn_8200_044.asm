; ============================================================================
; State Dispatch 044 (auto-analyzed)
; ROM Range: $009DD6-$009E5A (132 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   Object (A0, A1, A2, A3): +$02 (flags/type), +$04 (speed_index/velocity), +$1E, +$30 (x_position), +$34 (y_position)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D2, D7, A0, A1, A2, A3
; Object fields:
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$1E: [unknown]
;   +$30: x_position
;   +$34: y_position
; Confidence: medium
; ============================================================================

fn_8200_044:
        DC.W    $B3BB                           ; $009DD6
        DC.W    $B3BC                           ; $009DD8
        DC.W    $CCCD                           ; $009DDA
        DC.W    $CCCE                           ; $009DDC
        MULS    (A0),D7                         ; $009DDE
        MULS    (A1),D7                         ; $009DE0
        MOVEQ   #$0E,D1                         ; $009DE2
.loc_000E:
        LEA     $0004(A0),A1                    ; $009DE4
        MOVE.W  D1,D2                           ; $009DE8
.loc_0014:
        MOVE.W  (A0),D0                         ; $009DEA
        CMP.W  (A1),D0                          ; $009DEC
        BLT.S  .loc_006C                        ; $009DEE
        BGT.S  .loc_0072                        ; $009DF0
        MOVEA.W $0002(A0),A2                    ; $009DF2
        MOVEA.W $0002(A1),A3                    ; $009DF6
        MOVE.W  $001E(A2),D0                    ; $009DFA
        ADDI.W  #$2000,D0                       ; $009DFE
        ROL.W  #3,D0                            ; $009E02
        ANDI.W  #$0006,D0                       ; $009E04
        JMP     $009E0C(PC,D0.W)                ; $009E08
        BRA.S  .loc_003E                        ; $009E0C
        BRA.S  .loc_004A                        ; $009E0E
        BRA.S  .loc_0056                        ; $009E10
        BRA.S  .loc_0062                        ; $009E12
.loc_003E:
        MOVE.W  $0034(A2),D0                    ; $009E14
        CMP.W  $0034(A3),D0                     ; $009E18
        BLT.S  .loc_006C                        ; $009E1C
        BRA.S  .loc_0072                        ; $009E1E
.loc_004A:
        MOVE.W  $0030(A2),D0                    ; $009E20
        CMP.W  $0030(A3),D0                     ; $009E24
        BGT.S  .loc_006C                        ; $009E28
        BRA.S  .loc_0072                        ; $009E2A
.loc_0056:
        MOVE.W  $0034(A2),D0                    ; $009E2C
        CMP.W  $0034(A3),D0                     ; $009E30
        BGT.S  .loc_006C                        ; $009E34
        BRA.S  .loc_0072                        ; $009E36
.loc_0062:
        MOVE.W  $0030(A2),D0                    ; $009E38
        CMP.W  $0030(A3),D0                     ; $009E3C
        BGT.S  .loc_0072                        ; $009E40
.loc_006C:
        MOVE.L  (A0),D0                         ; $009E42
        MOVE.L  (A1),(A0)                       ; $009E44
        MOVE.L  D0,(A1)                         ; $009E46
.loc_0072:
        LEA     $0004(A1),A1                    ; $009E48
        DBRA    D2,.loc_0014                    ; $009E4C
        LEA     $0004(A0),A0                    ; $009E50
        DBRA    D1,.loc_000E                    ; $009E54
        RTS                                     ; $009E58
