; ============================================================================
; VDP Register Write, Frame Swap, and CRAM Copy
; ROM Range: $001E42-$001E94 (82 bytes)
; ============================================================================
;
; PURPOSE
; -------
; End-of-frame display update: writes VDP scroll/VRAM data via the VDP
; ports (A5=control, A6=data), resets the game state, toggles the MARS
; frame buffer swap bit, and copies 512 bytes of CRAM palette from work
; RAM at $A100 to the 32X CRAM.
;
; MEMORY VARIABLES
; ----------------
;   $FFFF8000  VDP scroll data A (word, written to VDP data port)
;   $FFFF8002  VDP scroll data B (word, written to VDP data port)
;   $FFFFC880  VDP register data A (word, written to VDP data port)
;   $FFFFC882  VDP register data B (word, written to VDP data port)
;   $FFFFC87E  Main game state index (word, cleared to 0)
;   $FFFFC80C  Frame toggle flag (bit 0 toggled)
;   $00A1518B  MARS adapter register (bit 0 = frame buffer select)
;   $FFFFA100  CRAM palette buffer (512 bytes, source for copy)
;
; Entry: A5 = VDP control port, A6 = VDP data port
; Exit:  VDP updated, frame swapped, CRAM copied
; Uses: D0, A0, A1
; ============================================================================

fn_200_039:
        move.w  (a5),d0                         ; $001E42: read VDP status
        move.l  #$6C000003,(a5)                 ; $001E44: set VDP VSRAM write address
        move.w  ($FFFF8000).w,(a6)              ; $001E4A: write scroll data A
        move.w  ($FFFF8002).w,(a6)              ; $001E4E: write scroll data B
        move.l  #$40000010,(a5)                 ; $001E52: set VDP VRAM write address
        move.w  ($FFFFC880).w,(a6)              ; $001E58: write register data A
        move.w  ($FFFFC882).w,(a6)              ; $001E5C: write register data B
        move.w  #$0000,($FFFFC87E).w            ; $001E60: $31FC $0000 $C87E — reset game state
        bchg    #0,($FFFFC80C).w                ; $001E66: $0178 $0000 $C80C — toggle frame flag
        bne.s   .frame_1                        ; $001E6C: was 1 → now 0
        bset    #0,$00A1518B                    ; $001E6E: select frame buffer 1
        bra.s   .copy_cram                      ; $001E76
.frame_1:
        bclr    #0,$00A1518B                    ; $001E78: select frame buffer 0
.copy_cram:
        lea     ($FFFFA100).w,a0                ; $001E80: palette buffer in work RAM
        lea     MARS_CRAM,a1                    ; $001E84: 32X CRAM destination
        moveq   #$7F,d0                         ; $001E8A: 128 longwords = 512 bytes
.copy_loop:
        move.l  (a0)+,(a1)+                     ; $001E8C: copy one longword
        dbra    d0,.copy_loop                   ; $001E8E: loop 128 times
        rts                                     ; $001E92: $4E75
