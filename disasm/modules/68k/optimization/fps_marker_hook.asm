; ============================================================================
; FPS Marker Hook - Size-neutral palette+marker wrapper
; Location: Optimization area (code_1c200)
; ============================================================================
;
; Called from fn_200_041 in place of two PC-relative JSRs to palette copy
; routines at $0048D6 and $0048DA. Replaces 8 bytes (2x4-byte JSR d16,PC)
; with 8 bytes (6-byte JSR abs.l + 2-byte NOP).
;
; This function:
;   1. Calls the two original palette copy routines (preserving behavior)
;   2. Writes a minimal test marker to both frame buffers
;
; Context when called:
;   - FM=0 (68K has frame buffer access, set by fn_200_041)
;   - VBLK is active (confirmed by fn_200_041's busy-wait loop)
;   - A1 = $00FF6E00 (palette data source in work RAM)
;   - A2 = $00A15200 (CRAM base)
;
; Register contract:
;   - A1, A2: passed through to palette routines (may be clobbered)
;   - D0, A0: used as scratch for marker writes (saved/restored)
;   - All other registers preserved
;
; Related: fn_200_041.asm, fps_vint_wrapper.asm
; ============================================================================

fps_marker_hook:
        ; --- Step 1: Call original palette copy routines ---
        ; These were originally at fn_200_041 $001FE4 and $001FE8
        ; as JSR (d16,PC) with displacement $28F0
        jsr     $008848D6               ; Palette copy 1 (ROM $0048D6)
        jsr     $008848DA               ; Palette copy 2 (ROM $0048DA)

        ; --- DIAGNOSTIC: Layered tests to isolate failure point ---
        ; Test A: Write $CAFE to COMM4 (proves hook executes; check in debugger)
        move.w  #$CAFE,$00A15128        ; COMM4 = $CAFE
        ; Test B: Set CRAM[0] = bright green (proves CRAM writes work; visible on screen)
        ;         In BGR555: B=0, G=31, R=0 = $03E0
        move.w  #$03E0,$00A15200        ; CRAM[0] = green background

        ; --- Step 2: Force CRAM[0xFF] = white AFTER palette copy ---
        ; The palette routines just wrote the game's full 256-entry palette
        ; to CRAM, overwriting our init-time setup. We must re-set entry $FF
        ; to white here, every frame, so our $FF-indexed marker pixels show
        ; as white instead of whatever the game uses for palette entry $FF.
        move.w  #$FFFF,$00A153FE        ; CRAM[0xFF] = white (RGB555 + priority)

        ; --- Step 3: Write minimal test marker to frame buffers ---
        ; FM=0 and VBLK guaranteed by caller. Write 10 white pixels
        ; at line 20, column 4 using line-table-derived address.
        ; NOTE: Line table entries are WORD offsets (per 32XDK wiki/d32xr/marsdev),
        ; must double to get byte offset before adding to FB base.
        movem.l d0/a0,-(sp)

        ; FB0 ($840000)
        lea     $840000,a0              ; Frame buffer 0 base
        move.w  (40)(a0),d0             ; Line table entry for line 20 (20*2=40)
        add.w   d0,d0                   ; Convert word offset → byte offset
        adda.w  d0,a0                   ; A0 = pixel row base
        move.w  #$FFFF,4(a0)            ; Columns 4-5 (2 white pixels)
        move.w  #$FFFF,6(a0)            ; Columns 6-7
        move.w  #$FFFF,8(a0)            ; Columns 8-9
        move.w  #$FFFF,10(a0)           ; Columns 10-11
        move.w  #$FFFF,12(a0)           ; Columns 12-13

        ; FB1 ($860000)
        lea     $860000,a0              ; Frame buffer 1 base
        move.w  (40)(a0),d0             ; Line table entry for line 20
        add.w   d0,d0                   ; Convert word offset → byte offset
        adda.w  d0,a0
        move.w  #$FFFF,4(a0)
        move.w  #$FFFF,6(a0)
        move.w  #$FFFF,8(a0)
        move.w  #$FFFF,10(a0)
        move.w  #$FFFF,12(a0)

        movem.l (sp)+,d0/a0
        rts

; ============================================================================
; End of fps_marker_hook (~100 bytes)
; ============================================================================
