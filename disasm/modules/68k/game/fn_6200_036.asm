; ============================================================================
; Obj Dispatch 036 (auto-analyzed)
; ROM Range: $007A40-$007A8E (78 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   Object (A2): +$18
;
; Entry: A2 = object/entity pointer
; Uses: D0, D5, A1, A2
; Object fields:
;   +$18: [unknown]
; Confidence: low
; ============================================================================

fn_6200_036:
        MOVE.B  $0018(A2),D0                    ; $007A40
        ANDI.W  #$000F,D0                       ; $007A44
        DC.W    $D040                           ; $007A48
        DC.W    $D040                           ; $007A4A
        MOVEA.L $007A52(PC,D0.W),A1             ; $007A4C
        JMP     (A1)                            ; $007A50
        DC.W    $0088                           ; $007A52
        MOVEQ   #-$76,D5                        ; $007A54
        DC.W    $0088                           ; $007A56
        MOVEQ   #-$72,D5                        ; $007A58
        DC.W    $0088                           ; $007A5A
        MOVEQ   #-$6E,D5                        ; $007A5C
        DC.W    $0088                           ; $007A5E
        MOVEQ   #-$66,D5                        ; $007A60
        DC.W    $0088                           ; $007A62
        MOVEQ   #-$56,D5                        ; $007A64
        DC.W    $0088                           ; $007A66
        MOVEQ   #-$4E,D5                        ; $007A68
        DC.W    $0088                           ; $007A6A
        MOVEQ   #-$4E,D5                        ; $007A6C
        DC.W    $0088                           ; $007A6E
        MOVEQ   #-$4E,D5                        ; $007A70
        DC.W    $0088                           ; $007A72
        MOVEQ   #-$5E,D5                        ; $007A74
        DC.W    $0088                           ; $007A76
        MOVEQ   #-$4E,D5                        ; $007A78
        DC.W    $0088                           ; $007A7A
        MOVEQ   #-$4E,D5                        ; $007A7C
        DC.W    $0088                           ; $007A7E
        MOVEQ   #-$4E,D5                        ; $007A80
        DC.W    $0088                           ; $007A82
        MOVEQ   #-$4E,D5                        ; $007A84
        DC.W    $0088                           ; $007A86
        MOVEQ   #-$52,D5                        ; $007A88
        MOVEQ   #$01,D0                         ; $007A8A
        RTS                                     ; $007A8C
