; ============================================================================
; Sh2 Comm 021 (auto-analyzed)
; ROM Range: $0028C2-$002984 (194 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: COMM0, adapter_ctrl
;   Object (A4): +$84, +$8B
;
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D2, D7, A1, A2, A3, A4
; Object fields:
;   +$84: [unknown]
;   +$8B: [unknown]
; Confidence: high
; ============================================================================

fn_2200_021:
        MOVE.W  #$0500,$00A15110                ; $0028C2
        MOVE.B  #$04,$00A15107                  ; $0028CA
        MOVE.B  (-14167).W,$00A15121            ; $0028D2
        MOVE.B  (-14168).W,$00A15120            ; $0028DA
.loc_0020:
        BTST    #1,$00A15123                    ; $0028E2
        BEQ.S  .loc_0020                        ; $0028EA
        BCLR    #1,$00A15123                    ; $0028EC
        LEA     $00FF6000,A1                    ; $0028F4
        LEA     $00A15112,A2                    ; $0028FA
        JSR     $008988EC                       ; $002900
        JSR     $008988EC                       ; $002906
        JSR     $008988EC                       ; $00290C
        JSR     $008988EC                       ; $002912
        JSR     $008988EC                       ; $002918
        JSR     $008988EC                       ; $00291E
        JSR     $008988EC                       ; $002924
        JSR     $008988EC                       ; $00292A
        JSR     $008988EC                       ; $002930
        JMP     $008988EC                       ; $002936
        LEA     $00A15100,A4                    ; $00293C
        MOVE.B  #$00,(A4)                       ; $002942
        LEA     $00A15186,A2                    ; $002946
        LEA     $00A15188,A3                    ; $00294C
        MOVE.W  #$00BF,D7                       ; $002952
        MOVEQ   #$00,D0                         ; $002956
        MOVE.W  #$3000,D1                       ; $002958
        MOVE.W  #$0100,D2                       ; $00295C
        MOVE.W  #$009F,$0084(A4)                ; $002960
.loc_00A4:
        MOVE.W  D1,(A2)                         ; $002966
        MOVE.W  D0,(A3)                         ; $002968
        MOVEQ   #$6F,D0                         ; $00296A
        DIVS    #$0378,D0                       ; $00296C
.loc_00AE:
        BTST    #1,$008B(A4)                    ; $002970
        BNE.S  .loc_00AE                        ; $002976
        DC.W    $D242                           ; $002978
        DBRA    D7,.loc_00A4                    ; $00297A
        MOVE.B  #$80,(A4)                       ; $00297E
        RTS                                     ; $002982
