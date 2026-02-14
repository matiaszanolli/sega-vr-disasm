; ============================================================================
; Menu Item Draw Loop (Jump Table Indexed)
; ROM Range: $01446C-$0144A8 (60 bytes)
; ============================================================================
; Category: game
; Purpose: Calls $014566 (check/init); if nonzero sets $C084 = $0F.
;   Loads longword address from jump table at $01462A indexed by
;   $C084 (×4), calls $0145F0 (menu_state_check) with D1=$9A00.
;   Increments $C084; when $C084 > $0F: advances $C082 by 4
;   and sets timer ($A006) = $28.
;
; Uses: D0, D1, A0, A1
; RAM:
;   $A006: timer (word, set to $28)
;   $C082: menu_state (word, +4 on completion)
;   $C084: menu_substate (word, 0-$F loop counter)
; Calls:
;   $014566: menu check/init
;   $0145F0: menu_state_check
; Jump table:
;   $01462A: 16 longword entries (menu item addresses)
; ============================================================================

menu_item_draw_loop:
        jsr     read_combined_start_button_state(pc); $4EBA $00F8
        beq.s   .dispatch                       ; $014470  zero → proceed
        move.w  #$000F,($FFFFC084).w           ; $014472  reset substate = $0F
.dispatch:
        lea     menu_item_address_table_vdp_reg_clear(pc),a0; $41FA $01B0
        move.w  ($FFFFC084).w,D0               ; $01447C  D0 = menu_substate
        asl.w   #2,D0                           ; $014480  D0 × 4 (longword index)
        movea.l $00(A0,D0.W),A1                ; $014482  A1 = table[substate]
        move.l  #$00009A00,D1                   ; $014486  D1 = $9A00 (param)
        jsr     menu_tile_copy_to_vdp(pc); $4EBA $0162
        addq.w  #1,($FFFFC084).w               ; $014490  substate++
        cmpi.w  #$000F,($FFFFC084).w           ; $014494  substate > $0F?
        ble.s   .done                           ; $01449A  no → done
        addq.w  #4,($FFFFC082).w               ; $01449C  advance menu_state
        move.w  #$0028,($FFFFA006).w           ; $0144A0  timer = $28
.done:
        rts                                     ; $0144A6
