; ============================================================================
; Menu Dispatch 006 (auto-analyzed)
; ROM Range: $00F39C-$00F44C (176 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Calls: object_update
;
; Uses: D0, D1, D5, D6, A1, A2, A3, A4
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
; Confidence: high
; ============================================================================

fn_e200_006:
        NEG.B  D0                               ; $00F39C
        NEG.L  -(A3)                            ; $00F39E
        DC.W    $4946                           ; $00F3A0
        LEA     $1C00(A1),A6                    ; $00F3A2
        MOVE.L  -(A3),(A4)                      ; $00F3A6
        MOVE.W  D6,$41E9(A2)                    ; $00F3A8
        DC.W    $7FFF                           ; $00F3AC
        DC.W    $7FFF                           ; $00F3AE
        DC.W    $7FFF                           ; $00F3B0
        DC.W    $7FFF                           ; $00F3B2
        MOVE.B  D0,D6                           ; $00F3B4
        MOVE.L  -(A3),(A4)                      ; $00F3B6
        MOVE.W  D6,$41E9(A2)                    ; $00F3B8
        NEG.B  D0                               ; $00F3BC
        NEG.L  -(A3)                            ; $00F3BE
        DC.W    $4946                           ; $00F3C0
        LEA     $7FFF(A1),A6                    ; $00F3C2
        DC.W    $63F5                           ; $00F3C6
        DC.W    $7FFF                           ; $00F3C8
        DC.W    $7FFF                           ; $00F3CA
        DC.W    $0010                           ; $00F3CC
        MOVE.B  $294E(A7),(A2)                  ; $00F3CE
        DC.W    $3DED                           ; $00F3D2
        DC.W    $7FFF                           ; $00F3D4
        DC.W    $7FFF                           ; $00F3D6
.loc_003C:
        DC.W    $7FFF                           ; $00F3D8
        DC.W    $7FFF                           ; $00F3DA
        DC.W    $77BA                           ; $00F3DC
        DC.W    $7BBC                           ; $00F3DE
        DC.W    $779A                           ; $00F3E0
        DC.W    $77BC                           ; $00F3E2
        BMI.S  .loc_0080                        ; $00F3E4
        DC.W    $6B37                           ; $00F3E6
        BLE.S  .loc_00A6                        ; $00F3E8
        DC.W    $6F79               ; DC.W    $6F79; $00F3EA
        DC.W    $739A                           ; $00F3EC
        BSR.S  .loc_003C                        ; $00F3EE
        DC.W    $7FFF                           ; $00F3F0
        DC.W    $7FFF                           ; $00F3F2
        DC.W    $7FFF                           ; $00F3F4
        DC.W    $7FFF                           ; $00F3F6
        DC.W    $7FFF                           ; $00F3F8
        DC.W    $7FFF                           ; $00F3FA
        DC.W    $7FBC                           ; $00F3FC
        DC.W    $7F7A                           ; $00F3FE
        DC.W    $7FDE                           ; $00F400
        DC.W    $7F9B                           ; $00F402
.loc_0068:
        NEG.W  D5                               ; $00F404
        SUBQ.B  #8,$6212(A3)                    ; $00F406
        BGT.S  .loc_0068                        ; $00F40A
        DC.W    $7FFF                           ; $00F40C
        BTST    D1,(A7)+                        ; $00F40E
        DC.W    $7FFF                           ; $00F410
        DC.W    $7FFF                           ; $00F412
        DC.W    $7FFF                           ; $00F414
        DC.W    $7FFF                           ; $00F416
        DC.W    $7FFF                           ; $00F418
        DC.W    $7FFF                           ; $00F41A
.loc_0080:
        JSR     $00882080                       ; $00F41C
        MOVE.W  (-14210).W,D0                   ; $00F422
        MOVEA.L $00F42C(PC,D0.W),A1             ; $00F426
        JMP     (A1)                            ; $00F42A
        DC.W    $0088                           ; $00F42C
        DC.W    $F44C                           ; $00F42E
        DC.W    $0088                           ; $00F430
        DC.W    $F6E2                           ; $00F432
        DC.W    $0088                           ; $00F434
        DC.W    $F85C                           ; $00F436
        DC.W    $4EBA,$C24A         ; JSR     $00B684(PC); $00F438
        BTST    #6,(-14322).W                   ; $00F43C
.loc_00A6:
        BNE.S  .loc_00AE                        ; $00F442
        ADDQ.W  #4,(-14210).W                   ; $00F444
        NOP                                     ; $00F448
.loc_00AE:
        RTS                                     ; $00F44A
