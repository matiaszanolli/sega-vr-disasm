; ============================================================================
; Sh2 Comm Dispatch 010 (auto-analyzed)
; ROM Range: $00B2FC-$00B36E (114 bytes)
; ============================================================================
; Category: sh2
; Purpose: State dispatcher using jump table
;   RAM: $C89E (sh2_comm_sub)
;   Object (A0, A1, A3): +$00, +$01, +$02 (flags/type), +$03, +$06 (speed), +$E2
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D2, A0, A1, A3
; RAM:
;   $C89E: sh2_comm_sub
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$02: flags/type
;   +$03: [unknown]
;   +$06: speed
;   +$E2: [unknown]
; Confidence: medium
; ============================================================================

fn_a200_010:
        MOVE.W  (-14178).W,D0                   ; $00B2FC
        MOVE.W  $00B2D8(PC,D0.W),D0             ; $00B300
        ADD.W  $00E2(A0),D0                     ; $00B304
        BMI.S  .loc_0070                        ; $00B308
        MULS    #$0320,D0                       ; $00B30A
        MOVE.W  $0006(A0),D1                    ; $00B30E
        BEQ.S  .loc_0070                        ; $00B312
        DIVS    D1,D0                           ; $00B314
        CMPI.W  #$0032,D0                       ; $00B316
        BLT.S  .loc_0022                        ; $00B31A
        MOVEQ   #$32,D0                         ; $00B31C
.loc_0022:
        DC.W    $D040                           ; $00B31E
        LEA     $00899884,A3                    ; $00B320
        DC.W    $023C                           ; $00B326
        DC.W    $00EF                           ; $00B328
        MOVE.W  $00(A3,D0.W),D0                 ; $00B32A
        MOVE.B  $0003(A1),D1                    ; $00B32E
        DC.W    $8300                           ; $00B332
        MOVE.B  D1,$0003(A1)                    ; $00B334
        MOVEQ   #$00,D2                         ; $00B338
        MOVE.B  $0002(A1),D1                    ; $00B33A
        DC.W    $8302                           ; $00B33E
        ANDI.B  #$0F,D1                         ; $00B340
        MOVE.B  D1,$0002(A1)                    ; $00B344
        MOVE.B  $0001(A1),D1                    ; $00B348
        DC.W    $8302                           ; $00B34C
        BCC.S  .loc_005C                        ; $00B34E
        SUBI.B  #$40,D1                         ; $00B350
        DC.W    $003C                           ; $00B354
        DC.W    $0010                           ; $00B356
.loc_005C:
        MOVE.B  D1,$0001(A1)                    ; $00B358
        MOVE.B  (A1),D1                         ; $00B35C
        DC.W    $8302                           ; $00B35E
        CMPI.B  #$59,D1                         ; $00B360
        BLE.S  .loc_006E                        ; $00B364
        MOVE.B  #$59,D1                         ; $00B366
.loc_006E:
        MOVE.B  D1,(A1)                         ; $00B36A
.loc_0070:
        RTS                                     ; $00B36C
