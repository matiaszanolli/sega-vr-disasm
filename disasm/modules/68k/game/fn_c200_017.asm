; ============================================================================
; Obj Heading Update 017 (auto-analyzed)
; ROM Range: $00CEEE-$00CFD6 (232 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 3 subroutines
;   RAM: $9100 (obj_table_1), $C8CC (race_substate)
;   Calls: obj_heading_update
;   Object (A0, A1, A2): +$00, +$02 (flags/type), +$06 (speed), +$14 (effect_duration), +$32, +$3A
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D7, A0, A1, A2, A6
; RAM:
;   $9100: obj_table_1
;   $C8CC: race_substate
; Calls:
;   $007AB6: obj_heading_update
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$06: speed
;   +$14: effect_duration
;   +$32: [unknown]
;   +$3A: [unknown]
;   +$3E: [unknown]
;   +$46: display_scale
; Confidence: high
; ============================================================================

fn_c200_017:
        ORI.B  #$0F,(A6)+                       ; $00CEEE
        DC.W    $0000                           ; $00CEF2
        DC.W    $FFF1                           ; $00CEF4
        DC.W    $FFE2                           ; $00CEF6
        ORI.B  #$0F,(A6)+                       ; $00CEF8
        DC.W    $0000                           ; $00CEFC
        DC.W    $FFF1                           ; $00CEFE
        DC.W    $FFE2                           ; $00CF00
        ORI.B  #$0F,(A6)+                       ; $00CF02
        DC.W    $0000                           ; $00CF06
        DC.W    $FFF1                           ; $00CF08
        DC.W    $FFE2                           ; $00CF0A
        LEA     (-28416).W,A0                   ; $00CF0C
        MOVEQ   #$0E,D7                         ; $00CF10
.loc_0024:
        MOVE.W  D7,-(A7)                        ; $00CF12
        DC.W    $4EBA,$ABA0         ; JSR     $007AB6(PC); $00CF14
        DC.W    $4EBA,$AB9C         ; JSR     $007AB6(PC); $00CF18
        DC.W    $4EBA,$AB98         ; JSR     $007AB6(PC); $00CF1C
        DC.W    $4EBA,$AB94         ; JSR     $007AB6(PC); $00CF20
        DC.W    $4EBA,$AB90         ; JSR     $007AB6(PC); $00CF24
        DC.W    $4EBA,$AB8C         ; JSR     $007AB6(PC); $00CF28
        DC.W    $4EBA,$AB88         ; JSR     $007AB6(PC); $00CF2C
        DC.W    $4EBA,$AB84         ; JSR     $007AB6(PC); $00CF30
        DC.W    $4EBA,$AB80         ; JSR     $007AB6(PC); $00CF34
        LEA     $0093AC2C,A1                    ; $00CF38
        MOVE.W  $00C8(A0),D0                    ; $00CF3E
        SUB.W  $0032(A0),D0                     ; $00CF42
        DC.W    $D040                           ; $00CF46
        BMI.S  .loc_0066                        ; $00CF48
        ANDI.W  #$03FF,D0                       ; $00CF4A
        MOVE.W  $00(A1,D0.W),D0                 ; $00CF4E
        BRA.S  .loc_0072                        ; $00CF52
.loc_0066:
        NEG.W  D0                               ; $00CF54
        ANDI.W  #$03FF,D0                       ; $00CF56
        MOVE.W  $00(A1,D0.W),D0                 ; $00CF5A
        NEG.W  D0                               ; $00CF5E
.loc_0072:
        MOVE.W  D0,$003A(A0)                    ; $00CF60
        LEA     $0093A82C,A1                    ; $00CF64
        MOVE.W  $0032(A0),D0                    ; $00CF6A
        SUB.W  $00C6(A0),D0                     ; $00CF6E
        DC.W    $D040                           ; $00CF72
        BMI.S  .loc_0092                        ; $00CF74
        ANDI.W  #$03FF,D0                       ; $00CF76
        MOVE.W  $00(A1,D0.W),D0                 ; $00CF7A
        BRA.S  .loc_009E                        ; $00CF7E
.loc_0092:
        NEG.W  D0                               ; $00CF80
        ANDI.W  #$03FF,D0                       ; $00CF82
        MOVE.W  $00(A1,D0.W),D0                 ; $00CF86
        NEG.W  D0                               ; $00CF8A
.loc_009E:
        DC.W    $4EBA,$A6C0         ; JSR     $00764E(PC); $00CF8C
        DC.W    $4EBA,$A1B8         ; JSR     $00714A(PC); $00CF90
        MOVE.W  D0,$003E(A0)                    ; $00CF94
        MOVE.W  $006E(A0),$0046(A0)             ; $00CF98
        LEA     $0100(A0),A0                    ; $00CF9E
        MOVE.W  (A7)+,D7                        ; $00CFA2
        DBRA    D7,.loc_0024                    ; $00CFA4
        JMP     $008836DE                       ; $00CFA8
        MOVE.W  (-14132).W,D0                   ; $00CFAE
        LEA     $008955CC,A1                    ; $00CFB2
        MOVEA.L $00(A1,D0.W),A1                 ; $00CFB8
        LEA     $00FF6178,A2                    ; $00CFBC
        MOVEQ   #$07,D7                         ; $00CFC2
.loc_00D6:
        MOVE.L  (A1)+,$0002(A2)                 ; $00CFC4
        MOVE.W  (A1)+,$0006(A2)                 ; $00CFC8
        LEA     $0014(A2),A2                    ; $00CFCC
        DBRA    D7,.loc_00D6                    ; $00CFD0
        RTS                                     ; $00CFD4
