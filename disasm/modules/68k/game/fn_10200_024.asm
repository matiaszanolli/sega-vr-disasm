; ============================================================================
; Name Entry Mode Select + Input Handler
; ROM Range: $011240-$01141A (474 bytes)
; ============================================================================
; Category: game
; Purpose: DMA + object_update + sprite_update, then 4 sh2_send_cmd
;   transfers (score display, scroll view, time digits, status bar).
;   If $A042 flag clear: 3 additional DMA transfers for name display.
;   Input handler reads P1 controller ($C86C):
;     Action buttons (A/B/C): play SFX $A8, enable display flags,
;       SH2 transition, action_state = 2.
;     Start button (bit 4): toggle mode flag $A019 (0↔1),
;       if $A019 was set or $A042 active: full SH2 transition instead.
;     Left (bit 2): clear $A019 if set, play SFX $A9.
;     Right (bit 3): set $A019 if clear, play SFX $A9.
;   Action state machine (same pattern as fn_10200_026):
;     State 1: wait for bit 6 clear, State 2: wait for bit 7 clear → advance.
;   Calls fn_10200_041 ($0119B8) on revert path.
;
; Uses: D0, D1, D2, A0, A1, A2
; RAM:
;   $A019: mode toggle flag (byte)
;   $A042: display mode flag (word)
;   $A046: time digit buffer (address via LEA)
;   $A05C: action state (word, 0/1/2)
;   $C80E: display control (byte, bits 6/7)
;   $C809: display enable A (byte)
;   $C80A: display enable B (byte)
;   $C802: display enable C (byte)
;   $C86C: controller P1 data (word)
;   $C87E: game_state (word)
;   $C8A4: sound effect (byte)
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
;   $0118D4: time_digit_render
;   $0119B8: fn_10200_041 (cursor update)
;   $0088179E: controller_poll
;   $0088205E: SH2 scene transition
;   $0088FB36: SH2 completion check
; ============================================================================

fn_10200_024:
        clr.w   D0                              ; $011240  mode = 0
        dc.w    $4EBA,$D2E8                     ; $011242  bsr.w dma_transfer ($00E52C)
        dc.w    $4EBA,$A43C                     ; $011246  bsr.w object_update ($00B684)
        dc.w    $4EBA,$A48E                     ; $01124A  bsr.w sprite_update ($00B6DA)
; --- SH2 DMA: score display ---
        movea.l #$06018F80,A0                   ; $01124E  source
        movea.l #$0400E038,A1                   ; $011254  dest
        move.w  #$00D8,D0                       ; $01125A  size = $D8
        move.w  #$0010,D1                       ; $01125E  width = $10
        dc.w    $4EBA,$D0F6                     ; $011262  bsr.w sh2_send_cmd ($00E35A)
; --- SH2 DMA: scroll view ---
        movea.l #$06028000,A0                   ; $011266  source
        movea.l #$04010038,A1                   ; $01126C  dest
        move.w  #$00D8,D0                       ; $011272  size = $D8
        move.w  #$0050,D1                       ; $011276  width = $50
        dc.w    $4EBA,$D0DE                     ; $01127A  bsr.w sh2_send_cmd ($00E35A)
; --- time digit render ---
        lea     $0402C090,A1                    ; $01127E  dest for digits
        lea     ($FFFFA046).w,A2                ; $011284  A2 = time digit buffer
        dc.w    $4EBA,$064A                     ; $011288  bsr.w time_digit_render ($0118D4)
; --- SH2 DMA: status bar ---
        movea.l #$06018C00,A0                   ; $01128C  source
        movea.l #$0400C048,A1                   ; $011292  dest
        move.w  #$0038,D0                       ; $011298  size = $38
        move.w  #$0010,D1                       ; $01129C  width = $10
        dc.w    $4EBA,$D0B8                     ; $0112A0  bsr.w sh2_send_cmd ($00E35A)
; --- conditional: name display DMA (if $A042 == 0) ---
        tst.w   ($FFFFA042).w                   ; $0112A4  display mode active?
        bne.w   .check_action_state             ; $0112A8  yes → skip name DMA
        movea.l #$0601A200,A0                   ; $0112AC  source A
        movea.l #$0401B030,A1                   ; $0112B2  dest A
        move.w  #$0080,D0                       ; $0112B8  size = $80
        move.w  #$0010,D1                       ; $0112BC  width = $10
        dc.w    $4EBA,$D098                     ; $0112C0  bsr.w sh2_send_cmd ($00E35A)
        movea.l #$0601AA00,A0                   ; $0112C4  source B
        movea.l #$0401B0D0,A1                   ; $0112CA  dest B
        move.w  #$0018,D0                       ; $0112D0  size = $18
        move.w  #$0010,D1                       ; $0112D4  width = $10
        dc.w    $4EBA,$D080                     ; $0112D8  bsr.w sh2_send_cmd ($00E35A)
        movea.l #$0601AB80,A0                   ; $0112DC  source C
        movea.l #$0401B100,A1                   ; $0112E2  dest C
        move.w  #$0018,D0                       ; $0112E8  size = $18
        move.w  #$0010,D1                       ; $0112EC  width = $10
        dc.w    $4EBA,$D068                     ; $0112F0  bsr.w sh2_send_cmd ($00E35A)
; --- action state machine ---
.check_action_state:
        cmpi.w  #$0001,($FFFFA05C).w            ; $0112F4  action state == 1?
        beq.w   .sh2_check_bit6                 ; $0112FA  yes → check SH2
        cmpi.w  #$0002,($FFFFA05C).w            ; $0112FE  action state == 2?
        beq.w   .sh2_check_bit7                 ; $011304  yes → check SH2
; --- poll controllers ---
        jsr     $0088179E                       ; $011308  controller_poll
        move.w  ($FFFFC86C).w,D1                ; $01130E  D1 = P1 controller
        move.w  D1,D2                           ; $011312  D2 = copy
        andi.b  #$E0,D2                         ; $011314  mask A/B/C buttons
        beq.s   .check_start                    ; $011318  none → check start
; --- A/B/C confirm ---
        move.b  #$A8,($FFFFC8A4).w              ; $01131A  play SFX $A8
        move.b  #$01,($FFFFC809).w              ; $011320  enable display A
        move.b  #$01,($FFFFC80A).w              ; $011326  enable display B
        bset    #7,($FFFFC80E).w                ; $01132C  set display control
        move.b  #$01,($FFFFC802).w              ; $011332  enable display C
        jsr     $0088205E                       ; $011338  SH2 scene transition
        move.w  #$0002,($FFFFA05C).w            ; $01133E  action_state = 2
        bra.w   .revert_state                   ; $011344
; --- start button handler ---
.check_start:
        btst    #4,D1                           ; $011348  start pressed?
        beq.s   .check_left                     ; $01134C  no → check left
        tst.b   ($FFFFA019).w                   ; $01134E  mode flag set?
        bne.w   .start_transition               ; $011352  yes → full transition
        tst.w   ($FFFFA042).w                   ; $011356  display mode active?
        bne.w   .start_transition               ; $01135A  yes → full transition
        move.b  #$A9,($FFFFC8A4).w              ; $01135E  play SFX $A9
        move.b  #$01,($FFFFA019).w              ; $011364  set mode flag
        bra.w   .revert_state                   ; $01136A
.start_transition:
        move.b  #$A8,($FFFFC8A4).w              ; $01136E  play SFX $A8
        move.b  #$01,($FFFFC809).w              ; $011374  enable display A
        move.b  #$01,($FFFFC80A).w              ; $01137A  enable display B
        bset    #7,($FFFFC80E).w                ; $011380  set display control
        move.b  #$01,($FFFFC802).w              ; $011386  enable display C
        jsr     $0088205E                       ; $01138C  SH2 scene transition
        move.w  #$0002,($FFFFA05C).w            ; $011392  action_state = 2
        bra.w   .revert_state                   ; $011398
; --- D-pad left/right: toggle mode ---
.check_left:
        tst.w   ($FFFFA042).w                   ; $01139C  display mode active?
        bne.s   .revert_state                   ; $0113A0  yes → no toggle
        btst    #2,D1                           ; $0113A2  left pressed?
        beq.s   .check_right                    ; $0113A6  no → check right
        tst.b   ($FFFFA019).w                   ; $0113A8  mode flag set?
        beq.w   .revert_state                   ; $0113AC  no → nothing to clear
        move.b  #$A9,($FFFFC8A4).w              ; $0113B0  play SFX $A9
        clr.b   ($FFFFA019).w                   ; $0113B6  clear mode flag
        bra.w   .revert_state                   ; $0113BA
.check_right:
        btst    #3,D1                           ; $0113BE  right pressed?
        beq.s   .revert_state                   ; $0113C2  no → revert
        tst.b   ($FFFFA019).w                   ; $0113C4  mode flag already set?
        bne.w   .revert_state                   ; $0113C8  yes → nothing to do
        move.b  #$A9,($FFFFC8A4).w              ; $0113CC  play SFX $A9
        move.b  #$01,($FFFFA019).w              ; $0113D2  set mode flag
        bra.w   .revert_state                   ; $0113D8
; --- SH2 completion checks ---
.sh2_check_bit6:
        jsr     $0088FB36                       ; $0113DC  SH2 completion check
        btst    #6,($FFFFC80E).w                ; $0113E2  display bit 6 set?
        bne.s   .revert_state                   ; $0113E8  yes → revert
        clr.w   ($FFFFA05C).w                   ; $0113EA  clear action state
        bra.w   .revert_state                   ; $0113EE
.sh2_check_bit7:
        jsr     $0088FB36                       ; $0113F2  SH2 completion check
        btst    #7,($FFFFC80E).w                ; $0113F8  display bit 7 set?
        bne.s   .revert_state                   ; $0113FE  yes → revert
        clr.w   ($FFFFA05C).w                   ; $011400  clear action state
        addq.w  #4,($FFFFC87E).w                ; $011404  advance game_state
        bra.w   .set_display                    ; $011408
; --- epilogue ---
.revert_state:
        dc.w    $6100,$05AA                     ; $01140C  bsr.w fn_10200_041 ($0119B8)
.set_display:
        move.w  #$0018,$00FF0008                ; $011410  display mode = $0018
        rts                                     ; $011418
