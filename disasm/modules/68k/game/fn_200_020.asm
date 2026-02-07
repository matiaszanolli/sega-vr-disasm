; ============================================================================
; Init Dispatch 020 (auto-analyzed)
; ROM Range: $0012F4-$00136E (122 bytes)
; ============================================================================
; Category: boot
; Purpose: State dispatcher using jump table
;
; Uses: D0, D1, D3, D4, D5, D6, D7, A0
; Confidence: low
; ============================================================================

fn_200_020:
        MOVE.W  A3,D3                           ; $0012F4
        MOVE.B  D4,D1                           ; $0012F6
        DC.W    $D201                           ; $0012F8
        BCC.S  .loc_0012                        ; $0012FA
        SUBQ.W  #1,D6                           ; $0012FC
        BTST    D6,D5                           ; $0012FE
        BEQ.S  .loc_0012                        ; $001300
        ORI.W  #$8000,D3                        ; $001302
.loc_0012:
        DC.W    $D201                           ; $001306
        BCC.S  .loc_0020                        ; $001308
        SUBQ.W  #1,D6                           ; $00130A
        BTST    D6,D5                           ; $00130C
        BEQ.S  .loc_0020                        ; $00130E
        ADDI.W  #$4000,D3                       ; $001310
.loc_0020:
        DC.W    $D201                           ; $001314
        BCC.S  .loc_002E                        ; $001316
        SUBQ.W  #1,D6                           ; $001318
        BTST    D6,D5                           ; $00131A
        BEQ.S  .loc_002E                        ; $00131C
        ADDI.W  #$2000,D3                       ; $00131E
.loc_002E:
        DC.W    $D201                           ; $001322
        BCC.S  .loc_003C                        ; $001324
        SUBQ.W  #1,D6                           ; $001326
        BTST    D6,D5                           ; $001328
        BEQ.S  .loc_003C                        ; $00132A
        ORI.W  #$1000,D3                        ; $00132C
.loc_003C:
        DC.W    $D201                           ; $001330
        BCC.S  .loc_004A                        ; $001332
        SUBQ.W  #1,D6                           ; $001334
        BTST    D6,D5                           ; $001336
        BEQ.S  .loc_004A                        ; $001338
        ORI.W  #$0800,D3                        ; $00133A
.loc_004A:
        MOVE.W  D5,D1                           ; $00133E
        MOVE.W  D6,D7                           ; $001340
        SUB.W  A5,D7                            ; $001342
        DC.W    $6428               ; BCC.S  $00136E; $001344
        MOVE.W  D7,D6                           ; $001346
        ADDI.W  #$0010,D6                       ; $001348
        NEG.W  D7                               ; $00134C
        LSL.W  D7,D1                            ; $00134E
        MOVE.B  (A0),D5                         ; $001350
        ROL.B  D7,D5                            ; $001352
        DC.W    $DE47                           ; $001354
        AND.W  $001382(PC,D7.W),D5              ; $001356
        DC.W    $D245                           ; $00135A
        MOVE.W  A5,D0                           ; $00135C
        DC.W    $D040                           ; $00135E
        AND.W  $001382(PC,D0.W),D1              ; $001360
        DC.W    $D243                           ; $001364
        MOVE.B  (A0)+,D5                        ; $001366
        LSL.W  #8,D5                            ; $001368
        MOVE.B  (A0)+,D5                        ; $00136A
        RTS                                     ; $00136C
