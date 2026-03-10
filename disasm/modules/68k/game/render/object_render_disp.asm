; ============================================================================
; object_render_disp — Object Render Dispatcher
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

object_render_disp:
        LEA     (-28672).W,A0                   ; $002BB0
        LEA     $00FF6100,A1                    ; $002BB4
        LEA     $00FF6330,A2                    ; $002BBA
        BTST    #5,(-15602).W                   ; $002BC0
        BNE.S  .render_paused_p1                  ; $002BC6
        jsr     object_render_disp+168(pc); $4EBA $008E
        TST.W  (-16308).W                       ; $002BCC
        BNE.S  .alt_path_p1                       ; $002BD0
        jsr     camera_param_calc_c(pc) ; $4EBA $0108
        jsr     object_param_8a_dispatch_002dca(pc); $4EBA $01F2
        jmp     object_field_clear(pc)  ; $4EFA $02EA
.alt_path_p1:
        jsr     camera_param_calc_d(pc) ; $4EBA $0324
        jmp     load_disp_list_pointer_002e9e(pc); $4EFA $02BA
.render_paused_p1:
        MOVEQ   #$02,D0                         ; $002BE6
        MOVE.W  D0,$0014(A1)                    ; $002BE8
        MOVE.W  D0,$0028(A1)                    ; $002BEC
        MOVE.W  D0,$003C(A1)                    ; $002BF0
        MOVE.W  D0,$0050(A1)                    ; $002BF4
        jsr     vdp_buffer_xfer_camera_offset_apply+10(pc); $4EBA $0536
        jsr     object_pos_copy_with_render_flags(pc); $4EBA $0412
        jmp     object_param_8a_dispatch_002dca(pc); $4EFA $01C8
        LEA     (-24832).W,A0                   ; $002C04
        LEA     $00FF6330,A1                    ; $002C08
        LEA     $00FF6100,A2                    ; $002C0E
        BTST    #5,(-15602).W                   ; $002C14
        BNE.S  .render_paused_p2                  ; $002C1A
        jsr     entity_visibility_check(pc); $4EBA $007C
        TST.W  (-16308).W                       ; $002C20
        BNE.S  .alt_path_p2                       ; $002C24
        jsr     camera_param_calc_c(pc) ; $4EBA $00B4
        jsr     object_param_8a_dispatch_002e34(pc); $4EBA $0208
        jmp     object_field_clear(pc)  ; $4EFA $0296
.alt_path_p2:
        jsr     camera_param_calc_d(pc) ; $4EBA $02D0
        jmp     load_disp_list_pointer_002eb2(pc); $4EFA $027A
.render_paused_p2:
        MOVEQ   #$02,D0                         ; $002C3A
        MOVE.W  D0,$0014(A1)                    ; $002C3C
        MOVE.W  D0,$0028(A1)                    ; $002C40
        MOVE.W  D0,$003C(A1)                    ; $002C44
        MOVE.W  D0,$0050(A1)                    ; $002C48
        jsr     vdp_buffer_xfer_camera_offset_apply+10(pc); $4EBA $04E2
        jsr     object_pos_copy_with_render_flags(pc); $4EBA $03BE
        jmp     object_param_8a_dispatch_002e34(pc); $4EFA $01DE
        MOVEQ   #$00,D0                         ; $002C58
        TST.W  $00C0(A0)                        ; $002C5A
        BEQ.S  .store_visibility                   ; $002C5E
        MOVEQ   #$01,D0                         ; $002C60
        TST.B  (-24604).W                       ; $002C62
        BNE.S  .check_flag_bit3                   ; $002C66
        TST.B  (-19204).W                       ; $002C68
        BEQ.S  .check_ghost_alt                   ; $002C6C
.check_flag_bit3:
        BTST    #3,$00E5(A0)                    ; $002C6E
        BEQ.S  .store_visibility                   ; $002C74
.force_invisible:
        MOVEQ   #$00,D0                         ; $002C76
        BRA.S  .store_visibility                 ; $002C78
.check_ghost_alt:
        BTST    #3,(-24603).W                   ; $002C7A
        BEQ.S  .store_visibility                   ; $002C80
        TST.B  $00E4(A0)                        ; $002C82
        BNE.S  .force_invisible                   ; $002C86
.store_visibility:
        MOVE.W  D0,$0118(A2)                    ; $002C88
        MOVE.W  D0,$012C(A2)                    ; $002C8C
        MOVE.W  D0,$0140(A2)                    ; $002C90
        MOVE.W  D0,$0154(A2)                    ; $002C94
        RTS                                     ; $002C98
