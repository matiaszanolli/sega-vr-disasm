; ============================================================================
; Sh2 Comm Cmd 27 027 (auto-analyzed)
; ROM Range: $012F56-$012F9C (70 bytes)
; ============================================================================
; Category: sh2
; Purpose: Calls: sh2_cmd_27
;   Object (A1): +$00, +$04 (speed_index/velocity)
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, A0, A1, A2, A3, A4
; Calls:
;   $00E3B4: sh2_cmd_27
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
; Confidence: medium
; ============================================================================

fn_12200_027:
        DC.W    $0088                           ; $012F56
        DC.W    $E5CE                           ; $012F58
        DC.W    $0088                           ; $012F5A
        DC.W    $E5FE                           ; $012F5C
        DC.W    $0088                           ; $012F5E
        DC.W    $F13C                           ; $012F60
        DC.W    $0089                           ; $012F62
        DC.W    $1D0A                           ; $012F64
        DC.W    $0089                           ; $012F66
        MOVEA.W (A4),A0                         ; $012F68
        DC.W    $0088                           ; $012F6A
        ROXL.W  -(A6)                           ; $012F6C
        DC.W    $0089                           ; $012F6E
        MOVE.L  (A2),(A3)+                      ; $012F70
        MOVEQ   #$00,D0                         ; $012F72
        MOVE.B  (-24551).W,D0                   ; $012F74
        LEA     $00892F9C,A1                    ; $012F78
        DC.W    $D040                           ; $012F7E
        MOVE.W  D0,D1                           ; $012F80
        DC.W    $D040                           ; $012F82
        DC.W    $D041                           ; $012F84
        MOVEA.L $00(A1,D0.W),A0                 ; $012F86
        MOVE.W  $04(A1,D0.W),D0                 ; $012F8A
        MOVE.W  #$0048,D1                       ; $012F8E
        MOVE.W  #$0010,D2                       ; $012F92
        DC.W    $4EBA,$B41C         ; JSR     $00E3B4(PC); $012F96
        RTS                                     ; $012F9A
