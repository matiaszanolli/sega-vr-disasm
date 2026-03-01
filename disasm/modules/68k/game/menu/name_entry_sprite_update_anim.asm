; ============================================================================
; Name Entry Sprite Update + Animation
; ROM Range: $0104A2-$0105DE (316 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrates name entry sprite display with DMA, animation,
;   and character preview rendering. Sends SH2 DMA for sprite data
;   ($06014000 → $24014034, $D8×$50). Handles blinking cursor animation
;   with timeout counter ($A030). Renders up to 3 character preview
;   slots at $24034060/$90/$C0. On completion ($A036=2), transitions
;   via SH2 call, enables display flags.
;
; Uses: D0, D1, A0, A1, A4
; RAM:
;   $A014: config flags (byte)
;   $A018: P1 buffer pointer (long)
;   $A01C: P2 buffer pointer (long)
;   $A02C: input active/blink flag (byte)
;   $A02D: blink timer (byte)
;   $A02E: blink animation counter (word)
;   $A030: timeout counter (word, init $0BB8=3000)
;   $A036: confirm state (word)
;   $C87E: game_state (word)
;   $C809/$C80A/$C80E/$C802: display enable flags
; Calls:
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
;   $010674: sprite_slot_render
;   $0088205E: SH2 scene transition
;   $0088FB36: SH2 completion check
; ============================================================================

name_entry_sprite_update_anim:
        clr.w   D0                              ; $0104A2  mode = 0
        jsr     MemoryInit(pc)          ; $4EBA $E086
        jsr     animated_seq_player+10(pc); $4EBA $B230
        movea.l #$06014000,A0                   ; $0104AC  A0 = sprite source
        movea.l #$24014034,A1                   ; $0104B2  A1 = sprite dest
        move.w  #$00D8,D0                       ; $0104B8  size = $D8
        move.w  #$0050,D1                       ; $0104BC  width = $50
        jsr     sh2_send_cmd(pc)        ; $4EBA $DE98
        tst.w   ($FFFFA02E).w                   ; $0104C4  animation counter
        bpl.s   .render_chars                   ; $0104C8  positive → render
        move.b  #$01,($FFFFA02C).w              ; $0104CA  set blink active
        move.b  #$01,($FFFFA02D).w              ; $0104D0  set blink timer
        subq.w  #1,($FFFFA030).w                ; $0104D6  decrement timeout
        bcc.s   .render_chars                   ; $0104DA  no underflow → continue
        move.w  #$0002,($FFFFA036).w            ; $0104DC  timeout! confirm = 2
        move.b  #$01,($FFFFC809).w              ; $0104E2  enable display A
        move.b  #$01,($FFFFC80A).w              ; $0104E8  enable display B
        bset    #7,($FFFFC80E).w                ; $0104EE  set display control
        move.b  #$01,($FFFFC802).w              ; $0104F4  enable display C
        jsr     $0088205E                       ; $0104FA  SH2 scene transition
        move.w  #$0BB8,($FFFFA030).w            ; $010500  reset timeout (3000)
.render_chars:
        movea.l ($FFFFA018).w,A0                ; $010506  A0 = P1 buffer
        btst    #0,($FFFFA014).w                ; $01050A  P1 active?
        bne.w   .check_char0                    ; $010510  yes → use P1
        movea.l ($FFFFA01C).w,A0                ; $010514  A0 = P2 buffer
.check_char0:
        tst.b   ($FFFFA02C).w                   ; $010518  input active?
        beq.w   .check_char1                    ; $01051C  no → skip slot 0
        movea.l A0,A4                           ; $010520  A4 = buffer (save)
        clr.w   D0                              ; $010522
        move.b  (A0),D0                         ; $010524  D0 = buffer[0]
        cmpi.b  #$20,D0                         ; $010526  is space?
        beq.w   .check_char1                    ; $01052A  yes → skip
        cmpi.b  #$03,D0                         ; $01052E  is end marker?
        beq.w   .check_char1                    ; $010532  yes → skip
        movea.l #$24034060,A1                   ; $010536  A1 = sprite slot 0
        bsr.w   ascii_character_to_tile_index_mapper_010674; $6100 $0136
.check_char1:
        tst.b   ($FFFFA02C).w                   ; $010540  input active?
        beq.w   .check_char2                    ; $010544  no → skip slot 1
        move.w  (A4),D0                         ; $010548  D0 = buffer word
        andi.w  #$00FF,D0                       ; $01054A  mask = buffer[1]
        cmpi.b  #$20,D0                         ; $01054E  is space?
        beq.w   .check_char2                    ; $010552  yes → skip
        cmpi.b  #$03,D0                         ; $010556  is end marker?
        beq.w   .check_char2                    ; $01055A  yes → skip
        movea.l #$24034090,A1                   ; $01055E  A1 = sprite slot 1
        bsr.w   ascii_character_to_tile_index_mapper_010674; $6100 $010E
.check_char2:
        tst.b   ($FFFFA02C).w                   ; $010568  input active?
        beq.w   .check_complete                 ; $01056C  no → skip slot 2
        move.b  $0002(A4),D0                    ; $010570  D0 = buffer[2]
        andi.w  #$00FF,D0                       ; $010574  mask to byte
        cmpi.b  #$20,D0                         ; $010578  is space?
        beq.w   .check_complete                 ; $01057C  yes → skip
        cmpi.b  #$03,D0                         ; $010580  is end marker?
        beq.w   .check_complete                 ; $010584  yes → skip
        movea.l #$240340C0,A1                   ; $010588  A1 = sprite slot 2
        bsr.w   ascii_character_to_tile_index_mapper_010674; $6100 $00E4
.check_complete:
        cmpi.w  #$0002,($FFFFA036).w            ; $010592  confirm state = 2?
        beq.w   .sh2_complete                   ; $010598  yes → check SH2
        subq.b  #1,($FFFFA02D).w                ; $01059C  decrement blink timer
        bcc.s   .anim_done                      ; $0105A0  no underflow → done
        bchg    #0,($FFFFA02C).w                ; $0105A2  toggle blink
        move.b  #$01,($FFFFA02D).w              ; $0105A8  reset timer
        btst    #0,($FFFFA02C).w                ; $0105AE  blink now on?
        beq.s   .anim_done                      ; $0105B4  no → done
        subq.w  #1,($FFFFA02E).w                ; $0105B6  decrement animation counter
.anim_done:
        bra.w   .set_display                    ; $0105BA
.sh2_complete:
        jsr     $0088FB36                       ; $0105BE  SH2 completion check
        btst    #7,($FFFFC80E).w                ; $0105C4  display ready?
        bne.s   .set_display                    ; $0105CA  no → keep waiting
        clr.w   ($FFFFA036).w                   ; $0105CC  clear confirm state
        addq.w  #4,($FFFFC87E).w                ; $0105D0  advance game_state
.set_display:
        move.w  #$0018,$00FF0008                ; $0105D4  display mode = $0018
        rts                                     ; $0105DC
