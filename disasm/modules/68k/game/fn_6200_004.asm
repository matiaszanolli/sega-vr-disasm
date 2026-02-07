; ============================================================================
; Obj Calc Steering 004 (auto-analyzed)
; ROM Range: $00659C-$00671A (382 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 27 subroutines
;   Calls: select_sprite_buffer, effect_timer_mgmt, object_frame_timer, load_object_params
;   Object (A0): +$06 (speed), +$44 (display_offset), +$46 (display_scale), +$4A, +$74
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; Calls:
;   $006F98: calc_steering
;   $007084: obj_position_update
;   $0070AA: angle_to_sine
;   $007816: obj_collision_test
;   $007C4E: obj_position_y
;   $007CD8: obj_position_x
; Object fields:
;   +$06: speed
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: [unknown]
;   +$74: [unknown]
; Confidence: high
; ============================================================================

fn_6200_004:
        DC.W    $0088                           ; $00659C
        DC.W    $65BC               ; BCS.S  $00655C; $00659E
        DC.W    $0088                           ; $0065A0
        BVC.S  .loc_000C                        ; $0065A2
        DC.W    $0088                           ; $0065A4
        BNE.S  .loc_0036                        ; $0065A6
.loc_000C:
        DC.W    $0088                           ; $0065A8
        DC.W    $66B4               ; BNE.S  $006560; $0065AA
        DC.W    $0088                           ; $0065AC
        BEQ.S  .loc_002E                        ; $0065AE
        DC.W    $0088                           ; $0065B0
        BEQ.S  $0065CC                          ; $0065B2
        DC.W    $0088                           ; $0065B4
        BEQ.S  $006632                          ; $0065B6
        DC.W    $0088                           ; $0065B8
        BNE.S  .loc_0056                        ; $0065BA
        DC.W    $4EBA,$51B2         ; JSR     $00B770(PC); $0065BC
        MOVEQ   #$00,D0                         ; $0065C0
        MOVE.W  D0,$0044(A0)                    ; $0065C2
        MOVE.W  D0,$0046(A0)                    ; $0065C6
.loc_002E:
        MOVE.W  D0,$004A(A0)                    ; $0065CA
        DC.W    $4EBA,$2040         ; JSR     $008610(PC); $0065CE
.loc_0036:
        DC.W    $4EBA,$1FC6         ; JSR     $00859A(PC); $0065D2
        DC.W    $4EBA,$3D78         ; JSR     $00A350(PC); $0065D6
        DC.W    $4EBA,$1B94         ; JSR     $008170(PC); $0065DA
        DC.W    $4EBA,$1AEC         ; JSR     $0080CC(PC); $0065DE
        DC.W    $4EBA,$1F64         ; JSR     $008548(PC); $0065E2
        DC.W    $4EBA,$2F12         ; JSR     $0094FA(PC); $0065E6
        DC.W    $4EBA,$2D26         ; JSR     $009312(PC); $0065EA
        DC.W    $4EBA,$3522         ; JSR     $009B12(PC); $0065EE
.loc_0056:
        DC.W    $4EBA,$2B8E         ; JSR     $009182(PC); $0065F2
        DC.W    $4EBA,$3026         ; JSR     $00961E(PC); $0065F6
        DC.W    $4EBA,$308C         ; JSR     $009688(PC); $0065FA
        DC.W    $4EBA,$3202         ; JSR     $009802(PC); $0065FE
        DC.W    $4EBA,$1876         ; JSR     $007E7A(PC); $006602
        DC.W    $4EBA,$0990         ; JSR     $006F98(PC); $006606
        DC.W    $4EBA,$16CC         ; JSR     $007CD8(PC); $00660A
        DC.W    $4EBA,$3E24         ; JSR     $00A434(PC); $00660E
        DC.W    $4EBA,$0A96         ; JSR     $0070AA(PC); $006612
        DC.W    $4EBA,$1636         ; JSR     $007C4E(PC); $006616
        DC.W    $4EBA,$0B2E         ; JSR     $00714A(PC); $00661A
        DC.W    $4EBA,$102E         ; JSR     $00764E(PC); $00661E
        DC.W    $4EBA,$1A0E         ; JSR     $008032(PC); $006622
        DC.W    $4EFA,$352C         ; JMP     $009B54(PC); $006626
        MOVE.W  #$0000,$0006(A0)                ; $00662A
        MOVE.W  #$0000,$0074(A0)                ; $006630
        DC.W    $4EBA,$5138         ; JSR     $00B770(PC); $006636
        MOVEQ   #$00,D0                         ; $00663A
        MOVE.W  D0,$0044(A0)                    ; $00663C
        MOVE.W  D0,$0046(A0)                    ; $006640
        MOVE.W  D0,$004A(A0)                    ; $006644
        DC.W    $4EBA,$E3C2         ; JSR     $004A0C(PC); $006648
        DC.W    $4EBA,$1F4C         ; JSR     $00859A(PC); $00664C
        DC.W    $4EBA,$3CFE         ; JSR     $00A350(PC); $006650
        DC.W    $4EBA,$1B1A         ; JSR     $008170(PC); $006654
        DC.W    $4EBA,$1A72         ; JSR     $0080CC(PC); $006658
        DC.W    $4EBA,$1EEA         ; JSR     $008548(PC); $00665C
        DC.W    $4EBA,$2E98         ; JSR     $0094FA(PC); $006660
        CMPI.W  #$0004,(-15764).W               ; $006664
        BEQ.S  .loc_00D4                        ; $00666A
        DC.W    $4EBA,$2CA4         ; JSR     $009312(PC); $00666C
.loc_00D4:
        DC.W    $4EBA,$34A0         ; JSR     $009B12(PC); $006670
        DC.W    $4EBA,$2B0C         ; JSR     $009182(PC); $006674
        DC.W    $4EBA,$3188         ; JSR     $009802(PC); $006678
        DC.W    $4EBA,$0A06         ; JSR     $007084(PC); $00667C
        DC.W    $4EBA,$0A28         ; JSR     $0070AA(PC); $006680
        DC.W    $4EBA,$1190         ; JSR     $007816(PC); $006684
        SUBQ.W  #1,(-16340).W                   ; $006688
        BGT.S  .loc_0104                        ; $00668C
        MOVE.W  #$0000,(-16340).W               ; $00668E
        MOVE.W  #$0000,$0074(A0)                ; $006694
        MOVE.W  (-16244).W,(-16262).W           ; $00669A
.loc_0104:
        DC.W    $4EBA,$15AC         ; JSR     $007C4E(PC); $0066A0
        DC.W    $4EBA,$0AA4         ; JSR     $00714A(PC); $0066A4
        DC.W    $4EBA,$0FA4         ; JSR     $00764E(PC); $0066A8
        DC.W    $4EBA,$1984         ; JSR     $008032(PC); $0066AC
        DC.W    $4EFA,$34A2         ; JMP     $009B54(PC); $0066B0
        DC.W    $4EBA,$50BA         ; JSR     $00B770(PC); $0066B4
        MOVEQ   #$00,D0                         ; $0066B8
        MOVE.W  D0,$0044(A0)                    ; $0066BA
        MOVE.W  D0,$0046(A0)                    ; $0066BE
        MOVE.W  D0,$004A(A0)                    ; $0066C2
        DC.W    $4EBA,$1ED2         ; JSR     $00859A(PC); $0066C6
        DC.W    $4EBA,$3C84         ; JSR     $00A350(PC); $0066CA
        DC.W    $4EBA,$1AA0         ; JSR     $008170(PC); $0066CE
        DC.W    $4EBA,$19F8         ; JSR     $0080CC(PC); $0066D2
        DC.W    $4EBA,$1E70         ; JSR     $008548(PC); $0066D6
        DC.W    $4EBA,$3126         ; JSR     $009802(PC); $0066DA
        DC.W    $4EBA,$179A         ; JSR     $007E7A(PC); $0066DE
        DC.W    $4EBA,$08B4         ; JSR     $006F98(PC); $0066E2
        DC.W    $4EBA,$15F0         ; JSR     $007CD8(PC); $0066E6
        DC.W    $4EBA,$3D48         ; JSR     $00A434(PC); $0066EA
        DC.W    $4EBA,$09BA         ; JSR     $0070AA(PC); $0066EE
        DC.W    $4EBA,$155A         ; JSR     $007C4E(PC); $0066F2
        DC.W    $4EBA,$0A52         ; JSR     $00714A(PC); $0066F6
        DC.W    $4EBA,$0F52         ; JSR     $00764E(PC); $0066FA
        DC.W    $4EBA,$1932         ; JSR     $008032(PC); $0066FE
        DC.W    $4EBA,$2F1A         ; JSR     $00961E(PC); $006702
        DC.W    $4EBA,$41F0         ; JSR     $00A8F8(PC); $006706
        BTST    #4,(-15602).W                   ; $00670A
        BEQ.S  .loc_017C                        ; $006710
        MOVE.W  (-16244).W,(-16262).W           ; $006712
.loc_017C:
        RTS                                     ; $006718
