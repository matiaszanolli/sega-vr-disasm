; ============================================================================
; Camera Render DMA + Overlay
; ROM Range: $013346-$0134C8 (386 bytes)
; ============================================================================
; Category: game
; Purpose: DMA transfer + 3 static SH2 DMA transfers (header, main display,
;   bottom panel). Then 5 dynamic SH2 transfers using pointer tables
;   indexed by camera selection counters ($A01A-$A020):
;     $89ABEE[replay_angle]  → $04009088 (40×10)
;     $89ABFA[music_track]   → $0400C088 (78×10)
;     $89AC7C[sfx_a]         → $0400F088 (68×10)
;     $89ACBE[sfx_b]         → $04012088 (88×10)
;   If blink toggle ($A026) active and mode != 5: sends overlay via
;   sh2_cmd_27 using table at $8934C8, waits for COMM0.
;   Copies 5×8 bytes of highlight palette from $8934E8 to CRAM+$178.
;   If blinking and mode-specific: overwrites 8 bytes in CRAM.
;   Sets $C821 display update flag, advances game_state, display $0020.
;
; Uses: D0, D1, D2, A0, A1
; RAM:
;   $A019: camera mode index (byte)
;   $A01A: replay angle counter (word)
;   $A01C: music track counter (word)
;   $A01E: SFX counter A (word)
;   $A020: SFX counter B (word)
;   $A026: blink toggle (word)
;   $C821: display update flag (byte)
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $00E35A: sh2_send_cmd
;   $00E3B4: sh2_cmd_27
;   $00E52C: dma_transfer
; ============================================================================

camera_render_dma_overlay:
        clr.w   D0                              ; $013346  mode = 0
        jsr     MemoryInit(pc)          ; $4EBA $B1E2
; --- static DMA: header area ---
        movea.l #$06018000,A0                   ; $01334C  source
        movea.l #$04004C74,A1                   ; $013352  dest
        move.w  #$0058,D0                       ; $013358  size = $58
        move.w  #$0010,D1                       ; $01335C  width = $10
        jsr     sh2_send_cmd(pc)        ; $4EBA $AFF8
; --- static DMA: main display ---
        movea.l #$0601AD00,A0                   ; $013364  source
        movea.l #$04009038,A1                   ; $01336A  dest
        move.w  #$0048,D0                       ; $013370  size = $48
        move.w  #$00A0,D1                       ; $013374  width = $A0
        jsr     sh2_send_cmd(pc)        ; $4EBA $AFE0
; --- static DMA: bottom panel ---
        movea.l #$0601DA00,A0                   ; $01337C  source
        movea.l #$04015088,A1                   ; $013382  dest
        move.w  #$0098,D0                       ; $013388  size = $98
        move.w  #$0020,D1                       ; $01338C  width = $20
        jsr     sh2_send_cmd(pc)        ; $4EBA $AFC8
; --- dynamic DMA: replay angle label ---
        lea     $0089ABEE,A0                    ; $013394  A0 = replay angle table
        move.w  ($FFFFA01A).w,D0                ; $01339A  D0 = replay_angle counter
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        movea.l $00(A0,D0.W),A0                 ; $0133A2  A0 = table[replay_angle]
        movea.l #$04009088,A1                   ; $0133A6  dest
        move.w  #$0040,D0                       ; $0133AC  size = $40
        move.w  #$0010,D1                       ; $0133B0  width = $10
        jsr     sh2_send_cmd(pc)        ; $4EBA $AFA4
; --- dynamic DMA: music track label ---
        lea     $0089ABFA,A0                    ; $0133B8  A0 = music track table
        move.w  ($FFFFA01C).w,D0                ; $0133BE  D0 = music_track counter
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        movea.l $00(A0,D0.W),A0                 ; $0133C6  A0 = table[music_track]
        movea.l #$0400C088,A1                   ; $0133CA  dest
        move.w  #$0078,D0                       ; $0133D0  size = $78
        move.w  #$0010,D1                       ; $0133D4  width = $10
        jsr     sh2_send_cmd(pc)        ; $4EBA $AF80
; --- dynamic DMA: SFX A label ---
        lea     $0089AC7C,A0                    ; $0133DC  A0 = SFX A table
        move.w  ($FFFFA01E).w,D0                ; $0133E2  D0 = sfx_a counter
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        movea.l $00(A0,D0.W),A0                 ; $0133EA  A0 = table[sfx_a]
        movea.l #$0400F088,A1                   ; $0133EE  dest
        move.w  #$0068,D0                       ; $0133F4  size = $68
        move.w  #$0010,D1                       ; $0133F8  width = $10
        jsr     sh2_send_cmd(pc)        ; $4EBA $AF5C
; --- dynamic DMA: SFX B label ---
        lea     $0089ACBE,A0                    ; $013400  A0 = SFX B table
        move.w  ($FFFFA020).w,D0                ; $013406  D0 = sfx_b counter
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        movea.l $00(A0,D0.W),A0                 ; $01340E  A0 = table[sfx_b]
        movea.l #$04012088,A1                   ; $013412  dest
        move.w  #$0088,D0                       ; $013418  size = $88
        move.w  #$0010,D1                       ; $01341C  width = $10
        jsr     sh2_send_cmd(pc)        ; $4EBA $AF38
; --- conditional overlay via sh2_cmd_27 ---
        tst.w   ($FFFFA026).w                   ; $013424  blink toggle active?
        beq.s   .copy_palette                   ; $013428  no → palette
        moveq   #$00,D0                         ; $01342A  clear D0
        move.b  ($FFFFA019).w,D0                ; $01342C  D0 = mode index
        lea     $008934C8,A1                    ; $013430  A1 = overlay table
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        movea.l $00(A1,D0.W),A0                 ; $01343A  A0 = overlay[mode]
        move.w  #$0048,D0                       ; $01343E  height = $48
        move.w  #$0010,D1                       ; $013442  width = $10
        move.w  #$0010,D2                       ; $013446  param = $10
.wait_comm0:
        tst.b   COMM0_HI                        ; $01344A  COMM0 busy?
        bne.s   .wait_comm0                     ; $013450  yes → wait
        jsr     sh2_cmd_27(pc)          ; $4EBA $AF60
; --- copy highlight palette to CRAM+$178 ---
.copy_palette:
        lea     $00FF6E00,A1                    ; $013456  A1 = CRAM base
        adda.l  #$00000178,A1                   ; $01345C  A1 += $178
        move.w  #$0004,D2                       ; $013462  copy 5 entries
.copy_pal_loop:
        lea     $008934E8,A0                    ; $013466  A0 = highlight palette
        move.w  (A0)+,(A1)+                     ; $01346C  copy word 0
        move.w  (A0)+,(A1)+                     ; $01346E  copy word 1
        move.w  (A0)+,(A1)+                     ; $013470  copy word 2
        move.w  (A0),(A1)+                      ; $013472  copy word 3
        dbra    D2,.copy_pal_loop               ; $013474  next entry
; --- conditional: overwrite mode-specific palette ---
        tst.w   ($FFFFA026).w                   ; $013478  blink active?
        beq.s   .finish                         ; $01347C  no → finish
        cmpi.b  #$05,($FFFFA019).w              ; $01347E  mode == 5?
        beq.s   .finish                         ; $013484  yes → skip
        clr.w   D0                              ; $013486
        move.b  ($FFFFA019).w,D0                ; $013488  D0 = mode index
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        lea     $00FF6E00,A1                    ; $013492  A1 = CRAM base
        adda.l  #$00000178,A1                   ; $013498  A1 += $178
        lea     $008934E0,A0                    ; $01349E  A0 = active palette
        move.w  (A0)+,$00(A1,D0.W)              ; $0134A4  overwrite word 0
        move.w  (A0)+,$02(A1,D0.W)              ; $0134A8  overwrite word 1
        move.w  (A0)+,$04(A1,D0.W)              ; $0134AC  overwrite word 2
        move.w  (A0),$06(A1,D0.W)               ; $0134B0  overwrite word 3
.finish:
        move.b  #$01,($FFFFC821).w              ; $0134B4  set display update flag
        addq.w  #4,($FFFFC87E).w                ; $0134BA  advance game_state
        move.w  #$0020,$00FF0008                ; $0134BE  display mode = $0020
        rts                                     ; $0134C6
