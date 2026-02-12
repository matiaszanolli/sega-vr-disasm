; ============================================================================
; VDP DMA Transfer Setup
; ROM Range: $001ACA-$001B14 (74 bytes)
; ============================================================================
; Requests Z80 bus, configures VDP DMA registers for a transfer, updates
; the VDP register cache ($C874/$C876), and releases the Z80 bus.
; Sets bit 4 of the VDP mode register to enable display during DMA.
;
; Memory:
;   $FFFFC874 = VDP register cache 1 (word, read + written to VDP)
;   $FFFFC876 = VDP register cache 2 (word, set to $0083, written to VDP)
; Entry: A5 = VDP control port | Exit: DMA configured | Uses: D0, D4, A5
; ============================================================================

fn_200_034:
        move.w  (A5),d0                         ; $001ACA: $3015 — read VDP status
        move.w  #$0100,Z80_BUSREQ              ; $001ACC: $33FC $0100 $00A1 $1100 — request Z80 bus
.wait_z80:
        btst    #0,Z80_BUSREQ                  ; $001AD4: $0838 $0000 $00A1 $1100 — bus granted?
        bne.s   .wait_z80                       ; $001ADC: $66F6
        move.w  ($FFFFC874).w,d4               ; $001ADE: $3838 $C874 — load VDP reg cache 1
        bset    #4,d4                           ; $001AE2: $08C4 $0004 — set display enable bit
        move.w  d4,(A5)                         ; $001AE6: $3A84 — write mode register to VDP
        move.l  #$93809401,(A5)                 ; $001AE8: $2ABC $9380 $9401 — DMA length = $0180
        move.l  #$951E96C0,(A5)                 ; $001AEE: $2ABC $951E $96C0 — DMA source low/mid
        move.w  #$977F,(A5)                     ; $001AF4: $3ABC $977F — DMA source high
        move.w  #$6C3C,(A5)                     ; $001AF8: $3ABC $6C3C — VRAM destination / trigger
        move.w  #$0083,($FFFFC876).w           ; $001AFC: $31FC $0083 $C876 — update VDP cache 2
        move.w  ($FFFFC876).w,(A5)             ; $001B02: $3A78 $C876 — write VDP cache 2
        move.w  ($FFFFC874).w,(A5)             ; $001B06: $3A78 $C874 — write VDP cache 1
        move.w  #$0000,Z80_BUSREQ              ; $001B0A: $33FC $0000 $00A1 $1100 — release Z80 bus
        rts                                     ; $001B12: $4E75
