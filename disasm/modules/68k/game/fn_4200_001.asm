; ============================================================================
; Input 001 (auto-analyzed)
; ROM Range: $004200-$004280 (128 bytes)
; ============================================================================
; Category: input
; Purpose: RAM: $C07C (input_state)
;   Object (A2, A3): +$00, +$08
;
; Entry: A2 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D5, D7, A0, A1, A2, A3
; RAM:
;   $C07C: input_state
; Object fields:
;   +$00: [unknown]
;   +$08: [unknown]
; Confidence: medium
; ============================================================================

fn_4200_001:
        AND.B  -(A0),D5                         ; $004200
        MOVEQ   #$07,D7                         ; $004202
        MOVEQ   #$00,D0                         ; $004204
        MOVE.B  (-15604).W,D0                   ; $004206
        MOVE.W  D0,D1                           ; $00420A
        CMPI.B  #$09,D0                         ; $00420C
        BLE.S  .loc_0028                        ; $004210
        LEA     $00FF6830,A2                    ; $004212
        MOVE.B  D7,$0000(A2)                    ; $004218
        MOVE.L  #$222EA436,$0008(A2)            ; $00421C
        SUBI.B  #$0A,D0                         ; $004224
.loc_0028:
        LEA     $00FF6820,A2                    ; $004228
        MOVE.B  D7,$0000(A2)                    ; $00422E
        LSL.W  #2,D0                            ; $004232
        LEA     $008997C4,A3                    ; $004234
        MOVE.L  $00(A3,D0.W),$0008(A2)          ; $00423A
        LSL.W  #2,D1                            ; $004240
        LEA     $00FF6810,A2                    ; $004242
        LEA     $00899780,A3                    ; $004248
        MOVE.L  $00(A3,D1.W),$0008(A2)          ; $00424E
        LEA     (-15776).W,A1                   ; $004254
        LEA     $00FF6860,A2                    ; $004258
        DC.W    $6120               ; BSR.S  $004280; $00425E
        LEA     (-15788).W,A1                   ; $004260
        LEA     $00FF6870,A2                    ; $004264
        CMPI.L  #$61000000,(A1)                 ; $00426A
        BEQ.S  .loc_0074                        ; $004270
        DC.W    $610C               ; BSR.S  $004280; $004272
.loc_0074:
        MOVE.W  #$0040,(-15780).W               ; $004274
        ADDQ.W  #4,(-16260).W                   ; $00427A
        RTS                                     ; $00427E
