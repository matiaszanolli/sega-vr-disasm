; ============================================================================
; Ai Dispatch 034 (auto-analyzed)
; ROM Range: $00BC1C-$00BCCA (174 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C8A0 (race_state), $C082 (menu_state), $C084 (menu_substate), $C8AA (scene_state)
;   Object (A0, A1): +$00, +$01, +$02 (flags/type), +$0E (param_e), +$10, +$88
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D6, A0, A1, A6
; RAM:
;   $C082: menu_state
;   $C084: menu_substate
;   $C8A0: race_state
;   $C8AA: scene_state
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$02: flags/type
;   +$0E: param_e
;   +$10: [unknown]
;   +$88: [unknown]
; Confidence: high
; ============================================================================

fn_a200_034:
        DC.W    $6000,$00AC         ; BRA.W  $00BCCA; $00BC1C
        DC.W    $6000,$0108         ; BRA.W  $00BD2A; $00BC20
        DC.W    $6000,$0104         ; BRA.W  $00BD2A; $00BC24
        DC.W    $6000,$00D6         ; BRA.W  $00BD00; $00BC28
        DC.W    $6000,$0170         ; BRA.W  $00BD9E; $00BC2C
        DC.W    $0088                           ; $00BC30
        EOR.L  D6,-(A6)                         ; $00BC32
        DC.W    $0088                           ; $00BC34
        EOR.L  D6,$0088(A0)                     ; $00BC36
        CMPA.L  A0,A6                           ; $00BC3A
        DC.W    $0088                           ; $00BC3C
        EOR.L  D6,-(A6)                         ; $00BC3E
        LEA     $00FF60C8,A1                    ; $00BC40
        MOVE.W  #$0010,(A1)                     ; $00BC46
        MOVE.W  #$00CF,$0002(A1)                ; $00BC4A
        MOVE.B  #$00,$00FF6850                  ; $00BC50
        DC.W    $4EBA,$020E         ; JSR     $00BE68(PC); $00BC58
        DC.W    $4EBA,$E3F2         ; JSR     $00A050(PC); $00BC5C
        DC.W    $4EBA,$0174         ; JSR     $00BDD6(PC); $00BC60
        LEA     $00897000,A0                    ; $00BC64
        MOVE.W  (-14176).W,D0                   ; $00BC6A
        MOVEA.L $00(A0,D0.W),A0                 ; $00BC6E
        MOVE.W  (-16254).W,D0                   ; $00BC72
        ASL.W  #4,D0                            ; $00BC76
        LEA     $00(A0,D0.W),A0                 ; $00BC78
        MOVEQ   #$00,D0                         ; $00BC7C
        MOVE.B  $0000(A0),D0                    ; $00BC7E
        JSR     $00BC1C(PC,D0.W)                ; $00BC82
        LEA     $00FF6830,A1                    ; $00BC86
        MOVEQ   #$00,D0                         ; $00BC8C
        ADDQ.W  #1,(-24344).W                   ; $00BC8E
        BTST    #3,(-24343).W                   ; $00BC92
        BEQ.S  .loc_0080                        ; $00BC98
        MOVEQ   #$01,D0                         ; $00BC9A
.loc_0080:
        MOVE.B  D0,(A1)                         ; $00BC9C
        MOVE.W  $000E(A0),D0                    ; $00BC9E
        DC.W    $D040                           ; $00BCA2
        DC.W    $D040                           ; $00BCA4
        MOVEA.L $00BC30(PC,D0.W),A1             ; $00BCA6
        JSR     (A1)                            ; $00BCAA
        SUBQ.W  #1,(-16252).W                   ; $00BCAC
        BPL.S  .loc_00AC                        ; $00BCB0
        ADDQ.W  #1,(-16254).W                   ; $00BCB2
        CLR.W  (-14166).W                       ; $00BCB6
        LEA     $0010(A0),A0                    ; $00BCBA
        MOVEQ   #$00,D0                         ; $00BCBE
        MOVE.B  $0001(A0),D0                    ; $00BCC0
        MOVE.W  D0,(-16252).W                   ; $00BCC4
.loc_00AC:
        RTS                                     ; $00BCC8
