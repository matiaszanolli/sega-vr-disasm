; ============================================================================
; Scene Sprite Table Init 020 (auto-analyzed)
; ROM Range: $00D08A-$00D19C (274 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 3 subroutines
;   RAM: $C8A0 (race_state), $C89C (sh2_comm_state), $C8C8 (vint_state), $C8CC (race_substate)
;   Calls: sprite_table_init
;   Object (A1, A3): +$00, +$01, +$04 (speed_index/velocity), +$10
;
; Entry: A1 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D7, A1, A2, A3
; RAM:
;   $C89C: sh2_comm_state
;   $C8A0: race_state
;   $C8C8: vint_state
;   $C8CC: race_substate
; Calls:
;   $006C46: sprite_table_init
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$04: speed_index/velocity
;   +$10: [unknown]
; Confidence: high
; ============================================================================

fn_c200_020:
        MOVE.B  #$00,(-14330).W                 ; $00D08A
        MOVE.B  #$C4,(-14329).W                 ; $00D090
        MOVE.B  #$C4,(-14328).W                 ; $00D096
        MOVE.B  #$00,(-14317).W                 ; $00D09C
        MOVE.B  #$C4,(-14316).W                 ; $00D0A2
        MOVE.B  #$C4,(-14315).W                 ; $00D0A8
        MOVE.W  #$C200,(-16266).W               ; $00D0AE
        MOVE.L  #$61000000,(-15788).W           ; $00D0B4
        MOVE.L  #$60000000,(-15776).W           ; $00D0BC
        MOVE.W  (-14176).W,D0                   ; $00D0C4
        DC.W    $4EFA,$FFA0         ; JMP     $00D06A(PC); $00D0C8
        LEA     (-598).W,A1                     ; $00D0CC
        MOVE.W  (-14180).W,D1                   ; $00D0D0
        LSL.W  #5,D1                            ; $00D0D4
        ADD.W  (-14176).W,D1                    ; $00D0D6
        MOVE.W  (-14136).W,D0                   ; $00D0DA
        LSL.W  #3,D0                            ; $00D0DE
        ADD.W  (-14132).W,D0                    ; $00D0E0
        DC.W    $D240                           ; $00D0E4
        LEA     $00(A1,D1.W),A1                 ; $00D0E6
        LEA     $00FF68E0,A2                    ; $00D0EA
        JMP     $00884280                       ; $00D0F0
        MOVE.B  #$03,(-14326).W                 ; $00D0F6
        LEA     (-15872).W,A2                   ; $00D0FC
        LEA     (-4384).W,A1                    ; $00D100
        JSR     $00884920                       ; $00D104
        MOVE.L  (-4356).W,(-15788).W            ; $00D10A
        MOVE.W  #$00C0,(-16300).W               ; $00D110
        MOVE.W  #$0540,(-16298).W               ; $00D116
        MOVE.W  #$0000,(-14186).W               ; $00D11C
        LEA     (-15872).W,A1                   ; $00D122
        LEA     $00FF68D8,A3                    ; $00D126
        MOVEQ   #$04,D7                         ; $00D12C
.loc_00A4:
        DC.W    $4EBA,$E30C         ; JSR     $00B43C(PC); $00D12E
        LEA     $0004(A1),A1                    ; $00D132
        LEA     $0010(A3),A3                    ; $00D136
        DBRA    D7,.loc_00A4                    ; $00D13A
        MOVEQ   #-$01,D1                        ; $00D13E
        MOVEQ   #$04,D7                         ; $00D140
        MOVE.L  (-15788).W,D0                   ; $00D142
        LEA     (-15872).W,A1                   ; $00D146
.loc_00C0:
        ADDQ.W  #1,D1                           ; $00D14A
        CMP.L  (A1)+,D0                         ; $00D14C
        DBEQ    D7,.loc_00C0                    ; $00D14E
        LSL.W  #4,D1                            ; $00D152
        LEA     $00FF68D0,A1                    ; $00D154
        LEA     $00(A1,D1.W),A1                 ; $00D15A
        MOVE.B  #$01,$0001(A1)                  ; $00D15E
        MOVE.L  A1,(-13984).W                   ; $00D164
        DC.W    $4EBA,$9ADC         ; JSR     $006C46(PC); $00D168
        DC.W    $4EBA,$B750         ; JSR     $0088BE(PC); $00D16C
        MOVE.W  #$00C0,(-16184).W               ; $00D170
        MOVE.W  #$07D0,(-14124).W               ; $00D176
        MOVE.W  #$0600,(-14122).W               ; $00D17C
        MOVE.W  #$3000,(-14120).W               ; $00D182
        MOVE.W  #$0000,(-14118).W               ; $00D188
        MOVE.W  #$00C0,(-14116).W               ; $00D18E
        MOVE.W  #$0540,(-14114).W               ; $00D194
        RTS                                     ; $00D19A
