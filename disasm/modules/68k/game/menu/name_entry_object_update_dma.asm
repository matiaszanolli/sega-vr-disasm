; ============================================================================
; Name Entry Object Update + DMA
; ROM Range: $01035C-$0103C4 (104 bytes)
; ============================================================================
; Category: game
; Purpose: DMA transfer, object update, and character table rendering.
;   Sends SH2 DMA for VRAM block ($0601C300 → $2400E030, $80×$20).
;   Calculates name table offset: $FEB1 value × 48 + $FEA5 value × 8 + 4,
;   adds to base $FA48 to get source address for character rendering.
;   Advances game_state, display mode $0020.
;
; Uses: D0, D1, A0, A1, A2
; RAM:
;   $FA48: name table base address (long)
;   $FEA5: column offset byte
;   $FEB1: row offset byte
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $00B684: object_update
;   $00E35A: sh2_send_cmd (A0=src, A1=dest, D0=size, D1=width)
;   $00E52C: dma_transfer (D0=mode)
;   $01071C: name_entry_sub
;   $010606: character_render (A1=palette, A2=source)
; ============================================================================

name_entry_object_update_dma:
        clr.w   D0                              ; $01035C  mode = 0
        bsr.w   MemoryInit              ; $6100 $E1CC
        jsr     object_update(pc)       ; $4EBA $B320
        bsr.w   name_entry_background_tile_transfer; $6100 $03B4
        movea.l #$0601C300,A0                   ; $01036A  A0 = VRAM source
        movea.l #$2400E030,A1                   ; $010370  A1 = display dest
        move.w  #$0080,D0                       ; $010376  size = $80
        move.w  #$0020,D1                       ; $01037A  width = $20
        dc.w    $4EBA,$DFDA                     ; $01037E  bsr.w sh2_send_cmd ($00E35A)
        lea     $2402F0C0,A1                    ; $010382  A1 = palette base
        lea     ($FFFFFA48).w,A2                ; $010388  A2 = name table base
        moveq   #$00,D0                         ; $01038C
        move.b  ($FFFFFEB1).w,D0                ; $01038E  D0 = row offset
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        move.w  D0,D1                           ; $010398  D1 = × 8
        add.w   d0,d0                   ; $D040
        add.w   d1,d0                   ; $D041
        add.w   d0,d0                   ; $D040
        adda.l  D0,A2                           ; $0103A0  A2 += row × 48
        moveq   #$00,D0                         ; $0103A2
        move.b  ($FFFFFEA5).w,D0                ; $0103A4  D0 = column offset
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        addq.w  #4,D0                           ; $0103AE  + 4 (header skip)
        adda.l  D0,A2                           ; $0103B0  A2 += col × 8 + 4
        bsr.w   lap_time_digit_renderer_a; $6100 $0252
        addq.w  #4,($FFFFC87E).w                ; $0103B6  advance game_state
        move.w  #$0020,$00FF0008                ; $0103BA  display mode = $0020
        rts                                     ; $0103C2
