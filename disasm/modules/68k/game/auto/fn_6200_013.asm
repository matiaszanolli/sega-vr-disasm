; ============================================================================
; Obj Fastcopy16 013 (auto-analyzed)
; ROM Range: $006C46-$006C88 (66 bytes)
; ============================================================================
; Category: game
; Purpose: Calls: FastCopy16
;
; Uses: D5, D6, D7, A1, A2, A3, A4
; Calls:
;   $004922: FastCopy16
; Confidence: low
; ============================================================================

fn_6200_013:
        MOVE.L  A4,-(A7)                        ; $006C46
        MOVE.W  #$0001,$00FF3000                ; $006C48
        LEA     $0089B844,A1                    ; $006C50
        LEA     $00FF304A,A2                    ; $006C56
        LEA     $00FF301A,A3                    ; $006C5C
        LEA     $00FF3002,A4                    ; $006C62
        MOVEQ   #$05,D5                         ; $006C68
.loc_0024:
        MOVEQ   #$01,D6                         ; $006C6A
.loc_0026:
        MOVE.L  A2,(A3)+                        ; $006C6C
        MOVE.W  (A1),D7                         ; $006C6E
        MOVE.W  (A1)+,(A2)+                     ; $006C70
.loc_002C:
        DC.W    $4EBA,$DCAE         ; JSR     $004922(PC); $006C72
        DBRA    D7,.loc_002C                    ; $006C76
        DBRA    D6,.loc_0026                    ; $006C7A
        MOVE.L  A2,(A4)+                        ; $006C7E
        DBRA    D5,.loc_0024                    ; $006C80
        MOVEA.L (A7)+,A4                        ; $006C84
        RTS                                     ; $006C86
