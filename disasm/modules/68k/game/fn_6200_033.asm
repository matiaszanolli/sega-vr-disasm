; ============================================================================
; Obj 033 (auto-analyzed)
; ROM Range: $0076A2-$007700 (94 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A1, A2): +$00, +$04 (speed_index/velocity), +$06 (speed), +$0A (param_a), +$0C, +$10
;
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D2, A1, A2
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
;   +$06: speed
;   +$0A: param_a
;   +$0C: [unknown]
;   +$10: [unknown]
;   +$12: timer_12
;   +$16: calc_speed
; Confidence: low
; ============================================================================

fn_6200_033:
        MOVEA.L (-15768).W,A1                   ; $0076A2
        LEA     (-16338).W,A2                   ; $0076A6
        LSR.W  #6,D0                            ; $0076AA
        DC.W    $D040                           ; $0076AC
        LEA     $00(A1,D0.W),A1                 ; $0076AE
        MOVE.B  (A1)+,D2                        ; $0076B2
        EXT.W   D2                              ; $0076B4
        MOVE.W  D2,$0000(A2)                    ; $0076B6
        MOVE.B  (A1),D2                         ; $0076BA
        EXT.W   D2                              ; $0076BC
        MOVE.W  D2,$0004(A2)                    ; $0076BE
        LEA     $07FF(A1),A1                    ; $0076C2
        MOVE.B  (A1)+,D2                        ; $0076C6
        EXT.W   D2                              ; $0076C8
        MOVE.W  D2,$0006(A2)                    ; $0076CA
        MOVE.B  (A1),D2                         ; $0076CE
        EXT.W   D2                              ; $0076D0
        MOVE.W  D2,$000A(A2)                    ; $0076D2
        LEA     $07FF(A1),A1                    ; $0076D6
        MOVE.B  (A1)+,D2                        ; $0076DA
        EXT.W   D2                              ; $0076DC
        MOVE.W  D2,$000C(A2)                    ; $0076DE
        MOVE.B  (A1),D2                         ; $0076E2
        EXT.W   D2                              ; $0076E4
        MOVE.W  D2,$0010(A2)                    ; $0076E6
        LEA     $07FF(A1),A1                    ; $0076EA
        MOVE.B  (A1)+,D2                        ; $0076EE
        EXT.W   D2                              ; $0076F0
        MOVE.W  D2,$0012(A2)                    ; $0076F2
        MOVE.B  (A1),D2                         ; $0076F6
        EXT.W   D2                              ; $0076F8
        MOVE.W  D2,$0016(A2)                    ; $0076FA
        RTS                                     ; $0076FE
