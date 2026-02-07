; ============================================================================
; Sh2 Comm Vdpprep 017 (auto-analyzed)
; ROM Range: $002680-$00270A (138 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 5 subroutines
;   Accesses 32X registers: adapter_ctrl
;   Calls: VDPPrep
;   Object (A4): +$8B
;
; Entry: A4 = object/entity pointer
; Uses: D0, A4
; Calls:
;   $00281E: VDPPrep
; Object fields:
;   +$8B: [unknown]
; Confidence: high
; ============================================================================

fn_2200_017:
        DC.W    $8000                           ; $002680
        ORI.B  #$00,D0                          ; $002682
        ORI.B  #$00,D0                          ; $002686
        DC.W    $0000                           ; $00268A
        LEA     $00A15100,A4                    ; $00268C
        BCLR    #0,$008B(A4)                    ; $002692
        DC.W    $4EBA,$00A8         ; JSR     $002742(PC); $002698
        DC.W    $4EBA,$0120         ; JSR     $0027BE(PC); $00269C
        DC.W    $4EBA,$017C         ; JSR     $00281E(PC); $0026A0
        BSET    #0,$008B(A4)                    ; $0026A4
        DC.W    $4EBA,$0096         ; JSR     $002742(PC); $0026AA
        DC.W    $4EBA,$010E         ; JSR     $0027BE(PC); $0026AE
        DC.W    $4EBA,$016A         ; JSR     $00281E(PC); $0026B2
        BCLR    #0,$008B(A4)                    ; $0026B6
        MOVE.B  #$00,(-14324).W                 ; $0026BC
        MOVEQ   #$00,D0                         ; $0026C2
        DC.W    $4EFA,$00BC         ; JMP     $002782(PC); $0026C4
        LEA     $00A15100,A4                    ; $0026C8
        BCLR    #0,$008B(A4)                    ; $0026CE
        DC.W    $616C               ; BSR.S  $002742; $0026D4
        DC.W    $4EBA,$00C8         ; JSR     $0027A0(PC); $0026D6
        DC.W    $4EBA,$0142         ; JSR     $00281E(PC); $0026DA
        BSET    #0,$008B(A4)                    ; $0026DE
        DC.W    $615C               ; BSR.S  $002742; $0026E4
        DC.W    $4EBA,$00B8         ; JSR     $0027A0(PC); $0026E6
        DC.W    $4EBA,$0132         ; JSR     $00281E(PC); $0026EA
        BCLR    #0,$008B(A4)                    ; $0026EE
        MOVE.B  #$00,(-14324).W                 ; $0026F4
        MOVEQ   #$00,D0                         ; $0026FA
        DC.W    $4EBA,$0084         ; JSR     $002782(PC); $0026FC
        MOVE.W  #$8000,$00A15202                ; $002700
        RTS                                     ; $002708
