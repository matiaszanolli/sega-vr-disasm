; ============================================================================
; Camera View Toggle 020
; ROM Range: $0088BE-$00896E (176 bytes)
; ============================================================================
; Category: game
; Purpose: Toggles camera view mode and configures rendering parameters
;   Button press (bits 5-6) toggles view flag
;   When view active: computes zoom, scroll speed, and position from speed
;   Two speed ranges with different scaling formulas
;
; Uses: D0, D1, A0
; RAM:
;   $C86D: button_raw
;   $C86C: button_state
;   $C313: view_toggle
;   $9000: view_config_base
;   $C0C8: view_active
;   $C8E0: zoom_level
;   $C8D8: view_speed
;   $C8D4: scroll_rate
;   $C8D6: scroll_speed
;   $C0AE: render_distance
;   $C0B0: render_param_a
;   $C0B2: render_param_b
;   $C054: track_pos_hi
;   $C056: track_pos_lo
;   $C0C6: render_angle
;   $C0BA: waypoint_x
; Confidence: medium
; ============================================================================

camera_view_toggle_020:
        move.b  ($FFFFC86D).w,D0                ; $0088BE  D0 = button_raw
        andi.b  #$60,D0                         ; $0088C2  isolate bits 5-6
        beq.s   .setup_view                     ; $0088C6  none → skip toggle
        bchg    #0,($FFFFC313).w                ; $0088C8  flip view_toggle
.setup_view:
        lea     ($FFFF9000).w,A0                ; $0088CE  A0 → view_config_base
        btst    #0,($FFFFC313).w                ; $0088D2  view_toggle on?
        dc.w    $6700,$00EA         ; BEQ.W   $0089C4    ; $0088D8  no → external handler
        bset    #3,($FFFFC313).w                ; $0088DC  view_toggle |= bit 3
        move.w  #$0000,($FFFFC0C8).w            ; $0088E2  view_active = 0
; --- check button state ---
        btst    #0,($FFFFC86C).w                ; $0088E8  button_state bit 0?
        dc.w    $667E               ; BNE.S   $00896E    ; $0088EE  yes → exit (next fn)
        btst    #1,($FFFFC86C).w                ; $0088F0  button_state bit 1?
        dc.w    $6600,$00A0         ; BNE.W   $008998    ; $0088F6  yes → external handler
; --- compute view parameters from speed ---
        move.w  #$0010,($FFFFC8E0).w            ; $0088FA  zoom_level = 16
        move.w  ($FFFFC8D8).w,D0                ; $008900  D0 = view_speed
        cmpi.w  #$3000,D0                       ; $008904  speed > $3000?
        bgt.s   .high_speed                     ; $008908  yes → high speed path
        beq.s   .set_vdp                        ; $00890A  equal → skip calc
; --- low speed: compute scroll_rate from speed ---
        move.w  #$07D0,($FFFFC8D4).w            ; $00890C  scroll_rate = 2000
        move.w  #$0200,$00FF60CC                ; $008912  VDP reg = $200
        lsr.w   #3,D0                           ; $00891A  D0 >>= 3
        subi.w  #$00A0,D0                       ; $00891C  D0 -= 160
        move.w  D0,($FFFFC8D6).w                ; $008920  scroll_speed = D0
        bra.s   .set_render                     ; $008924
.high_speed:
; --- high speed: compute scroll_rate from speed ---
        move.w  #$0600,($FFFFC8D6).w            ; $008926  scroll_speed = $600
        moveq   #$09,D1                         ; $00892C  D1 = 9
        lsr.w   D1,D0                           ; $00892E  D0 >>= 9
        neg.w   D0                              ; $008930  D0 = -D0
        addi.w  #$07D0,D0                       ; $008932  D0 = 2000 - (speed >> 9)
        move.w  D0,($FFFFC8D4).w                ; $008936  scroll_rate = D0
.set_vdp:
        move.w  #$0100,$00FF60CC                ; $00893A  VDP reg = $100
.set_render:
        move.w  ($FFFFC8D4).w,($FFFFC0AE).w    ; $008942  render_distance = scroll_rate
        move.w  #$0000,($FFFFC0B0).w            ; $008948  render_param_a = 0
        move.w  #$0000,($FFFFC0B2).w            ; $00894E  render_param_b = 0
        move.w  ($FFFFC8D6).w,($FFFFC054).w    ; $008954  track_pos_hi = scroll_speed
        move.w  ($FFFFC8D8).w,($FFFFC056).w    ; $00895A  track_pos_lo = view_speed
        move.w  #$0000,($FFFFC0C6).w            ; $008960  render_angle = 0
        move.w  #$0000,($FFFFC0BA).w            ; $008966  waypoint_x = 0
        rts                                     ; $00896C
