/*
 * general_queue_drain - Async Queue Processor for General SH2 Commands
 * ====================================================================
 * Location: Expansion ROM at $301000 (SH2 address: 0x02301000)
 * Size: ~240 bytes (including literal pool)
 *
 * PURPOSE
 * -------
 * Drains a ring buffer of general SH2 command entries ($22, $25, $2F, $21).
 * For each entry, replays the COMM register protocol that the 68K used to
 * perform synchronously. This moves the blocking waits from the saturated
 * 68K to the underutilized Slave SH2, which acts as a "command proxy".
 *
 * Called by slave_comm7_idle_check after draining the cmd_27 queue.
 * The Master SH2 processes commands identically — it cannot distinguish
 * whether COMM registers were written by the 68K or the Slave SH2.
 *
 * QUEUE LAYOUT (68K Work RAM, shared with SH2)
 * ---------------------------------------------
 * 68K address:  $FFFC00  (in 68K Work RAM)
 * SH2 address:  $02FFFC00
 *
 *   +0x00: write_idx (16-bit, 0-31, wraps with AND #$1F)
 *   +0x02: read_idx  (16-bit, 0-31, wraps with AND #$1F)
 *   +0x04: entry[0]  (16 bytes)
 *   +0x14: entry[1]  ...
 *   ...
 *   +0x1F4: entry[31]
 *   Total: 516 bytes ($FFFC00-$FFFE03)
 *
 * ENTRY FORMAT (16 bytes each)
 * ----------------------------
 *   +0x00: cmd_type  (byte)  — $22, $25, $2F, or $21
 *   +0x01: reserved  (byte)
 *   +0x02: reserved  (word)
 *   +0x04: field_a   (long)  — primary pointer
 *   +0x08: field_b   (long)  — secondary pointer or packed params
 *   +0x0C: field_c   (long)  — packed params
 *
 * PER-COMMAND FIELD MAPPING
 * -------------------------
 *   cmd $25: field_a = A0 (raw),        field_b = A1 (raw), field_c = unused
 *   cmd $22: field_a = A0 (raw),       field_b = A1 (raw), field_c = (D0<<16)|D1
 *   cmd $2F: field_a = A0 (raw),       field_b = (D0<<16)|D1, field_c = (D2<<16)|D3
 *   cmd $21: field_a = A0 (raw),       field_b = A1 (raw), field_c = (D0<<16)|D1
 *
 * COMM PROTOCOL REPLAY
 * --------------------
 * Each command is replayed as the exact COMM register sequence the 68K used:
 *
 * cmd $25 (2-phase): COMM4/5=A0, COMM6=$0101, COMM0=$25/trigger,
 *                    wait COMM6==0, COMM4/5=A1, COMM6=$0101
 *
 * cmd $22 (3-phase): COMM4/5=A1, COMM6=$0101, COMM0=$22/trigger,
 *                    wait COMM6==0, COMM4=D0, COMM5=D1, COMM6=$0101,
 *                    wait COMM6==0, COMM4/5=A0, COMM6=$0101
 *
 * cmd $2F (3-phase): COMM4/5=A0, COMM6=$0101, COMM0=$2F/trigger,
 *                    wait COMM6==0, COMM4=D0, COMM5=D1, COMM6=$0101,
 *                    wait COMM6==0, COMM4=D2, COMM5=D3, COMM6=$0101
 *
 * cmd $21 (3-phase): Same as $22 (identical COMM sequence, different cmd code)
 *
 * REGISTER USAGE
 * --------------
 * Persistent (setup once):
 *   R6  = COMM0 addr    (0x20004020)
 *   R7  = COMM4 addr    (0x20004028)
 *   R8  = queue base    (0x02FFFC00)
 *   R10 = COMM6 addr    (0x2000402C)
 *   R11 = $0101         (handshake constant)
 *   R12 = COMM0_LO addr (0x20004021)
 *
 * Per-entry:
 *   R1  = read_idx (for update)
 *   R2  = COMM5 addr (COMM4 + 2, precomputed)
 *   R3  = field_a
 *   R4  = field_b
 *   R5  = field_c
 *   R9  = cmd_type
 *
 * Scratch: R0 (also required by CMP/EQ #imm and SHLR16)
 * Preserved: R15 (stack), PR (via stack)
 * Destroyed: R0-R7, R9-R12
 */

        .section .text
        .align 2

        .global general_queue_drain

general_queue_drain:
        sts.l   pr,@-r15                /* Save return address */

        /* Load persistent registers */
        mov.l   .L_queue_base,r8        /* R8 = 0x02FFFC00 (queue in 68K WRAM) */
        mov.l   .L_comm0_addr,r6        /* R6 = 0x20004020 (COMM0) */
        mov.l   .L_comm4_addr,r7        /* R7 = 0x20004028 (COMM4) */
        mov.l   .L_comm6_addr,r10       /* R10 = 0x2000402C (COMM6) */
        mov.w   .L_handshake,r11        /* R11 = 0x0101 */
        mov     r6,r12
        add     #1,r12                  /* R12 = 0x20004021 (COMM0_LO) */

.L_drain_loop:
        /* Load indices — re-read write_idx each iteration
         * in case 68K enqueues more while we're processing */
        mov.w   @r8,r0                  /* R0 = write_idx */
        extu.w  r0,r0                   /* Zero-extend (MOV.W sign-extends) */
        mov     r8,r1
        add     #2,r1
        mov.w   @r1,r1                  /* R1 = read_idx */
        extu.w  r1,r1                   /* Zero-extend */

        /* Check if queue empty */
        cmp/eq  r0,r1                   /* read_idx == write_idx? */
        bt      .L_done                 /* Yes: queue empty, exit */

        /* Calculate entry address: base + 4 + read_idx * 16
         * read_idx * 16 = (read_idx << 2) << 2 */
        mov     r1,r2                   /* R2 = read_idx */
        shll2   r2                      /* R2 = read_idx * 4 */
        shll2   r2                      /* R2 = read_idx * 16 */
        add     r8,r2                   /* R2 = base + read_idx * 16 */
        add     #4,r2                   /* R2 = &entry[read_idx] */

        /* Load cmd_type (byte at +0 of entry) */
        mov.b   @r2,r0                  /* R0 = cmd_type (sign-extended) */
        extu.b  r0,r9                   /* R9 = cmd_type (zero-extended) */

        /* Load entry fields (+4, +8, +12) */
        add     #4,r2                   /* R2 -> field_a */
        mov.l   @r2+,r3                 /* R3 = field_a */
        mov.l   @r2+,r4                 /* R4 = field_b */
        mov.l   @r2,r5                  /* R5 = field_c */

        /* Precompute COMM5 address (used by word-pair phases) */
        mov     r7,r2                   /* R2 = COMM4 addr */
        add     #2,r2                   /* R2 = COMM5 addr (0x2000402A) */

        /* Wait COMM0_HI == 0 (Master ready for new command) */
.L_wait_comm0:
        mov.b   @r6,r0                  /* R0 = COMM0_HI byte */
        tst     r0,r0                   /* == 0? */
        bf      .L_wait_comm0           /* No: keep waiting */

        /* Dispatch by command type */
        mov     r9,r0                   /* R0 = cmd_type (CMP/EQ needs R0) */
        cmp/eq  #0x25,r0
        bt      .L_cmd25
        cmp/eq  #0x2F,r0
        bt      .L_cmd2F
        /* Fall through: cmd $22 or $21 (identical 3-phase protocol) */

/* ============================================================
 * CMD $22/$21: 3-phase COMM protocol
 *   Phase 1: COMM4/5 = A1 (field_b), trigger cmd
 *   Phase 2: COMM4 = D0, COMM5 = D1 (field_c words)
 *   Phase 3: COMM4/5 = A0 (field_a)
 * ============================================================ */
.L_cmd22_21:
        /* Phase 1: Send A1 pointer and trigger command */
        mov.l   r4,@r7                  /* COMM4/5 = field_b (A1) */
        mov.w   r11,@r10                /* COMM6 = $0101 */
        mov.b   r9,@r12                 /* COMM0_LO = cmd_type ($21 or $22) */
        mov     #1,r0
        mov.b   r0,@r6                  /* COMM0_HI = 1 (trigger Master) */

        /* Wait COMM6 clear (Master acknowledged phase 1) */
.L_cmd22_w1:
        mov.b   @r10,r0                 /* R0 = COMM6_HI byte */
        tst     r0,r0
        bf      .L_cmd22_w1

        /* Phase 2: Send D0/D1 as separate words */
        mov     r5,r0                   /* R0 = field_c ((D0<<16)|D1) */
        shlr16  r0                      /* R0 = D0 (high word) */
        mov.w   r0,@r7                  /* COMM4 = D0 */
        mov.w   r5,@r2                  /* COMM5 = D1 (low word of field_c) */
        mov.w   r11,@r10                /* COMM6 = $0101 */

        /* Wait COMM6 clear (Master acknowledged phase 2) */
.L_cmd22_w2:
        mov.b   @r10,r0
        tst     r0,r0
        bf      .L_cmd22_w2

        /* Phase 3: Send A0 pointer (no wait after — Master processes async) */
        mov.l   r3,@r7                  /* COMM4/5 = field_a (A0) */
        mov.w   r11,@r10                /* COMM6 = $0101 */
        bra     .L_next_entry
        nop

/* ============================================================
 * CMD $25: 2-phase COMM protocol
 *   Phase 1: COMM4/5 = A0 (field_a, already SH2-converted), trigger
 *   Phase 2: COMM4/5 = A1 (field_b)
 * ============================================================ */
.L_cmd25:
        /* Phase 1: Send A0 pointer (SH2 space, converted by 68K enqueue) */
        mov.l   r3,@r7                  /* COMM4/5 = field_a */
        mov.w   r11,@r10                /* COMM6 = $0101 */
        mov.b   r9,@r12                 /* COMM0_LO = $25 */
        mov     #1,r0
        mov.b   r0,@r6                  /* COMM0_HI = 1 */

        /* Wait COMM6 clear */
.L_cmd25_w1:
        mov.b   @r10,r0
        tst     r0,r0
        bf      .L_cmd25_w1

        /* Phase 2: Send A1 pointer */
        mov.l   r4,@r7                  /* COMM4/5 = field_b */
        mov.w   r11,@r10                /* COMM6 = $0101 */
        bra     .L_next_entry
        nop

/* ============================================================
 * CMD $2F: 3-phase COMM protocol
 *   Phase 1: COMM4/5 = A0 (field_a), trigger cmd $2F
 *   Phase 2: COMM4 = D0, COMM5 = D1 (field_b words)
 *   Phase 3: COMM4 = D2, COMM5 = D3 (field_c words)
 * ============================================================ */
.L_cmd2F:
        /* Phase 1: Send A0 pointer */
        mov.l   r3,@r7                  /* COMM4/5 = field_a */
        mov.w   r11,@r10                /* COMM6 = $0101 */
        mov.b   r9,@r12                 /* COMM0_LO = $2F */
        mov     #1,r0
        mov.b   r0,@r6                  /* COMM0_HI = 1 */

        /* Wait COMM6 clear */
.L_cmd2F_w1:
        mov.b   @r10,r0
        tst     r0,r0
        bf      .L_cmd2F_w1

        /* Phase 2: Send D0/D1 as word pair from field_b */
        mov     r4,r0                   /* R0 = field_b ((D0<<16)|D1) */
        shlr16  r0                      /* R0 = D0 */
        mov.w   r0,@r7                  /* COMM4 = D0 */
        mov.w   r4,@r2                  /* COMM5 = D1 (low word of field_b) */
        mov.w   r11,@r10                /* COMM6 = $0101 */

        /* Wait COMM6 clear */
.L_cmd2F_w2:
        mov.b   @r10,r0
        tst     r0,r0
        bf      .L_cmd2F_w2

        /* Phase 3: Send D2/D3 as word pair from field_c */
        mov     r5,r0                   /* R0 = field_c ((D2<<16)|D3) */
        shlr16  r0                      /* R0 = D2 */
        mov.w   r0,@r7                  /* COMM4 = D2 */
        mov.w   r5,@r2                  /* COMM5 = D3 (low word of field_c) */
        mov.w   r11,@r10                /* COMM6 = $0101 */
        /* Fall through to .L_next_entry */

/* ============================================================
 * UPDATE READ INDEX AND LOOP
 * ============================================================ */
.L_next_entry:
        /* Increment read_idx (mod 32) */
        mov     r8,r2                   /* R2 = queue base */
        add     #2,r2                   /* R2 = &read_idx */
        mov.w   @r2,r0                  /* R0 = read_idx */
        add     #1,r0                   /* read_idx++ */
        mov     #31,r1                  /* R1 = mask for mod 32 */
        and     r1,r0                   /* read_idx &= 31 */
        mov.w   r0,@r2                  /* Store new read_idx */

        bra     .L_drain_loop           /* Process next entry */
        nop

/* ============================================================
 * COMPLETION: Return to caller
 * ============================================================ */
.L_done:
        lds.l   @r15+,pr               /* Restore PR */
        rts
        nop

/* ============================================================
 * LITERAL POOL (must be 4-byte aligned for MOV.L @(disp,PC))
 * ============================================================ */
        .align 4

.L_handshake:
        .word   0x0101                  /* Handshake ready value */
        .word   0x0000                  /* Padding for 4-byte alignment */

.L_queue_base:
        .long   0x02FFFC00              /* General cmd queue in 68K Work RAM */

.L_comm0_addr:
        .long   0x20004020              /* COMM0 register (SH2 side) */

.L_comm4_addr:
        .long   0x20004028              /* COMM4 register (SH2 side) */

.L_comm6_addr:
        .long   0x2000402C              /* COMM6 register (SH2 side) */

/* End of general_queue_drain.asm */
