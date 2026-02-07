; ============================================================================
; Obj Dispatch 043 (auto-analyzed)
; ROM Range: $0031A6-$003204 (94 bytes)
; ============================================================================
; Category: object
; Purpose: State dispatcher using jump table
;   RAM: $6950 (obj_flags)
;   Object (A1, A2): +$00, +$88
;
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D4, A0, A1, A2, A6
; RAM:
;   $6950: obj_flags
; Object fields:
;   +$00: [unknown]
;   +$88: [unknown]
; Confidence: medium
; ============================================================================

fn_2200_043:
        MOVEQ   #$00,D0                         ; $0031A6
        MOVE.B  (-15611).W,D0                   ; $0031A8
        MOVEA.L $0031B2(PC,D0.W),A1             ; $0031AC
        JMP     (A1)                            ; $0031B0
        DC.W    $0088                           ; $0031B2
        MOVE.W  ($0088).W,$3272(A1)             ; $0031B4
        DC.W    $0088                           ; $0031BA
        MOVE.W  (A6)+,($0088).W                 ; $0031BC
        MOVE.W  (A6)+,($0088).W                 ; $0031C0
        MOVE.W  (A6)+,($0088).W                 ; $0031C4
        MOVE.W  (A6)+,($0088).W                 ; $0031C8
        MOVE.W  $0088(A2),D1                    ; $0031CC
        MOVE.W  $0088(A2),D1                    ; $0031D0
        MOVE.W  $0088(A2),D1                    ; $0031D4
        MOVE.W  D4,D1                           ; $0031D8
        DC.W    $0088                           ; $0031DA
        MOVEA.W (A0),A1                         ; $0031DC
        TST.W  (-16306).W                       ; $0031DE
        DC.W    $676C               ; BEQ.S  $003250; $0031E2
        MOVEA.L (-15784).W,A1                   ; $0031E4
        MOVE.B  #$02,$0000(A1)                  ; $0031E8
        MOVE.B  #$03,$00FF6950                  ; $0031EE
        MOVE.B  #$01,$00FF6940                  ; $0031F6
        ADDQ.B  #4,(-15611).W                   ; $0031FE
        RTS                                     ; $003202
