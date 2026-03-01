; ============================================================================
; Name Entry Dual Scroll View + Action Handler
; ROM Range: $011630-$0117F4 (452 bytes)
; ============================================================================
; Category: game
; Purpose: DMA + object_update + sprite_update, then sh2_send_cmd for
;   scroll view (source $26032000 + offset $A032, dest $240100A0).
;   Applies P1 scroll velocity ($A026→$A022, 3 steps, ±$200) and
;   P2 scroll velocity ($A036→$A032, 3 steps, ±$200).
;   P1 uses controller $C86C: action buttons → SH2 transition (state 2),
;     D-pad down/up → scroll P1 view.
;   P2 uses controller $C86E: same pattern for second scroll area.
;   Action state machine: state 1 checks bit 6, state 2 checks bit 7
;   of $C80E. Display mode $0018.
;
; Uses: D0, D1, D2, A0, A1
; RAM:
;   $A022: P1 scroll position (long)
;   $A026: P1 scroll velocity (long)
;   $A02A: P1 max scroll (long)
;   $A02E: P1 step counter (byte)
;   $A032: P2 scroll position (long)
;   $A036: P2 scroll velocity (long)
;   $A03A: P2 max scroll (long)
;   $A03E: P2 step counter (byte)
;   $A05C: action state (word, 0/1/2)
;   $C80E: display control (byte, bits 6/7)
;   $C809/$C80A/$C802: display enable flags
;   $C86C: controller P1 data (word)
;   $C86E: controller P2 data (word)
;   $C87E: game_state (word)
;   $C8A4: sound effect (byte)
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
;   $0088179E: controller_poll
;   $0088205E: SH2 scene transition
;   $0088FB36: SH2 completion check
; ============================================================================

name_entry_dual_scroll_view_action_handler:
        clr.w   D0                              ; $011630  mode = 0
        jsr     MemoryInit(pc)          ; $4EBA $CEF8
        jsr     object_update(pc)       ; $4EBA $A04C
        jsr     animated_seq_player+10(pc); $4EBA $A09E
; --- SH2 DMA: scroll view ---
        movea.l #$26032000,A0                   ; $01163E  source base
        move.l  ($FFFFA032).w,D0                ; $011644  D0 = P2 scroll offset
        adda.l  D0,A0                           ; $011648  A0 += offset
        movea.l #$240100A0,A1                   ; $01164A  dest
        move.w  #$0080,D0                       ; $011650  size = $80
        move.w  #$0050,D1                       ; $011654  width = $50
        jsr     sh2_send_cmd(pc)        ; $4EBA $CD00
; --- apply P1 scroll velocity ---
        tst.l   ($FFFFA026).w                   ; $01165C  P1 velocity active?
        beq.w   .check_action_state             ; $011660  no → check input
        move.l  ($FFFFA022).w,D0                ; $011664  D0 = P1 scroll position
        move.l  ($FFFFA026).w,D1                ; $011668  D1 = P1 velocity
        add.l   d1,d0                   ; $D081
        move.l  D0,($FFFFA022).w                ; $01166E  store new position
        subq.b  #1,($FFFFA02E).w                ; $011672  decrement P1 step counter
        bcc.w   .p2_scroll                      ; $011676  still stepping → P2
        clr.l   ($FFFFA026).w                   ; $01167A  clear P1 velocity (done)
; --- action state machine ---
.check_action_state:
        cmpi.w  #$0001,($FFFFA05C).w            ; $01167E  action state == 1?
        beq.w   .sh2_check_bit6                 ; $011684  yes → check SH2
        cmpi.w  #$0002,($FFFFA05C).w            ; $011688  action state == 2?
        beq.w   .sh2_check_bit7                 ; $01168E  yes → check SH2
; --- poll controllers ---
        jsr     $0088179E                       ; $011692  controller_poll
        move.w  ($FFFFC86C).w,D1                ; $011698  D1 = P1 controller
        move.w  D1,D2                           ; $01169C  D2 = copy
        andi.b  #$F0,D2                         ; $01169E  mask action buttons
        beq.s   .p1_check_dpad                  ; $0116A2  none → check D-pad
; --- P1 action confirm ---
        move.b  #$A8,($FFFFC8A4).w              ; $0116A4  play SFX $A8
        move.w  #$0002,($FFFFA05C).w            ; $0116AA  action_state = 2
        move.b  #$01,($FFFFC809).w              ; $0116B0  enable display A
        move.b  #$01,($FFFFC80A).w              ; $0116B6  enable display B
        bset    #7,($FFFFC80E).w                ; $0116BC  set display control
        move.b  #$01,($FFFFC802).w              ; $0116C2  enable display C
        jsr     $0088205E                       ; $0116C8  SH2 scene transition
        bra.w   .revert_state                   ; $0116CE
; --- P1 D-pad: scroll ---
.p1_check_dpad:
        lsr.w   #8,D1                           ; $0116D2  D1 = direction bits
        btst    #0,D1                           ; $0116D4  down pressed?
        beq.s   .p1_check_up                    ; $0116D8  no → check up
        tst.l   ($FFFFA022).w                   ; $0116DA  at minimum?
        ble.w   .p2_scroll                      ; $0116DE  yes → P2
        move.l  #$FFFFFE00,($FFFFA026).w        ; $0116E2  velocity = -$200
        move.b  #$03,($FFFFA02E).w              ; $0116EA  3 steps
        bra.w   .p2_scroll                      ; $0116F0
.p1_check_up:
        btst    #1,D1                           ; $0116F4  up pressed?
        beq.s   .p2_scroll                      ; $0116F8  no → P2
        move.l  ($FFFFA022).w,D0                ; $0116FA  D0 = scroll position
        cmp.l   ($FFFFA02A).w,D0                ; $0116FE  at max?
        bge.w   .p2_scroll                      ; $011702  yes → P2
        move.l  #$00000200,($FFFFA026).w        ; $011706  velocity = +$200
        move.b  #$03,($FFFFA02E).w              ; $01170E  3 steps
; --- P2 scroll velocity ---
.p2_scroll:
        tst.l   ($FFFFA036).w                   ; $011714  P2 velocity active?
        beq.w   .p2_input                       ; $011718  no → check P2 input
        move.l  ($FFFFA032).w,D0                ; $01171C  D0 = P2 scroll position
        move.l  ($FFFFA036).w,D1                ; $011720  D1 = P2 velocity
        add.l   d1,d0                   ; $D081
        move.l  D0,($FFFFA032).w                ; $011726  store new position
        subq.b  #1,($FFFFA03E).w                ; $01172A  decrement P2 step counter
        bcc.w   .revert_state                   ; $01172E  still stepping → revert
        clr.l   ($FFFFA036).w                   ; $011732  clear P2 velocity (done)
; --- P2 input ---
.p2_input:
        move.w  ($FFFFC86E).w,D1                ; $011736  D1 = P2 controller
        move.w  D1,D2                           ; $01173A  D2 = copy
        andi.b  #$F0,D2                         ; $01173C  mask action buttons
        beq.s   .p2_check_dpad                  ; $011740  none → check D-pad
; --- P2 action confirm ---
        move.b  #$A8,($FFFFC8A4).w              ; $011742  play SFX $A8
        move.w  #$0002,($FFFFA05C).w            ; $011748  action_state = 2
        move.b  #$01,($FFFFC809).w              ; $01174E  enable display A
        move.b  #$01,($FFFFC80A).w              ; $011754  enable display B
        bset    #7,($FFFFC80E).w                ; $01175A  set display control
        move.b  #$01,($FFFFC802).w              ; $011760  enable display C
        jsr     $0088205E                       ; $011766  SH2 scene transition
        bra.w   .revert_state                   ; $01176C
; --- P2 D-pad: scroll ---
.p2_check_dpad:
        lsr.w   #8,D1                           ; $011770  D1 = direction bits
        btst    #0,D1                           ; $011772  down pressed?
        beq.s   .p2_check_up                    ; $011776  no → check up
        tst.l   ($FFFFA032).w                   ; $011778  at minimum?
        ble.w   .revert_state                   ; $01177C  yes → revert
        move.l  #$FFFFFE00,($FFFFA036).w        ; $011780  velocity = -$200
        move.b  #$03,($FFFFA03E).w              ; $011788  3 steps
        bra.w   .revert_state                   ; $01178E
.p2_check_up:
        btst    #1,D1                           ; $011792  up pressed?
        beq.s   .revert_state                   ; $011796  no → revert
        move.l  ($FFFFA032).w,D0                ; $011798  D0 = scroll position
        cmp.l   ($FFFFA03A).w,D0                ; $01179C  at max?
        bge.w   .revert_state                   ; $0117A0  yes → revert
        move.l  #$00000200,($FFFFA036).w        ; $0117A4  velocity = +$200
        move.b  #$03,($FFFFA03E).w              ; $0117AC  3 steps
        bra.w   .revert_state                   ; $0117B2
; --- SH2 completion checks ---
.sh2_check_bit6:
        jsr     $0088FB36                       ; $0117B6  SH2 completion check
        btst    #6,($FFFFC80E).w                ; $0117BC  display bit 6 set?
        bne.s   .revert_state                   ; $0117C2  yes → revert
        clr.w   ($FFFFA05C).w                   ; $0117C4  clear action state
        bra.w   .revert_state                   ; $0117C8
.sh2_check_bit7:
        jsr     $0088FB36                       ; $0117CC  SH2 completion check
        btst    #7,($FFFFC80E).w                ; $0117D2  display bit 7 set?
        bne.s   .revert_state                   ; $0117D8  yes → revert
        clr.w   ($FFFFA05C).w                   ; $0117DA  clear action state
        addq.w  #4,($FFFFC87E).w                ; $0117DE  advance game_state
        bra.w   .set_display                    ; $0117E2
; --- epilogue ---
.revert_state:
        subq.w  #4,($FFFFC87E).w                ; $0117E6  revert game_state
.set_display:
        move.w  #$0018,$00FF0008                ; $0117EA  display mode = $0018
        rts                                     ; $0117F2
