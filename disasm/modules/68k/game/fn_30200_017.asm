; ============================================================================
; Fm Init Channel 017 (auto-analyzed)
; ROM Range: $030936-$0309F2 (188 bytes)
; ============================================================================
; Category: sound
; Purpose: Orchestrator calling 4 subroutines
;   Accesses VDP registers
;   Calls: fm_write_wrapper, fm_init_channel, fm_set_volume
;   Object (A0, A5, A6): +$00, +$01, +$0B, +$25, +$30 (x_position), +$34 (y_position)
;
; Entry: A0 = object/entity pointer
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D3, D4, D6, A0, A1, A3
; Calls:
;   $030C8A: fm_init_channel
;   $030CBA: fm_write_wrapper
;   $030FB2: fm_set_volume
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$0B: [unknown]
;   +$25: [unknown]
;   +$30: x_position
;   +$34: y_position
; Confidence: high
; ============================================================================

fn_30200_017:
        DC.W    $00FF                           ; $030936
        DC.W    $8600                           ; $030938
        DC.W    $00FF                           ; $03093A
        DIVU    -$01(A0,D0.W),D3                ; $03093C
        OR.W   D3,(A0)                          ; $030940
        DC.W    $00FF                           ; $030942
        OR.B   (A0),D4                          ; $030944
        DC.W    $00FF                           ; $030946
        DC.W    $8840                           ; $030948
        DC.W    $00FF                           ; $03094A
        DC.W    $8870                           ; $03094C
        CLR.B  $0000(A6)                        ; $03094E
        MOVEQ   #$27,D0                         ; $030952
        MOVEQ   #$00,D1                         ; $030954
        DC.W    $4EBA,$0362         ; JSR     $030CBA(PC); $030956
        LEA     $0220(A6),A5                    ; $03095A
        MOVEQ   #$05,D6                         ; $03095E
.loc_002A:
        TST.B  (A5)                             ; $030960
        BPL.W  .loc_00B2                        ; $030962
        BCLR    #7,(A5)                         ; $030966
        MOVEQ   #$00,D3                         ; $03096A
        MOVE.B  $0001(A5),D3                    ; $03096C
        BMI.S  .loc_007C                        ; $030970
        DC.W    $4EBA,$0316         ; JSR     $030C8A(PC); $030972
        CMPI.B  #$04,D3                         ; $030976
        BNE.S  .loc_0056                        ; $03097A
        TST.B  $0340(A6)                        ; $03097C
        BPL.S  .loc_0056                        ; $030980
        LEA     $0340(A6),A5                    ; $030982
        MOVEA.L $0034(A6),A1                    ; $030986
        BRA.S  .loc_0068                        ; $03098A
.loc_0056:
        SUBQ.B  #2,D3                           ; $03098C
        LSL.B  #2,D3                            ; $03098E
        DC.W    $41FA,$FEC0         ; LEA     $030852(PC),A0; $030990
        MOVEA.L A5,A3                           ; $030994
        MOVEA.L $00(A0,D3.W),A5                 ; $030996
        MOVEA.L $0030(A6),A1                    ; $03099A
.loc_0068:
        BCLR    #2,(A5)                         ; $03099E
        BSET    #1,(A5)                         ; $0309A2
        MOVE.B  $000B(A5),D0                    ; $0309A6
        DC.W    $4EBA,$093C         ; JSR     $0312E8(PC); $0309AA
        MOVEA.L A3,A5                           ; $0309AE
        BRA.S  .loc_00B2                        ; $0309B0
.loc_007C:
        DC.W    $4EBA,$05FE         ; JSR     $030FB2(PC); $0309B2
        LEA     $0370(A6),A0                    ; $0309B6
        CMPI.B  #$E0,D3                         ; $0309BA
        BEQ.S  .loc_009A                        ; $0309BE
        CMPI.B  #$C0,D3                         ; $0309C0
        BEQ.S  .loc_009A                        ; $0309C4
        LSR.B  #3,D3                            ; $0309C6
        DC.W    $41FA,$FE88         ; LEA     $030852(PC),A0; $0309C8
        MOVEA.L $00(A0,D3.W),A0                 ; $0309CC
.loc_009A:
        BCLR    #2,(A0)                         ; $0309D0
        BSET    #1,(A0)                         ; $0309D4
        CMPI.B  #$E0,$0001(A0)                  ; $0309D8
        BNE.S  .loc_00B2                        ; $0309DE
        MOVE.B  $0025(A0),$00C00011             ; $0309E0
.loc_00B2:
        ADDA.W  #$0030,A5                       ; $0309E8
        DBRA    D6,.loc_002A                    ; $0309EC
        RTS                                     ; $0309F0
