; ============================================================================
; gfx_32x_cram_fill — 32X CRAM Fill
; ROM Range: $000694-$0006BC (40 bytes)
; ============================================================================
; Fills all 256 entries (512 bytes) of 32X CRAM with the color value in D0.
; Waits for framebuffer access via adapter control register (BCLR #7 at
; MARS_CRAM-$0100), then writes 32 iterations x 16 bytes = 512 bytes.
;
; Entry: D0 = 32-bit color value to fill (typically 0 for black/clear)
; Uses: D0, D7, A0
; Hardware:
;   MARS_CRAM ($A15200): 32X color RAM (256 x 16-bit entries)
; ============================================================================

gfx_32x_cram_fill:
        MOVEM.L D0/D7/A0,-(A7)                  ; $000694
        LEA     MARS_CRAM,A0                    ; $000698
.loc_000A:
        BCLR    #7,-$0100(A0)                   ; $00069E
        BNE.S  .loc_000A                        ; $0006A4
        MOVE.W  #$001F,D7                       ; $0006A6
.loc_0016:
        MOVE.L  D0,(A0)+                        ; $0006AA
        MOVE.L  D0,(A0)+                        ; $0006AC
        MOVE.L  D0,(A0)+                        ; $0006AE
        MOVE.L  D0,(A0)+                        ; $0006B0
        DBRA    D7,.loc_0016                    ; $0006B2
        MOVEM.L (A7)+,D0/D7/A0                  ; $0006B6
        RTS                                     ; $0006BA
