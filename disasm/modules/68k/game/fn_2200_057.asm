; ============================================================================
; Vint 057 (auto-analyzed)
; ROM Range: $003924-$00397C (88 bytes)
; ============================================================================
; Category: vint
; Purpose: Calls: collision_distance_calc
;   Object (A3): +$00
;
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D2, D7, A1, A2, A3, A6
; Calls:
;   $0039EC: collision_distance_calc
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_2200_057:
        DC.W    $F809                           ; $003924
        MOVE.B  (A7),D2                         ; $003926
        AND.B  D7,(A7)+                         ; $003928
        DC.W    $F07F                           ; $00392A
        DC.W    $0000                           ; $00392C
        MOVE.L  $1498(A2),D1                    ; $00392E
        DC.W    $0000                           ; $003932
        MOVE.B  $00(A3,D0.W),(A6)               ; $003934
        ORI.B  #$00,D0                          ; $003938
        MOVE.L  $160C(A2),D1                    ; $00393C
        DC.W    $FDF0                           ; $003940
        DC.W    $0A2C                           ; $003942
        ADD.W  D0,-(A1)                         ; $003944
        MOVE.B  D0,D0                           ; $003946
        DC.W    $0000                           ; $003948
        MOVE.L  $1DBE(A2),D1                    ; $00394A
        DC.W    $0000                           ; $00394E
        DC.W    $1A69                           ; $003950
        ORI.B  #$00,D0                          ; $003952
        DC.W    $0000                           ; $003956
        MOVE.L  $1EB8(A2),D1                    ; $003958
        LEA     $00883A4E,A1                    ; $00395C
        LEA     $00FF65B0,A2                    ; $003962
        MOVE.L  #$22295A24,D0                   ; $003968
        MOVEQ   #$03,D7                         ; $00396E
        DC.W    $4EBA,$007A         ; JSR     $0039EC(PC); $003970
        TST.B  (-14321).W                       ; $003974
        DC.W    $6702               ; BEQ.S  $00397C; $003978
        RTS                                     ; $00397A
