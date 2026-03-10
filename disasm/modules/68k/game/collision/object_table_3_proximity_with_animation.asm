; ============================================================================
; Object Table 3 Proximity with Animation — trackside object visibility
; ROM Range: $003B28-$003C1A (242 bytes)
; ============================================================================
; Loads player position from object table 3 ($9F00), gets sprite table via
; indexed ROM lookup at $00895A64. Checks 2D proximity (X/Z threshold $0C80)
; for 3 objects (D7=2). On match, copies sprite data and cycles animation
; frame counter (12 frames at $C008, D0 doubled twice for 4-byte stride).
; Second pass (if race_state $C89C = mode 1): checks 4 objects from table
; $00883A4E with 3D proximity (Y threshold $0300), static textures.
;
; Entry: A0 (loaded internally from $9F00 obj_table_3)
; Uses: D0, D1, D2, D3, D4, D5, D7, A0, A1, A2
; RAM:
;   $9F00: obj_table_3
;   $C008: animation frame counter (0-11, wraps)
;   $C89C: race_state (selects second proximity pass)
; Confidence: medium
; ============================================================================

object_table_3_proximity_with_animation:
        LEA     (-24832).W,A0                   ; $003B28
        MOVE.W  (-14176).W,D1                   ; $003B2C
        LEA     $00895A64,A1                    ; $003B30
        MOVEA.L $00(A1,D1.W),A1                 ; $003B36
        LEA     $00FF663C,A2                    ; $003B3A
        MOVE.W  #$0C80,D1                       ; $003B40
        MOVEQ   #$02,D7                         ; $003B44
.check_next_object:
        MOVE.W  $0030(A0),D2                    ; $003B46
        MOVE.W  $0034(A0),D4                    ; $003B4A
        SUB.W  (A1),D2                          ; $003B4E
        BPL.S  .x_positive                        ; $003B50
        NEG.W  D2                               ; $003B52
.x_positive:
        CMP.W  D1,D2                            ; $003B54
        BGT.S  .not_in_range                        ; $003B56
        SUB.W  $0004(A1),D4                     ; $003B58
        BPL.S  .z_positive                        ; $003B5C
        NEG.W  D4                               ; $003B5E
.z_positive:
        CMP.W  D1,D4                            ; $003B60
        BGT.S  .not_in_range                        ; $003B62
        MOVE.W  #$0001,$0000(A2)                ; $003B64
        MOVE.L  (A1)+,$0002(A2)                 ; $003B6A
        MOVE.W  (A1)+,$0006(A2)                 ; $003B6E
        MOVE.W  (A1)+,$000A(A2)                 ; $003B72
        MOVE.W  (A1)+,$000E(A2)                 ; $003B76
        MOVEA.L (A1),A1                         ; $003B7A
        MOVE.W  (-16376).W,D0                   ; $003B7C
        ADDQ.W  #1,D0                           ; $003B80
        CMPI.W  #$000C,D0                       ; $003B82
        BNE.S  .wrap_frame_counter                        ; $003B86
        MOVE.W  #$0000,D0                       ; $003B88
.wrap_frame_counter:
        MOVE.W  D0,(-16376).W                   ; $003B8C
        LSR.W  #1,D0                            ; $003B90
        ADD.W   D0,D0                           ; $003B92
        ADD.W   D0,D0                           ; $003B94
        MOVE.L  $00(A1,D0.W),$0010(A2)          ; $003B96
        BRA.S  .check_second_pass                        ; $003B9C
.not_in_range:
        LEA     $000E(A1),A1                    ; $003B9E
        DBRA    D7,.check_next_object                    ; $003BA2
        MOVE.W  #$0000,$0000(A2)                ; $003BA6
.check_second_pass:
        MOVE.W  (-14180).W,D1                   ; $003BAC
        CMPI.W  #$0001,D1                       ; $003BB0
        DC.W    $6672               ; BNE.S  $003C28; $003BB4
        LEA     $00883A4E,A1                    ; $003BB6
        LEA     $00FF6650,A2                    ; $003BBC
        MOVE.W  #$0C80,D1                       ; $003BC2
        MOVE.W  #$0300,D3                       ; $003BC6
        MOVEQ   #$03,D7                         ; $003BCA
        MOVE.W  $0030(A0),D2                    ; $003BCC
        MOVE.W  $0034(A0),D4                    ; $003BD0
        MOVE.W  $0032(A0),D5                    ; $003BD4
        SUB.W  (A1),D2                          ; $003BD8
        BPL.S  .x2_positive                        ; $003BDA
        NEG.W  D2                               ; $003BDC
.x2_positive:
        CMP.W  D1,D2                            ; $003BDE
        DC.W    $6E38               ; BGT.S  $003C1A; $003BE0
        SUB.W  $0002(A1),D5                     ; $003BE2
        BPL.S  .y_positive                        ; $003BE6
        NEG.W  D5                               ; $003BE8
.y_positive:
        CMP.W  D3,D5                            ; $003BEA
        DC.W    $6E2C               ; BGT.S  $003C1A; $003BEC
        SUB.W  $0004(A1),D4                     ; $003BEE
        BPL.S  .z2_positive                        ; $003BF2
        NEG.W  D4                               ; $003BF4
.z2_positive:
        CMP.W  D1,D4                            ; $003BF6
        DC.W    $6E20               ; BGT.S  $003C1A; $003BF8
        MOVE.W  #$0001,$0000(A2)                ; $003BFA
        MOVE.L  (A1)+,$0002(A2)                 ; $003C00
        MOVE.W  (A1)+,$0006(A2)                 ; $003C04
        MOVE.W  (A1)+,$000A(A2)                 ; $003C08
        MOVE.W  (A1),$000E(A2)                  ; $003C0C
        MOVE.L  #$22295A24,$0010(A2)            ; $003C10
        RTS                                     ; $003C18
