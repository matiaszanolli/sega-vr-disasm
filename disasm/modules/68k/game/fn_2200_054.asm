; ============================================================================
; Vint Dispatch 054 (auto-analyzed)
; ROM Range: $0037B6-$00385E (168 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8A0 (race_state)
;   Object (A0, A1, A2, A4): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 (speed), +$0A (param_a), +$0E (param_e)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D2, D4, D7, A0, A1, A2
; RAM:
;   $C8A0: race_state
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$06: speed
;   +$0A: param_a
;   +$0E: param_e
;   +$10: [unknown]
;   +$30: x_position
; Confidence: high
; ============================================================================

fn_2200_054:
        LEA     (-28672).W,A0                   ; $0037B6
        MOVE.W  (-14176).W,D1                   ; $0037BA
        LEA     $00895A64,A1                    ; $0037BE
        MOVEA.L $00(A1,D1.W),A1                 ; $0037C4
        LEA     $00FF659C,A2                    ; $0037C8
        MOVE.W  #$0C80,D1                       ; $0037CE
        MOVEQ   #$02,D7                         ; $0037D2
.loc_001E:
        MOVE.W  $0030(A0),D2                    ; $0037D4
        MOVE.W  $0034(A0),D4                    ; $0037D8
        SUB.W  (A1),D2                          ; $0037DC
        BPL.S  .loc_002C                        ; $0037DE
        NEG.W  D2                               ; $0037E0
.loc_002C:
        CMP.W  D1,D2                            ; $0037E2
        BGT.S  .loc_0076                        ; $0037E4
        SUB.W  $0004(A1),D4                     ; $0037E6
        BPL.S  .loc_0038                        ; $0037EA
        NEG.W  D4                               ; $0037EC
.loc_0038:
        CMP.W  D1,D4                            ; $0037EE
        BGT.S  .loc_0076                        ; $0037F0
        MOVE.W  #$0001,$0000(A2)                ; $0037F2
        MOVE.L  (A1)+,$0002(A2)                 ; $0037F8
        MOVE.W  (A1)+,$0006(A2)                 ; $0037FC
        MOVE.W  (A1)+,$000A(A2)                 ; $003800
        MOVE.W  (A1)+,$000E(A2)                 ; $003804
        MOVEA.L (A1),A1                         ; $003808
        MOVE.W  (-16376).W,D0                   ; $00380A
        ADDQ.W  #1,D0                           ; $00380E
        CMPI.W  #$000C,D0                       ; $003810
        BNE.S  .loc_0064                        ; $003814
        MOVE.W  #$0000,D0                       ; $003816
.loc_0064:
        MOVE.W  D0,(-16376).W                   ; $00381A
        LSR.W  #1,D0                            ; $00381E
        DC.W    $D040                           ; $003820
        DC.W    $D040                           ; $003822
        MOVE.L  $00(A1,D0.W),$0010(A2)          ; $003824
        BRA.S  .loc_0084                        ; $00382A
.loc_0076:
        LEA     $000E(A1),A1                    ; $00382C
        DBRA    D7,.loc_001E                    ; $003830
        MOVE.W  #$0000,$0000(A2)                ; $003834
.loc_0084:
        MOVE.W  (-14176).W,D0                   ; $00383A
        MOVEA.L $003844(PC,D0.W),A1             ; $00383E
        JMP     (A1)                            ; $003842
        DC.W    $0088                           ; $003844
        MOVEA.W (A6)+,A4                        ; $003846
        DC.W    $0088                           ; $003848
        MOVE.W  (A4)+,$0088(A4)                 ; $00384A
        MOVEA.W (A4)+,A4                        ; $00384E
        DC.W    $0088                           ; $003850
        MOVE.W  $0088(A2),(A5)                  ; $003852
        MOVEA.W (A4)+,A4                        ; $003856
        DC.W    $0088                           ; $003858
        MOVEA.W (A4)+,A4                        ; $00385A
        RTS                                     ; $00385C
