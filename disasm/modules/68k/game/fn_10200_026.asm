; ============================================================================
; Name Entry Scroll View + Action Handler
; ROM Range: $01146E-$0115A8 (314 bytes)
; ============================================================================
; Category: game
; Purpose: DMA transfer, updates objects and sprites, sends SH2 DMA.
;   Handles smooth scrolling of name entry view with velocity ($A026)
;   applied over duration ($A02E steps). Processes action buttons:
;   D-pad up/down for scrolling, A/B/C for confirmation.
;   On confirm: enables display flags and triggers SH2 transition.
;
; Uses: D0, D1, D2, A0, A1
; RAM:
;   $A022: scroll position (long)
;   $A026: scroll velocity (long)
;   $A02A: max scroll position (long)
;   $A02E: scroll step counter (byte)
;   $A05C: action state (word)
;   $C86C: controller data (word)
;   $C87E: game_state (word)
;   $C8A4: sound effect (byte)
;   $C809/$C80A/$C80E/$C802: display enable flags
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
;   $0088179E: controller_poll
;   $0088205E: SH2 scene transition
;   $0088FB36: SH2 completion check
; ============================================================================

fn_10200_026:
        clr.w   D0                              ; $01146E  mode = 0
        dc.w    $4EBA,$D0BA                     ; $011470  bsr.w dma_transfer ($00E52C)
        dc.w    $4EBA,$A20E                     ; $011474  bsr.w object_update ($00B684)
        dc.w    $4EBA,$A260                     ; $011478  bsr.w sprite_update ($00B6DA)
        movea.l #$06018F80,A0                   ; $01147C  A0 = score display source
        movea.l #$0400E038,A1                   ; $011482  A1 = display dest
        move.w  #$00D8,D0                       ; $011488  size = $D8
        move.w  #$0010,D1                       ; $01148C  width = $10
        dc.w    $4EBA,$CEC8                     ; $011490  bsr.w sh2_send_cmd ($00E35A)
        movea.l #$26028000,A0                   ; $011494  A0 = VRAM scroll source
        move.l  ($FFFFA022).w,D0                ; $01149A  D0 = scroll position
        adda.l  D0,A0                           ; $01149E  A0 += scroll offset
        movea.l #$24010038,A1                   ; $0114A0  A1 = scroll dest
        move.w  #$00D8,D0                       ; $0114A6  size = $D8
        move.w  #$0050,D1                       ; $0114AA  width = $50
        dc.w    $4EBA,$CEAA                     ; $0114AE  bsr.w sh2_send_cmd ($00E35A)
        tst.l   ($FFFFA026).w                   ; $0114B2  velocity active?
        beq.w   .no_velocity                    ; $0114B6  no → check input
        move.l  ($FFFFA022).w,D0                ; $0114BA  D0 = scroll position
        move.l  ($FFFFA026).w,D1                ; $0114BE  D1 = velocity
        dc.w    $D081                           ; $0114C2  add.l d1,d0 — apply velocity
        move.l  D0,($FFFFA022).w                ; $0114C4  store new position
        subq.b  #1,($FFFFA02E).w                ; $0114C8  decrement step counter
        bcc.w   .revert_state                   ; $0114CC  still stepping → revert
        clr.l   ($FFFFA026).w                   ; $0114D0  clear velocity (done)
.no_velocity:
        cmpi.w  #$0001,($FFFFA05C).w            ; $0114D4  action state == 1?
        beq.w   .sh2_check_bit6                 ; $0114DA  yes → check SH2
        cmpi.w  #$0002,($FFFFA05C).w            ; $0114DE  action state == 2?
        beq.w   .sh2_check_bit7                 ; $0114E4  yes → check SH2 bit 7
        jsr     $0088179E                       ; $0114E8  poll controllers
        move.w  ($FFFFC86C).w,D1                ; $0114EE  D1 = controller data
        move.w  D1,D2                           ; $0114F2  D2 = copy
        andi.b  #$F0,D2                         ; $0114F4  mask action buttons
        beq.s   .check_dpad                     ; $0114F8  none → check D-pad
        move.b  #$A8,($FFFFC8A4).w              ; $0114FA  play confirm sound
        move.w  #$0002,($FFFFA05C).w            ; $011500  action state = 2
        move.b  #$01,($FFFFC809).w              ; $011506  enable display A
        move.b  #$01,($FFFFC80A).w              ; $01150C  enable display B
        bset    #7,($FFFFC80E).w                ; $011512  set display control
        move.b  #$01,($FFFFC802).w              ; $011518  enable display C
        jsr     $0088205E                       ; $01151E  SH2 scene transition
        bra.w   .set_display                    ; $011524
.check_dpad:
        lsr.w   #8,D1                           ; $011528  D1 = direction bits
        btst    #0,D1                           ; $01152A  down pressed?
        beq.s   .check_up                       ; $01152E  no → check up
        tst.l   ($FFFFA022).w                   ; $011530  already at min?
        ble.w   .revert_state                   ; $011534  yes → revert
        move.l  #$FFFFFE50,($FFFFA026).w        ; $011538  velocity = -$1B0
        move.b  #$07,($FFFFA02E).w              ; $011540  7 steps
        bra.w   .revert_state                   ; $011546
.check_up:
        btst    #1,D1                           ; $01154A  up pressed?
        beq.s   .revert_state                   ; $01154E  no → revert
        move.l  ($FFFFA022).w,D0                ; $011550  D0 = scroll position
        cmp.l   ($FFFFA02A).w,D0                ; $011554  at max?
        bge.w   .revert_state                   ; $011558  yes → revert
        move.l  #$000001B0,($FFFFA026).w        ; $01155C  velocity = +$1B0
        move.b  #$07,($FFFFA02E).w              ; $011564  7 steps
.sh2_check_bit6:
        jsr     $0088FB36                       ; $01156A  SH2 completion check
        btst    #6,($FFFFC80E).w                ; $011570  display bit 6 set?
        bne.s   .revert_state                   ; $011576  yes → revert
        clr.w   ($FFFFA05C).w                   ; $011578  clear action state
        bra.w   .revert_state                   ; $01157C
.sh2_check_bit7:
        jsr     $0088FB36                       ; $011580  SH2 completion check
        btst    #7,($FFFFC80E).w                ; $011586  display bit 7 set?
        bne.s   .revert_state                   ; $01158C  yes → revert
        clr.w   ($FFFFA05C).w                   ; $01158E  clear action state
        addq.w  #4,($FFFFC87E).w                ; $011592  advance game_state
        bra.w   .set_display                    ; $011596
.revert_state:
        subq.w  #4,($FFFFC87E).w                ; $01159A  revert game_state
.set_display:
        move.w  #$0018,$00FF0008                ; $01159E  display mode = $0018
        rts                                     ; $0115A6
