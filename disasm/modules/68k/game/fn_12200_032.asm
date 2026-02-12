; ============================================================================
; Camera Menu Input Handler
; ROM Range: $0135C4-$0136AA (230 bytes)
; ============================================================================
; Category: game
; Purpose: Processes controller input for camera selection menu.
;   Entry: D1 = controller data.
;   D-pad down (bit 0): decrement $A019 counter, wrap at 0→5.
;   D-pad up (bit 1): increment $A019 counter, wrap at 5→0.
;   Left (bit 2): dispatch via handler table at $8936AA with D0=$FFFF.
;   Right (bit 3): dispatch via same table with D0=$0001.
;   Action buttons (bits 4-7): set selection state $A022 (1=start, 2=confirm, 3=accept).
;   All inputs play SFX $A9. Updates blink timer from $FF2100 and toggles $A026.
;
; Entry: D1 = controller data
; Uses: D0, D1, D2, A0
; RAM:
;   $A019: camera mode index (byte, range 0-5)
;   $A022: selection state (word)
;   $A024: blink timer (word)
;   $A026: blink toggle (word, toggled via NEG)
;   $C8A4: sound effect (byte)
; ============================================================================

fn_12200_032:
        move.w  D1,D2                           ; $0135C4  D2 = controller copy
        andi.b  #$F0,D2                         ; $0135C6  mask action buttons
        bne.w   .action_buttons                 ; $0135CA  pressed → handle action
        btst    #0,D1                           ; $0135CE  down pressed?
        beq.s   .check_up                       ; $0135D2  no → check up
        jsr     $0088205E                       ; $0135D4  SH2 scene transition
        move.b  #$A9,($FFFFC8A4).w              ; $0135DA  play SFX $A9
        subq.b  #1,($FFFFA019).w                ; $0135E0  decrement mode index
        bcc.w   .update_blink                   ; $0135E4  no underflow → blink
        move.b  #$05,($FFFFA019).w              ; $0135E8  wrap to 5
        bra.w   .update_blink                   ; $0135EE
.check_up:
        btst    #1,D1                           ; $0135F2  up pressed?
        beq.s   .check_left                     ; $0135F6  no → check left
        jsr     $0088205E                       ; $0135F8  SH2 scene transition
        move.b  #$A9,($FFFFC8A4).w              ; $0135FE  play SFX $A9
        addq.b  #1,($FFFFA019).w                ; $013604  increment mode index
        cmpi.b  #$05,($FFFFA019).w              ; $013608  index <= 5?
        ble.w   .update_blink                   ; $01360E  yes → blink
        clr.b   ($FFFFA019).w                   ; $013612  wrap to 0
        bra.w   .update_blink                   ; $013616
.check_left:
        btst    #2,D1                           ; $01361A  left pressed?
        beq.s   .check_right                    ; $01361E  no → check right
        move.b  #$A9,($FFFFC8A4).w              ; $013620  play SFX $A9
        move.w  #$FFFF,D0                       ; $013626  D0 = -1 (decrement)
        lea     $008936AA,A0                    ; $01362A  A0 = handler table
        clr.w   D2                              ; $013630
        move.b  ($FFFFA019).w,D2                ; $013632  D2 = mode index
        dc.w    $D442                           ; $013636  add.w d2,d2 — D2 × 2
        dc.w    $D442                           ; $013638  add.w d2,d2 — D2 × 4
        movea.l $00(A0,D2.W),A0                 ; $01363A  A0 = handler[mode]
        clr.w   D2                              ; $01363E  D2 = 0
        jsr     (A0)                            ; $013640  call handler
        bra.w   .update_blink                   ; $013642
.check_right:
        btst    #3,D1                           ; $013646  right pressed?
        beq.s   .update_blink                   ; $01364A  no → blink update
        move.b  #$A9,($FFFFC8A4).w              ; $01364C  play SFX $A9
        move.w  #$0001,D0                       ; $013652  D0 = +1 (increment)
        lea     $008936AA,A0                    ; $013656  A0 = handler table
        clr.w   D2                              ; $01365C
        move.b  ($FFFFA019).w,D2                ; $01365E  D2 = mode index
        dc.w    $D442                           ; $013662  add.w d2,d2 — D2 × 2
        dc.w    $D442                           ; $013664  add.w d2,d2 — D2 × 4
        movea.l $00(A0,D2.W),A0                 ; $013666  A0 = handler[mode]
        clr.w   D2                              ; $01366A  D2 = 0
        jsr     (A0)                            ; $01366C  call handler
        bra.w   .update_blink                   ; $01366E
.action_buttons:
        move.w  #$0001,($FFFFA022).w            ; $013672  selection state = 1 (start)
        btst    #7,D1                           ; $013678  C button?
        bne.s   .update_blink                   ; $01367C  yes → keep state 1
        move.w  #$0002,($FFFFA022).w            ; $01367E  selection state = 2 (confirm)
        btst    #4,D1                           ; $013684  A button?
        beq.s   .update_blink                   ; $013688  no → keep state 2
        move.w  #$0003,($FFFFA022).w            ; $01368A  selection state = 3 (accept)
.update_blink:
        subq.w  #1,($FFFFA024).w                ; $013690  decrement blink timer
        bcc.w   .done                           ; $013694  no underflow → done
        move.w  $00FF2100,($FFFFA024).w         ; $013698  reload timer from SH2
        subq.w  #1,($FFFFA026).w                ; $0136A0  decrement blink toggle
        neg.w   ($FFFFA026).w                   ; $0136A4  negate toggle (flip sign)
.done:
        rts                                     ; $0136A8
