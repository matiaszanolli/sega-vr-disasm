; ============================================================================
; Render Slot Setup — configure 7 trackside object render slots
; ROM Range: $003F2E-$004084 (342 bytes)
; ============================================================================
; Four entry points for different viewport configurations:
;   Entry 1 ($003F2E): 1P mode — viewport A ($FF64AC) then viewport B ($FF6178)
;   Entry 2 ($003F5A): 1P alt — viewport C ($FF627C) then viewport D ($FF63A8)
;   Entry 3 ($003F86): 2P mode — viewport B ($FF6178) only
;   Common ($003F90): Iterates 7 render slots with $14-byte stride. For each:
;     reads trackside object index from RAM, doubles it for table lookup,
;     loads 4-byte sprite definition pointer from ROM tables, sets visibility.
; ROM tables: $008959B0, $008959D0, $008959FC, $00895A24, $00895A44
;
; Entry: A0 = player entity pointer (+$C0=render_flags)
; Uses: D0, D1, D2, D3, D4, A0, A1, A2
; Confidence: medium
; ============================================================================

render_slot_setup:
        MOVEQ   #$00,D3                         ; $003F2E
        MOVEQ   #$00,D4                         ; $003F30
        TST.W  $00FF6448                        ; $003F32
        BEQ.S  .loc_0016                        ; $003F38
        TST.W  $00C0(A0)                        ; $003F3A
        BEQ.S  .loc_0016                        ; $003F3E
        MOVEQ   #$01,D3                         ; $003F40
        MOVEQ   #$02,D4                         ; $003F42
.loc_0016:
        LEA     $00FF64AC,A1                    ; $003F44
        JSR     .loc_0062(PC)                   ; $003F4A
        MOVEQ   #$01,D3                         ; $003F4E
        MOVEQ   #$02,D4                         ; $003F50
        LEA     $00FF6178,A1                    ; $003F52
        BRA.S  .loc_0062                        ; $003F58
        MOVEQ   #$00,D3                         ; $003F5A
        MOVEQ   #$00,D4                         ; $003F5C
        TST.W  $00FF6218                        ; $003F5E
        BEQ.S  .loc_0042                        ; $003F64
        TST.W  $00C0(A0)                        ; $003F66
        BEQ.S  .loc_0042                        ; $003F6A
        MOVEQ   #$01,D3                         ; $003F6C
        MOVEQ   #$02,D4                         ; $003F6E
.loc_0042:
        LEA     $00FF627C,A1                    ; $003F70
        JSR     .loc_0062(PC)                   ; $003F76
        MOVEQ   #$01,D3                         ; $003F7A
        MOVEQ   #$02,D4                         ; $003F7C
        LEA     $00FF63A8,A1                    ; $003F7E
        BRA.S  .loc_0062                        ; $003F84
        LEA     $00FF6178,A1                    ; $003F86
        MOVEQ   #$01,D3                         ; $003F8C
        MOVEQ   #$02,D4                         ; $003F8E
.loc_0062:
        MOVEQ   #$00,D1                         ; $003F90
        MOVEQ   #$14,D2                         ; $003F92
        MOVE.W  D1,$0000(A1)                    ; $003F94
        MOVE.W  D1,$00(A1,D2.W)                 ; $003F98
        MOVE.W  (-16372).W,D0                   ; $003F9C
        BMI.S  .loc_0092                        ; $003FA0
        ADD.W   D0,D0                           ; $003FA2
        ADD.W   D0,D0                           ; $003FA4
        LEA     $008959B0,A2                    ; $003FA6
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $003FAC
        MOVE.W  D4,$0000(A1)                    ; $003FB2
        MOVE.L  $00(A2,D0.W),$10(A1,D2.W)       ; $003FB6
        MOVE.W  D3,$00(A1,D2.W)                 ; $003FBC
.loc_0092:
        ADDA.L  D2,A1                           ; $003FC0
        ADDA.L  D2,A1                           ; $003FC2
        MOVE.W  D1,$0000(A1)                    ; $003FC4
        MOVE.W  (-16366).W,D0                   ; $003FC8
        BMI.S  .loc_00B4                        ; $003FCC
        ADD.W   D0,D0                           ; $003FCE
        ADD.W   D0,D0                           ; $003FD0
        LEA     $008959D0,A2                    ; $003FD2
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $003FD8
        MOVE.W  D3,$0000(A1)                    ; $003FDE
.loc_00B4:
        ADDA.L  D2,A1                           ; $003FE2
        MOVE.W  D1,$0000(A1)                    ; $003FE4
        MOVE.W  (-16360).W,D0                   ; $003FE8
        BMI.S  .loc_00D4                        ; $003FEC
        ADD.W   D0,D0                           ; $003FEE
        ADD.W   D0,D0                           ; $003FF0
        LEA     $008959FC,A2                    ; $003FF2
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $003FF8
        MOVE.W  D3,$0000(A1)                    ; $003FFE
.loc_00D4:
        ADDA.L  D2,A1                           ; $004002
        MOVE.W  D1,$0000(A1)                    ; $004004
        MOVE.W  (-16354).W,D0                   ; $004008
        BMI.S  .loc_00F4                        ; $00400C
        ADD.W   D0,D0                           ; $00400E
        ADD.W   D0,D0                           ; $004010
        LEA     $00895A24,A2                    ; $004012
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $004018
        MOVE.W  D4,$0000(A1)                    ; $00401E
.loc_00F4:
        ADDA.L  D2,A1                           ; $004022
        MOVE.W  D1,$0000(A1)                    ; $004024
        MOVE.W  (-16348).W,D0                   ; $004028
        BMI.S  .loc_0114                        ; $00402C
        ADD.W   D0,D0                           ; $00402E
        ADD.W   D0,D0                           ; $004030
        LEA     $00895A24,A2                    ; $004032
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $004038
        MOVE.W  D3,$0000(A1)                    ; $00403E
.loc_0114:
        ADDA.L  D2,A1                           ; $004042
        MOVE.W  D1,$0000(A1)                    ; $004044
        MOVE.W  (-16370).W,D0                   ; $004048
        BMI.S  .loc_0134                        ; $00404C
        ADD.W   D0,D0                           ; $00404E
        ADD.W   D0,D0                           ; $004050
        LEA     $00895A44,A2                    ; $004052
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $004058
        MOVE.W  D4,$0000(A1)                    ; $00405E
.loc_0134:
        ADDA.L  D2,A1                           ; $004062
        MOVE.W  D1,$0000(A1)                    ; $004064
        MOVE.W  (-16368).W,D0                   ; $004068
        BMI.S  .loc_0154                        ; $00406C
        ADD.W   D0,D0                           ; $00406E
        ADD.W   D0,D0                           ; $004070
        LEA     $00895A44,A2                    ; $004072
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $004078
        MOVE.W  D3,$0000(A1)                    ; $00407E
.loc_0154:
        RTS                                     ; $004082
