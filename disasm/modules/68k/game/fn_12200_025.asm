; ============================================================================
; Camera Dma Transfer 025 (auto-analyzed)
; ROM Range: $012BFA-$012C9E (164 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C87E (game_state)
;   Calls: dma_transfer
;   Object (A0): +$00
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0, A3, A4, A5, A6
; RAM:
;   $C87E: game_state
; Calls:
;   $00E52C: dma_transfer
; Object fields:
;   +$00: [unknown]
; Confidence: medium
; ============================================================================

fn_12200_025:
        MOVE.L  $5FF6(A3),D1                    ; $012BFA
        MOVE.L  $710A(A3),D1                    ; $012BFE
        MOVE.L  -$6EDE(A3),D1                   ; $012C02
        MOVE.L  -$5610(A3),D1                   ; $012C06
        MOVE.L  -$370C(A3),D1                   ; $012C0A
        MOVE.L  $5FF6(A3),D1                    ; $012C0E
        DC.W    $0000                           ; $012C12
        DC.W    $FFB0                           ; $012C14
        ORI.W  #$0140,-(A0)                     ; $012C16
        ORI.B  #$00,D0                          ; $012C1A
        ORI.B  #$00,D0                          ; $012C1E
        DC.W    $0000                           ; $012C22
        DC.W    $FFB0                           ; $012C24
        ORI.W  #$0140,-(A0)                     ; $012C26
        ORI.B  #$00,D0                          ; $012C2A
        ORI.B  #$00,D0                          ; $012C2E
        DC.W    $0000                           ; $012C32
        DC.W    $FFB0                           ; $012C34
        ORI.W  #$0140,$00(A0,D0.W)              ; $012C36
        ORI.B  #$00,D0                          ; $012C3C
        ORI.B  #$00,D0                          ; $012C40
        DC.W    $FFA0                           ; $012C44
        ORI.L  #$01800000,D0                    ; $012C46
        ORI.B  #$00,D0                          ; $012C4C
        ORI.B  #$00,D0                          ; $012C50
        DC.W    $FF10                           ; $012C54
        ORI.W  #$0140,(A0)                      ; $012C56
        ORI.B  #$00,D0                          ; $012C5A
        ORI.B  #$00,D0                          ; $012C5E
        DC.W    $0000                           ; $012C62
        DC.W    $FFB0                           ; $012C64
        ORI.W  #$0140,-(A0)                     ; $012C66
        ORI.B  #$00,D0                          ; $012C6A
        ORI.B  #$00,D0                          ; $012C6E
        DC.W    $008B                           ; $012C72
        CMPA.L  (A4)+,A5                        ; $012C74
        DC.W    $008B                           ; $012C76
        CMPA.W  (A4)+,A6                        ; $012C78
        DC.W    $008B                           ; $012C7A
        CMPA.L  (A4)+,A5                        ; $012C7C
        DC.W    $008B                           ; $012C7E
        CMPA.L  (A4)+,A6                        ; $012C80
        DC.W    $008B                           ; $012C82
        CMPA.W  (A4)+,A7                        ; $012C84
        DC.W    $008B                           ; $012C86
        CMPA.L  (A4)+,A5                        ; $012C88
        CLR.W  D0                               ; $012C8A
        DC.W    $6100,$B89E         ; BSR.W  $00E52C; $012C8C
        MOVE.W  #$0020,$00FF0008                ; $012C90
        ADDQ.W  #4,(-14210).W                   ; $012C98
        RTS                                     ; $012C9C
