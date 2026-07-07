/*
 * bridge_probe — VR60 Phase 5F-1b SH2->Render Bridge VALIDATION PROBE
 * Expansion ROM Address: $3039E0 (SH2: $023039E0)
 *
 * ============================================================================
 *  PURPOSE — diagnostic only, NOT the full port
 * ============================================================================
 * Re-scoped per VR60_PHASE5F1B_PROBE_DIAGNOSIS.md (2026-06-18). The original
 * probe wrote $0600C218 — but the per-frame racing render (Slave cmd $02
 * handler $06000FA8, re-triggered by cmd $3F via COMM2_HI=$02) NEVER reads
 * C218. It reads its display-object descriptors from C128/C178/C254 via the
 * entity loop $060024DC ($14 / 20-byte stride). C218 feeds only the non-racing
 * handlers ($01/$04/$05/$07) through dispatcher $06000DC8. So the C218 write
 * was a semantic no-op at the wrong address (H1, the operative root cause).
 *
 * This probe now implements the diagnosis's recommended **Run C**: clear the
 * visibility word of the LARGEST racing descriptor block, $0600C254 (56 entries,
 * $14 stride) — the bulk opponent-car descriptors most likely.
 *
 * Mechanism (entity-loop gate, decoded $060024DE-E2):
 *   $060024DE  MOV.W @(0,R14),R0
 *   $060024E0  CMP/EQ #0,R0
 *   $060024E2  BT  $060024FE      ; descriptor +$00 == 0  ->  skip render (HIDDEN)
 * The 68K writer confirms the semantics: vdp_sprite_pointer_setup_cond_disp_
 * clear.asm:36-45 clears $FF6128 +$00 to disable; sfx_trigger_object_enable_
 * fields.asm:7 sets +$00 = 1 to enable. So 0 = invisible, and +$00 is the gate.
 * For these $14-stride records only +$00 matters (the +$14/+$28 of the old
 * probe were for the $3C-stride C218 format and are NOT used here — clearing
 * +$00 of every record already covers the block contiguously).
 *
 * WHAT THE PROBE DOES (this build = Run C):
 *   Clears descriptor +$00 = $0000 on all 56 records of the $0600C254 block,
 *   $14 stride, written CACHE-THROUGH at $2600C254 (= $0600C254 | $20000000).
 *   Range: $2600C254 .. $2600C6B4 (excl). Stays below batch-G descriptor
 *   $0600C6DC and well below Huffman $0600C800 — no collision (region map:
 *   SH2_RENDERING_ARCHITECTURE.md:131-139).
 *
 * ============================================================================
 *  RUN SELECTOR — flip blocks in ONE LINE (see .bp_desc_base / .bp_count below)
 * ============================================================================
 *   Run C (THIS BUILD): base $2600C254, count 56  (batch 3, largest)
 *   Run A             : base $2600C128, count  4  (batch 1)
 *   Run B             : base $2600C178, count  8  (batch 2)
 *
 *   To switch runs, edit exactly TWO lines at the bottom of this file:
 *     1) `.bp_desc_base: .long 0x2600C254`  -> 0x2600C128 (A) or 0x2600C178 (B)
 *     2) `mov #56,r2`                       -> #4 (A) or #8 (B)
 *   Stride stays $14 for all three. Then `make clean && make all`.
 *
 * EXPECTED VISIBLE EFFECT (racing scene, opponent cars on screen):
 *   Whichever on-screen elements live in the targeted block VANISH.
 *   INTERPRETATION MATRIX:
 *     - opponent CARS vanish  => C254 is the racing bridge target. GREEN LIGHT
 *                                for the re-scoped 5F-1b port (target this block).
 *     - HUD / viewport / track-sprites vanish instead => C254 holds those;
 *                                try Run A then Run B for the cars.
 *     - nothing changes       => cars come from a block not in {C128,C178,C254}
 *                                (batch-0 camera C100->CA00, or on-chip Pipeline-1
 *                                path) -> escalate / re-trace.
 *
 * ADDRESSING (H-4 cache coherency — still mandatory at the CORRECT address):
 *   Writes use the Master CACHE-THROUGH alias $2600C254. KNOWN_ISSUES.md
 *   "Cache-Through Addressing for Shared Memory": Master->Slave SDRAM writes
 *   MUST be cache-through or the store stays in the Master data cache and never
 *   reaches DRAM for the Slave to read. (H-4 was correct in the old probe; it
 *   failed only because C218 was the wrong block.)
 *
 * REGISTER CONVENTION (VR60 §7.9): called from cmd $3F where GBR = player entity
 *   ($0600F20C) and R8 = COMM base. This probe is a leaf: clobbers R0-R2 only,
 *   preserves GBR/R8/R13/R15, so the cmd $3F relay/cleanup tail is unaffected.
 *
 * REVERT (one line, in cmd3f_vr60_gameframe.asm): swap the `.bridge_addr`
 *   literal back to `.patcher_addr` (sh2_render_state_patch, the no-op patcher)
 *   per that file's "5F-1b PROBE" marker. This routine is otherwise inert.
 *
 * Clobbers: R0,R1,R2. Preserves: everything else (no PR save — leaf).
 * ============================================================================
 */

.section .text
.align 2

.global bridge_probe
bridge_probe:
    /* --- EXECUTION SENTINEL (diagnostic): write $DEADBEEF to real SDRAM
     * cache-through $2600FC00. If cmd $3F executes this handler, the sentinel
     * reaches DRAM (cache-through bypasses the write-back cache confound) and is
     * observable at $0600FC00. Proves execution independent of descriptor theory. */
    mov.l   @(.bp_sentinel_addr,pc),r1
    mov.l   @(.bp_sentinel_val,pc),r0
    mov.l   r0,@r1                    /* $2600FC00 = $DEADBEEF */

    /* R1 = descriptor base, CACHE-THROUGH (see .bp_desc_base) */
    mov.l   @(.bp_desc_base,pc),r1   /* R1 = $2600C254 (Run C) */
    mov     #56,r2                    /* R2 = descriptor count (Run C = 56; A=4, B=8) */
    mov     #0,r0                     /* R0 = 0 (invisible) */
.bp_loop:
    mov.w   r0,@r1                    /* descriptor +$00 visibility word = 0 (HIDDEN) */
    add     #0x14,r1                  /* next descriptor (stride 20 = $14) */
    dt      r2                        /* count-- */
    bf      .bp_loop                  /* loop while != 0 */
    rts
    nop

.align 2
.bp_sentinel_addr:
    .long   0x2600FC00               /* real SDRAM cache-through execution sentinel */
.bp_sentinel_val:
    .long   0xDEADBEEF
.bp_desc_base:
    /* RUN SELECTOR line 1 of 2: C254 (Run C) | C128 (Run A) | C178 (Run B) */
    .long   0x2600C254               /* C254 racing descriptor batch 3, Master cache-through */

.global bridge_probe_end
bridge_probe_end:
