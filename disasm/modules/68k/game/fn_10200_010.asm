; ============================================================================
; Name Entry Character Input (Player 1)
; ROM Range: $010244-$01035C (280 bytes)
; ============================================================================
; Category: game
; Purpose: Handles character input for player 1 name entry.
;   DMA transfer, cursor render, controller poll.
;   Processes character placement: validates against space ($20) and
;   end marker ($03), writes to name buffer(s) at cursor position.
;   Handles backspace (delete button), supports dual-player mode via $A014.
;   Advances game_state on completion or timeout.
;
; Uses: D0, D1, D2, A0
; RAM:
;   $A014: dual-player config flags (byte)
;   $A018: name buffer pointer P1 (long)
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
;   $00E52C: dma_transfer (D0=mode)
;   $010796: cursor_render (A0=buffer)
;   $0088179E: controller_poll
;   $01084C: input_handler (fn_10200_002)
;   $0088FB36: SH2 transition check
; ============================================================================

fn_10200_010:
        clr.w   D0                              ; $010244  mode = 0
        dc.w    $4EBA,$E2E4                     ; $010246  bsr.w dma_transfer ($00E52C)
        movea.l ($FFFFA018).w,A0                ; $01024A  A0 = P1 name buffer
        dc.w    $6100,$0546                     ; $01024E  bsr.w cursor_render ($010796)
        jsr     $0088179E                       ; $010252  poll controllers
        cmpi.w  #$0001,($FFFFA036).w            ; $010258  confirm state = 1?
        beq.w   .confirm_check                  ; $01025E  yes → check SH2
        move.w  ($FFFFC86C).w,D1                ; $010262  D1 = controller data
        btst    #4,D1                           ; $010266  start button?
        bne.w   .handle_delete                  ; $01026A  yes → delete char
        move.w  D1,D2                           ; $01026E  D2 = input copy
        andi.b  #$E0,D2                         ; $010270  mask action buttons
        beq.w   .no_action_btn                  ; $010274  none → handle input
        move.b  #$01,($FFFFA02C).w              ; $010278  set input active
        move.b  #$00,($FFFFA02D).w              ; $01027E  reset blink timer
        move.b  #$A8,($FFFFC8A4).w              ; $010284  play confirm sound
        btst    #7,D1                           ; $01028A  A button?
        bne.w   .complete                       ; $01028E  yes → complete entry
        move.w  ($FFFFA024).w,D0                ; $010292  D0 = char index
        cmpi.b  #$03,D0                         ; $010296  end marker?
        beq.w   .complete                       ; $01029A  yes → complete
        cmpi.b  #$08,D0                         ; $01029E  backspace?
        beq.w   .handle_delete                  ; $0102A2  yes → delete
        clr.w   D1                              ; $0102A6
        move.b  ($FFFFA020).w,D1                ; $0102A8  D1 = cursor position
        movea.l ($FFFFA018).w,A0                ; $0102AC  A0 = P1 buffer
        move.b  D0,$00(A0,D1.W)                 ; $0102B0  write char to buffer
        btst    #1,($FFFFA014).w                ; $0102B4  dual-player mode?
        beq.w   .advance_cursor                 ; $0102BA  no → advance
        movea.l ($FFFFA01C).w,A0                ; $0102BE  A0 = P2 buffer
        move.b  D0,$00(A0,D1.W)                 ; $0102C2  write char to P2 buffer
.advance_cursor:
        addq.b  #1,($FFFFA020).w                ; $0102C6  advance cursor
        cmpi.b  #$03,($FFFFA020).w              ; $0102CA  at max (3 chars)?
        bge.w   .complete                       ; $0102D0  yes → complete entry
        bra.w   .revert_state                   ; $0102D4
.complete:
        addq.w  #4,($FFFFC87E).w                ; $0102D8  advance game_state
        bra.w   .set_display                    ; $0102DC
.handle_delete:
        tst.b   ($FFFFA020).w                   ; $0102E0  cursor at start?
        beq.w   .revert_state                   ; $0102E4  yes → skip
        clr.w   D1                              ; $0102E8
        move.b  ($FFFFA020).w,D1                ; $0102EA  D1 = cursor pos
        movea.l ($FFFFA018).w,A0                ; $0102EE  A0 = P1 buffer
        move.b  #$20,$00(A0,D1.W)               ; $0102F2  write space (clear char)
        btst    #1,($FFFFA014).w                ; $0102F8  dual-player mode?
        beq.w   .backspace_p1                   ; $0102FE  no → P1 only
        movea.l ($FFFFA01C).w,A0                ; $010302  A0 = P2 buffer
        move.b  #$20,$00(A0,D1.W)               ; $010306  clear P2 char too
.backspace_p1:
        subq.b  #1,($FFFFA020).w                ; $01030C  move cursor back
        clr.w   D1                              ; $010310
        move.b  ($FFFFA020).w,D1                ; $010312  D1 = new cursor pos
        movea.l ($FFFFA018).w,A0                ; $010316  A0 = P1 buffer
        move.b  #$20,$00(A0,D1.W)               ; $01031A  clear current pos
        btst    #1,($FFFFA014).w                ; $010320  dual-player?
        beq.w   .update_display                 ; $010326  no → done
        movea.l ($FFFFA01C).w,A0                ; $01032A  A0 = P2 buffer
        move.b  #$20,$00(A0,D1.W)               ; $01032E  clear P2 current pos
.update_display:
        bra.w   .revert_state                   ; $010334
.no_action_btn:
        dc.w    $6100,$0512                     ; $010338  bsr.w input_handler ($01084C)
.confirm_check:
        jsr     $0088FB36                       ; $01033C  SH2 transition check
        btst    #6,($FFFFC80E).w                ; $010342  display busy?
        bne.s   .revert_state                   ; $010348  yes → revert
        clr.w   ($FFFFA036).w                   ; $01034A  clear confirm state
.revert_state:
        subq.w  #4,($FFFFC87E).w                ; $01034E  revert game_state
.set_display:
        move.w  #$0018,$00FF0008                ; $010352  display mode = $0018
        rts                                     ; $01035A
