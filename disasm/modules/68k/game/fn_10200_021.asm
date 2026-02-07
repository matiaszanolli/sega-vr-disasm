; ============================================================================
; Name Entry Dispatch 021 (auto-analyzed)
; ROM Range: $01103E-$0111A4 (358 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Calls: object_update
;   Object (A0): +$0E (param_e), +$77
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, A0
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
; Object fields:
;   +$0E: param_e
;   +$77: [unknown]
; Confidence: high
; ============================================================================

fn_10200_021:
        DC.W    $000E                           ; $01103E
        ADD.B  D1,(A0)                          ; $011040
        DC.W    $000E                           ; $011042
        DC.W    $D440                           ; $011044
        DC.W    $000E                           ; $011046
        ADD.B  D2,$0E(A0,D0.W)                  ; $011048
        ADD.W  $0E(A0,D0.W),D3                  ; $01104C
        ADDA.L  (A0),A3                         ; $011050
        DC.W    $000E                           ; $011052
        ADD.B  D4,$0E(A0,D0.W)                  ; $011054
        ADD.W  $0E(A0,D0.W),D5                  ; $011058
        ADD.L  D5,-(A0)                         ; $01105C
        DC.W    $000E                           ; $01105E
        ADD.B  D6,(A0)                          ; $011060
        NEG.B  D0                               ; $011062
        NEG.L  -(A3)                            ; $011064
        DC.W    $4946                           ; $011066
        LEA     $1C00(A1),A6                    ; $011068
        MOVE.L  -(A3),(A4)                      ; $01106C
        MOVE.W  D6,$41E9(A2)                    ; $01106E
        DC.W    $0010                           ; $011072
        MOVE.B  $294E(A7),(A2)                  ; $011074
        DC.W    $3DED                           ; $011078
        MOVE.B  D0,D6                           ; $01107A
        MOVE.L  -(A3),(A4)                      ; $01107C
        MOVE.W  D6,$41E9(A2)                    ; $01107E
        NEG.B  D0                               ; $011082
        NEG.L  -(A3)                            ; $011084
        DC.W    $4946                           ; $011086
        LEA     $7FFF(A1),A6                    ; $011088
        DC.W    $63F5                           ; $01108C
        DC.W    $7FFF                           ; $01108E
        DC.W    $7FFF                           ; $011090
        DC.W    $0010                           ; $011092
        MOVE.B  $294E(A7),(A2)                  ; $011094
        DC.W    $3DED                           ; $011098
        DC.W    $7FFF                           ; $01109A
        DC.W    $7FFF                           ; $01109C
        DC.W    $7FFF                           ; $01109E
        DC.W    $7FFF                           ; $0110A0
        DC.W    $7FFF                           ; $0110A2
        DC.W    $7FFF                           ; $0110A4
        DC.W    $7FFF                           ; $0110A6
        DC.W    $7FFF                           ; $0110A8
.loc_006C:
        NEG.W  D5                               ; $0110AA
        SUBQ.B  #8,$6212(A3)                    ; $0110AC
        BGT.S  .loc_006C                        ; $0110B0
        DC.W    $7FFF                           ; $0110B2
        DC.W    $0E9A                           ; $0110B4
        DC.W    $7FFF                           ; $0110B6
        DC.W    $7FFF                           ; $0110B8
        DC.W    $7FFF                           ; $0110BA
        DC.W    $7FFF                           ; $0110BC
        DC.W    $7FFF                           ; $0110BE
        DC.W    $7FFF                           ; $0110C0
        DC.W    $0010                           ; $0110C2
        MOVE.B  $294E(A7),(A2)                  ; $0110C4
        DC.W    $3DED                           ; $0110C8
.loc_008C:
        NEG.W  D5                               ; $0110CA
        SUBQ.B  #8,$6212(A3)                    ; $0110CC
        BGT.S  .loc_008C                        ; $0110D0
        DC.W    $7FFF                           ; $0110D2
        BTST    D1,(A7)+                        ; $0110D4
        DC.W    $7FFF                           ; $0110D6
        DC.W    $7FFF                           ; $0110D8
        DC.W    $7FFF                           ; $0110DA
        DC.W    $7FFF                           ; $0110DC
        DC.W    $7FFF                           ; $0110DE
        DC.W    $7FFF                           ; $0110E0
        NEG.B  D0                               ; $0110E2
        NEG.L  -(A3)                            ; $0110E4
        DC.W    $4946                           ; $0110E6
        LEA     $4445(A1),A6                    ; $0110E8
        MOVE    D6,CCR                          ; $0110EC
        DC.W    $4968                           ; $0110EE
        LEA     $7FFF(A2),A6                    ; $0110F0
        DC.W    $63F5                           ; $0110F4
        DC.W    $7FFF                           ; $0110F6
        DC.W    $7FFF                           ; $0110F8
        DC.W    $7FFF                           ; $0110FA
        DC.W    $7FFF                           ; $0110FC
        DC.W    $7FFF                           ; $0110FE
        DC.W    $7FFF                           ; $011100
        ORI.B  #$00,D0                          ; $011102
        DC.W    $0000                           ; $011106
        DC.W    $4380                           ; $011108
        DC.W    $0000                           ; $01110A
        DC.W    $8700                           ; $01110C
        DC.W    $0000                           ; $01110E
        DC.W    $CA80                           ; $011110
        ORI.B  #$00,D0                          ; $011112
        DC.W    $0000                           ; $011116
        MOVE.L  D0,D4                           ; $011118
        DC.W    $0000                           ; $01111A
        ADDQ.B  #8,D0                           ; $01111C
        DC.W    $0000                           ; $01111E
        MOVEQ   #$00,D4                         ; $011120
        JSR     $00882080                       ; $011122
        MOVE.W  (-14210).W,D0                   ; $011128
        MOVEA.L $011132(PC,D0.W),A1             ; $01112C
        JMP     (A1)                            ; $011130
        DC.W    $0089                           ; $011132
        MOVE.B  -(A4),-$77(A0,D0.W)             ; $011134
        MOVE.B  -(A4),-$77(A0,D0.W)             ; $011138
        DC.W    $1240                           ; $01113C
        DC.W    $0089                           ; $01113E
        DC.W    $17F4                           ; $011140
        JSR     $00882080                       ; $011142
        MOVE.W  (-14210).W,D0                   ; $011148
        MOVEA.L $011152(PC,D0.W),A1             ; $01114C
        JMP     (A1)                            ; $011150
        DC.W    $0089                           ; $011152
        MOVE.B  -(A4),-$77(A0,D0.W)             ; $011154
        MOVE.B  -(A4),-$77(A0,D0.W)             ; $011158
        MOVE.B  (A2)+,D2                        ; $01115C
        DC.W    $0089                           ; $01115E
        DC.W    $146E                           ; $011160
        DC.W    $0089                           ; $011162
        DC.W    $1862                           ; $011164
        JSR     $00882080                       ; $011166
        MOVE.W  (-14210).W,D0                   ; $01116C
        MOVEA.L $011176(PC,D0.W),A1             ; $011170
        JMP     (A1)                            ; $011174
        DC.W    $0089                           ; $011176
        MOVE.B  -(A4),-$77(A0,D0.W)             ; $011178
        MOVE.B  -(A4),-$77(A0,D0.W)             ; $01117C
        DC.W    $11B6                           ; $011180
        DC.W    $0089                           ; $011182
        DC.W    $11B6                           ; $011184
        DC.W    $0089                           ; $011186
        DC.W    $15A8                           ; $011188
        DC.W    $0089                           ; $01118A
        MOVE.B  -$77(A0,D0.W),D3                ; $01118C
        DC.W    $188A                           ; $011190
        DC.W    $4EBA,$A4F0         ; JSR     $00B684(PC); $011192
        BTST    #6,(-14322).W                   ; $011196
        BNE.S  .loc_0164                        ; $01119C
        ADDQ.W  #4,(-14210).W                   ; $01119E
.loc_0164:
        RTS                                     ; $0111A2
