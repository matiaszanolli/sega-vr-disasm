; ============================================================================
; Name Entry Rendering + SH2 Transfer
; ROM Range: $012084-$0121FA (374 bytes)
; ============================================================================
; Category: game
; Purpose: DMA transfer + 3 static sh2_send_cmd DMA transfers.
;   Two sh2_cmd_27 calls with dynamic table lookups based on player flag
;   ($A01A): if 0, uses $A019 index with D2=$10; else uses $A01B with
;   D2=$FFC0. First cmd27 uses ×4 table at $8921FA, second uses ×6 table
;   at $892206. COMM protocol (cmd $2C, COMM4=$4000) sends transfer params.
;   Resolves active player selection indices and stores to $A01E/$A022.
;   Calculates row offset ($A02C × $280) for final DMA from $0601BE00.
;   Advances game_state, display mode $0020.
;
; Uses: D0, D1, D2, D3, A0, A1
; RAM:
;   $A019: camera mode index P1 (byte)
;   $A01A: active player flag (byte, 0=P1, !0=P2)
;   $A01B: camera mode index P2 (byte)
;   $A01C: selection index P2 (byte)
;   $A01E: resolved selection A (long)
;   $A022: resolved selection B (long)
;   $A02C: display row (word)
;   $A034: VRAM dest pointer (long)
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $00E35A: sh2_send_cmd
;   $00E3B4: sh2_cmd_27
;   $00E52C: dma_transfer
; ============================================================================

name_entry_rendering_sh2_xfer:
        clr.w   D0                              ; $012084  mode = 0
        jsr     MemoryInit(pc)          ; $4EBA $C4A4
; --- static DMA: header ---
        movea.l #$06018000,A0                   ; $01208A  source
        movea.l #$04004C74,A1                   ; $012090  dest
        move.w  #$0058,D0                       ; $012096  size = $58
        move.w  #$0010,D1                       ; $01209A  width = $10
        jsr     sh2_send_cmd(pc)        ; $4EBA $C2BA
; --- static DMA: display A ---
        movea.l #$06018900,A0                   ; $0120A2  source
        movea.l #$04019010,A1                   ; $0120A8  dest
        move.w  #$0120,D0                       ; $0120AE  size = $120
        move.w  #$0010,D1                       ; $0120B2  width = $10
        jsr     sh2_send_cmd(pc)        ; $4EBA $C2A2
; --- static DMA: display B ---
        movea.l #$06019B00,A0                   ; $0120BA  source
        movea.l #$0401C010,A1                   ; $0120C0  dest
        move.w  #$0120,D0                       ; $0120C6  size = $120
        move.w  #$0010,D1                       ; $0120CA  width = $10
        jsr     sh2_send_cmd(pc)        ; $4EBA $C28A
; --- first sh2_cmd_27: ×4 table lookup ---
        moveq   #$00,D0                         ; $0120D2  clear D0
        tst.b   ($FFFFA01A).w                   ; $0120D4  active player flag
        bne.s   .player2_idx1                   ; $0120D8  P2 → use $A01B
        move.b  ($FFFFA019).w,D0                ; $0120DA  D0 = P1 mode index
        move.w  #$0010,D2                       ; $0120DE  D2 = $10
        bra.s   .cmd27_first                    ; $0120E2
.player2_idx1:
        move.b  ($FFFFA01B).w,D0                ; $0120E4  D0 = P2 mode index
        move.w  #$FFC0,D2                       ; $0120E8  D2 = $FFC0
.cmd27_first:
        move.b  D0,D3                           ; $0120EC  D3 = save index
        lea     $008921FA,A1                    ; $0120EE  A1 = source table (×4)
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        movea.l $00(A1,D0.W),A0                 ; $0120F8  A0 = table[idx].source
        move.w  #$0061,D0                       ; $0120FC  size = $61
        tst.b   D3                              ; $012100  index == 0?
        bne.s   .send_cmd27_1                   ; $012102  no → keep $61
        move.w  #$0060,D0                       ; $012104  size = $60 (for index 0)
.send_cmd27_1:
        move.w  #$0010,D1                       ; $012108  width = $10
.wait_comm0_1:
        tst.b   COMM0_HI                        ; $01210C  COMM0 busy?
        bne.s   .wait_comm0_1                   ; $012112  yes → wait
        jsr     sh2_cmd_27(pc)          ; $4EBA $C29E
; --- second sh2_cmd_27: ×6 table lookup ---
        moveq   #$00,D0                         ; $012118  clear D0
        tst.b   ($FFFFA01A).w                   ; $01211A  active player flag
        beq.s   .player1_idx2                   ; $01211E  P1 → use $A019
        move.b  ($FFFFA019).w,D0                ; $012120  D0 = P1 mode index
        move.w  #$0010,D2                       ; $012124  D2 = $10
        bra.s   .cmd27_second                   ; $012128
.player1_idx2:
        move.b  ($FFFFA01C).w,D0                ; $01212A  D0 = P2 selection
        move.w  #$FFC0,D2                       ; $01212E  D2 = $FFC0
.cmd27_second:
        lea     $00892206,A1                    ; $012132  A1 = source table (×6)
        add.w   d0,d0                   ; $D040
        move.w  D0,D1                           ; $01213A  D1 = D0 × 2
        add.w   d0,d0                   ; $D040
        add.w   d1,d0                   ; $D041
        movea.l $00(A1,D0.W),A0                 ; $012140  A0 = table[idx].source
        move.w  $04(A1,D0.W),D0                 ; $012144  D0 = table[idx].size
        move.w  #$0010,D1                       ; $012148  width = $10
.wait_comm0_2:
        tst.b   COMM0_HI                        ; $01214C  COMM0 busy?
        bne.s   .wait_comm0_2                   ; $012152  yes → wait
        jsr     sh2_cmd_27(pc)          ; $4EBA $C25E
; --- COMM protocol: cmd $2C ---
.wait_comm0_3:
        tst.b   COMM0_HI                        ; $012158  COMM0 busy?
        bne.s   .wait_comm0_3                   ; $01215E  yes → wait
        move.w  #$0101,COMM6                    ; $012160  COMM6 = $0101
        move.w  #$4000,COMM4                    ; $012168  COMM4 = $4000
        move.b  #$2C,COMM0_LO                   ; $012170  cmd = $2C
        move.b  #$01,COMM0_HI                   ; $012178  trigger
.wait_comm6:
        tst.b   COMM6                           ; $012180  COMM6 cleared?
        bne.s   .wait_comm6                     ; $012186  no → wait
        move.w  #$0078,COMM4                    ; $012188  height = $78
        move.w  #$0101,COMM6                    ; $012190  signal ready
; --- resolve active selection indices ---
        moveq   #$00,D0                         ; $012198
        move.b  ($FFFFA019).w,D0                ; $01219A  D0 = P1 mode
        tst.b   ($FFFFA01A).w                   ; $01219E  player flag
        beq.s   .store_sel_a                    ; $0121A2  P1 → use $A019
        move.b  ($FFFFA01B).w,D0                ; $0121A4  D0 = P2 mode
.store_sel_a:
        move.l  D0,($FFFFA01E).w                ; $0121A8  store selection A
        moveq   #$00,D0                         ; $0121AC
        move.b  ($FFFFA019).w,D0                ; $0121AE  D0 = P1 mode
        tst.b   ($FFFFA01A).w                   ; $0121B2  player flag
        bne.s   .store_sel_b                    ; $0121B6  P2 → use $A019
        move.b  ($FFFFA01C).w,D0                ; $0121B8  D0 = P2 selection
.store_sel_b:
        move.l  D0,($FFFFA022).w                ; $0121BC  store selection B
; --- final DMA: row-offset display ---
        movea.l #$0601BE00,A0                   ; $0121C0  source base
        moveq   #$00,D1                         ; $0121C6  clear offset
        move.w  ($FFFFA02C).w,D0                ; $0121C8  D0 = display row
        beq.s   .send_final                     ; $0121CC  row 0 → no offset
        subq.w  #1,D0                           ; $0121CE  D0 = row - 1
.calc_row_offset:
        addi.l  #$00000280,D1                   ; $0121D0  D1 += $280 per row
        dbra    D0,.calc_row_offset             ; $0121D6
        adda.l  D1,A0                           ; $0121DA  A0 += row offset
.send_final:
        movea.l ($FFFFA034).w,A1                ; $0121DC  A1 = VRAM dest
        move.w  #$0028,D0                       ; $0121E0  size = $28
        move.w  #$0060,D1                       ; $0121E4  width = $60
        jsr     sh2_send_cmd(pc)        ; $4EBA $C170
        addq.w  #4,($FFFFC87E).w                ; $0121EC  advance game_state
        move.w  #$0020,$00FF0008                ; $0121F0  display mode = $0020
        rts                                     ; $0121F8
