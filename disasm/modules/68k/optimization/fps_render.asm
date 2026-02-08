; ============================================================================
; FPS Renderer - 2-Digit Frame Counter Display
; Location: Optimization area ($89C208+, after fps_vint_wrapper)
; ============================================================================
;
; PURPOSE
; -------
; Renders the current FPS value (from fps_value at $FFFFE602) to both
; frame buffers using an embedded 4x5 pixel font.
;
; DISPLAY LAYOUT
; --------------
; 14x7 pixel box at top-left (rows 3-9, columns 2-15):
;   - 1px black border (top/bottom/left/right)
;   - 2 digits: tens at cols 4-7, ones at cols 10-13
;   - 2px spacer between digits (cols 8-9)
;
; RENDERING METHOD
; ----------------
; Uses a 16-entry nibble-to-pixels LUT: each 4-bit font row maps to a
; longword of 4 pixel bytes. One MOVE.L per digit per row = fast rendering.
; Palette: CRAM[254]=$0000 (black BG), CRAM[255]=$7FFF (white FG).
;
; FM BIT PROTOCOL
; ---------------
; Called from V-INT epilogue. FM is likely 1 (SH2 owns VDP).
; Saves/restores FM state, temporarily clearing FM for 68K FB access.
;
; LINE TABLE
; ----------
; Entries are WORD offsets (per 32XDK wiki). Must double to get byte offset.
;
; CALLING CONVENTION
; ------------------
; Parameters: None (reads fps_value via symbol)
; Returns: Nothing
; Clobbers: Nothing (all registers saved/restored)
; Cost: ~800 cycles (~0.6% of 68K frame budget)
; ============================================================================

; --- FPS state symbols defined in fps_vint_wrapper.asm ---
; FPS_BASE, fps_value are imported from fps_vint_wrapper

fps_render:
        movem.l d0-d5/a0-a2,-(sp)

        ; --- Save FM state and claim FB + CRAM access ---
        move.w  $00A15100,d5            ; D5 = saved adapter ctrl (FM in bit 15)
        bclr    #7,$00A15100            ; FM=0 (68K gets FB + CRAM access)

        ; --- Set palette entries for counter ---
        move.w  #$0000,$00A153FC        ; CRAM[254] = black (background)
        move.w  #$7FFF,$00A153FE        ; CRAM[255] = white (foreground)

        ; --- Get FPS value, clamp 0-99, split into digits ---
        moveq   #0,d0
        move.w  fps_value,d0            ; Read fps_value from RAM
        cmpi.w  #99,d0
        bls.s   .clamp_ok
        moveq   #99,d0
.clamp_ok:
        divu    #10,d0                  ; D0.W = tens, D0[31:16] = ones
        move.w  d0,d1                   ; D1 = tens digit (0-9)
        swap    d0
        move.w  d0,d2                   ; D2 = ones digit (0-9)

        ; --- Compute font byte offsets (digit * 5 rows) ---
        mulu    #5,d1                   ; D1 = tens * 5
        mulu    #5,d2                   ; D2 = ones * 5

        ; --- Render to both frame buffers ---
        lea     $840000,a1              ; FB0
        bsr.w   .render_fb
        lea     $860000,a1              ; FB1
        bsr.w   .render_fb

        ; --- Restore FM state ---
        btst    #15,d5                  ; Was FM=1 originally?
        beq.s   .fm_done
        bset    #7,$00A15100            ; Restore FM=1
.fm_done:
        movem.l (sp)+,d0-d5/a0-a2
        rts

; ---- Render 2 digits to one frame buffer ----
; Input: A1 = FB base, D1 = tens*5, D2 = ones*5
; Uses: D0, D3, D4 (scratch), A0, A2
.render_fb:
        lea     fps_font(pc),a2         ; A2 = font + LUT base

        ; --- Top border row (line 3): solid black ---
        move.w  6(a1),d0                ; Line table[3] (byte offset 3*2=6)
        add.w   d0,d0                   ; Word offset -> byte offset
        lea     0(a1,d0.w),a0           ; A0 = pixel row for line 3
        bsr.s   .fill_bg_row

        ; --- 5 digit rows (lines 4-8, font rows 0-4) ---
        moveq   #0,d3                   ; Font row counter
.rowloop:
        ; Get pixel row address for display line (d3 + 4)
        move.w  d3,d4
        addq.w  #4,d4                   ; Display line = row + 4
        add.w   d4,d4                   ; Line table byte index = line * 2
        move.w  0(a1,d4.w),d0          ; Line table entry (word offset)
        add.w   d0,d0                   ; Word offset -> byte offset
        lea     0(a1,d0.w),a0          ; A0 = pixel row base

        ; Left border (cols 2-3)
        move.w  #$FEFE,2(a0)

        ; Tens digit (cols 4-7): look up font row in nibble LUT
        move.w  d1,d4
        add.w   d3,d4                   ; D4 = tens*5 + row
        moveq   #0,d0
        move.b  0(a2,d4.w),d0          ; Font byte (bits 3-0 = pixels)
        andi.w  #$0F,d0
        lsl.w   #2,d0                   ; LUT index = nibble * 4
        move.l  50(a2,d0.w),4(a0)      ; 4 pixels from LUT -> cols 4-7

        ; Spacer (cols 8-9)
        move.w  #$FEFE,8(a0)

        ; Ones digit (cols 10-13): same lookup
        move.w  d2,d4
        add.w   d3,d4                   ; D4 = ones*5 + row
        moveq   #0,d0
        move.b  0(a2,d4.w),d0
        andi.w  #$0F,d0
        lsl.w   #2,d0
        move.l  50(a2,d0.w),10(a0)     ; 4 pixels from LUT -> cols 10-13

        ; Right border (cols 14-15)
        move.w  #$FEFE,14(a0)

        addq.w  #1,d3
        cmpi.w  #5,d3
        blt.s   .rowloop

        ; --- Bottom border row (line 9): solid black ---
        move.w  18(a1),d0               ; Line table[9] (byte offset 9*2=18)
        add.w   d0,d0
        lea     0(a1,d0.w),a0
        ; Fall through to .fill_bg_row (tail call: its RTS returns from .render_fb)

.fill_bg_row:
        move.l  #$FEFEFEFE,2(a0)        ; Cols 2-5
        move.l  #$FEFEFEFE,6(a0)        ; Cols 6-9
        move.l  #$FEFEFEFE,10(a0)       ; Cols 10-13
        move.w  #$FEFE,14(a0)           ; Cols 14-15
        rts

; ============================================================================
; Data: 4x5 pixel font for digits 0-9 (50 bytes)
; Each byte = one row, bits 3-0 = pixels (bit 3 = leftmost)
; ============================================================================
fps_font:
        dc.b    $06,$09,$09,$09,$06     ; 0: .XX. X..X X..X X..X .XX.
        dc.b    $04,$0C,$04,$04,$07     ; 1: .X.. XX.. .X.. .X.. .XXX
        dc.b    $06,$01,$06,$08,$0F     ; 2: .XX. ...X .XX. X... XXXX
        dc.b    $06,$01,$06,$01,$06     ; 3: .XX. ...X .XX. ...X .XX.
        dc.b    $0A,$0A,$0F,$02,$02     ; 4: X.X. X.X. XXXX ..X. ..X.
        dc.b    $0F,$08,$0E,$01,$0E     ; 5: XXXX X... XXX. ...X XXX.
        dc.b    $06,$08,$0E,$09,$06     ; 6: .XX. X... XXX. X..X .XX.
        dc.b    $0F,$01,$02,$04,$04     ; 7: XXXX ...X ..X. .X.. .X..
        dc.b    $06,$09,$06,$09,$06     ; 8: .XX. X..X .XX. X..X .XX.
        dc.b    $06,$09,$07,$01,$06     ; 9: .XX. X..X .XXX ...X .XX.
        even

; ============================================================================
; Data: Nibble-to-pixels LUT (64 bytes)
; Maps each 4-bit font pattern to 4 pixel bytes (1 longword).
; $FE = palette 254 (black BG), $FF = palette 255 (white FG)
; Index = nibble * 4. Bit 3 = leftmost pixel (highest byte).
; ============================================================================
nibble_pixels:
        dc.l    $FEFEFEFE               ; $0 = ....
        dc.l    $FEFEFEFF               ; $1 = ...X
        dc.l    $FEFEFFFE               ; $2 = ..X.
        dc.l    $FEFEFFFF               ; $3 = ..XX
        dc.l    $FEFFFEFE               ; $4 = .X..
        dc.l    $FEFFFEFF               ; $5 = .X.X
        dc.l    $FEFFFFFE               ; $6 = .XX.
        dc.l    $FEFFFFFF               ; $7 = .XXX
        dc.l    $FFFEFEFE               ; $8 = X...
        dc.l    $FFFEFEFF               ; $9 = X..X
        dc.l    $FFFEFFFE               ; $A = X.X.
        dc.l    $FFFEFFFF               ; $B = X.XX
        dc.l    $FFFFFEFE               ; $C = XX..
        dc.l    $FFFFFEFF               ; $D = XX.X
        dc.l    $FFFFFFFE               ; $E = XXX.
        dc.l    $FFFFFFFF               ; $F = XXXX

; ============================================================================
; End of fps_render module (~314 bytes: ~200 code + 50 font + 64 LUT)
; ============================================================================
