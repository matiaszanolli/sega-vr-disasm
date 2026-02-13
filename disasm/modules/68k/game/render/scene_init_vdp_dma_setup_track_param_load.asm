; ============================================================================
; Scene Init + VDP DMA Setup + Track Parameter Load
; ROM Range: $00D3FC-$00D481 (133 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 48 bytes (12 longword entries) of scene config.
;   Code block A ($D42C): Sets VDP CRAM address, tail-jumps to palette_init.
;   Code block B ($D43A): LEA work buffer, calls nametable_init_A, tail-jumps
;   to nametable_init_B. Data table ($D44C): 4 track parameter bytes.
;   Code block C ($D450): Uses track_id ($FEA8 or $FEAC) to load parameter
;   byte from table → $C81A. Loads longword from ROM table at $898BFC
;   indexed by track_id → $FF6828 (or $FF68B8 if $C80F set).
;
; Uses: D0, D1, A0, A1, A5
; RAM:
;   $C80F: track_select_flag (byte)
;   $C81A: track_param (byte)
;   $FEA8: track_id_A (byte)
;   $FEAC: track_id_B (byte)
; Calls:
;   $00483E: nametable_init_A
;   $004842: nametable_init_B
;   $0048B8: palette_init
; ============================================================================

scene_init_vdp_dma_setup_track_param_load:
; --- data prefix: 48 bytes (12 longword scene config entries) ---
        dc.l    $00000001,$00000002             ; $00D3FC
        dc.l    $00000003,$00000005             ; $00D404
        dc.l    $00000004,$00000004             ; $00D40C
        dc.l    $00000001,$00000005             ; $00D414
        dc.l    $00000006,$00000004             ; $00D41C
        dc.l    $00000007,$00000007             ; $00D424
; --- code block A: VDP CRAM setup + palette init ---
        move.l  #$40000000,(A5)                 ; $00D42C  VDP CRAM address
        moveq   #$00,D1                         ; $00D432  D1 = 0
        jmp     $008848B8                       ; $00D434  palette_init (tail)
; --- code block B: nametable init ---
        lea     ($FFFF8000).w,A1                ; $00D43A  A1 → VDP work buffer
        moveq   #$00,D1                         ; $00D43E  D1 = 0
        jsr     $0088483E                       ; $00D440  nametable_init_A
        jmp     $00884842                       ; $00D446  nametable_init_B (tail)
; --- data table: 4 track parameter bytes ---
.track_table:
        dc.b    $05,$0A,$0F,$14                 ; $00D44C
; --- code block C: track parameter load ---
        moveq   #$00,D0                         ; $00D450  clear D0
        move.b  ($FFFFFEA8).w,D0                ; $00D452  D0 = track_id_A
        move.b  ($FFFFC80F).w,D1                ; $00D456  D1 = track_select_flag
        beq.s   .load_param                     ; $00D45A  zero → use track_id_A
        move.b  ($FFFFFEAC).w,D0                ; $00D45C  D0 = track_id_B
.load_param:
        move.b  .track_table(PC,D0.W),($FFFFC81A).w ; $00D460  track_param = table[track_id]
        lea     $00898BFC,A0                    ; $00D466  A0 → ROM longword table
        lsl.w   #2,D0                           ; $00D46C  D0 × 4 (longword stride)
        adda.l  D0,A0                           ; $00D46E  A0 += offset
        move.l  (A0),$00FF6828                  ; $00D470  load to VDP buffer A
        tst.b   D1                              ; $00D476  track_select_flag set?
        beq.s   .done                           ; $00D478  no → done
        move.l  (A0),$00FF68B8                  ; $00D47A  load to VDP buffer B
.done:
        rts                                     ; $00D480
