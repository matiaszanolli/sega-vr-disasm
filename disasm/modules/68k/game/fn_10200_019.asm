; ============================================================================
; Name Entry Cursor Render
; ROM Range: $010796-$01084C (182 bytes)
; ============================================================================
; Category: game
; Purpose: Renders name entry cursor with blink animation.
;   Decrements blink timer, toggles input_active flag on underflow.
;   Renders 1-3 sprite slots based on cursor position ($A020):
;     pos >= 2: all 3 slots, pos == 1: 2 slots, pos == 0: 1 slot.
;   Each slot displays either the current character or cursor indicator.
;
; Entry: A0 = name buffer pointer
; Uses: D0, A0, A1, A4
; RAM:
;   $A02C: input active/blink flag (byte, toggled)
;   $A02D: blink timer (byte, decremented)
;   $A020: cursor position (byte, 0/1/2+)
;   $A024: character index (word)
; Calls:
;   $010674: sprite_slot_render (A0=source, A1=dest, D0=char)
; ============================================================================

fn_10200_019:
        subq.b  #1,($FFFFA02D).w                ; $010796  decrement blink timer
        bcc.s   .check_cursor                   ; $01079A  no underflow → continue
        bchg    #0,($FFFFA02C).w                ; $01079C  toggle blink flag
        move.b  #$00,($FFFFA02D).w              ; $0107A2  reset timer
.check_cursor:
        tst.b   ($FFFFA020).w                   ; $0107A8  cursor position
        beq.w   .pos_zero                       ; $0107AC  pos 0 → single slot
        cmpi.b  #$01,($FFFFA020).w              ; $0107B0  pos 1?
        beq.w   .pos_one                        ; $0107B6  yes → two slots
        movea.l A0,A4                           ; $0107BA  A4 = buffer ptr (save)
        clr.w   D0                              ; $0107BC
        move.b  (A0),D0                         ; $0107BE  D0 = char at buffer[0]
        cmpi.b  #$20,D0                         ; $0107C0  is space?
        beq.w   .slot1                          ; $0107C4  skip first slot
        movea.l #$24034060,A1                   ; $0107C8  A1 = sprite slot 0
        dc.w    $6100,$FEA4                     ; $0107CE  bsr.w sprite_slot_render ($010674)
.slot1:
        move.w  (A4),D0                         ; $0107D2  D0 = word at buffer
        andi.w  #$00FF,D0                       ; $0107D4  mask low byte = buffer[1]
        cmpi.b  #$20,D0                         ; $0107D8  is space?
        beq.w   .slot2                          ; $0107DC  skip second slot
        movea.l #$24034090,A1                   ; $0107E0  A1 = sprite slot 1
        dc.w    $6100,$FE8C                     ; $0107E6  bsr.w sprite_slot_render ($010674)
.slot2:
        tst.b   ($FFFFA02C).w                   ; $0107EA  blink active?
        beq.w   .done                           ; $0107EE  no → skip cursor
        move.w  ($FFFFA024).w,D0                ; $0107F2  D0 = current char index
        movea.l #$240340C0,A1                   ; $0107F6  A1 = sprite slot 2
        dc.w    $6100,$FE76                     ; $0107FC  bsr.w sprite_slot_render ($010674)
        bra.w   .done                           ; $010800
.pos_zero:
        tst.b   ($FFFFA02C).w                   ; $010804  blink active?
        beq.w   .done                           ; $010808  no → skip
        move.w  ($FFFFA024).w,D0                ; $01080C  D0 = current char index
        movea.l #$24034060,A1                   ; $010810  A1 = sprite slot 0
        dc.w    $6100,$FE5C                     ; $010816  bsr.w sprite_slot_render ($010674)
        bra.w   .done                           ; $01081A
.pos_one:
        clr.w   D0                              ; $01081E
        move.b  (A0),D0                         ; $010820  D0 = char at buffer[0]
        cmpi.b  #$20,D0                         ; $010822  is space?
        beq.w   .pos_one_cursor                 ; $010826  skip first → show cursor
        movea.l #$24034060,A1                   ; $01082A  A1 = sprite slot 0
        dc.w    $6100,$FE42                     ; $010830  bsr.w sprite_slot_render ($010674)
.pos_one_cursor:
        tst.b   ($FFFFA02C).w                   ; $010834  blink active?
        beq.w   .done                           ; $010838  no → skip cursor
        move.w  ($FFFFA024).w,D0                ; $01083C  D0 = current char index
        movea.l #$24034090,A1                   ; $010840  A1 = sprite slot 1
        dc.w    $6100,$FE2C                     ; $010846  bsr.w sprite_slot_render ($010674)
.done:
        rts                                     ; $01084A
