; ============================================================================
; VDP Register Initialization
; ROM Range: $000FEA-$001034 (74 bytes)
; ============================================================================
; Disables interrupts, requests Z80 bus, calls io_port_init ($0018D8),
; releases Z80 bus, restores SR. Then loads a 19-byte register table
; and programs all VDP registers ($00-$12). Also initializes VDP
; register caches at $C874/$C875.
;
; Memory:
;   $FFFFC874 = VDP register cache 1 (byte, set to $81 = mode reg 1)
;   $FFFFC875 = VDP register cache 2 (byte, loaded from table[1])
; Entry: A5 = VDP control port | Exit: VDP initialized
; Uses: D0, D7, A0, A5
; ============================================================================

vdp_reg_init:
        move    SR,-(a7)                        ; $000FEA: $40E7 — save status register
        move    #$2700,SR                       ; $000FEC: $46FC $2700 — disable all interrupts
        move.w  #$0100,Z80_BUSREQ              ; $000FF0: $33FC $0100 $00A1 $1100 — request Z80 bus
.wait_z80:
        btst    #0,Z80_BUSREQ                  ; $000FF8: $0838 $0000 $00A1 $1100 — bus granted?
        bne.s   .wait_z80                       ; $001000: $66F6
        dc.w    $4EBA,$08D4                     ; JSR io_port_init(PC) ; $001002: → $0018D8
        move.w  #$0000,Z80_BUSREQ              ; $001006: $33FC $0000 $00A1 $1100 — release Z80 bus
        move    (a7)+,SR                        ; $00100E: $46DF — restore status register
        dc.w    $41FA,$0022                     ; LEA vdp_reg_table(PC),A0 ; $001010: → $001034
        move.b  #$81,($FFFFC874).w             ; $001014: $11FC $0081 $C874 — VDP mode reg 1 cache
        move.b  $0001(a0),($FFFFC875).w        ; $00101A: $11E8 $0001 $C875 — VDP cache 2 from table
        move.w  #$8000,d0                       ; $001020: $303C $8000 — VDP reg write base ($80xx)
        moveq   #$12,d7                         ; $001024: $7E12 — 19 registers ($00-$12)
.write_regs:
        move.b  (a0)+,d0                        ; $001026: $1018 — load register value
        move.w  d0,(A5)                         ; $001028: $3A80 — write $80xx to VDP control
        addi.w  #$0100,d0                       ; $00102A: $0640 $0100 — advance to next register
        dbra    d7,.write_regs                  ; $00102E: $51CF $FFF6 — loop 19 times
        rts                                     ; $001032: $4E75
