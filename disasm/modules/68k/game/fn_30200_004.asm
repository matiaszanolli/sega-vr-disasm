; ============================================================================
; Fm 004 (auto-analyzed)
; ROM Range: $0302EE-$030354 (102 bytes)
; ============================================================================
; Category: sound
; Purpose: Object (A0, A5): +$00, +$03, +$0A (param_a), +$10, +$1C, +$1E
;
; Entry: A0 = object/entity pointer
; Entry: A5 = object/entity pointer
; Uses: D0, D6, A0, A5
; Object fields:
;   +$00: [unknown]
;   +$03: [unknown]
;   +$0A: param_a
;   +$10: [unknown]
;   +$1C: [unknown]
;   +$1E: [unknown]
;   +$26: [unknown]
; Confidence: low
; ============================================================================

fn_30200_004:
        MOVEQ   #$00,D6                         ; $0302EE
        MOVE.B  $000A(A5),D0                    ; $0302F0
        ANDI.W  #$007F,D0                       ; $0302F4
        BEQ.S  .loc_0050                        ; $0302F8
        DC.W    $41FA,$263A         ; LEA     $032936(PC),A0; $0302FA
        SUBQ.W  #1,D0                           ; $0302FE
        LSL.W  #2,D0                            ; $030300
        MOVEA.L $00(A0,D0.W),A0                 ; $030302
        MOVEQ   #$00,D0                         ; $030306
        MOVE.B  $0026(A5),D0                    ; $030308
        ADDQ.B  #1,$0026(A5)                    ; $03030C
        MOVE.B  $00(A0,D0.W),D6                 ; $030310
        BPL.S  .loc_0046                        ; $030314
        CMPI.B  #$80,D6                         ; $030316
        DC.W    $673C               ; BEQ.S  $030358; $03031A
        CMPI.B  #$81,D6                         ; $03031C
        DC.W    $673C               ; BEQ.S  $03035E; $030320
        CMPI.B  #$83,D6                         ; $030322
        DC.W    $673C               ; BEQ.S  $030364; $030326
        CMPI.B  #$82,D6                         ; $030328
        DC.W    $6748               ; BEQ.S  $030376; $03032C
        CMPI.B  #$84,D6                         ; $03032E
        DC.W    $674A               ; BEQ.S  $03037E; $030332
.loc_0046:
        EXT.W   D6                              ; $030334
        MOVE.B  $0003(A5),D0                    ; $030336
        EXT.W   D0                              ; $03033A
        MULU    D0,D6                           ; $03033C
.loc_0050:
        MOVE.W  $001E(A5),D0                    ; $03033E
        DC.W    $DC40                           ; $030342
        ADD.W  $0010(A5),D6                     ; $030344
        TST.B  $000A(A5)                        ; $030348
        BPL.S  .loc_0064                        ; $03034C
        ADD.W  $001C(A5),D6                     ; $03034E
.loc_0064:
        RTS                                     ; $030352
