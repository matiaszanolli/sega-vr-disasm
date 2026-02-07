; ============================================================================
; Ai Sh2 Comm 043 (auto-analyzed)
; ROM Range: $00BEFC-$00BF9E (162 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C89C (sh2_comm_state), $C8CA (race_substate_read), $C8CC (race_substate)
;   Object (A2): +$00, +$03, +$04 (speed_index/velocity), +$05, +$06 (speed), +$07
;
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D2, D3, A1, A2, A3, A6
; RAM:
;   $C89C: sh2_comm_state
;   $C8CA: race_substate_read
;   $C8CC: race_substate
; Object fields:
;   +$00: [unknown]
;   +$03: [unknown]
;   +$04: speed_index/velocity
;   +$05: [unknown]
;   +$06: speed
;   +$07: [unknown]
;   +$08: [unknown]
; Confidence: high
; ============================================================================

fn_a200_043:
        MOVE.L  $35E0(A6),D1                    ; $00BEFC
        MOVE.L  $3CE4(A6),D1                    ; $00BF00
        MOVE.L  $43E8(A6),D1                    ; $00BF04
        MOVE.L  $4A6C(A6),D1                    ; $00BF08
        MOVE.L  $5070(A6),D1                    ; $00BF0C
        MOVE.L  $35E0(A6),D1                    ; $00BF10
        LEA     $00FF6900,A1                    ; $00BF14
        LEA     (-4344).W,A2                    ; $00BF1A
        LEA     $0088C05C,A3                    ; $00BF1E
        MOVE.W  (-24338).W,D0                   ; $00BF24
        MOVE.W  D0,D1                           ; $00BF28
        ADDQ.W  #1,D1                           ; $00BF2A
        ASL.W  #3,D0                            ; $00BF2C
        LEA     $00(A2,D0.W),A2                 ; $00BF2E
        MOVE.W  (-14180).W,D0                   ; $00BF32
        ADD.W  (-14134).W,D0                    ; $00BF36
        ADD.W  (-14132).W,D0                    ; $00BF3A
        LSL.W  #5,D0                            ; $00BF3E
        MOVE.W  D0,D2                           ; $00BF40
        DC.W    $D442                           ; $00BF42
        DC.W    $D442                           ; $00BF44
        DC.W    $D042                           ; $00BF46
        ADDA.W  D0,A2                           ; $00BF48
        MOVEQ   #$04,D0                         ; $00BF4A
.loc_0050:
        CLR.W  (A1)+                            ; $00BF4C
        MOVE.B  D1,(A1)+                        ; $00BF4E
        MOVE.B  $0003(A2),(A1)+                 ; $00BF50
        MOVE.L  (A3)+,(A1)+                     ; $00BF54
        CLR.W  (A1)+                            ; $00BF56
        MOVE.B  $0004(A2),(A1)+                 ; $00BF58
        MOVE.B  $0005(A2),D2                    ; $00BF5C
        MOVE.B  D2,D3                           ; $00BF60
        LSR.W  #4,D3                            ; $00BF62
        MOVE.B  D3,(A1)+                        ; $00BF64
        ANDI.B  #$0F,D2                         ; $00BF66
        MOVE.B  D2,(A1)+                        ; $00BF6A
        MOVE.B  $0006(A2),(A1)+                 ; $00BF6C
        MOVE.B  $0007(A2),D2                    ; $00BF70
        MOVE.B  D2,D3                           ; $00BF74
        LSR.W  #4,D3                            ; $00BF76
        MOVE.B  D3,(A1)+                        ; $00BF78
        ANDI.B  #$0F,D2                         ; $00BF7A
        MOVE.B  D2,(A1)+                        ; $00BF7E
        MOVE.L  (A2),D2                         ; $00BF80
        ANDI.L  #$FFFFFF00,D2                   ; $00BF82
        MOVE.L  D2,(A1)+                        ; $00BF88
        ADDQ.W  #1,D1                           ; $00BF8A
        LEA     $0008(A2),A2                    ; $00BF8C
        DBRA    D0,.loc_0050                    ; $00BF90
        ADDQ.W  #4,(-24342).W                   ; $00BF94
        ADDQ.W  #5,(-24338).W                   ; $00BF98
        RTS                                     ; $00BF9C
