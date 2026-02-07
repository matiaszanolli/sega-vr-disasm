; ============================================================================
; Obj Tile Position Calc 035 (auto-analyzed)
; ROM Range: $00789C-$007A40 (420 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 6 subroutines
;   Calls: tile_position_calc, angle_normalize, velocity_apply, sprite_list_process
;   Object (A0, A2, A4): +$04 (speed_index/velocity), +$18, +$30 (x_position), +$34 (y_position), +$40 (heading_angle), +$46 (display_scale)
;
; Entry: A0 = object/entity pointer
; Entry: A2 = object/entity pointer
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D2, A0, A1, A2, A3, A4
; Calls:
;   $0073E8: tile_position_calc
;   $00748C: angle_normalize
;   $0074A4: sprite_list_process
;   $007534: velocity_apply
;   $007A40: obj_type_dispatch
; Object fields:
;   +$04: speed_index/velocity
;   +$18: [unknown]
;   +$30: x_position
;   +$34: y_position
;   +$40: heading_angle
;   +$46: display_scale
;   +$55: [unknown]
;   +$56: [unknown]
; Confidence: high
; ============================================================================

fn_6200_035:
        MOVE.B  #$00,(-15590).W                 ; $00789C
        MOVE.W  $0040(A0),D0                    ; $0078A2
        ADD.W  $0046(A0),D0                     ; $0078A6
        DC.W    $4EBA,$FDF6         ; JSR     $0076A2(PC); $0078AA
        MOVE.W  $0030(A0),D1                    ; $0078AE
        MOVE.W  $0034(A0),D2                    ; $0078B2
        DC.W    $4EBA,$FB30         ; JSR     $0073E8(PC); $0078B6
        MOVE.L  A1,(A4)                         ; $0078BA
        DC.W    $4EBA,$FBCE         ; JSR     $00748C(PC); $0078BC
        BNE.S  .loc_0036                        ; $0078C0
        MOVE.L  #$00000000,(A4)                 ; $0078C2
        MOVE.L  #$00000000,$0004(A4)            ; $0078C8
        BRA.S  .loc_004E                        ; $0078D0
.loc_0036:
        MOVE.L  A2,$0004(A4)                    ; $0078D2
        MOVE.L  A2,$00CE(A0)                    ; $0078D6
        MOVE.B  $0018(A2),D0                    ; $0078DA
        MOVE.B  D0,(-15591).W                   ; $0078DE
        MOVE.W  D1,(-16176).W                   ; $0078E2
        MOVE.W  D2,(-16174).W                   ; $0078E6
.loc_004E:
        MOVE.W  $0030(A0),D1                    ; $0078EA
        ADD.W  (-16338).W,D1                    ; $0078EE
        MOVE.W  $0034(A0),D2                    ; $0078F2
        ADD.W  (-16334).W,D2                    ; $0078F6
        MOVE.B  #$01,$0056(A0)                  ; $0078FA
        DC.W    $4EBA,$FAE6         ; JSR     $0073E8(PC); $007900
        MOVE.L  (A4),D0                         ; $007904
        BEQ.S  .loc_0084                        ; $007906
        CMPA.L  D0,A1                           ; $007908
        BNE.S  .loc_0084                        ; $00790A
        MOVEA.L A1,A3                           ; $00790C
        MOVEA.L $0004(A4),A1                    ; $00790E
        DC.W    $4EBA,$FC20         ; JSR     $007534(PC); $007912
        BNE.S  .loc_008A                        ; $007916
        MOVEA.L A3,A1                           ; $007918
        DC.W    $4EBA,$FB88         ; JSR     $0074A4(PC); $00791A
        BRA.S  .loc_0088                        ; $00791E
.loc_0084:
        DC.W    $4EBA,$FB6A         ; JSR     $00748C(PC); $007920
.loc_0088:
        BEQ.S  .loc_009E                        ; $007924
.loc_008A:
        MOVE.L  A2,$00D2(A0)                    ; $007926
        MOVE.W  D1,(-16172).W                   ; $00792A
        MOVE.W  D2,(-16170).W                   ; $00792E
        DC.W    $4EBA,$010C         ; JSR     $007A40(PC); $007932
        MOVE.B  D0,$0056(A0)                    ; $007936
.loc_009E:
        MOVE.W  $0030(A0),D1                    ; $00793A
        ADD.W  (-16332).W,D1                    ; $00793E
        MOVE.W  $0034(A0),D2                    ; $007942
        ADD.W  (-16328).W,D2                    ; $007946
        MOVE.B  #$01,$0057(A0)                  ; $00794A
        DC.W    $4EBA,$FA96         ; JSR     $0073E8(PC); $007950
        MOVE.L  (A4),D0                         ; $007954
        BEQ.S  .loc_00D4                        ; $007956
        CMPA.L  D0,A1                           ; $007958
        BNE.S  .loc_00D4                        ; $00795A
        MOVEA.L A1,A3                           ; $00795C
        MOVEA.L $0004(A4),A1                    ; $00795E
        DC.W    $4EBA,$FBD0         ; JSR     $007534(PC); $007962
        BNE.S  .loc_00DA                        ; $007966
        MOVEA.L A3,A1                           ; $007968
        DC.W    $4EBA,$FB38         ; JSR     $0074A4(PC); $00796A
        BRA.S  .loc_00D8                        ; $00796E
.loc_00D4:
        DC.W    $4EBA,$FB1A         ; JSR     $00748C(PC); $007970
.loc_00D8:
        BEQ.S  .loc_00EE                        ; $007974
.loc_00DA:
        MOVE.L  A2,$00D6(A0)                    ; $007976
        MOVE.W  D1,(-16168).W                   ; $00797A
        MOVE.W  D2,(-16166).W                   ; $00797E
        DC.W    $4EBA,$00BC         ; JSR     $007A40(PC); $007982
        MOVE.B  D0,$0057(A0)                    ; $007986
.loc_00EE:
        MOVE.W  $0030(A0),D1                    ; $00798A
        ADD.W  (-16326).W,D1                    ; $00798E
        MOVE.W  $0034(A0),D2                    ; $007992
        ADD.W  (-16322).W,D2                    ; $007996
        MOVE.B  #$01,$0058(A0)                  ; $00799A
        DC.W    $4EBA,$FA46         ; JSR     $0073E8(PC); $0079A0
        MOVE.L  (A4),D0                         ; $0079A4
        BEQ.S  .loc_0124                        ; $0079A6
        CMPA.L  D0,A1                           ; $0079A8
        BNE.S  .loc_0124                        ; $0079AA
        MOVEA.L A1,A3                           ; $0079AC
        MOVEA.L $0004(A4),A1                    ; $0079AE
        DC.W    $4EBA,$FB80         ; JSR     $007534(PC); $0079B2
        BNE.S  .loc_012A                        ; $0079B6
        MOVEA.L A3,A1                           ; $0079B8
        DC.W    $4EBA,$FAE8         ; JSR     $0074A4(PC); $0079BA
        BRA.S  .loc_0128                        ; $0079BE
.loc_0124:
        DC.W    $4EBA,$FACA         ; JSR     $00748C(PC); $0079C0
.loc_0128:
        BEQ.S  .loc_013E                        ; $0079C4
.loc_012A:
        MOVE.L  A2,$00DA(A0)                    ; $0079C6
        MOVE.W  D1,(-16164).W                   ; $0079CA
        MOVE.W  D2,(-16162).W                   ; $0079CE
        DC.W    $4EBA,$006C         ; JSR     $007A40(PC); $0079D2
        MOVE.B  D0,$0058(A0)                    ; $0079D6
.loc_013E:
        MOVE.W  $0030(A0),D1                    ; $0079DA
        ADD.W  (-16320).W,D1                    ; $0079DE
        MOVE.W  $0034(A0),D2                    ; $0079E2
        ADD.W  (-16316).W,D2                    ; $0079E6
        MOVE.B  #$01,$0059(A0)                  ; $0079EA
        DC.W    $4EBA,$F9F6         ; JSR     $0073E8(PC); $0079F0
        MOVE.L  (A4),D0                         ; $0079F4
        BEQ.S  .loc_0174                        ; $0079F6
        CMPA.L  D0,A1                           ; $0079F8
        BNE.S  .loc_0174                        ; $0079FA
        MOVEA.L A1,A3                           ; $0079FC
        MOVEA.L $0004(A4),A1                    ; $0079FE
        DC.W    $4EBA,$FB30         ; JSR     $007534(PC); $007A02
        BNE.S  .loc_017A                        ; $007A06
        MOVEA.L A3,A1                           ; $007A08
        DC.W    $4EBA,$FA98         ; JSR     $0074A4(PC); $007A0A
        BRA.S  .loc_0178                        ; $007A0E
.loc_0174:
        DC.W    $4EBA,$FA7A         ; JSR     $00748C(PC); $007A10
.loc_0178:
        BEQ.S  .loc_018E                        ; $007A14
.loc_017A:
        MOVE.L  A2,$00DE(A0)                    ; $007A16
        MOVE.W  D1,(-16160).W                   ; $007A1A
        MOVE.W  D2,(-16158).W                   ; $007A1E
        DC.W    $4EBA,$001C         ; JSR     $007A40(PC); $007A22
        MOVE.B  D0,$0059(A0)                    ; $007A26
.loc_018E:
        MOVE.B  $0056(A0),D0                    ; $007A2A
        OR.B   $0057(A0),D0                     ; $007A2E
        OR.B   $0058(A0),D0                     ; $007A32
        OR.B   $0059(A0),D0                     ; $007A36
        MOVE.B  D0,$0055(A0)                    ; $007A3A
        RTS                                     ; $007A3E
