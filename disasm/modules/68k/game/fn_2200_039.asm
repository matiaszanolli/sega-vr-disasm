; ============================================================================
; Vint Physics 039 (auto-analyzed)
; ROM Range: $003010-$0030C6 (182 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$30 (x_position), +$32, +$34 (y_position), +$3A, +$3C (heading_mirror), +$3E
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, A0, A1, A2
; Object fields:
;   +$30: x_position
;   +$32: [unknown]
;   +$34: y_position
;   +$3A: [unknown]
;   +$3C: heading_mirror
;   +$3E: [unknown]
;   +$44: display_offset
;   +$46: display_scale
; Confidence: medium
; ============================================================================

fn_2200_039:
        MOVEQ   #$00,D0                         ; $003010
        TST.W  $00C0(A0)                        ; $003012
        BEQ.S  .loc_000A                        ; $003016
        MOVEQ   #$01,D0                         ; $003018
.loc_000A:
        MOVE.W  D0,$0118(A2)                    ; $00301A
        MOVE.W  D0,$012C(A2)                    ; $00301E
        MOVE.W  D0,$0140(A2)                    ; $003022
        MOVE.W  D0,$0154(A2)                    ; $003026
        MOVE.W  $0030(A0),D0                    ; $00302A
        MOVE.W  D0,$011A(A2)                    ; $00302E
        MOVE.W  $009C(A0),D0                    ; $003032
        ASL.W  #4,D0                            ; $003036
        ADD.W  (-16156).W,D0                    ; $003038
        ADD.W  $0032(A0),D0                     ; $00303C
        MOVE.W  D0,$011C(A2)                    ; $003040
        MOVE.W  $0034(A0),D0                    ; $003044
        MOVE.W  D0,$011E(A2)                    ; $003048
        MOVE.W  $003A(A0),D1                    ; $00304C
        ASR.W  #3,D1                            ; $003050
        MOVE.W  $0044(A0),D0                    ; $003052
        ASR.W  #3,D0                            ; $003056
        DC.W    $D041                           ; $003058
        NEG.W  D0                               ; $00305A
        MOVE.W  D0,$0120(A2)                    ; $00305C
        MOVE.W  $003C(A0),D2                    ; $003060
        ADD.W  $0096(A0),D2                     ; $003064
        ASR.W  #3,D2                            ; $003068
        MOVE.W  $0046(A0),D0                    ; $00306A
        ASR.W  #3,D0                            ; $00306E
        NEG.W  D0                               ; $003070
        DC.W    $D042                           ; $003072
        MOVE.W  D0,$0122(A2)                    ; $003074
        MOVE.W  $003E(A0),D3                    ; $003078
        ASR.W  #3,D3                            ; $00307C
        MOVE.W  $004A(A0),D0                    ; $00307E
        ADD.W  $004C(A0),D0                     ; $003082
        ASR.W  #5,D0                            ; $003086
        DC.W    $D043                           ; $003088
        NEG.W  D0                               ; $00308A
        MOVE.W  D0,$0124(A2)                    ; $00308C
        MOVE.W  $0090(A0),D0                    ; $003090
        ASR.W  #3,D0                            ; $003094
        MOVE.W  D0,$0032(A1)                    ; $003096
        MOVE.W  D0,$0046(A1)                    ; $00309A
        MOVE.W  D0,$0136(A2)                    ; $00309E
        MOVE.W  D0,$014A(A2)                    ; $0030A2
        MOVE.W  $00BC(A0),D0                    ; $0030A6
        ASR.W  #3,D0                            ; $0030AA
        MOVE.W  D0,$0030(A1)                    ; $0030AC
        MOVE.W  D0,$0044(A1)                    ; $0030B0
        MOVE.W  D0,$0058(A1)                    ; $0030B4
        MOVE.W  D0,$0134(A2)                    ; $0030B8
        MOVE.W  D0,$0148(A2)                    ; $0030BC
        MOVE.W  D0,$015C(A2)                    ; $0030C0
        RTS                                     ; $0030C4
