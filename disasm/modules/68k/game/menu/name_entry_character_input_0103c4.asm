; ============================================================================
; Name Entry Character Input (Player 2)
; ROM Range: $0103C4-$0104A2 (222 bytes)
; ============================================================================
; Category: game
; Purpose: Handles character input for player 2 name entry.
;   Nearly identical to name_entry_character_input_010244 (Player 1) but uses P2 buffer ($A01C).
;   No dual-player buffer mirroring (single buffer only).
;   Same character validation, backspace, and completion logic.
;
; Uses: D0, D1, D2, A0
; RAM:
;   $A01C: name buffer pointer P2 (long)
;   $A020: cursor position (byte)
;   $A024: character index (word)
;   $A02C: input active flag (byte)
;   $A02D: blink timer (byte)
;   $A036: confirm state (word)
;   $C86C: controller data (word)
;   $C87E: game_state (word)
;   $C8A4: sound effect (byte)
;   $C80E: display control (byte)
; Calls:
;   $00E52C: dma_transfer
;   $010796: cursor_render
;   $0088179E: controller_poll
;   $01084C: input_handler
;   $0088FB36: SH2 transition check
; ============================================================================

name_entry_character_input_0103c4:
        clr.w   D0                              ; $0103C4  mode = 0
        dc.w    $4EBA,$E164                     ; $0103C6  bsr.w dma_transfer ($00E52C)
        movea.l ($FFFFA01C).w,A0                ; $0103CA  A0 = P2 name buffer
        dc.w    $6100,$03C6                     ; $0103CE  bsr.w cursor_render ($010796)
        jsr     $0088179E                       ; $0103D2  poll controllers
        cmpi.w  #$0001,($FFFFA036).w            ; $0103D8  confirm state = 1?
        beq.w   .confirm_check                  ; $0103DE  yes → check SH2
        move.w  ($FFFFC86C).w,D1                ; $0103E2  D1 = controller data
        btst    #4,D1                           ; $0103E6  start button?
        bne.w   .handle_delete                  ; $0103EA  yes → delete
        move.w  D1,D2                           ; $0103EE  D2 = input copy
        andi.b  #$E0,D2                         ; $0103F0  mask action buttons
        beq.w   .no_action_btn                  ; $0103F4  none → handle input
        move.b  #$01,($FFFFA02C).w              ; $0103F8  set input active
        move.b  #$00,($FFFFA02D).w              ; $0103FE  reset blink timer
        move.b  #$A8,($FFFFC8A4).w              ; $010404  play confirm sound
        btst    #7,D1                           ; $01040A  A button?
        bne.w   .complete                       ; $01040E  yes → complete entry
        move.w  ($FFFFA024).w,D0                ; $010412  D0 = char index
        cmpi.b  #$03,D0                         ; $010416  end marker?
        beq.w   .complete                       ; $01041A  yes → complete
        cmpi.b  #$08,D0                         ; $01041E  backspace?
        beq.w   .handle_delete                  ; $010422  yes → delete
        clr.w   D1                              ; $010426
        move.b  ($FFFFA020).w,D1                ; $010428  D1 = cursor position
        movea.l ($FFFFA01C).w,A0                ; $01042C  A0 = P2 buffer
        move.b  D0,$00(A0,D1.W)                 ; $010430  write char
        addq.b  #1,($FFFFA020).w                ; $010434  advance cursor
        cmpi.b  #$03,($FFFFA020).w              ; $010438  at max?
        bge.w   .complete                       ; $01043E  yes → complete
        bra.w   .update_display                 ; $010442
.complete:
        addq.w  #4,($FFFFC87E).w                ; $010446  advance game_state
        bra.w   .set_display                    ; $01044A
.handle_delete:
        clr.w   D1                              ; $01044E
        move.b  ($FFFFA020).w,D1                ; $010450  D1 = cursor pos
        movea.l ($FFFFA01C).w,A0                ; $010454  A0 = P2 buffer
        move.b  #$20,$00(A0,D1.W)               ; $010458  clear char (space)
        tst.b   ($FFFFA020).w                   ; $01045E  cursor at start?
        beq.w   .update_display                 ; $010462  yes → skip
        subq.b  #1,($FFFFA020).w                ; $010466  move cursor back
        clr.w   D1                              ; $01046A
        move.b  ($FFFFA020).w,D1                ; $01046C  D1 = new pos
        movea.l ($FFFFA01C).w,A0                ; $010470  A0 = P2 buffer
        move.b  #$20,$00(A0,D1.W)               ; $010474  clear prev pos
        bra.w   .update_display                 ; $01047A
.no_action_btn:
        dc.w    $6100,$03CC                     ; $01047E  bsr.w input_handler ($01084C)
.confirm_check:
        jsr     $0088FB36                       ; $010482  SH2 transition check
        btst    #6,($FFFFC80E).w                ; $010488  display busy?
        bne.s   .update_display                 ; $01048E  yes → skip clear
        clr.w   ($FFFFA036).w                   ; $010490  clear confirm state
.update_display:
        subq.w  #4,($FFFFC87E).w                ; $010494  revert game_state
.set_display:
        move.w  #$0018,$00FF0008                ; $010498  display mode = $0018
        rts                                     ; $0104A0
