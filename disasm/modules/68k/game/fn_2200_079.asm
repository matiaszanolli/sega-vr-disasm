; ============================================================================
; Display Dispatch 079 (auto-analyzed)
; ROM Range: $004084-$00413A (182 bytes)
; ============================================================================
; Category: display
; Purpose: State dispatcher using jump table
;   RAM: $C048 (camera_state), $C07C (input_state), $C050 (scroll_state), $6960 (display_state_flag)
;   Object (A2): +$00, +$04 (speed_index/velocity), +$06 (speed), +$08, +$10
;
; Entry: A2 = object/entity pointer
; Uses: D0, A0, A1, A2
; RAM:
;   $6960: display_state_flag
;   $6970: race_mode_flag
;   $C048: camera_state
;   $C050: scroll_state
;   $C07C: input_state
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
;   +$06: speed
;   +$08: [unknown]
;   +$10: [unknown]
; Confidence: high
; ============================================================================

fn_2200_079:
        MOVE.W  #$0001,(-16312).W               ; $004084
        MOVE.W  (-16260).W,D0                   ; $00408A
        MOVEA.L $004094(PC,D0.W),A1             ; $00408E
        JMP     (A1)                            ; $004092
        DC.W    $0088                           ; $004094
        DC.W    $40C8                           ; $004096
        DC.W    $0088                           ; $004098
        DC.W    $412E                           ; $00409A
        DC.W    $0088                           ; $00409C
        DC.W    $413A                           ; $00409E
        DC.W    $0088                           ; $0040A0
        DC.W    $4168                           ; $0040A2
        DC.W    $0088                           ; $0040A4
        DC.W    $417C                           ; $0040A6
        DC.W    $0088                           ; $0040A8
        DC.W    $41E4                           ; $0040AA
        DC.W    $0088                           ; $0040AC
        DC.W    $42BA                           ; $0040AE
        DC.W    $0088                           ; $0040B0
        DC.W    $4300                           ; $0040B2
        DC.W    $0088                           ; $0040B4
        DC.W    $432E                           ; $0040B6
        DC.W    $0088                           ; $0040B8
        DC.W    $434A                           ; $0040BA
        DC.W    $0088                           ; $0040BC
        DC.W    $4390                           ; $0040BE
        DC.W    $0088                           ; $0040C0
        DC.W    $43BC                           ; $0040C2
        DC.W    $0088                           ; $0040C4
        LEA     (A0),A1                         ; $0040C6
        MOVE.B  #$01,(-14336).W                 ; $0040C8
        CMPI.W  #$FFFF,(-16304).W               ; $0040CE
        BNE.S  .loc_0058                        ; $0040D4
        MOVE.W  #$0000,(-16304).W               ; $0040D6
.loc_0058:
        MOVE.B  #$00,$00FF6960                  ; $0040DC
        MOVE.B  #$00,$00FF6930                  ; $0040E4
        MOVE.B  #$00,$00FF6970                  ; $0040EC
        LEA     $00FF6754,A2                    ; $0040F4
        MOVE.B  #$F3,(-14302).W                 ; $0040FA
        MOVE.W  #$FFE0,$0004(A2)                ; $004100
        MOVE.W  #$0040,$0006(A2)                ; $004106
        MOVE.W  #$F600,$0008(A2)                ; $00410C
        MOVE.L  #$2229660C,$0010(A2)            ; $004112
        MOVE.W  #$0001,$0000(A2)                ; $00411A
        MOVE.W  #$0040,(-15780).W               ; $004120
        ADDQ.W  #4,(-16260).W                   ; $004126
        DC.W    $4EFA,$708C         ; JMP     $00B1B8(PC); $00412A
        MOVE.B  #$96,(-14171).W                 ; $00412E
        ADDQ.W  #4,(-16260).W                   ; $004134
        RTS                                     ; $004138
