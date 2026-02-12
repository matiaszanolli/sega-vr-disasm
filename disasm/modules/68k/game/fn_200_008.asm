; ============================================================================
; System Initialization Orchestrator
; ROM Range: $000D68-$000DC4 (92 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Main system initialization routine. Calls RAM clear, Z80/VDP init,
; controller port init (if config changed), and a fourth init sub.
; Then configures MARS interrupt control, VDP mode, and jumps into
; the game initialization chain.
;
; Contains an embedded sub-function at $000DB0 that clears ~47KB of
; work RAM ($FF1000-$FFFDFF) with zero-fill.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFFEA4  Cached controller config (byte)
;   $FFFFC818  Current controller config (byte)
;
; Entry: none
; Uses: D0, D1, D7, A1, A2
; Calls: $000DB0 (RAM clear), $000FEA (z80_bus_vdp_init),
;        $00170C (controller_port_init), $001048 (init sub)
; ============================================================================

fn_200_008:
        DC.W    $4EBA,$0046         ; JSR     $000DB0(PC); $000D68 — clear work RAM
        DC.W    $4EBA,$027C         ; JSR     $000FEA(PC); $000D6C — init Z80 bus + VDP
        move.b  ($FFFFFEA4).w,d0                ; $000D70: load cached controller config
        cmp.b   ($FFFFC818).w,d0                ; $000D74: compare with current
        beq.s   .skip_ctrl_init                 ; $000D78: same: skip reinit
        DC.W    $4EBA,$0990         ; JSR     $00170C(PC); $000D7A — init controller ports
        move.b  ($FFFFC818).w,($FFFFFEA4).w     ; $000D7E: cache new config
.skip_ctrl_init:
        DC.W    $4EBA,$02C2         ; JSR     $001048(PC); $000D84 — fourth init sub
        move.w  #$0083,MARS_SYS_INTCTL          ; $000D88: enable MARS interrupts
        andi.b  #$FC,MARS_VDP_MODE+1            ; $000D90: clear VDP mode bits 0-1
        jsr     $0088266C                       ; $000D98: game init chain A
        jsr     $008826C8                       ; $000D9E: game init chain B
        lea     $008BA020,a2                    ; $000DA4: object table base
        jmp     $0088284C                       ; $000DAA: jump to main init

; --- Embedded sub: Clear work RAM ($FF1000, ~47KB) ---
; Entry: none | Uses: D1, D7, A1
fn_200_008_clear_ram:
        lea     $00FF1000,a1                    ; $000DB0: start of clearable RAM
        moveq   #$00,d1                         ; $000DB6: zero fill value
        move.w  #$2E67,d7                       ; $000DB8: 11880 longwords = 47520 bytes
.clear_loop:
        move.l  d1,(a1)+                        ; $000DBC: write zero longword
        dbra    d7,.clear_loop                  ; $000DBE: loop
        rts                                     ; $000DC2: $4E75
