; ============================================================================
; Menu Dispatch 011 (auto-analyzed)
; ROM Range: $010084-$01017A (246 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Calls: object_update
;   Object (A0): +$0E (param_e)
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, A0
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
; Object fields:
;   +$0E: param_e
; Confidence: high
; ============================================================================

fn_e200_011:
        DC.W    $000E                           ; $010084
        ADD.B  D1,(A0)                          ; $010086
        DC.W    $000E                           ; $010088
        DC.W    $D440                           ; $01008A
        DC.W    $000E                           ; $01008C
        ADD.B  D2,$0E(A0,D0.W)                  ; $01008E
        ADD.W  $0E(A0,D0.W),D3                  ; $010092
        ADDA.L  (A0),A3                         ; $010096
        DC.W    $000E                           ; $010098
        ADD.B  D4,$0E(A0,D0.W)                  ; $01009A
        ADD.W  $0E(A0,D0.W),D5                  ; $01009E
        ADD.L  D5,-(A0)                         ; $0100A2
        DC.W    $000E                           ; $0100A4
        ADD.B  D6,(A0)                          ; $0100A6
        NEG.B  D0                               ; $0100A8
        NEG.L  -(A3)                            ; $0100AA
        DC.W    $4946                           ; $0100AC
        LEA     $1C00(A1),A6                    ; $0100AE
        MOVE.L  -(A3),(A4)                      ; $0100B2
        MOVE.W  D6,$41E9(A2)                    ; $0100B4
        DC.W    $7FFF                           ; $0100B8
        DC.W    $7FFF                           ; $0100BA
        DC.W    $7FFF                           ; $0100BC
        DC.W    $7FFF                           ; $0100BE
        MOVE.B  D0,D6                           ; $0100C0
        MOVE.L  -(A3),(A4)                      ; $0100C2
        MOVE.W  D6,$41E9(A2)                    ; $0100C4
        NEG.B  D0                               ; $0100C8
        NEG.L  -(A3)                            ; $0100CA
        DC.W    $4946                           ; $0100CC
        LEA     $033E(A1),A6                    ; $0100CE
        DC.W    $63FF                           ; $0100D2
        BCLR    D0,$00E8(A7)                    ; $0100D4
        DC.W    $0815                           ; $0100D8
        DC.W    $1075                           ; $0100DA
        MOVE.B  (A1),(A4)+                      ; $0100DC
        MOVE.L  $21C2(A5),-(A0)                 ; $0100DE
        MOVEA.L D2,A3                           ; $0100E2
        MOVEA.L -(A2),A5                        ; $0100E4
        MOVE.L  -(A3),(A7)+                     ; $0100E6
        DC.W    $7FFF                           ; $0100E8
        DC.W    $7FFF                           ; $0100EA
        DC.W    $7FFF                           ; $0100EC
        DC.W    $7FFF                           ; $0100EE
.loc_006C:
        NEG.W  D5                               ; $0100F0
        SUBQ.B  #8,$6212(A3)                    ; $0100F2
        BGT.S  .loc_006C                        ; $0100F6
        DC.W    $7FFF                           ; $0100F8
        DC.W    $0E9A                           ; $0100FA
        DC.W    $7FFF                           ; $0100FC
        DC.W    $00E1                           ; $0100FE
        MOVE.B  D0,-(A0)                        ; $010100
        MOVE.W  D6,($5779).W                    ; $010102
        DC.W    $7FFF                           ; $010106
        DC.W    $0010                           ; $010108
        MOVE.B  $294E(A7),(A2)                  ; $01010A
        DC.W    $3DED                           ; $01010E
.loc_008C:
        NEG.W  D5                               ; $010110
        SUBQ.B  #8,$6212(A3)                    ; $010112
        BGT.S  .loc_008C                        ; $010116
        DC.W    $7FFF                           ; $010118
        DC.W    $0E9A                           ; $01011A
        DC.W    $7FFF                           ; $01011C
        MOVE.W  (A5)+,$02DB(A5)                 ; $01011E
        DC.W    $0277                           ; $010122
        DC.W    $01B0                           ; $010124
        DC.W    $63FF                           ; $010126
        JSR     $00882080                       ; $010128
        MOVE.W  (-14210).W,D0                   ; $01012E
        MOVEA.L $010138(PC,D0.W),A1             ; $010132
        JMP     (A1)                            ; $010136
        DC.W    $0089                           ; $010138
        DC.W    $017A                           ; $01013A
        DC.W    $0089                           ; $01013C
        ANDI.W  #$0089,D4                       ; $01013E
        SUBI.L  #$008905DE,-(A2)                ; $010142
        JSR     $00882080                       ; $010148
        MOVE.W  (-14210).W,D0                   ; $01014E
        MOVEA.L $010158(PC,D0.W),A1             ; $010152
        JMP     (A1)                            ; $010156
        DC.W    $0089                           ; $010158
        BCHG    D1,(A4)+                        ; $01015A
        DC.W    $0089                           ; $01015C
        BSET    D1,D4                           ; $01015E
        DC.W    $0089                           ; $010160
        SUBI.L  #$008905DE,-(A2)                ; $010162
        DC.W    $4EBA,$B51A         ; JSR     $00B684(PC); $010168
        BTST    #6,(-14322).W                   ; $01016C
        BNE.S  .loc_00F4                        ; $010172
        ADDQ.W  #4,(-14210).W                   ; $010174
.loc_00F4:
        RTS                                     ; $010178
