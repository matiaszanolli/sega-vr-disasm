; ============================================================================
; Logic Dispatch 002 (auto-analyzed)
; ROM Range: $0043D0-$004460 (144 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state), $C048 (camera_state), $C07C (input_state), $C8AA (scene_state)
;   Object (A0, A1): +$00, +$2C
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1, A6
; RAM:
;   $C048: camera_state
;   $C07C: input_state
;   $C87E: game_state
;   $C8AA: scene_state
; Object fields:
;   +$00: [unknown]
;   +$2C: [unknown]
; Confidence: high
; ============================================================================

fn_4200_002:
        MOVE.L  #$0088FB98,$00FF0002            ; $0043D0
        BTST    #5,(-15602).W                   ; $0043DA
        BNE.S  .loc_0032                        ; $0043E0
        MOVE.L  #$60000000,(-15776).W           ; $0043E2
        LEA     (-15872).W,A1                   ; $0043EA
        MOVE.W  $002C(A0),D0                    ; $0043EE
        LSL.W  #2,D0                            ; $0043F2
        MOVE.L  #$00000000,$00(A1,D0.W)         ; $0043F4
        BCLR    #3,(-14322).W                   ; $0043FC
.loc_0032:
        ANDI.B  #$7F,(-14322).W                 ; $004402
        MOVE.W  #$0000,(-14210).W               ; $004408
        MOVEQ   #$00,D0                         ; $00440E
        MOVE.W  D0,(-14208).W                   ; $004410
        MOVE.W  D0,(-14206).W                   ; $004414
        MOVE.W  #$0020,$00FF0008                ; $004418
        DC.W    $4EBA,$70A8         ; JSR     $00B4CA(PC); $004420
        MOVE.B  #$00,(-14336).W                 ; $004424
        DC.W    $4EFA,$E464         ; JMP     $002890(PC); $00442A
        MOVE.W  #$0001,(-16312).W               ; $00442E
        MOVE.W  (-16260).W,D0                   ; $004434
        MOVEA.L $00443E(PC,D0.W),A1             ; $004438
        JMP     (A1)                            ; $00443C
        DC.W    $0088                           ; $00443E
        DC.W    $444E                           ; $004440
        DC.W    $0088                           ; $004442
        NEG.W  -(A0)                            ; $004444
        DC.W    $0088                           ; $004446
        NEG.L  (A0)+                            ; $004448
        DC.W    $0088                           ; $00444A
        NEG.L  -(A6)                            ; $00444C
        MOVE.B  #$01,(-14336).W                 ; $00444E
        ADDQ.W  #4,(-16260).W                   ; $004454
        MOVE.W  #$0000,(-14166).W               ; $004458
        RTS                                     ; $00445E
