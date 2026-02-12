; ============================================================================
; VDP DMA Transfer Setup
; ROM Range: $001A72-$001ACA (88 bytes)
; ============================================================================
; Category: boot
; Purpose: Configures and triggers a VDP DMA transfer. Requests Z80 bus,
;   sets VDP DMA registers ($9340/$9400/$9540/$96C2/$977F) for source,
;   length, and mode. Writes VRAM destination ($C000) and triggers DMA.
;   Uses RAM-cached VDP parameters at $C874/$C876/$C880/$C882.
;
; Entry: A5 = VDP control port, A6 = VDP data port
; Uses: D0, D4, A5, A6
; RAM:
;   $C874: VDP register cache A (word)
;   $C876: DMA trigger value (word)
;   $C880: VRAM write addr high (word)
;   $C882: VRAM write addr low (word)
; ============================================================================

fn_200_033:
        move.w  (A5),D0                         ; $001A72  read VDP status
        move.l  #$40000010,(A5)                 ; $001A74  set VRAM write mode
        move.w  ($FFFFC880).w,(A6)              ; $001A7A  write VRAM addr high
        move.w  ($FFFFC882).w,(A6)              ; $001A7E  write VRAM addr low
        move.w  #$0100,Z80_BUSREQ              ; $001A82  request Z80 bus
.wait_z80:
        btst    #0,Z80_BUSREQ                  ; $001A8A  Z80 bus granted?
        bne.s   .wait_z80                       ; $001A92  no → wait
        move.w  ($FFFFC874).w,D4               ; $001A94  D4 = VDP reg cache
        bset    #4,D4                           ; $001A98  set DMA enable bit
        move.w  D4,(A5)                         ; $001A9C  write VDP register
        move.l  #$93409400,(A5)                 ; $001A9E  DMA length low/high
        move.l  #$954096C2,(A5)                 ; $001AA4  DMA source low/mid
        move.w  #$977F,(A5)                     ; $001AAA  DMA source high + mode
        move.w  #$C000,(A5)                     ; $001AAE  VRAM destination
        move.w  #$0080,($FFFFC876).w           ; $001AB2  DMA trigger = $0080
        move.w  ($FFFFC876).w,(A5)              ; $001AB8  write DMA trigger
        move.w  ($FFFFC874).w,(A5)              ; $001ABC  restore VDP register
        move.w  #$0000,Z80_BUSREQ              ; $001AC0  release Z80 bus
        rts                                     ; $001AC8
