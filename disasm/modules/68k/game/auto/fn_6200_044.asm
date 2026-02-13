; ============================================================================
; fn_6200_044 — Directional Collision Probe
; ROM Range: $007AD6-$007BAC (214 bytes)
; Probes for collisions in the entity's heading direction. Computes offset
; from heading angle via ROM table at $0093661E, performs tile lookup at
; offset position, checks for track boundary collision via angle_normalize
; and velocity_apply. Probes two points (forward and adjacent) and stores
; surface tracking data in +$C6/+$C8. Falls through to center probe check.
;
; Entry: A0 = entity base pointer, A4 = scratch buffer pointer
; Uses: D0, D1, D2, A0, A1, A2, A3, A4
; Object fields: +$30 x_position, +$34 y_position, +$40 heading,
;   +$46 scale, +$55 collision_flag, +$C6/+$C8 surface_offsets
; Confidence: high
; ============================================================================

fn_6200_044:
        MOVE.W  $0040(A0),D0                    ; $007AD6
        ADD.W  $0046(A0),D0                     ; $007ADA
        LEA     $0093661E,A3                    ; $007ADE
        LSR.W  #6,D0                            ; $007AE4
        ADD.W   D0,D0                           ; $007AE6
        LEA     $00(A3,D0.W),A3                 ; $007AE8
        MOVE.B  (A3)+,D1                        ; $007AEC
        EXT.W   D1                              ; $007AEE
        MOVE.B  (A3),D2                         ; $007AF0
        EXT.W   D2                              ; $007AF2
        ADD.W  $0030(A0),D1                     ; $007AF4
        ADD.W  $0034(A0),D2                     ; $007AF8
        DC.W    $4EBA,$F8EA         ; JSR     $0073E8(PC); $007AFC
        MOVE.L  A1,(A4)                         ; $007B00
        DC.W    $4EBA,$F988         ; JSR     $00748C(PC); $007B02
        BNE.S  .loc_0042                        ; $007B06
        MOVE.L  #$00000000,(A4)                 ; $007B08
        MOVE.L  #$00000000,$0004(A4)            ; $007B0E
        BRA.S  .loc_005A                        ; $007B16
.loc_0042:
        MOVE.L  A2,$0004(A4)                    ; $007B18
        DC.W    $4EBA,$FAAA         ; JSR     $0075C8(PC); $007B1C
        BLE.S  .loc_005A                        ; $007B20
        MOVE.W  $00C6(A0),D2                    ; $007B22
        EXT.L   D2                              ; $007B26
        ADD.L   D2,D1; $007B28
        ASR.L  #1,D1                            ; $007B2A
        MOVE.W  D1,$00C6(A0)                    ; $007B2C
.loc_005A:
        LEA     $07FF(A3),A3                    ; $007B30
        MOVE.B  (A3)+,D1                        ; $007B34
        EXT.W   D1                              ; $007B36
        MOVE.B  (A3),D2                         ; $007B38
        EXT.W   D2                              ; $007B3A
        ADD.W  $0030(A0),D1                     ; $007B3C
        ADD.W  $0034(A0),D2                     ; $007B40
        DC.W    $4EBA,$F8A2         ; JSR     $0073E8(PC); $007B44
        MOVE.L  (A4),D0                         ; $007B48
        BEQ.S  .loc_008E                        ; $007B4A
        CMPA.L  D0,A1                           ; $007B4C
        BNE.S  .loc_008E                        ; $007B4E
        MOVEA.L A1,A3                           ; $007B50
        MOVEA.L $0004(A4),A1                    ; $007B52
        DC.W    $4EBA,$F9DC         ; JSR     $007534(PC); $007B56
        BNE.S  .loc_0092                        ; $007B5A
        MOVEA.L A3,A1                           ; $007B5C
        DC.W    $4EBA,$F944         ; JSR     $0074A4(PC); $007B5E
        BRA.S  .loc_0092                        ; $007B62
.loc_008E:
        DC.W    $4EBA,$F926         ; JSR     $00748C(PC); $007B64
.loc_0092:
        DC.W    $4EBA,$FA5E         ; JSR     $0075C8(PC); $007B68
        BLE.S  .loc_00A6                        ; $007B6C
        MOVE.W  $00C8(A0),D2                    ; $007B6E
        EXT.L   D2                              ; $007B72
        ADD.L   D2,D1; $007B74
        ASR.L  #1,D1                            ; $007B76
        MOVE.W  D1,$00C8(A0)                    ; $007B78
.loc_00A6:
        MOVE.W  $0030(A0),D1                    ; $007B7C
        MOVE.W  $0034(A0),D2                    ; $007B80
        MOVE.B  #$01,$0055(A0)                  ; $007B84
        DC.W    $4EBA,$F85C         ; JSR     $0073E8(PC); $007B8A
        MOVE.L  (A4),D0                         ; $007B8E
        DC.W    $672C               ; BEQ.S  $007BBE; $007B90
        CMPA.L  D0,A1                           ; $007B92
        DC.W    $6628               ; BNE.S  $007BBE; $007B94
        MOVEA.L A1,A3                           ; $007B96
        MOVEA.L $0004(A4),A1                    ; $007B98
        DC.W    $4EBA,$F996         ; JSR     $007534(PC); $007B9C
        DC.W    $6622               ; BNE.S  $007BC4; $007BA0
        MOVEA.L A3,A1                           ; $007BA2
        DC.W    $4EBA,$F8FE         ; JSR     $0074A4(PC); $007BA4
        DC.W    $661A               ; BNE.S  $007BC4; $007BA8
        RTS                                     ; $007BAA
