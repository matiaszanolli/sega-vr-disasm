; ============================================================================
; Name Entry SH2 Transfer + Advance
; ROM Range: $010200-$010244 (68 bytes)
; ============================================================================
; Category: game
; Purpose: Reads current name byte from buffer, sends two SH2 DMA commands.
;   First: transfers $A8 bytes at $10 width (sprite data).
;   Second: calculates VRAM row from player index × 640 ($A022 × 128 + × 512),
;   transfers $28 bytes at $10 width (character tile). Advances game_state.
;
; Uses: D0, D1, A0, A1
; RAM:
;   $A022: player selection index (word)
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $00E35A: sh2_send_cmd (A0=src, A1=dest, D0=size, D1=width)
; ============================================================================

name_entry_sh2_xfer_advance:
        dc.w    $1050                           ; $010200  move.b (a0),d0 — read name byte
        move.w  #$00A8,D0                       ; $010202  transfer size = $A8
        move.w  #$0010,D1                       ; $010206  width = $10
        jsr     sh2_send_cmd(pc)        ; $4EBA $E14E
        movea.l #$06020000,A0                   ; $01020E  A0 = VRAM char source
        move.w  ($FFFFA022).w,D0                ; $010214  D0 = player index
        lsl.w   #7,D0                           ; $010218  D0 × 128
        move.w  D0,D1                           ; $01021A  D1 = × 128
        lsl.w   #2,D0                           ; $01021C  D0 × 512
        add.w   d1,d0                   ; $D041
        lea     $00(A0,D0.W),A0                 ; $010220  A0 += row offset
        movea.l #$240310CC,A1                   ; $010224  A1 = VRAM destination
        move.w  #$0028,D0                       ; $01022A  transfer size = $28
        move.w  #$0010,D1                       ; $01022E  width = $10
        jsr     sh2_send_cmd(pc)        ; $4EBA $E126
        addq.w  #4,($FFFFC87E).w                ; $010236  advance game_state
        move.w  #$0020,$00FF0008                ; $01023A  display mode = $0020
        rts                                     ; $010242
