; ============================================================================
; sprite_hud_layout_builder — Sprite/HUD Layout Builder
; ROM Range: $003C2A-$003CCE (164 bytes)
; ============================================================================
; Builds 4 sprite entries at $FF66DC from two PC-relative data tables:
;   - Animation table at sprite_hud_layout_builder (18 words): indexed by race_state + comm_sub
;   - Position table at .pos_table (24 words = 3 groups × 8 words):
;     indexed by vint_state × 16
;
; Each sprite entry (20 bytes at $14 stride) gets:
;   +$00: visibility flag ($0001)
;   +$02: anim_word + pos_offset (added)
;   +$04: anim_word (direct copy)
;   +$06: anim_word - pos_offset (subtracted)
;
; Alternate exit at $3CC4: loads RAM $C026, returns if negative.
;
; Uses: D0, D1, D2, A1, A2, A3
; RAM: $C89E (sh2_comm_sub), $C8A0 (race_state),
;      $C8C8 (vint_state), $C026
; ============================================================================

sprite_hud_layout_builder:
; --- animation frame table (18 words) -----------------------------------------
        dc.w    $F190,$09FA,$F1F0               ; $003C2A  frame set 0
        dc.w    $F190,$0A40,$F1F0               ; $003C30  frame set 1
        dc.w    $EA70,$03B3,$FB50               ; $003C36  frame set 2
        dc.w    $E900,$0AF0,$0800               ; $003C3C  frame set 3
        dc.w    $EA70,$03B3,$FB50               ; $003C42  frame set 4
        dc.w    $F190,$09FA,$F1F0               ; $003C48  frame set 5
; --- position coordinate table (3 groups × 8 words) --------------------------
.pos_table:
        dc.w    $0030,$002B,$0031,$FFFD         ; $003C4E  group 0
        dc.w    $FFD7,$002B,$FFCE,$FFFD         ; $003C56
        dc.w    $0034,$0021,$0035,$FFF3         ; $003C5E  group 1
        dc.w    $FFD3,$0021,$FFCA,$FFF3         ; $003C66
        dc.w    $0034,$0017,$0035,$FFEE         ; $003C6E  group 2
        dc.w    $FFD3,$0017,$FFCA,$FFEE         ; $003C76
; --- code starts here ---------------------------------------------------------
        move.w  ($FFFFC8C8).w,D0                ; $003C7E  vint_state
        lsl.w   #4,D0                           ; $003C82  × 16
        lea     .pos_table(PC,D0.W),A2          ; $003C84  position table entry
        move.w  ($FFFFC8A0).w,D0                ; $003C88  race_state
        add.w   ($FFFFC89E).w,D0                ; $003C8C  + sh2_comm_sub
        lea     sprite_hud_layout_builder(PC,D0.W),A3         ; $003C90  animation table entry
        lea     $00FF66DC,A1                    ; $003C94  sprite buffer
        moveq   #$01,D1                         ; $003C9A  visibility flag
        moveq   #$03,D2                         ; $003C9C  4 sprites
.build_sprite:
        move.w  D1,$0000(A1)                    ; $003C9E  sprite visible
        move.w  (A3)+,D0                        ; $003CA2  anim word
        add.w   (A2)+,D0                        ; $003CA4  + position offset
        move.w  D0,$0002(A1)                    ; $003CA6  sprite X/Y
        move.w  (A3)+,$0004(A1)                 ; $003CAA  sprite attribute
        move.w  (A3)+,D0                        ; $003CAE  anim word
        sub.w   (A2)+,D0                        ; $003CB0  - position offset
        move.w  D0,$0006(A1)                    ; $003CB2  sprite size
        lea     $0014(A1),A1                    ; $003CB6  next sprite slot
        subq.w  #6,A3                           ; $003CBA  rewind A3 (re-read same 3 words)
        dbra    D2,.build_sprite                ; $003CBC
        moveq   #$00,D0                         ; $003CC0
        bra.s   vdp_sprite_pointer_setup_cond_disp_clear ; skip alternate exit, fall through
; --- alternate entry: conditional return --------------------------------------
        moveq   #$00,D0                         ; $003CC4
        move.w  ($FFFFC026).w,D0                ; $003CC6
        bpl.s   vdp_sprite_pointer_setup_cond_disp_clear ; $003CCA  positive → fall into next fn
        rts                                     ; $003CCC
