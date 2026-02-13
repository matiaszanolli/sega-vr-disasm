; ============================================================================
; fn_2200_026 — Object Render Dispatcher
; ROM Range: $002BB0-$002C9A (234 bytes)
; ============================================================================
; Dispatches object rendering pipeline for both players. Two entry points:
;   $002BB0: Player 1 (A0=$FF9000, A1=$FF6100, A2=$FF6330)
;   $002C04: Player 2 (A0=$FF9F00, A1=$FF6330, A2=$FF6100)
;
; For each player, checks if rendering is paused ($C3AE bit 5), then:
;   - Normal path: obj_render_check → camera_calc → texture_select → finish
;   - Alt path (no camera): position_copy → finish
;   - Paused path: sets visibility=2, obj_flags_set → render_flags → texture
;
; Also includes render visibility subroutine ($002C58) that checks entity
; +$C0 (render state), ghost mode (-$600C/-$B4FC), and flag bit 3 at +$E5.
;
; Uses: D0, A0, A1, A2
; Calls:
;   $002C58: render_visibility_check (internal)
;   $002CDC: camera_param_calc_c (JSR PC-relative)
;   $002DCA/$002E34: texture_select (JSR PC-relative)
;   $002F04: position_copy (JSR PC-relative)
;   $003010: render_flags_set (JSR PC-relative)
;   $003130: obj_flags_set (JSR PC-relative)
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
