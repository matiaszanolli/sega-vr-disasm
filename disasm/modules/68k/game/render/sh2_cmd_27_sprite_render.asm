; ============================================================================
; SH2 Cmd 27 Sprite Render
; ROM Range: $00E118-$00E19E (134 bytes)
; ============================================================================
; Sends two sprite render commands to SH2 via sh2_cmd_27. First
; sprite: selects source from ROM table (indexed by player ID),
; uses ×6 stride. Second sprite: selects base address from player
; ID, uses ×72 stride, checks COMM0 busy before sending.
;
; Uses: D0, D1, D2, D3, A0, A1
; RAM:
;   $A019: player_id_a
;   $A025: player_id_b
;   $A026: player_id_c
;   $A027: player_select
; Calls:
;   $00E3B4: sh2_cmd_27 (JSR PC-relative)
; ============================================================================

sh2_cmd_27_sprite_render:
; --- sprite 1: ROM table lookup with ×6 stride ---
        moveq   #$00,d0
        tst.b   ($FFFFA027).w                   ; player_select active?
        bne.s   .use_id_b
        move.b  ($FFFFA019).w,d0                ; player_id_a
        bra.s   .calc_offset_1
.use_id_b:
        move.b  ($FFFFA025).w,d0                ; player_id_b
.calc_offset_1:
        lea     $0088E19E,a1                    ; ROM sprite table base
        add.w   d0,d0                            ; ×2
        move.w  d0,d1                           ; save ×2
        add.w   d0,d0                            ; ×4
        add.w   d1,d0                            ; ×6 (= ×2 + ×4)
        movea.l $00(a1,d0.w),a0                 ; load sprite data pointer
        move.w  $04(a1,d0.w),d0                 ; load sprite param
        move.w  #$0030,d1                       ; width = 48
        move.w  #$0010,d2                       ; height = 16
        jsr     sh2_cmd_27(pc)          ; $4EBA $026A
; --- sprite 2: base address + ×72 stride ---
        moveq   #$00,d0
        tst.b   ($FFFFA027).w                   ; player_select active?
        beq.s   .use_id_c
        move.b  ($FFFFA019).w,d0                ; player_id_a
        bra.s   .calc_offset_2
.use_id_c:
        move.b  ($FFFFA026).w,d0                ; player_id_c
.calc_offset_2:
        move.b  d0,d3                           ; save player ID
        movea.l #$0401C010,a0                   ; base sprite address
        add.w   d0,d0                            ; ×2
        add.w   d0,d0                            ; ×4
        add.w   d0,d0                            ; ×8
        move.w  d0,d1                           ; save ×8
        add.w   d0,d0                            ; ×16
        add.w   d0,d0                            ; ×32
        add.w   d0,d0                            ; ×64
        add.w   d1,d0                            ; ×72 (= ×64 + ×8)
        lea     $00(a0,d0.w),a0                 ; offset into sprite data
        move.w  #$0049,d0                       ; command = $49
        move.w  #$0010,d1                       ; width = 16
        move.w  #$0010,d2                       ; height = 16
        tst.b   d3                              ; player ID = 0?
        beq.s   .wait_comm
        move.w  #$0048,d0                       ; command = $48 (alternate)
        subq.l  #1,a0                           ; adjust address -1
.wait_comm:
        tst.b   COMM0_HI                        ; COMM0 busy?
        bne.s   .wait_comm                       ; yes → wait
        jsr     sh2_cmd_27(pc)          ; $4EBA $021A
        rts
