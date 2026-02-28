; ============================================================================
; Name Entry Color/Palette Update
; ROM Range: $0119B8-$011A5C (164 bytes)
; ============================================================================
; Category: game
; Purpose: Updates name entry palette with animated color cycling.
;   Copies 8 base palette entries from ROM, then generates 4 dynamic
;   entries by splitting RGB channels, shifting/combining with OR.
;   Color offset ($A019) animates via BCD-style clamped increment/decrement
;   driven by fade direction ($A01C).
;
; Uses: D0, D1, D2, D3, D4, D5, A0, A1
; RAM:
;   $A019: color offset index (byte)
;   $A01A: brightness value (byte)
;   $A01C: fade direction/step (byte)
;   $C821: display update flag (byte, set to $01)
;   $FF6E00+$1E0: palette destination (CRAM)
; ============================================================================

name_entry_color_palette_update:
        lea     $00FF6E00,A0                    ; $0119B8  A0 = CRAM base
        adda.l  #$000001E0,A0                   ; $0119BE  A0 = CRAM + $1E0 (palette slot)
        lea     $00891A70,A1                    ; $0119C4  A1 = base palette ROM data
        move.w  #$0007,D0                       ; $0119CA  copy 8 entries
.copy_base:
        move.w  (A1)+,D1                        ; $0119CE  read palette entry
        bset    #15,D1                          ; $0119D0  set priority bit
        move.w  D1,(A0)+                        ; $0119D4  write to CRAM
        dbra    D0,.copy_base                   ; $0119D6
        moveq   #$00,D0                         ; $0119DA  clear D0
        move.b  ($FFFFA019).w,D0                ; $0119DC  D0 = color offset
        add.l   d0,d0                   ; $D080
        add.l   d0,d0                   ; $D080
        add.l   d0,d0                   ; $D080
        lea     $00FF6E00,A0                    ; $0119E6  A0 = CRAM base
        adda.l  #$000001E0,A0                   ; $0119EC  A0 = CRAM + $1E0
        adda.l  D0,A0                           ; $0119F2  A0 += offset × 8
        lea     $00891A80,A1                    ; $0119F4  A1 = dynamic palette ROM data
        moveq   #$00,D1                         ; $0119FA  clear D1
        move.b  ($FFFFA01A).w,D1                ; $0119FC  D1 = brightness
        move.w  #$0003,D2                       ; $011A00  process 4 entries
.process_color:
        move.w  (A1)+,D5                        ; $011A04  D5 = blue component
        bsr.s   cursor_pos_clamp                ; $011A06  scale blue component
        move.w  D5,D3                           ; $011A08  D3 = scaled blue
        move.w  (A1)+,D5                        ; $011A0A  D5 = green component
        bsr.s   cursor_pos_clamp                ; $011A0C  scale green component
        move.w  D5,D4                           ; $011A0E  D4 = scaled green
        move.w  (A1)+,D5                        ; $011A10  D5 = red component
        bsr.s   cursor_pos_clamp                ; $011A12  scale red component
        lsl.w   #5,D4                           ; $011A14  green << 5
        lsl.w   #8,D5                           ; $011A16  red << 8
        lsl.w   #2,D5                           ; $011A18  red << 10 total
        or.w    d4,d3                   ; $8644
        or.w    d5,d3                   ; $8645
        bset    #15,D3                          ; $011A1E  set priority bit
        move.w  D3,(A0)+                        ; $011A22  write final color to CRAM
        dbra    D2,.process_color               ; $011A24
        move.b  ($FFFFA01A).w,D0                ; $011A28  D0 = current brightness
        move.b  ($FFFFA01C).w,D1                ; $011A2C  D1 = fade step
        add.b   d1,d0                   ; $D001
        cmpi.b  #$1F,D0                         ; $011A32  brightness > 31?
        ble.s   .check_min                      ; $011A36  no → check minimum
        move.b  #$1F,D0                         ; $011A38  clamp to max 31
        move.b  #$FE,D1                         ; $011A3C  reverse direction (-2)
        bra.s   .store_brightness               ; $011A40
.check_min:
        tst.b   D0                              ; $011A42  brightness < 0?
        bge.s   .store_brightness               ; $011A44  no → store
        clr.b   D0                              ; $011A46  clamp to min 0
        move.b  #$02,D1                         ; $011A48  reverse direction (+2)
.store_brightness:
        move.b  D0,($FFFFA01A).w                ; $011A4C  store brightness
        move.b  D1,($FFFFA01C).w                ; $011A50  store fade direction
        move.b  #$01,($FFFFC821).w              ; $011A54  flag display update
        rts                                     ; $011A5A
