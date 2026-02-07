; ============================================================================
; Fm Write Port0 006 (auto-analyzed)
; ROM Range: $030358-$0303CC (116 bytes)
; ============================================================================
; Category: sound
; Purpose: Calls: z80_bus_request, fm_write_port0
;   Object (A0, A5, A6): +$01, +$03, +$0E (param_e), +$20, +$26, +$28
;
; Entry: A0 = object/entity pointer
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D3, D5, D6, A0, A1, A2
; Calls:
;   $030CD8: fm_write_port0
;   $030D1C: z80_bus_request
; Object fields:
;   +$01: [unknown]
;   +$03: [unknown]
;   +$0E: param_e
;   +$20: [unknown]
;   +$26: [unknown]
;   +$28: [unknown]
; Confidence: high
; ============================================================================

fn_30200_006:
        CLR.B  $0026(A5)                        ; $030358
        DC.W    $60A8               ; BRA.S  $030306; $03035C
        SUBQ.B  #2,$0026(A5)                    ; $03035E
        DC.W    $60A2               ; BRA.S  $030306; $030362
        BSET    #1,(A5)                         ; $030364
        TST.B  $0001(A5)                        ; $030368
        BMI.S  .loc_001A                        ; $03036C
        DC.W    $6000,$091A         ; BRA.W  $030C8A; $03036E
.loc_001A:
        DC.W    $6000,$0C3E         ; BRA.W  $030FB2; $030372
        MOVE.B  $01(A0,D0.W),$0026(A5)          ; $030376
        DC.W    $6088               ; BRA.S  $030306; $03037C
        MOVE.B  $01(A0,D0.W),D0                 ; $03037E
        ADD.B  D0,$0003(A5)                     ; $030382
        ADDQ.B  #1,$0026(A5)                    ; $030386
        DC.W    $6000,$FF7A         ; BRA.W  $030306; $03038A
        DC.W    $43FA,$003C         ; LEA     $0303CC(PC),A1; $03038E
        LEA     $0020(A6),A2                    ; $030392
        TST.B  $000E(A6)                        ; $030396
        BEQ.S  .loc_0048                        ; $03039A
        LEA     $0028(A6),A2                    ; $03039C
.loc_0048:
        MOVEQ   #$03,D5                         ; $0303A0
        DC.W    $4EBA,$0978         ; JSR     $030D1C(PC); $0303A2
.loc_004E:
        MOVE.W  D6,D1                           ; $0303A6
        MOVE.W  (A2)+,D0                        ; $0303A8
        DC.W    $D240                           ; $0303AA
        MOVE.W  D1,D3                           ; $0303AC
        LSR.W  #8,D1                            ; $0303AE
        MOVE.B  (A1)+,D0                        ; $0303B0
        DC.W    $4EBA,$0924         ; JSR     $030CD8(PC); $0303B2
        MOVE.B  D3,D1                           ; $0303B6
        MOVE.B  (A1)+,D0                        ; $0303B8
        DC.W    $4EBA,$091C         ; JSR     $030CD8(PC); $0303BA
        DBRA    D5,.loc_004E                    ; $0303BE
        MOVE.W  #$0000,$00A11100                ; $0303C2
        RTS                                     ; $0303CA
