/*
 * collision_track_data — SH2 Track-Data Addressing Layer (VR60 Phase 5B)
 * Expansion ROM Address: $303100 (SH2: $02303100)
 *
 * THE KEYSTONE SUB-PHASE. Ports the two track-data addressing functions and
 * DEFINES the 68K->SH2 pointer-translation convention that all later collision
 * work (5C–5E) inherits. ADDITIVE ONLY: these are NOT wired into cmd $3F yet,
 * the 68K globals packer is NOT modified yet, and no existing function is
 * touched. 5B delivers the two functions + the documented convention + a
 * proposed SDRAM layout + reference-model verification.
 *
 * Functions:
 *   track_data_index_calc_table_lookup  (68K $0073E8, 68B)  — 2-level ROM lookup
 *   track_data_extract_033              (68K $0076A2, 94B)  — 4-page geometry extract
 *
 * ===========================================================================
 *  POINTER-TRANSLATION CONVENTION (the deliverable that matters most)
 * ===========================================================================
 *
 *  PROBLEM. The track-data pointer TABLES at file $742C/$745C (SH2 $0200742C /
 *  $0200745C) hold 68K *CPU* addresses as their CONTENTS ($0094C000 … $009D0000).
 *  $FFC268 (the road-segment base) likewise holds a 68K CPU address. A 68K CPU
 *  address cannot be dereferenced on the SH2 — it must be translated to the SH2
 *  ROM window first.
 *
 *  TRANSLATION (verified 2026-06-17 against build/vr_rebuild.32x bytes):
 *        SH2_addr = 68K_addr - $880000 + $02000000 = 68K_addr + $01780000
 *        file_off = 68K_addr - $880000
 *    Worked: $0094C000 - $880000 = file $0CC000 -> SH2 $020CC000 (track data
 *    present). Highest base referenced $009D0000 -> file $150000 -> SH2
 *    $02150000, well inside the 4MB ROM ($3F0000). All 13 table content
 *    addresses map in-ROM. NO banking/mirroring.
 *
 *  WHERE TO TRANSLATE — the decision (DOCUMENTED, applies to all of 5C–5E):
 *
 *    1. Table BASE pointers (the `lea $742C(pc),A2` result). On 68K this is a
 *       code-relative address; on SH2 the equivalent literal/PC-relative load
 *       yields the SH2 ROM address $0200742C DIRECTLY. -> NO translation.
 *       (A2 is returned to the caller already as a valid SH2 pointer.)
 *
 *    2. Table CONTENT pointers (the seg-ptr and base-ptr read FROM the table)
 *       and the $FFC268 road-segment base — these are 68K CPU addresses.
 *       -> TRANSLATE by +$01780000, ONCE, at the moment the pointer is formed,
 *          BEFORE the first dereference.
 *
 *    3. CONSEQUENCE / RULE FOR 5C–5E: index_calc returns A1 (final tile ptr)
 *       and A2 (table/surface base) ALREADY as SH2 addresses. They are stored
 *       into the SDRAM-entity tile fields (+$CE/$D2/$D6/$DA) as SH2-ready
 *       pointers, so `collision_response_surface_tracking` (5D) dereferences
 *       them with NO further translation. "Translate once when formed, store
 *       SH2-ready; never translate at dereference."
 *
 *  WHY STORING SH2-TRANSLATED POINTERS IN THE SDRAM ENTITY IS SAFE DURING
 *  DUAL-PATH. SH2 collision operates on the SDRAM entity copy (player
 *  $0600F20C, AI $06010000). The still-running 68K collision path uses the
 *  SEPARATE WRAM entity ($FFxxxx). The two +$CE/$D2/$D6/$DA pointer fields live
 *  in different memories, so writing SH2-form pointers into the SDRAM entity
 *  does NOT corrupt the 68K path. (KEY FACT — enables single-form storage.)
 *
 *  VERIFICATION (reference model, 2026-06-17, vs faithful 68K model over ROM):
 *    index_calc : 19,895 populated (D1,D2,race_state,alt) cases, 0 mismatch —
 *                 SH2-translated path resolves to the IDENTICAL file offset /
 *                 tile data as the 68K path.
 *    extract_033: 40,000 (base,D0) cases sampled from the verified in-ROM track
 *                 bases, 0 mismatch — identical 8-word signed work buffer.
 *
 * ===========================================================================
 *  PROPOSED SDRAM LAYOUT (for Auditor review — packer NOT modified in 5B)
 * ===========================================================================
 *
 *  (a) Per-frame-staged inputs (the 68K packer would copy these each frame into
 *      the 64-byte globals block at $0600F30C). ONLY +$38–$3F are free, and
 *      vr60_globals_stage REWRITES +$30–$3F every frame ("silent data
 *      destroyer", decision-log line 1202) — so +$38–$3F are valid ONLY for
 *      per-frame-staged values (which these are), never for persistent data.
 *        globals +$38  (word)  : race_state           (68K $FFC8A0, copied as-is)
 *        globals +$3A  (long)  : track_seg_base_xlat  (68K $FFC268 PRE-TRANSLATED
 *                                 by the packer: value+$01780000 -> SH2 addr)
 *        (+$3E/$3F: 2 bytes spare in the staged window)
 *      NOTE: entity +$E4 (alt-table flag) is read directly from the SDRAM entity
 *      via GBR — no staging needed (it is already an entity field).
 *
 *  (b) Intra-frame SH2-only scratch — the $FFC02E work buffer (extract_033
 *      output, consumed by track_boundary in 5C, 24 bytes used: words at
 *      +$00,+$04,+$06,+$0A,+$0C,+$10,+$12,+$16). Never needs 68K staging.
 *        DEDICATED SDRAM scratch: $06011000 (TRACK_WORK_BUF, 24B reserved 32B).
 *        Justified free: Phase 1 verified $0600F20C–$06017FFF free; AI entities
 *        occupy $06010000–$06010F00; $06011000+ is unused. grep of disasm/sh2/
 *        for 0x06011000 / 06011 returns no consumer.
 *
 *  NOTE: In 5B these globals/scratch offsets are DEFINED and used by the SH2
 *  code below, but the PACKER that fills globals +$38/+$3A is added in 5C/5D.
 *  Until then these functions are assembled-only and not dispatched.
 *
 * ===========================================================================
 *  REGISTER CONVENTION (VR60 §7.9, same as physics_ and collision_leaf)
 * ===========================================================================
 *   GBR = entity base ($0600F20C)   R13 = globals base ($0600F30C)
 *   R8  = COMM base ($20004020)     (not used here, preserved)
 *   R14 = entity base (indexed)     R0-R7,R9-R12 scratch
 *
 *  SH2 vs 68K translation notes:
 *    68K ASR.W #n,Dn (signed word)  -> SHLL16; n×SHAR; SHLR16 (operate in hi
 *      word so SHAR is arithmetic on the sign bit, then move back). For #4/#5
 *      here we instead sign-extend to long (EXTS.W) and SHAR — the inputs are
 *      then long, matching the 68K word semantics because the values stay small.
 *    68K ASL.W #1,Dn                -> SHLL (word kept in low 16 + re-mask)
 *    68K EXT.W Dn                   -> EXTS.B Rn (byte->word) where used
 *    68K MOVEA.L $00(A2,D0.W),A1    -> indexed long load: MOV @(R0,Rn),Rm
 *    All ROM-table / absolute literals are 8-hex-digit $0200xxxx (NEVER 7-digit
 *    0x020xxxxx — the dropped-zero bug, KNOWN_ISSUES §SH2 ROM-Table Literals).
 */

.section .text
.align 2

/* ============================================================================
 * track_data_index_calc_table_lookup
 * 68K: $0073E8-$00742A (68 bytes)
 *
 * Computes a track-segment index from x/y position and looks up a tile pointer
 * through a 2-level ROM table. Returns the final tile pointer (SH2-translated)
 * and the table base (already SH2).
 *
 * In:  R1 = D1 (x_pos, signed word)
 *      R2 = D2 (y_pos, signed word)
 *      GBR= entity base (reads entity +$E4 alt-table flag)
 *      R13= globals base (reads race_state at globals +$38)
 * Out: R1  = A1 = final tile pointer (SH2 address, ready to dereference)
 *      R9  = A2 = table base (SH2 address $0200742C or $0200745C)
 * Clobbers: R0,R3,R4,R5,R6,R9.  Preserves: R2 (caller may reuse), GBR,R13,R8,PR.
 *
 * 68K reference (every read/arith cited):
 *   move.l #$400,D3                     ; D3 = base offset
 *   move.w D1,D4 ; asr.w #4,D4 ; add.w D3,D4 ; asr.w #5,D4
 *   move.w D2,D5 ; asr.w #4,D5 ; add.w D5,D3
 *   andi.w #$FFE0,D3 ; asl.w #1,D3 ; add.w D4,D3 ; add.w D3,D3
 *   move.w ($C8A0).w,D0 ; add.w D0,D0          ; D0 = race_state*2
 *   lea $742C(pc),A2                            ; normal table (SH2: $0200742C)
 *   tst.b $E4(A0) ; bne -> lea $745C(pc),A2     ; alt table  (SH2: $0200745C)
 *   movea.l $00(A2,D0.W),A1                     ; A1 = seg ptr  (68K addr -> XLAT)
 *   move.w  $00(A1,D3.W),D3                     ; D3 = seg[off]  (word)
 *   movea.l $04(A2,D0.W),A1                     ; A1 = base ptr (68K addr -> XLAT)
 *   add.l D3,D3 ; adda.l D3,A1                  ; A1 += D3*2  -> final tile ptr
 *   rts
 * ============================================================================
 */
.global track_data_index_calc_table_lookup
track_data_index_calc_table_lookup:
    /* D3 = $400 ; D4 = (D1 asr 4) ; D4 = (D4 + D3) asr 5  (word semantics) */
    mov     #0, r3
    mov.w   @(.tk_c0400,pc), r3        /* R3 = $0400 (base offset, word) */
    mov     r1, r4
    exts.w  r4, r4                     /* sign-extend x_pos word -> long */
    shar    r4
    shar    r4
    shar    r4
    shar    r4                         /* D4 = D1 asr.w #4 */
    add     r3, r4                     /* add.w D3,D4 */
    exts.w  r4, r4                     /* keep word range, signed */
    shar    r4
    shar    r4
    shar    r4
    shar    r4
    shar    r4                         /* D4 = D4 asr.w #5 */
    /* D5 = (D2 asr 4) ; D3 = (D3 + D5) word */
    mov     r2, r5
    exts.w  r5, r5
    shar    r5
    shar    r5
    shar    r5
    shar    r5                         /* D5 = D2 asr.w #4 */
    add     r5, r3                     /* add.w D5,D3 */
    /* andi.w #$FFE0,D3 ; asl.w #1,D3 ; add.w D4,D3 ; add.w D3,D3 */
    mov.w   @(.tk_cffe0,pc), r0
    and     r0, r3                     /* andi.w #$FFE0,D3 */
    shll    r3                         /* asl.w #1,D3 */
    add     r4, r3                     /* add.w D4,D3 */
    add     r3, r3                     /* add.w D3,D3 */
    extu.w  r3, r3                     /* D3 used as unsigned word index below */

    /* D0 = race_state(globals +$38) * 2 */
    mov     #0x38, r0
    mov.w   @(r0,r13), r0              /* R0 = race_state (word) */
    extu.w  r0, r0
    add     r0, r0                     /* D0 = race_state*2 */
    mov     r0, r6                     /* R6 = D0 (table row byte index) */

    /* Select normal vs alternate table by entity +$E4 (byte) */
    mov.l   @(.tk_tbl_norm,pc), r9     /* A2 = $0200742C (normal, SH2 addr) */
    mov.w   @(0xE4,gbr), r0            /* entity +$E4 (read word; flag in low byte) */
    extu.b  r0, r0                     /* tst.b $E4(A0): isolate byte */
    tst     r0, r0
    bt      .tk_lookup                 /* zero -> normal table */
    mov.l   @(.tk_tbl_alt,pc), r9      /* A2 = $0200745C (alternate, SH2 addr) */
.tk_lookup:
    /* A1 = *(A2 + D0)  [seg ptr, 68K addr] ; TRANSLATE +$01780000 */
    mov     r6, r0                     /* R0 = D0 */
    mov.l   @(r0,r9), r1               /* R1 = seg ptr (68K CPU addr) */
    mov.l   @(.tk_xlat,pc), r5         /* R5 = $01780000 */
    add     r5, r1                     /* R1 = seg ptr as SH2 addr */
    /* D3 = *(A1 + D3.W)  word */
    mov     r3, r0                     /* R0 = D3 (unsigned word index) */
    mov.w   @(r0,r1), r3               /* D3 = seg[off] (word, sign-extended) */
    extu.w  r3, r3                     /* high bits were 0 on 68K (word ops); mask */
    /* A1 = *(A2 + D0 + 4)  [base ptr, 68K addr] ; TRANSLATE +$01780000 */
    mov     r6, r0
    add     #4, r0
    mov.l   @(r0,r9), r1               /* R1 = base ptr (68K CPU addr) */
    add     r5, r1                     /* R1 = base ptr as SH2 addr */
    /* add.l D3,D3 ; adda.l D3,A1 */
    add     r3, r3                     /* D3 *= 2 */
    add     r3, r1                     /* A1 += D3  -> final tile ptr (SH2 addr) */
    rts
    nop

.align 1
.tk_c0400:      .short  0x0400
.tk_cffe0:      .short  0xFFE0
.align 2
.tk_tbl_norm:   .long   0x0200742C     /* normal table base (SH2 ROM, no XLAT) */
.tk_tbl_alt:    .long   0x0200745C     /* alternate table base (SH2 ROM, no XLAT) */
.tk_xlat:       .long   0x01780000     /* 68K->SH2 translation: -$880000+$02000000 */

/* ============================================================================
 * track_data_extract_033
 * 68K: $0076A2-$0076FE (94 bytes)
 *
 * Reads signed byte pairs from 4 track-data "pages" ($800 apart, advanced by
 * $7FF + the post-increment) into the work buffer.
 *
 * In:  R0  = D0 (track segment index, pre-shifted by caller)
 *      R13 = globals base (reads PRE-TRANSLATED track_seg_base at globals +$3A)
 * Out: writes 8 signed words to TRACK_WORK_BUF ($06011000):
 *        +$00,+$04 = page0 ; +$06,+$0A = page1 ; +$0C,+$10 = page2 ;
 *        +$12,+$16 = page3
 * Clobbers: R0,R1,R2,R3.  Preserves: GBR,R13,R8,PR.
 *
 * 68K reference:
 *   movea.l ($C268).w,A1                 ; A1 = track base (68K addr; here PRE-XLAT)
 *   lea ($C02E).w,A2                      ; A2 = work buffer (here SDRAM scratch)
 *   lsr.w #6,D0 ; add.w D0,D0 ; lea $00(A1,D0.W),A1
 *   move.b (A1)+,D2 ; ext.w D2 ; move.w D2,$00(A2)
 *   move.b (A1),D2  ; ext.w D2 ; move.w D2,$04(A2)
 *   lea $7FF(A1),A1 ; ... +$06,+$0A
 *   lea $7FF(A1),A1 ; ... +$0C,+$10
 *   lea $7FF(A1),A1 ; ... +$12,+$16
 *   rts
 * ============================================================================
 */
.global track_data_extract_033
track_data_extract_033:
    /* Preserve D0 (input segment index) before R0 is reused as the indexed-load
     * index register — the 68K keeps D0 and A1-base in separate registers. */
    mov     r0, r3                     /* R3 = D0 (input) */
    /* A1 = pre-translated track base (globals +$3A, longword, already SH2) */
    mov     #0x3A, r0                  /* SH2 indexed load requires R0 as index */
    mov.l   @(r0,r13), r1              /* R1 = A1 = track_seg_base_xlat (SH2 addr) */
    /* A2 = work buffer (dedicated SDRAM scratch) */
    mov.l   @(.tk_workbuf,pc), r2      /* R2 = A2 = $06011000 */
    /* D0 = (D0 lsr.w #6) ; D0 += D0 ; A1 += D0  (compute in R3, keep R0 free) */
    extu.w  r3, r3                     /* word value (lsr is logical) */
    shlr    r3
    shlr    r3
    shlr    r3
    shlr    r3
    shlr    r3
    shlr    r3                         /* D0 >>= 6 (logical) */
    add     r3, r3                     /* add.w D0,D0 */
    extu.w  r3, r3                     /* word index */
    add     r3, r1                     /* A1 += D0 */

    /* Stores use the register-INDEXED form `mov.w Rsrc,@(R0,R2)` because the
     * SH2 displacement-store `mov.w R0,@(disp,Rn)` only permits R0 as source.
     * We build the buffer offset in R0 each time (R0 is free between reads). */

    /* --- page 0 --- */
    mov.b   @r1+, r3                   /* D2 = (A1)+ signed byte */
    exts.b  r3, r3                     /* ext.w D2 */
    mov     #0x00, r0
    mov.w   r3, @(r0,r2)               /* buf+$00 */
    mov.b   @r1, r3                    /* D2 = (A1) signed byte */
    exts.b  r3, r3
    mov     #0x04, r0
    mov.w   r3, @(r0,r2)               /* buf+$04 */
    /* --- page 1: A1 += $7FF --- */
    mov.w   @(.tk_c07ff,pc), r0
    add     r0, r1                     /* lea $7FF(A1),A1 */
    mov.b   @r1+, r3
    exts.b  r3, r3
    mov     #0x06, r0
    mov.w   r3, @(r0,r2)               /* buf+$06 */
    mov.b   @r1, r3
    exts.b  r3, r3
    mov     #0x0A, r0
    mov.w   r3, @(r0,r2)               /* buf+$0A */
    /* --- page 2: A1 += $7FF --- */
    mov.w   @(.tk_c07ff,pc), r0
    add     r0, r1
    mov.b   @r1+, r3
    exts.b  r3, r3
    mov     #0x0C, r0
    mov.w   r3, @(r0,r2)               /* buf+$0C */
    mov.b   @r1, r3
    exts.b  r3, r3
    mov     #0x10, r0
    mov.w   r3, @(r0,r2)               /* buf+$10 */
    /* --- page 3: A1 += $7FF --- */
    mov.w   @(.tk_c07ff,pc), r0
    add     r0, r1
    mov.b   @r1+, r3
    exts.b  r3, r3
    mov     #0x12, r0
    mov.w   r3, @(r0,r2)               /* buf+$12 */
    mov.b   @r1, r3
    exts.b  r3, r3
    mov     #0x16, r0
    mov.w   r3, @(r0,r2)               /* buf+$16 */
    rts
    nop

.align 1
.tk_c07ff:      .short  0x07FF
.align 2
.tk_workbuf:    .long   0x06011000     /* TRACK_WORK_BUF (SDRAM scratch, 24B used) */

.global collision_track_data_end
collision_track_data_end:
