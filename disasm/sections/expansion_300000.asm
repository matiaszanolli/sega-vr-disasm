; ============================================================================
; Expansion ROM Section ($300000-$3FFFFF)
; 1MB of SH2 working space
; ============================================================================
;
; NOTE: This section is executed by SH2 processors, not the 68000.
; It can only contain:
; - SH2 code in dc.w format (raw opcodes)
; - Data literals
; - Padding (0xFF)
;
; CRITICAL CONSTRAINT:
; Phase 11 hook calls handler at 0x02300028 (file offset: 0x300000 + 0x28)
; Handler MUST be placed at exactly this offset (EVEN address required for SH2).
;
; COMM Register Addresses (SH2 perspective):
;   COMM7 = 0x2000402E (Master→Slave work signal)
;
; Signal Values (COMM7):
;   0x0000 = Idle
;   0x0001 = Frame sync
;   0x0016 = Vertex transform (vertex_transform parallel processing)
;   0x0027 = Queue drain (cmd $27 async processing)
;
; Shared Counter Block (cache-through SDRAM):
;   0x2203E010 = Master call counter (word) - incremented by shadow_path_wrapper
;   0x2203E012 = Slave completion counter (word) - incremented by slave_work_wrapper
;   0x2203E014 = Frame counter (word) - incremented by slave_work_wrapper on frame sync
;   0x2203E016 = Reserved (word)
;
; FIXED: Moved counters from COMM4/COMM5/COMM6 to dedicated RAM to avoid conflicts
;        Original game uses COMM4-COMM6 for command protocol
;
; MEMORY LAYOUT (status as of March 2026):
;   0x300000-0x300027  Padding (40 bytes)
;   0x300028-0x30003F  handler_frame_sync (22 bytes)           — DORMANT (B-006 reverted)
;   0x300050-0x30007B  master_dispatch_hook (44 bytes)         — DORMANT (B-006 reverted)
;   0x300100-0x30015F  vertex_transform_optimized (96 bytes)   — DORMANT (B-006 reverted)
;   0x300200-0x30026F  slave_work_wrapper_v2 (112 bytes)       — DORMANT (B-006 reverted)
;   0x300280-0x3002AB  slave_test_func (32 bytes)              — DORMANT (B-006 reverted)
;   0x300300-0x300325  vertex_transform_original_relocated      — DORMANT (B-006 reverted)
;   0x300400-0x300450  shadow_path_wrapper (~80 bytes)         — DORMANT (B-006 reverted)
;   0x300500-0x300537  cmd25_single_shot (~56 bytes)           — ACTIVE  (B-005, JT $020814)
;   0x300600-0x30067F  cmd27_queue_drain (128 bytes)           — DORMANT (superseded by inline drain at $020608)
;   0x300700-0x30073F  slave_comm7_idle_check (64 bytes)       — ACTIVE  (B-003, trampoline $020608)
;   --- Phase 1 allocations ---
;   0x300800-0x300BFF  cmdint_handler (1KB reserved)           — RESERVED (never activated)
;   0x300C00-0x300FFF  queue_processor (1KB reserved)          — RESERVED (never activated)
;   --- Track 1 Phase 3 ---
;   0x301000-0x3010EF  general_queue_drain (240 bytes)         — DORMANT (Track 1 Phase 3, deactivated)
;   0x3010F0-0x30119F  cmd22_single_shot (176 bytes)           — ACTIVE  (B-004, JT $020808)
;   0x3011A0-0x3011DF  vis_bitmask_handler (64 bytes)          — DORMANT (S-1c reverted, JT restored)
;   0x3011E0-0x30123F  vertex_transform_optimized (96 bytes)  — ACTIVE  (S-6 Phase A, trampoline $0234C8)
;   0x301300-0x30148F  coord_transform_batched (388 bytes)   — ACTIVE  (S-6 Phase B, trampolines $02338A-$02349F)
;   0x301490-0x3FFFFF  Free space (remaining ~1018KB)
;
; Shared Data Structures (cache-through SDRAM, NOT in expansion ROM):
;   0x2203E000-0x2203E00F  Parameter block (16 bytes: R14, R7, R8, R5)
;   0x2203E010-0x2203E017  Counter block (8 bytes: Master, Slave, Frame, Reserved)
;
; ============================================================================

        org     $300000

; ============================================================================
; PADDING: 0x300000-0x300027 (40 bytes)
; ============================================================================
        dcb.b   $28, $FF

; ============================================================================
; FRAME SYNC HANDLER: 0x300028 — STATUS: DORMANT (B-006 reverted)
; ============================================================================
; Simple handler that increments COMM4 and returns.
; Never triggered — dispatch hook that called this was reverted.
;
; See: disasm/sh2/expansion/handler_frame_sync.asm for source
;
handler_frame_sync:
        include "sh2/generated/handler_frame_sync.inc"

; ============================================================================
; PADDING TO master_dispatch_hook
; ============================================================================
; Current position: 0x30003E (handler ends at 0x28 + 22 bytes)
; Pad to 0x300050 for master dispatch hook
        dcb.b   ($300050 - *), $FF

; ============================================================================
; MASTER DISPATCH HOOK: 0x300050 — STATUS: DORMANT (B-006 reverted)
; ============================================================================
; Was: Called by Master SH2 when dispatching a command from 68K.
; Wrote COMM7=cmd for all commands EXCEPT 0x16 (vertex transform).
; Reverted due to COMM7 namespace collision (game cmd 0x27 = queue drain signal).
;
; Entry: R0 = command value (1-255)
; Preserved: R4 (context), R8 (COMM0 addr)
; Uses: R0, R1, R2
;
; See: disasm/sh2/expansion/master_dispatch_hook.asm for source
;
master_dispatch_hook:
        include "sh2/generated/master_dispatch_hook.inc"

; ============================================================================
; PADDING TO vertex_transform_optimized
; ============================================================================
; Current position: 0x30006C (hook ends at 0x50 + 28 bytes)
; Pad to 0x300100 for nice alignment
        dcb.b   ($300100 - *), $FF

; ============================================================================
; vertex_transform_optimized — STATUS: DORMANT (B-006 reverted)
; Entry point: 0x300100 (SH2 address: 0x02300100) - 4-BYTE ALIGNED
; ============================================================================
vertex_transform_optimized:
        include "sh2/generated/vertex_transform_optimized.inc"

; ============================================================================
; PADDING TO slave_work_wrapper
; ============================================================================
; Current position: ~0x300160 (vertex_transform_optimized is ~96 bytes)
; Pad to 0x300200 for nice alignment
        dcb.b   ($300200 - *), $FF

; ============================================================================
; SLAVE WORK WRAPPER V2: 0x300200 — STATUS: DORMANT (B-006 reverted)
; ============================================================================
; Was: Slave SH2 main loop - polls COMM7 for work signals from Master/68K.
; Dispatches based on COMM7 value:
;   0x01 = Frame sync (increment COMM4)
;   0x16 = Vertex transform (calls slave_test_func, increments COMM5)
;   0x27 = Queue drain (calls cmd27_queue_drain) ← NEW in v2
;
; Protocol:
;   1. Master/68K writes COMM7 = work_type
;   2. Slave detects COMM7 != 0, dispatches to appropriate handler
;   3. Handler executes (queue drain clears COMM7 itself)
;   4. Slave clears COMM7, returns to polling
;
; See: disasm/sh2/expansion/slave_work_wrapper_v2.asm for full source
;
slave_work_wrapper:
        include "sh2/generated/slave_work_wrapper_v2.inc"

; ============================================================================
; PADDING TO slave_test_func
; ============================================================================
; Current position: 0x300270 (slave_work_wrapper_v2 is 112 bytes)
; Pad to 0x300280 for nice alignment
        dcb.b   ($300280 - *), $FF

; ============================================================================
; SLAVE TEST FUNCTION: 0x300280 — STATUS: DORMANT (B-006 reverted)
; ============================================================================
; Reads parameters from shared memory at 0x2203E000, then calls vertex_transform_optimized.
; Adds 100 to COMM5 on successful return.
;
; Parameter block at 0x2203E000 (cache-through SDRAM, written by Master):
;   +0x00: R14 (context pointer)
;   +0x04: R7 (loop counter)
;   +0x08: R8 (data pointer)
;   +0x0C: R5 (output pointer)
;
; See: disasm/sh2/expansion/slave_test_func.asm for source
;
slave_test_func:
        include "sh2/generated/slave_test_func.inc"

; ============================================================================
; ORIGINAL vertex_transform — STATUS: DORMANT (B-006 reverted)
; ============================================================================
; Was: Relocated from ROM $0234C8 for shadow path instrumentation.
; FIXED: Replaced PC-relative BSR with absolute MOV.L+JSR because the
; original BSR targets (coord_transform at $023368, nested at $02350A) are in
; main ROM, unreachable by BSR from expansion ROM.
;
; Address: 0x300300 (SH2: 0x02300300)
; Size: 52 bytes (26 words, ends at 0x300333)
;
        dcb.b   ($300300 - *), $FF  ; Pad to 0x300300 (auto-sized)
vertex_transform_original_relocated:
        dc.w    $4F22        ; $300300  STS.L PR,@-R15
        dc.w    $D30A        ; $300302  MOV.L @(40,PC),R3 → coord_transform addr
        dc.w    $430B        ; $300304  JSR @R3
        dc.w    $0009        ; $300306  NOP (delay slot)
        dc.w    $2F76        ; $300308  MOV.L R7,@-R15       ← LOOP TARGET
        dc.w    $2F86        ; $30030A  MOV.L R8,@-R15
        dc.w    $D308        ; $30030C  MOV.L @(32,PC),R3 → nested func addr
        dc.w    $430B        ; $30030E  JSR @R3
        dc.w    $4F22        ; $300310  STS.L PR,@-R15 (delay slot — saves PR)
        dc.w    $68F6        ; $300312  MOV.L @R15+,R8
        dc.w    $67F6        ; $300314  MOV.L @R15+,R7
        dc.w    $8581        ; $300316  MOV.B R0,@($1,R5)
        dc.w    $C801        ; $300318  TST #1,R0
        dc.w    $8F01        ; $30031A  BF/S +1
        dc.w    $7810        ; $30031C  ADD #$10,R8 (delay slot)
        dc.w    $7804        ; $30031E  ADD #$04,R8
        dc.w    $4710        ; $300320  DT R7
        dc.w    $8BF1        ; $300322  BF $300308 (disp=-15, loop back)
        dc.w    $4F26        ; $300324  LDS.L @R15+,PR
        dc.w    $000B        ; $300326  RTS
        dc.w    $0009        ; $300328  NOP
        dc.w    $0009        ; $30032A  NOP (align to 4 bytes)
        dc.w    $0202        ; $30032C  Literal: coord_transform = 0x02023368 (high)
        dc.w    $3368        ; $30032E  Literal: coord_transform = 0x02023368 (low)
        dc.w    $0202        ; $300330  Literal: nested func = 0x0202350A (high)
        dc.w    $350A        ; $300332  Literal: nested func = 0x0202350A (low)

; ============================================================================
; SHADOW PATH WRAPPER: 0x300400 — STATUS: DORMANT (B-006 reverted)
; ============================================================================
; Was: Full instrumentation for shadow path (Option 3).
; Called from vertex_transform jump at $0234C8.
;
; Increments COMM6 (Master call counter), signals Slave via COMM7,
; then calls relocated original vertex_transform. Master uses original results,
; Slave works in parallel for timing measurement.
;
; Metrics:
;   COMM6 = Master call counter (incremented here)
;   COMM5 = Slave completion counter (incremented by Slave)
;   Gap = COMM6 - COMM5 (critical timing metric)
;
; See: disasm/sh2/expansion/shadow_path_wrapper.asm for source
;
        dcb.b   ($300400 - *), $FF  ; Pad to 0x300400 (auto-sized)
shadow_path_wrapper:
        include "sh2/generated/shadow_path_wrapper.inc"

; ============================================================================
; CMD25 SINGLE-SHOT HANDLER: 0x300500 — STATUS: ACTIVE (B-005, JT $020814)
; ============================================================================
; B-005: Single-shot decompression handler for cmd $25.
; Replaces the 3-phase COMM6 handshake protocol with single-shot dispatch.
;
; Protocol (command $25 - single-shot):
;   COMM3:4 = A0 source ptr (with $02000000 SDRAM prefix from 68K)
;   COMM5:6 = A1 dest ptr (full SH2 address, e.g. $0601xxxx)
;   COMM0_LO = $25 (dispatch index), COMM0_HI = $01 (trigger)
;   SH2 clears COMM0_LO=$00 after reading params (handshake)
;
; Entry: R8 = $20004020 (COMM base); dispatched via jump table $06000814
; Calls: decompressor at $06005058, hw_init_short at $060043F0
; Size: 64 bytes (52 code + 12 pool)
;
; See: disasm/sh2/expansion/cmd25_single_shot.asm for source
;
        dcb.b   ($300500 - *), $FF  ; Pad to 0x300500 (auto-sized)
cmd25_single_shot:
        include "sh2/generated/cmd25_single_shot.inc"

; ============================================================================
; PADDING TO cmd27_queue_drain
; ============================================================================
; Current position: 0x300540 (after cmd25_single_shot, 64 bytes)
; Pad to 0x300600 for nice alignment
        dcb.b   ($300600 - *), $FF

; ============================================================================
; CMD27 QUEUE DRAIN: 0x300600 — STATUS: DORMANT (superseded by inline drain at $020608)
; ============================================================================
; Was: Async queue processor for cmd $27. Called by slave_work_wrapper when
; COMM7 = $27 (doorbell signal from 68K).
;
; Drains all queued cmd $27 entries from 68K Work RAM at $FFFB00.
; Each entry: data_ptr(4) + width(2) + height(2) + add_value(2) = 10 bytes
;
; Protocol:
;   1. 68K enqueues entries, rings doorbell (COMM7 = $27)
;   2. Slave detects COMM7 == $27 via slave_work_wrapper
;   3. Slave calls cmd27_queue_drain
;   4. Drain loops until read_idx == write_idx
;   5. Returns (slave_work_wrapper clears COMM7)
;
; See: disasm/sh2/expansion/cmd27_queue_drain.asm for full source
; See: disasm/modules/68k/sh2/sh2_cmd_27_async.asm for 68K side
;
cmd27_queue_drain:
        include "sh2/generated/cmd27_queue_drain.inc"

; ============================================================================
; SLAVE COMM7 IDLE CHECK: 0x300700 — STATUS: ACTIVE (B-003, trampoline $020608)
; ============================================================================
; Replaces Slave's 64-NOP delay loop with COMM7 doorbell check.
; When COMM7 = $0027: clears COMM7, calls cmd27_queue_drain, returns to
; command_loop. When COMM7 = 0: returns directly to command_loop.
;
; Trampoline at $020608 (Slave delay loop) JMPs here.
; See: disasm/sh2/expansion/slave_comm7_idle_check.asm for full source
;
        dcb.b   ($300700 - *), $FF      ; Pad to 0x300700
slave_comm7_idle_check:
        include "sh2/generated/slave_comm7_idle_check.inc"

; ============================================================================
; PHASE 1: CMDINT HANDLER AND QUEUE PROCESSOR
; ============================================================================
; Pad from end of slave_comm7_idle_check to Phase 1 allocation at 0x300800
        dcb.b   ($300800 - *), $FF

; --- Phase 1: Master SH2 CMDINT Handler (at 0x300800) — STATUS: RESERVED ---
; SH2 address: 0x02300800
; CMDINT ISR that processes ring buffer entries from SDRAM.
; Never activated. See: disasm/sh2/expansion/cmdint_handler.asm for source
cmdint_handler:
        include "sh2/generated/cmdint_handler.inc"

; --- Pad to queue_processor at 0x300C00 ---
        dcb.b   ($C00 - $900), $FF      ; Pad from ~$900 to $C00

; --- Phase 1: Queue Processor (at 0x300C00) — STATUS: RESERVED ---
; SH2 address: 0x02300C00
; Ring buffer drain loop called by CMDINT handler.
; Never activated. See: disasm/sh2/expansion/queue_processor.asm for source
queue_processor:
        include "sh2/generated/queue_processor.inc"

; ============================================================================
; GENERAL QUEUE DRAIN: 0x301000 — STATUS: DORMANT (Track 1 Phase 3, deactivated)
; ============================================================================
; Was: Async queue processor for general SH2 commands ($22, $25, $2F, $21).
; Replays the COMM register protocol for each queued entry, moving the
; blocking waits from the 68K to the Slave SH2.
;
; Called by slave_comm7_idle_check after draining the cmd_27 queue.
; Queue at $FFFC00 (68K) / $02FFFC00 (SH2), 32 entries x 16 bytes.
;
; See: disasm/sh2/expansion/general_queue_drain.asm for full source
;
        dcb.b   ($301000 - *), $FF      ; Pad to 0x301000
general_queue_drain:
        include "sh2/generated/general_queue_drain.inc"

; ============================================================================
; CMD22 SINGLE-SHOT HANDLER: 0x3010F0 — STATUS: ACTIVE (B-004, JT $020808)
; ============================================================================
; Inline COMM cleanup protocol (Phase 2 optimization):
;   Replaces hw_init_short JSR with inline byte/word-level COMM writes.
;   After copy, clears COMM1 + sets COMM1_LO bit 0, then clears COMM0_HI
;   via byte write (preserves COMM0_LO). Re-checks COMM0_LO:
;     $22 → re-dispatch internally (no dispatch loop round-trip)
;     other → restore COMM0_HI=$01, return to dispatch loop
;     $00 → truly idle, exit
;
; Jump table entry at $020808 = $023010F0 (B-004, set in code_20200.asm).
;
; See: disasm/sh2/expansion/cmd22_single_shot.asm for source
;
        dcb.b   ($3010F0 - *), $FF      ; Pad to 0x3010F0
cmd22_single_shot:
        include "sh2/generated/cmd22_single_shot.inc"

; ============================================================================
; VISIBILITY BITMASK HANDLER: 0x3011A0 — STATUS: DORMANT (S-1c reverted)
; ============================================================================
; Was: Entity visibility descriptor patcher. Reads 15-bit bitmask from COMM3,
; patches 15 entity descriptor flag words at $2200C344 (stride $14).
; Reverted: S-1d profiling proved entity descriptors at $0600C344 are unused
; during racing. Jump table entry $07 restored to original handler ($06000490).
;
; See: disasm/sh2/expansion/vis_bitmask_handler.asm for source
;
        dcb.b   ($3011A0 - *), $FF      ; Pad to 0x3011A0
vis_bitmask_handler:
        include "sh2/generated/vis_bitmask_handler.inc"

; ============================================================================
; VERTEX TRANSFORM OPTIMIZED: 0x3011E0 — STATUS: ACTIVE (S-6, trampoline $0234C8)
; ============================================================================
; coord_transform (func_016) inlined at the start, eliminating BSR/RTS overhead.
; BSR to frustum_cull alt entry ($0202350A) replaced with MOV.L+JSR.
; Trampoline at original location $0234C8 (vertex_transform_orig.asm).
;
; Savings: ~6 cycles/call × 800 polygons = ~4,800 cycles/frame (~1.2% Slave)
;
; See: disasm/sh2/expansion/vertex_transform_optimized.asm for source
;
        dcb.b   ($3011E0 - *), $FF      ; Pad to 0x3011E0
vertex_transform_opt:
        include "sh2/generated/vertex_transform_optimized.inc"

; ============================================================================
; COORD_TRANSFORM BATCHED: 0x301300 — STATUS: ACTIVE (S-6, Phase B)
; ============================================================================
; Relocated state machine (func_017-019) with coord_transform inlined at all
; 3 BSR sites. External BSR to func_020 ($0234A0) replaced with MOV.L+JSR.
; Original entry points at $02338A-$02349F replaced with JMP trampolines.
;
; Entry points in expansion ROM:
;   $301300 = func_017 (quad_helper)
;   $301336 = func_018 (quad_batch_short main)
;   $30138C = func_018_alt (quad_batch_short alternate path)
;   $3013CA = func_019 (quad_batch_alt_short main)
;   $30140A = func_019_helper (helper_process)
;   $301440 = func_019_alt (alternate entry)
;
; Savings: ~14,400 cycles/frame (~3.7% Slave budget)
; Combined with Phase A (vertex_transform): ~5% total
;
; Generated by Phase B relocation script (194 words = 388 bytes)
;
        dcb.b   ($301300 - *), $FF      ; Pad to 0x301300
coord_transform_batched:
        include "sh2/expansion/coord_transform_batched.inc"

; ============================================================================
; VR60 GAME FRAME HANDLER: 0x301500 — STATUS: ACTIVE (VR60 Phase 0)
; ============================================================================
; Master SH2 command handler for the VR60 architectural redesign.
; Phase 0: No-op that reads SDRAM mailbox and signals completion.
; Future phases add game logic (physics, AI, collision).
;
; Jump table entry at $02087C = $02301500 (cmd $3F).
; SDRAM mailbox at $0600BC00 (cache-through: $2200BC00).
;
; See: disasm/sh2/expansion/cmd3f_vr60_gameframe.asm for source
;
        dcb.b   ($301500 - *), $FF      ; Pad to 0x301500
cmd3f_vr60_gameframe:
        include "sh2/generated/cmd3f_vr60_gameframe.inc"

; ============================================================================
; REMAINING EXPANSION ROM SPACE (from ~0x301530)
; ============================================================================
; Pad to $3F0000 (960KB) instead of $400000 (1MB) to avoid PicoDrive
; emulator bug triggered by ROM files > ~0x3F1F40 bytes.
; Still provides ~960KB expansion space (99.7% free).
        dcb.b   ($3F0000 - *), $FF
