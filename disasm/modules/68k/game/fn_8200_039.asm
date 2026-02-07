; ============================================================================
; State Velocity 039 (auto-analyzed)
; ROM Range: $00987E-$0099AA (300 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0): +$02 (flags/type), +$10, +$3C (heading_mirror), +$4C, +$62, +$6A
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, A0
; Object fields:
;   +$02: flags/type
;   +$10: [unknown]
;   +$3C: heading_mirror
;   +$4C: [unknown]
;   +$62: [unknown]
;   +$6A: [unknown]
;   +$78: [unknown]
;   +$8C: velocity_x
; Confidence: medium
; ============================================================================

fn_8200_039:
        MOVE.W  (-16384).W,D0                   ; $00987E
        BPL.S  .loc_0008                        ; $009882
        NEG.W  D0                               ; $009884
.loc_0008:
        MULS    $0010(A0),D0                    ; $009886
        ASR.W  #8,D0                            ; $00988A
        MOVE.W  $0078(A0),D1                    ; $00988C
        DC.W    $9240                           ; $009890
        CMPI.W  #$007F,D1                       ; $009892
        BGE.S  .loc_001C                        ; $009896
        MOVEQ   #$7F,D1                         ; $009898
.loc_001C:
        MOVE.W  D1,$0078(A0)                    ; $00989A
        CLR.B  (-15589).W                       ; $00989E
        MOVE.W  $0092(A0),D0                    ; $0098A2
        ADD.W  $0062(A0),D0                     ; $0098A6
        BNE.W  .loc_00D2                        ; $0098AA
        MOVE.W  $004C(A0),D0                    ; $0098AE
        MOVE.W  D0,D1                           ; $0098B2
        BPL.S  .loc_003A                        ; $0098B4
        NEG.W  D1                               ; $0098B6
.loc_003A:
        CMPI.W  #$0037,D1                       ; $0098B8
        BLE.W  .loc_00D2                        ; $0098BC
        MOVE.W  $0094(A0),D1                    ; $0098C0
        BPL.S  .loc_004A                        ; $0098C4
        NEG.W  D1                               ; $0098C6
.loc_004A:
        EXT.L   D0                              ; $0098C8
        DIVS    (-16146).W,D0                   ; $0098CA
        CMP.W  (-16144).W,D1                    ; $0098CE
        BGT.S  .loc_0074                        ; $0098D2
        MOVE.W  #$0200,D2                       ; $0098D4
        SUB.W  $0078(A0),D2                     ; $0098D8
        MULS    D2,D0                           ; $0098DC
        ASR.L  #8,D0                            ; $0098DE
        ADD.W  D0,$0094(A0)                     ; $0098E0
        MOVE.W  $0094(A0),D0                    ; $0098E4
        ASR.W  #1,D0                            ; $0098E8
        MOVE.W  D0,$0096(A0)                    ; $0098EA
        BRA.W  .loc_012A                        ; $0098EE
.loc_0074:
        MOVE.B  #$01,(-15589).W                 ; $0098F2
        ASR.W  #2,D0                            ; $0098F8
        MOVE.W  D0,D1                           ; $0098FA
        ASR.W  #1,D1                            ; $0098FC
        DC.W    $D041                           ; $0098FE
        ADD.W  D0,$0094(A0)                     ; $009900
        MOVE.W  $0094(A0),D0                    ; $009904
        MOVE.W  D0,D1                           ; $009908
        BPL.S  .loc_0090                        ; $00990A
        NEG.W  D1                               ; $00990C
.loc_0090:
        MOVE.W  D0,$0096(A0)                    ; $00990E
        MULS    (-16138).W,D0                   ; $009912
        ASR.L  #8,D0                            ; $009916
        SUB.W  D0,$003C(A0)                     ; $009918
        CMP.W  (-16142).W,D1                    ; $00991C
        BLT.W  .loc_012A                        ; $009920
        MOVE.W  $006A(A0),D2                    ; $009924
        ADD.W  $008C(A0),D2                     ; $009928
        BNE.W  .loc_012A                        ; $00992C
        MOVE.W  #$2000,D2                       ; $009930
        TST.W  $0094(A0)                        ; $009934
        BMI.S  .loc_00C0                        ; $009938
        MOVE.W  #$1000,D2                       ; $00993A
.loc_00C0:
        MOVE.B  #$B2,(-14172).W                 ; $00993E
        OR.W   D2,$0002(A0)                     ; $009944
        CLR.B  (-15589).W                       ; $009948
        BRA.W  .loc_012A                        ; $00994C
.loc_00D2:
        MOVE.W  $0094(A0),D0                    ; $009950
        MOVE.W  D0,D1                           ; $009954
        BMI.S  .loc_00E6                        ; $009956
        CMPI.W  #$0100,D0                       ; $009958
        BGT.S  .loc_00F0                        ; $00995C
        MOVE.W  #$0100,D0                       ; $00995E
        BRA.S  .loc_00F0                        ; $009962
.loc_00E6:
        CMPI.W  #$FF00,D0                       ; $009964
        BLT.S  .loc_00F0                        ; $009968
        MOVE.W  #$FF00,D0                       ; $00996A
.loc_00F0:
        MOVE.W  D0,D1                           ; $00996E
        MULS    (-16140).W,D0                   ; $009970
        ASR.L  #8,D0                            ; $009974
        SUB.W  D0,$0094(A0)                     ; $009976
        MOVE.W  $0094(A0),D2                    ; $00997A
        DC.W    $B540                           ; $00997E
        BPL.S  .loc_0108                        ; $009980
        CLR.W  $0094(A0)                        ; $009982
.loc_0108:
        MOVE.W  $0094(A0),D0                    ; $009986
        MOVE.W  D0,$0096(A0)                    ; $00998A
        TST.W  D1                               ; $00998E
        BGE.S  .loc_0118                        ; $009990
        NEG.W  D0                               ; $009992
        NEG.W  D1                               ; $009994
.loc_0118:
        CMP.W  D0,D1                            ; $009996
        BLT.S  .loc_012A                        ; $009998
        TST.W  D0                               ; $00999A
        BLT.S  .loc_012A                        ; $00999C
        CMPI.W  #$000F,D0                       ; $00999E
        BGT.S  .loc_012A                        ; $0099A2
        CLR.W  $0094(A0)                        ; $0099A4
.loc_012A:
        RTS                                     ; $0099A8
