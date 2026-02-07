; ============================================================================
; Vint 066 (auto-analyzed)
; ROM Range: $003CCE-$003D22 (84 bytes)
; ============================================================================
; Category: vint
; Purpose: RAM: $C8C8 (vint_state)
;   Object (A1): +$00, +$14 (effect_duration), +$28, +$3C (heading_mirror)
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, A1, A2, A3
; RAM:
;   $C8C8: vint_state
; Object fields:
;   +$00: [unknown]
;   +$14: effect_duration
;   +$28: [unknown]
;   +$3C: heading_mirror
; Confidence: medium
; ============================================================================

fn_2200_066:
        LEA     $00FF66EC,A1                    ; $003CCE
        LEA     $00895B7E,A2                    ; $003CD4
        ASL.W  #4,D0                            ; $003CDA
        MOVEQ   #$03,D1                         ; $003CDC
.loc_0010:
        MOVEA.L (A2)+,A3                        ; $003CDE
        ADDA.L  D0,A3                           ; $003CE0
        MOVE.L  A3,(A1)                         ; $003CE2
        LEA     $0014(A1),A1                    ; $003CE4
        DBRA    D1,.loc_0010                    ; $003CE8
        MOVE.W  (-16346).W,D1                   ; $003CEC
        CMPI.W  #$0007,D1                       ; $003CF0
        DC.W    $6D2C               ; BLT.S  $003D22; $003CF4
        CMPI.W  #$0013,D1                       ; $003CF6
        DC.W    $6C26               ; BGE.S  $003D22; $003CFA
        MOVEQ   #$00,D0                         ; $003CFC
        LEA     $00FF6128,A1                    ; $003CFE
        MOVE.W  D0,$0000(A1)                    ; $003D04
        MOVE.W  D0,$0014(A1)                    ; $003D08
        TST.W  (-16308).W                       ; $003D0C
        BNE.S  .loc_0052                        ; $003D10
        MOVE.W  D0,$0028(A1)                    ; $003D12
        TST.W  (-14136).W                       ; $003D16
        BNE.S  .loc_0052                        ; $003D1A
        MOVE.W  D0,$003C(A1)                    ; $003D1C
.loc_0052:
        RTS                                     ; $003D20
