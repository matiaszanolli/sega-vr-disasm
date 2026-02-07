; ============================================================================
; Obj Table 3 002 (auto-analyzed)
; ROM Range: $00AF18-$00AFC2 (170 bytes)
; ============================================================================
; Category: object
; Purpose: RAM: $9F00 (obj_table_3)
;   Object (A0, A1): +$02 (flags/type), +$04 (speed_index/velocity), +$06 (speed), +$32, +$6A, +$88
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, A0, A1
; RAM:
;   $9F00: obj_table_3
; Object fields:
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$06: speed
;   +$32: [unknown]
;   +$6A: [unknown]
;   +$88: [unknown]
;   +$8C: velocity_x
; Confidence: medium
; ============================================================================

fn_a200_002:
        LEA     (-24832).W,A1                   ; $00AF18
        CLR.W  $0088(A0)                        ; $00AF1C
        CLR.W  $0088(A1)                        ; $00AF20
        MOVE.W  $006A(A0),D0                    ; $00AF24
        ADD.W  $006A(A1),D0                     ; $00AF28
        ADD.W  $008C(A0),D0                     ; $00AF2C
        ADD.W  $008C(A1),D0                     ; $00AF30
        BNE.W  .loc_00A8                        ; $00AF34
        MOVE.W  $0032(A1),D0                    ; $00AF38
        SUB.W  $0032(A0),D0                     ; $00AF3C
        BPL.S  .loc_002C                        ; $00AF40
        NEG.W  D0                               ; $00AF42
.loc_002C:
        CMPI.W  #$0200,D0                       ; $00AF44
        BGE.S  .loc_00A8                        ; $00AF48
        DC.W    $4EBA,$FEBE         ; JSR     $00AE0A(PC); $00AF4A
        BEQ.W  .loc_00A8                        ; $00AF4E
        MOVE.B  #$B8,(-14172).W                 ; $00AF52
        MOVE.W  $0004(A0),D0                    ; $00AF58
        SUB.W  $0004(A1),D0                     ; $00AF5C
        BPL.S  .loc_004C                        ; $00AF60
        NEG.W  D0                               ; $00AF62
.loc_004C:
        CMP.W  (-14130).W,D0                    ; $00AF64
        DC.W    $6F00,$0094         ; BLE.W  $00AFFE; $00AF68
        MOVE.W  $0006(A0),D0                    ; $00AF6C
        ADD.W  $0006(A1),D0                     ; $00AF70
        MOVE.W  D0,D2                           ; $00AF74
        ASR.W  #1,D2                            ; $00AF76
        ASR.W  #2,D0                            ; $00AF78
        DC.W    $D440                           ; $00AF7A
        MOVE.W  D0,D1                           ; $00AF7C
        ASR.W  #1,D1                            ; $00AF7E
        DC.W    $D240                           ; $00AF80
        CMPI.W  #$04DC,D1                       ; $00AF82
        BLE.S  .loc_0074                        ; $00AF86
        MOVE.W  #$04DC,D1                       ; $00AF88
.loc_0074:
        CMPI.W  #$04DC,D2                       ; $00AF8C
        BLE.S  .loc_007E                        ; $00AF90
        MOVE.W  #$04DC,D2                       ; $00AF92
.loc_007E:
        MOVE.W  $0006(A1),D0                    ; $00AF96
        CMP.W  $0006(A0),D0                     ; $00AF9A
        BLE.S  .loc_008A                        ; $00AF9E
        DC.W    $C342                           ; $00AFA0
.loc_008A:
        MOVE.W  D2,$0006(A1)                    ; $00AFA2
        MOVE.W  $0004(A0),D3                    ; $00AFA6
        SUB.W  $0004(A1),D3                     ; $00AFAA
        CMP.W  (-14128).W,D3                    ; $00AFAE
        DC.W    $6F0E               ; BLE.S  $00AFC2; $00AFB2
        ORI.W  #$0800,$0002(A0)                 ; $00AFB4
        ORI.W  #$0800,$0002(A1)                 ; $00AFBA
.loc_00A8:
        RTS                                     ; $00AFC0
