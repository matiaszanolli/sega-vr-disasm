; ============================================================================
; object_type_dispatch_b — Object Type Dispatch B
; ROM Range: $007BE4-$007C32 (78 bytes)
; Reads object type from A2+$18 (low 4 bits), multiplies by 4 for longword
; index, dispatches through 14-entry jump table. Each target returns a
; type classification code in D0. Same structure as object_type_dispatch.
;
; Entry: A2 = object pointer (tile data)
; Uses: D0, D6, A1, A2
; Object fields: +$18 type/flags
; Confidence: high
; ============================================================================

object_type_dispatch_b:
        MOVE.B  $0018(A2),D0                    ; $007BE4
        ANDI.W  #$000F,D0                       ; $007BE8
        ADD.W   D0,D0; $007BEC
        ADD.W   D0,D0; $007BEE
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
