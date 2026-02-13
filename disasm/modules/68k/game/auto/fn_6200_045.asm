; ============================================================================
; Obj Dispatch 045 (auto-analyzed)
; ROM Range: $007BE4-$007C32 (78 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   Object (A2): +$18
;
; Entry: A2 = object/entity pointer
; Uses: D0, D6, A1, A2
; Object fields:
;   +$18: [unknown]
; Confidence: low
; ============================================================================

fn_6200_045:
        MOVE.B  $0018(A2),D0                    ; $007BE4
        ANDI.W  #$000F,D0                       ; $007BE8
        DC.W    $D040                           ; $007BEC
        DC.W    $D040                           ; $007BEE
        MOVEA.L $007BF6(PC,D0.W),A1             ; $007BF0
        JMP     (A1)                            ; $007BF4
        DC.W    $0088                           ; $007BF6
        MOVEQ   #$2E,D6                         ; $007BF8
        DC.W    $0088                           ; $007BFA
        MOVEQ   #$32,D6                         ; $007BFC
        DC.W    $0088                           ; $007BFE
        MOVEQ   #$36,D6                         ; $007C00
        DC.W    $0088                           ; $007C02
        MOVEQ   #$3A,D6                         ; $007C04
        DC.W    $0088                           ; $007C06
        MOVEQ   #$42,D6                         ; $007C08
        DC.W    $0088                           ; $007C0A
        MOVEQ   #$46,D6                         ; $007C0C
        DC.W    $0088                           ; $007C0E
        MOVEQ   #$46,D6                         ; $007C10
        DC.W    $0088                           ; $007C12
        MOVEQ   #$46,D6                         ; $007C14
        DC.W    $0088                           ; $007C16
        MOVEQ   #$3E,D6                         ; $007C18
        DC.W    $0088                           ; $007C1A
        MOVEQ   #$46,D6                         ; $007C1C
        DC.W    $0088                           ; $007C1E
        MOVEQ   #$46,D6                         ; $007C20
        DC.W    $0088                           ; $007C22
        MOVEQ   #$46,D6                         ; $007C24
        DC.W    $0088                           ; $007C26
        MOVEQ   #$46,D6                         ; $007C28
        DC.W    $0088                           ; $007C2A
        MOVEQ   #$42,D6                         ; $007C2C
        MOVEQ   #$01,D0                         ; $007C2E
        RTS                                     ; $007C30
