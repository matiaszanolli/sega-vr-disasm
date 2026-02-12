; ============================================================================
; Scene Init + VDP DMA Setup + Track Parameter Load
; ROM Range: $00D3FC-$00D482 (134 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 12 bytes of padding/table ($00,$00,$00,$01...).
;   Code: Sets VDP CRAM address $40000000, calls palette init ($48B8) and
;   nametable init ($483E/$4842). Uses track_id ($FEA8 or $FEB8) to load
;   parameter byte from table at $D44C → $C826. Loads longword from ROM
;   table $898BFC[track_id×4] → $FF6828 (or $FF68B8 if $C80F set).
;
; Uses: D0, D1, D7, A0, A1, A4, A5
; RAM:
;   $C80F: track_select_flag (byte)
;   $C826: track_param (byte)
;   $FEA8: track_id_A (byte)
;   $FEB8: track_id_B (byte)
; Calls:
;   $00483E: nametable_init_A
;   $004842: nametable_init_B
;   $0048B8: palette_init
; ============================================================================

fn_c200_022:
; --- data prefix: 12 bytes ---
        dc.b    $00,$00,$00,$01                 ; $00D3FC
        dc.b    $00,$00,$00,$02                 ; $00D400
        dc.b    $00,$00,$00,$03                 ; $00D404
; --- code: VDP + track init ---
        move.l  #$40000000,(A5)                 ; $00D42C  VDP CRAM address
        moveq   #$00,D1                         ; $00D432  D1 = 0
        jmp     $008848B8                       ; $00D434  palette_init
        lea     ($FFFF8000).w,A1                ; $00D43A  A1 → VDP work buffer
        moveq   #$00,D1                         ; $00D43E  D1 = 0
        jsr     $0088483E                       ; $00D440  nametable_init_A
        jmp     $00884842                       ; $00D446  nametable_init_B (tail)
        dc.w    $050A                           ; $00D44C  table entry 0
        dc.w    $0774                           ; $00D44E  table entry 1
; --- track parameter load ---
        moveq   #$00,D0                         ; $00D450  clear D0
        move.b  ($FFFFFEA8).w,D0                ; $00D452  D0 = track_id_A
        move.b  ($FFFFC80F).w,D1                ; $00D456  D1 = track_select_flag
        beq.s   .load_param                     ; $00D45A  zero → use track_id_A
        move.b  ($FFFFFEB8).w,D0                ; $00D45C  D0 = track_id_B
.load_param:
        move.b  $00D44C(PC,D0.W),($FFFFC826).w  ; $00D460  track_param = table[track_id]
        lea     $00898BFC,A0                    ; $00D466  A0 → ROM longword table
        lsl.w   #2,D0                           ; $00D46C  D0 × 4 (longword stride)
        adda.l  D0,A0                           ; $00D46E  A0 += offset
        move.l  (A0),$00FF6828                  ; $00D470  load to VDP buffer A
        tst.b   D1                              ; $00D476  track_select_flag set?
        beq.s   .done                           ; $00D478  no → done
        move.l  (A0),$00FF68B8                  ; $00D47A  load to VDP buffer B
.done:
        rts                                     ; $00D480
