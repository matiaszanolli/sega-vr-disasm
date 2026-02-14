; ============================================================================
; VDP DMA Transfer Setup (Scroll Data)
; ROM Range: $0019EA-$001A64 (122 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 10-word VDP register configuration table.
;   Code: Reads VDP status (A5), sets VDP address $6C000003 (scroll table),
;   writes 2 words from $8000/$8002 (scroll A/B). Sets VDP address
;   $40000010, writes 2 words from $C880/$C882.
;   Performs Z80 bus request cycle, configures DMA registers
;   ($9340/$9400/$9540/$96C2/$977F), sets DMA target $C000, triggers
;   with $0080 from $C876, restores VDP mode from $C874, releases Z80 bus.
;
; Uses: D0, D3, D4, D5, A1, A5, A6
; RAM:
;   $8000: VDP scroll A (word)
;   $8002: VDP scroll B (word)
;   $C874: VDP mode register cache (word)
;   $C876: DMA trigger register cache (word)
;   $C880: VDP parameter A (word)
;   $C882: VDP parameter B (word)
; ============================================================================

vdp_dma_xfer_setup_0019ea:
; --- data prefix: 10-word VDP register table ---
        dc.w    $400C                           ; $0019EA  VDP reg: $400C
        negx.b   d3                     ; $4003
        dc.w    $000C                           ; $0019EE  param: $000C
        dc.w    $0003                           ; $0019F0  param: $0003
        dc.w    $00A1                           ; $0019F2  addr: $00A1
        dc.w    $0003                           ; $0019F4  param: $0003
        dc.w    $00A1                           ; $0019F6  addr: $00A1
        dc.w    $0005                           ; $0019F8  param: $0005
        dc.w    $00A1                           ; $0019FA  addr: $00A1
        dc.w    $0007                           ; $0019FC  param: $0007
; --- code ---
        move.w  (A5),D0                         ; $0019FE  D0 = VDP status
        move.l  #$6C000003,(A5)                ; $001A00  VDP addr = scroll table
        move.w  ($FFFF8000).w,(A6)             ; $001A06  write scroll A
        move.w  ($FFFF8002).w,(A6)             ; $001A0A  write scroll B
        move.l  #$40000010,(A5)                ; $001A0E  VDP addr = $40000010
        move.w  ($FFFFC880).w,(A6)             ; $001A14  write VDP param A
        move.w  ($FFFFC882).w,(A6)             ; $001A18  write VDP param B
        move.w  #$0100,Z80_BUSREQ              ; $001A1C  request Z80 bus
.wait_z80:
        btst    #0,Z80_BUSREQ                  ; $001A24  Z80 bus granted?
        bne.s   .wait_z80                       ; $001A2C  no → wait
        move.w  ($FFFFC874).w,D4               ; $001A2E  D4 = VDP mode register
        bset    #4,D4                           ; $001A32  set DMA enable bit
        move.w  D4,(A5)                         ; $001A36  write mode register
        move.l  #$93409400,(A5)                ; $001A38  DMA length low/high
        move.l  #$954096C2,(A5)                ; $001A3E  DMA source low/mid
        move.w  #$977F,(A5)                    ; $001A44  DMA source high + type
        move.w  #$C000,(A5)                    ; $001A48  DMA target = $C000
        move.w  #$0080,($FFFFC876).w          ; $001A4C  DMA trigger = $0080
        move.w  ($FFFFC876).w,(A5)             ; $001A52  write DMA trigger
        move.w  ($FFFFC874).w,(A5)             ; $001A56  restore VDP mode
        move.w  #$0000,Z80_BUSREQ              ; $001A5A  release Z80 bus
        rts                                     ; $001A62
