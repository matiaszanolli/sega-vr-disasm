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

fn_10200_011:
        clr.w   D0                              ; $01035C  mode = 0
        dc.w    $6100,$E1CC                     ; $01035E  bsr.w dma_transfer ($00E52C)
        dc.w    $4EBA,$B320                     ; $010362  bsr.w object_update ($00B684)
        dc.w    $6100,$03B4                     ; $010366  bsr.w name_entry_sub ($01071C)
        movea.l #$0601C300,A0                   ; $01036A  A0 = VRAM source
        movea.l #$2400E030,A1                   ; $010370  A1 = display dest
        move.w  #$0080,D0                       ; $010376  size = $80
        move.w  #$0020,D1                       ; $01037A  width = $20
        dc.w    $4EBA,$DFDA                     ; $01037E  bsr.w sh2_send_cmd ($00E35A)
        lea     $2402F0C0,A1                    ; $010382  A1 = palette base
        lea     ($FFFFFA48).w,A2                ; $010388  A2 = name table base
        moveq   #$00,D0                         ; $01038C
        move.b  ($FFFFFEB1).w,D0                ; $01038E  D0 = row offset
        dc.w    $D040                           ; $010392  add.w d0,d0 — × 2
        dc.w    $D040                           ; $010394  add.w d0,d0 — × 4
        dc.w    $D040                           ; $010396  add.w d0,d0 — × 8
        move.w  D0,D1                           ; $010398  D1 = × 8
        dc.w    $D040                           ; $01039A  add.w d0,d0 — × 16
        dc.w    $D041                           ; $01039C  add.w d1,d0 — × 24
        dc.w    $D040                           ; $01039E  add.w d0,d0 — × 48
        adda.l  D0,A2                           ; $0103A0  A2 += row × 48
        moveq   #$00,D0                         ; $0103A2
        move.b  ($FFFFFEA5).w,D0                ; $0103A4  D0 = column offset
        dc.w    $D040                           ; $0103A8  add.w d0,d0 — × 2
        dc.w    $D040                           ; $0103AA  add.w d0,d0 — × 4
        dc.w    $D040                           ; $0103AC  add.w d0,d0 — × 8
        addq.w  #4,D0                           ; $0103AE  + 4 (header skip)
        adda.l  D0,A2                           ; $0103B0  A2 += col × 8 + 4
        dc.w    $6100,$0252                     ; $0103B2  bsr.w character_render ($010606)
        addq.w  #4,($FFFFC87E).w                ; $0103B6  advance game_state
        move.w  #$0020,$00FF0008                ; $0103BA  display mode = $0020
        rts                                     ; $0103C2
