; ============================================================================
; Scene Race Substate 018 (auto-analyzed)
; ROM Range: $00CFD6-$00D04C (118 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8CC (race_substate)
;   Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: D0, A1, A2, A3
; RAM:
;   $C8CC: race_substate
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_c200_018:
        MOVE.W  (-14132).W,D0                   ; $00CFD6
        LEA     $008955CC,A1                    ; $00CFDA
        MOVEA.L $00(A1,D0.W),A1                 ; $00CFE0
        MOVEA.L A1,A3                           ; $00CFE4
        LEA     $00FF6178,A2                    ; $00CFE6
        DC.W    $61D4               ; BSR.S  $00CFC2; $00CFEC
        MOVEA.L A3,A1                           ; $00CFEE
        LEA     $00FF627C,A2                    ; $00CFF0
        DC.W    $61CA               ; BSR.S  $00CFC2; $00CFF6
        MOVEA.L A3,A1                           ; $00CFF8
        LEA     $00FF63A8,A2                    ; $00CFFA
        DC.W    $61C0               ; BSR.S  $00CFC2; $00D000
        MOVEA.L A3,A1                           ; $00D002
        LEA     $00FF64AC,A2                    ; $00D004
        DC.W    $60B6               ; BRA.S  $00CFC2; $00D00A
        LEA     (-14330).W,A1                   ; $00D00C
        MOVE.B  #$00,(A1)+                      ; $00D010
        MOVE.B  #$C4,(A1)+                      ; $00D014
        MOVE.B  #$C4,(A1)                       ; $00D018
        MOVE.W  #$C200,(-16266).W               ; $00D01C
        BTST    #3,(-14322).W                   ; $00D022
        BNE.S  .loc_0064                        ; $00D028
        MOVE.L  #$61000000,(-15788).W           ; $00D02A
        MOVE.L  #$60000000,(-15776).W           ; $00D032
.loc_0064:
        DC.W    $43FA,$0014         ; LEA     $00D050(PC),A1; $00D03A
        MOVEQ   #$00,D0                         ; $00D03E
        MOVE.B  (-599).W,D0                     ; $00D040
        MOVE.B  $00(A1,D0.W),(-16303).W         ; $00D044
        RTS                                     ; $00D04A
