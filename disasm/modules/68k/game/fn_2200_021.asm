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
        MOVE.W  #$0500,MARS_DREQ_LEN            ; $0028C2: Set DMA length
        MOVE.B  #$04,MARS_DREQ_CTRL+1           ; $0028CA: Set DMA mode
        MOVE.B  (-14167).W,COMM0_LO             ; $0028D2: Write command code
        MOVE.B  (-14168).W,COMM0_HI             ; $0028DA: Write command flag
.loc_0020:
        BTST    #1,COMM1_LO                     ; $0028E2: Poll ack bit
        BEQ.S  .loc_0020                        ; $0028EA
        BCLR    #1,COMM1_LO                     ; $0028EC: Clear ack bit
        LEA     $00FF6000,A1                    ; $0028F4: Source buffer
        LEA     MARS_FIFO,A2                    ; $0028FA: FIFO register
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
        LEA     MARS_SYS_BASE,A4                ; $00293C: 32X register base
        MOVE.B  #$00,(A4)                       ; $002942: Clear adapter ctrl
        LEA     MARS_VDP_FILLADR,A2             ; $002946: VDP fill address reg
        LEA     MARS_VDP_FILLDATA,A3            ; $00294C: VDP fill data reg
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
