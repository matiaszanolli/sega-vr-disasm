; ============================================================================
; Obj Render Check 026 (auto-analyzed)
; ROM Range: $002BB0-$002C9A (234 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 8 subroutines
;   RAM: $9F00 (obj_table_3)
;   Calls: obj_transform_copy, obj_texture_select, obj_position_copy, obj_render_flags_set
;   Object (A0, A1): +$14 (effect_duration), +$28, +$3C (heading_mirror), +$50, +$C0 (render_flags), +$E4
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1, A2
; RAM:
;   $9F00: obj_table_3
; Calls:
;   $002C9A: obj_render_check
;   $002CDC: obj_transform_copy
;   $002DCA: obj_texture_select
;   $002F04: obj_position_copy
;   $003010: obj_render_flags_set
; Object fields:
;   +$14: effect_duration
;   +$28: [unknown]
;   +$3C: heading_mirror
;   +$50: [unknown]
;   +$C0: render_flags
;   +$E4: [unknown]
;   +$E5: [unknown]
; Confidence: high
; ============================================================================

fn_2200_026:
        LEA     (-28672).W,A0                   ; $002BB0
        LEA     $00FF6100,A1                    ; $002BB4
        LEA     $00FF6330,A2                    ; $002BBA
        BTST    #5,(-15602).W                   ; $002BC0
        BNE.S  .loc_0036                        ; $002BC6
        DC.W    $4EBA,$008E         ; JSR     $002C58(PC); $002BC8
        TST.W  (-16308).W                       ; $002BCC
        BNE.S  .loc_002E                        ; $002BD0
        DC.W    $4EBA,$0108         ; JSR     $002CDC(PC); $002BD2
        DC.W    $4EBA,$01F2         ; JSR     $002DCA(PC); $002BD6
        DC.W    $4EFA,$02EA         ; JMP     $002EC6(PC); $002BDA
.loc_002E:
        DC.W    $4EBA,$0324         ; JSR     $002F04(PC); $002BDE
        DC.W    $4EFA,$02BA         ; JMP     $002E9E(PC); $002BE2
.loc_0036:
        MOVEQ   #$02,D0                         ; $002BE6
        MOVE.W  D0,$0014(A1)                    ; $002BE8
        MOVE.W  D0,$0028(A1)                    ; $002BEC
        MOVE.W  D0,$003C(A1)                    ; $002BF0
        MOVE.W  D0,$0050(A1)                    ; $002BF4
        DC.W    $4EBA,$0536         ; JSR     $003130(PC); $002BF8
        DC.W    $4EBA,$0412         ; JSR     $003010(PC); $002BFC
        DC.W    $4EFA,$01C8         ; JMP     $002DCA(PC); $002C00
        LEA     (-24832).W,A0                   ; $002C04
        LEA     $00FF6330,A1                    ; $002C08
        LEA     $00FF6100,A2                    ; $002C0E
        BTST    #5,(-15602).W                   ; $002C14
        BNE.S  .loc_008A                        ; $002C1A
        DC.W    $4EBA,$007C         ; JSR     $002C9A(PC); $002C1C
        TST.W  (-16308).W                       ; $002C20
        BNE.S  .loc_0082                        ; $002C24
        DC.W    $4EBA,$00B4         ; JSR     $002CDC(PC); $002C26
        DC.W    $4EBA,$0208         ; JSR     $002E34(PC); $002C2A
        DC.W    $4EFA,$0296         ; JMP     $002EC6(PC); $002C2E
.loc_0082:
        DC.W    $4EBA,$02D0         ; JSR     $002F04(PC); $002C32
        DC.W    $4EFA,$027A         ; JMP     $002EB2(PC); $002C36
.loc_008A:
        MOVEQ   #$02,D0                         ; $002C3A
        MOVE.W  D0,$0014(A1)                    ; $002C3C
        MOVE.W  D0,$0028(A1)                    ; $002C40
        MOVE.W  D0,$003C(A1)                    ; $002C44
        MOVE.W  D0,$0050(A1)                    ; $002C48
        DC.W    $4EBA,$04E2         ; JSR     $003130(PC); $002C4C
        DC.W    $4EBA,$03BE         ; JSR     $003010(PC); $002C50
        DC.W    $4EFA,$01DE         ; JMP     $002E34(PC); $002C54
        MOVEQ   #$00,D0                         ; $002C58
        TST.W  $00C0(A0)                        ; $002C5A
        BEQ.S  .loc_00D8                        ; $002C5E
        MOVEQ   #$01,D0                         ; $002C60
        TST.B  (-24604).W                       ; $002C62
        BNE.S  .loc_00BE                        ; $002C66
        TST.B  (-19204).W                       ; $002C68
        BEQ.S  .loc_00CA                        ; $002C6C
.loc_00BE:
        BTST    #3,$00E5(A0)                    ; $002C6E
        BEQ.S  .loc_00D8                        ; $002C74
.loc_00C6:
        MOVEQ   #$00,D0                         ; $002C76
        BRA.S  .loc_00D8                        ; $002C78
.loc_00CA:
        BTST    #3,(-24603).W                   ; $002C7A
        BEQ.S  .loc_00D8                        ; $002C80
        TST.B  $00E4(A0)                        ; $002C82
        BNE.S  .loc_00C6                        ; $002C86
.loc_00D8:
        MOVE.W  D0,$0118(A2)                    ; $002C88
        MOVE.W  D0,$012C(A2)                    ; $002C8C
        MOVE.W  D0,$0140(A2)                    ; $002C90
        MOVE.W  D0,$0154(A2)                    ; $002C94
        RTS                                     ; $002C98
