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
; Historical B-006 counter block (INVALID ADDRESS; dormant code only):
;   0x2203E010 = Master call counter (word) - incremented by shadow_path_wrapper
;   0x2203E012 = Slave completion counter (word) - incremented by slave_work_wrapper
;   0x2203E014 = Frame counter (word) - incremented by slave_work_wrapper on frame sync
;   0x2203E016 = Reserved (word)
; 0x22xxxxxx is the cache-through cartridge-ROM alias, not SDRAM; these writes
; cannot provide shared counters. The B-006 callers are reverted/dormant.
;
; FIXED: Moved counters from COMM4/COMM5/COMM6 to dedicated RAM to avoid conflicts
;        Original game uses COMM4-COMM6 for command protocol
;
; MEMORY LAYOUT (status corrected 2026-07-21):
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
;   0x301490-0x3014FF  Free (padding to cmd $3F)
;   0x301500-0x3016AB  cmd3f_vr60_gameframe (428 bytes)       — BUILT/JT-INSTALLED; 1P trigger disabled
;   0x3016B0-0x30175F  cmd3e_entity_transfer (176 bytes)      — BUILT; 1P modes 0/1 enabled, mode 2 disabled
;   0x301760-0x3017AF  physics_divide (80 bytes)              — BUILT; dormant in current 1P
;   0x3017C0-0x301B33  physics_group1 (884 bytes)             — BUILT; dormant in current 1P
;   0x301B40-0x301D2F  physics_group2_accel (496 bytes)       — BUILT; dormant in current 1P
;   0x301D40-0x301E5B  physics_timers (284 bytes)             — BUILT; dormant in current 1P
;   0x301E60-0x3029EB  physics_pos/drift + AI ports           — BUILT; dormant in current 1P
;   0x302B00-0x302C7F  render_state_patcher (384 bytes)       — BUILT; verified no-op
;   0x302D00-0x3039D7  collision ports (end label 0x3039D8)   — ASSEMBLED/reference-tested; not wired
;   0x3039E0-0x303A03  corrected C254 bridge probe (36 bytes) — ASSEMBLED; dormant
;   0x303A10-0x3EFFFF  Free space (ROM padded to $3F0000)
;
; Historical B-006 data addresses (0x22xxxxxx = cartridge ROM alias, not SDRAM):
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
; Reads parameters from the historical 0x2203E000 literal, then calls vertex_transform_optimized.
; Adds 100 to COMM5 on successful return.
;
; WARNING: 0x2203E000 is cache-through cartridge ROM, not SDRAM. This dormant
; B-006 experiment cannot use that address as a writable parameter block. A
; future revival must use 0x2603E000 (cache-through SDRAM) and revalidate it.
; Historical parameter layout:
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
;   COMM3:4 = A0 source ptr (with $02000000 cartridge-ROM prefix from 68K)
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
; VISIBILITY BITMASK HANDLER: 0x3011A0 — STATUS: DORMANT/INVALID (S-1c reverted)
; ============================================================================
; Was: Entity visibility descriptor patcher. Reads 15-bit bitmask from COMM3,
; attempted to patch flags at invalid ROM alias $2200C344 (stride $14).
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
; VR60 GAME FRAME HANDLER: 0x301500 — BUILT/JT-INSTALLED; 1P TRIGGER DISABLED
; ============================================================================
; Master SH2 handler containing block copies plus the ported physics/AI pipeline.
; Collision remains additive/unwired. Normal 1P does not trigger this handler,
; so none of this work is authoritative there.
;
; Jump table entry at $02087C = $02301500 (cmd $3F).
; Intended SDRAM mailbox is $0600BC00 (cache-through $2600BC00). Q-023's
; validation-only ACTIVE artifact selects the corrected source-built include;
; its STAGE-CONTROL and all ordinary builds retain the legacy include. Neither
; arm enables the normal-1P cmd $3F trigger.
;
; See: disasm/sh2/expansion/cmd3f_vr60_gameframe.asm for source
;
        dcb.b   ($301500 - *), $FF      ; Pad to 0x301500
cmd3f_vr60_gameframe:
        ifd     VR60_Q027_VALIDATION
        include "sh2/generated/q027_player_stock_dispatch.inc"
        assert  *=$3016B0,"Q-027 player handler must be exactly 432 bytes"
        else
        ifd     VR60_Q026_VALIDATION
        include "sh2/generated/q026_player_shadow.inc"
        assert  *=$3015C8,"Q-026 player handler must be exactly 200 bytes"
        else
        ifd     VR60_Q023_MAILBOX_VALIDATION
        ifd     VR60_Q023_STAGE_CONTROL
        include "sh2/generated/cmd3f_vr60_gameframe.inc"
        else
        include "sh2/generated/cmd3f_vr60_gameframe_q023_corrected.inc"
        endif
        else
        include "sh2/generated/cmd3f_vr60_gameframe.inc"
        endif
        endif
        endif

; ============================================================================
; VR60 ENTITY TRANSFER HANDLER: 0x3016B0 — BUILT; 1P MODES 0/1 ENABLED
; ============================================================================
; Configures SH2 DMAC channel 0 to receive 256 bytes of player entity data
; from the 68K via DREQ FIFO. Data lands at $0600F20C (entity working copy).
;
; Jump table entry at $020878 = $023016B0 (cmd $3E).
;
; See: disasm/sh2/expansion/cmd3e_entity_transfer.asm for source
;
        dcb.b   ($3016B0 - *),$FF      ; Pad to 0x3016B0 (cmd $3F = 428B; cmd $3E is 176B and fits before $301760)
cmd3e_entity_transfer:
        include "sh2/generated/cmd3e_entity_transfer.inc"

; ============================================================================
; VR60 PHYSICS DIVISION INFRASTRUCTURE: 0x301760 — BUILT; DORMANT IN CURRENT 1P
; ============================================================================
; SH2 division support for physics port:
;   - sh2_sdiv16: Software signed 16-bit divide (~50 cycles)
;   - gear_recip_table: 6-entry reciprocal table (replaces DIVU)
;   - recip_div400, recip_div1175: constant reciprocals (replace DIVS #imm)
;
; See: disasm/sh2/expansion/physics_divide.asm for source
;
        dcb.b   ($301760 - *), $FF      ; Pad to 0x301760 (original physics_divide location)
physics_divide:
        include "sh2/generated/physics_divide.inc"

; ============================================================================
; VR60 PHYSICS GROUP 1: 0x3017C0 — BUILT; DORMANT IN CURRENT 1P
; ============================================================================
; SH2 translations of physics functions 1 (speed_degrade_calc) and 5
; (entity_speed_clamp). Uses GBR as entity base pointer.
;
; See: disasm/sh2/expansion/physics_group1.asm for source
;
        dcb.b   ($3017C0 - *), $FF      ; Pad to 0x3017C0
physics_group1:
        include "sh2/generated/physics_group1.inc"

; ============================================================================
; VR60 PHYSICS GROUP 2 (ACCEL): 0x301B40 — BUILT; DORMANT IN CURRENT 1P
; ============================================================================
; SH2 translations of functions 6 (speed_accel_braking) and 7 (tilt_adjust).
; DIVU replaced with gear reciprocal table multiply.
;
; See: disasm/sh2/expansion/physics_group2_accel.asm for source
;
        dcb.b   ($301B40 - *), $FF      ; Pad to 0x301B40
physics_group2_accel:
        include "sh2/generated/physics_group2_accel.inc"

; ============================================================================
; VR60 TIMER/GUARD FUNCTIONS: 0x301D40 — BUILT; DORMANT IN CURRENT 1P
; ============================================================================
; Co-ported from 68K to solve entity ownership problem. These functions
; modify entity fields that physics depends on, so they must run on the
; same CPU as physics (Master SH2).
;
; Functions: timer_decrement_multi, effect_timer_mgmt, timer_expire_reset,
;            field_check_guard, anim_timer_speed_clear
;
; See: disasm/sh2/expansion/physics_timers.asm for source
;
        dcb.b   ($301D40 - *), $FF      ; Pad to 0x301D40
physics_timers:
        include "sh2/generated/physics_timers.inc"

; ============================================================================
; VR60 16.16 POSITION UPDATE: 0x301E60 — BUILT; DORMANT IN CURRENT 1P
; ============================================================================
; 16.16 fixed-point position update. Replaces 68K entity_pos_update with
; sub-pixel precision accumulation. Integer part at +$30/+$34 (rendering-
; compatible), fraction at +$F2/+$F4 (new persistent fields).
;
; See: disasm/sh2/expansion/physics_pos_update.asm for source
;
        dcb.b   ($301E60 - *), $FF      ; Pad to 0x301E60
physics_pos_update:
        include "sh2/generated/physics_pos_update.inc"

; ============================================================================
; VR60 DRIFT SYSTEM: 0x301F20 — BUILT; DORMANT IN CURRENT 1P
; ============================================================================
; 4 functions: drift_physics, suspension_damping, lateral_drift_A, lateral_drift_B
; See: disasm/sh2/expansion/physics_drift.asm for source
;
        dcb.b   ($301F20 - *), $FF      ; Pad to 0x301F20
physics_drift:
        include "sh2/generated/physics_drift.inc"

; ============================================================================
; VR60 AI STEERING: 0x3025E0 — BUILT; DORMANT IN CURRENT 1P
; ============================================================================
; AI steering + atan2 calculation (shared with camera system)
; See: disasm/sh2/expansion/ai_steering.asm for source
;
        dcb.b   ($3025E0 - *), $FF      ; Pad to 0x3025E0
ai_steering:
        include "sh2/generated/ai_steering.inc"

; ============================================================================
; VR60 AI ORCHESTRATOR: 0x302700 — BUILT; DORMANT IN CURRENT 1P
; ============================================================================
; AI entity main update: spawn positioning, steering, speed, position.
; 3 entry points: main (active racing), spawn (timer), finish (retirement).
; See: disasm/sh2/expansion/ai_orchestrator.asm for source
;
        dcb.b   ($302700 - *), $FF      ; Pad to 0x302700
ai_orchestrator:
        include "sh2/generated/ai_orchestrator.inc"

; ============================================================================
; RENDER STATE PATCHER: VR60 Phase 7 — BUILT, VERIFIED NO-OP
; ============================================================================
; Intended to bridge physics entity data ($0600F20C) to Slave render state, but
; writes CA00/CCA0 locations that do not affect the per-frame racing consumer.
; Retained as historical code; the corrected descriptor probe is separate.
; Called from cmd3f_vr60_gameframe after physics pipeline.
;
; See: disasm/sh2/expansion/render_state_patcher.asm for source
;
        dcb.b   (($302B00) - *), $FF      ; Pad to next aligned block
render_state_patcher:
        include "sh2/generated/render_state_patcher.inc"

; ============================================================================
; VR60 COLLISION LEAF MATH: 0x302D00 — STATUS: ASSEMBLED ONLY (VR60 Phase 5A)
; ============================================================================
; Three zero-addressing-risk pure-math BSP/collision leaf functions, ported
; 1:1 from 68K. REGISTER-PARAMETER leaves (caller supplies pointers/scalars):
;   angle_normalize / angle_normalize_p24 / angle_normalize_alt
;       (68K $748C / +24 $74A4 / +168 $7534) — BSP visibility test
;   plane_eval / plane_eval_signed  (68K $75C8 / $75E0) — plane evaluation
;   rotational_offset_calc          (68K $764E) — billboard offsets; calls the
;       existing .pu_sin_lookup sine routine at SH2 $02301EDC.
;
; NOT wired into cmd $3F dispatch yet — 5A is additive/assembly-only. Verified
; byte-correct vs a 68K reference model (100k randomized cases).
; position_separation / proximity_zone_loop deferred to Phase 5E (entity-table
; iteration, needs the SDRAM entity-iteration convention).
;
; See: disasm/sh2/expansion/collision_leaf.asm for source
;
        dcb.b   ($302D00 - *), $FF      ; Pad to 0x302D00
collision_leaf:
        include "sh2/generated/collision_leaf.inc"

; ============================================================================
; VR60 COLLISION TRACK-DATA ADDRESSING: 0x303100 — STATUS: ASSEMBLED ONLY (5B)
; ============================================================================
; THE KEYSTONE sub-phase. Two track-data addressing functions + the documented
; 68K->SH2 pointer-translation convention (translate table CONTENTS and the
; $C268 base by +$01780000 ONCE at formation; table BASE is PC-relative and
; already an SH2 addr). Reference-model verified vs the ROM (index_calc 19,895
; cases / extract_033 40,000 cases, 0 mismatch).
;   track_data_index_calc_table_lookup (68K $0073E8) — 2-level ROM tile lookup
;   track_data_extract_033             (68K $0076A2) — 4-page geometry extract
;
; NOT wired into cmd $3F dispatch and the 68K globals packer is NOT modified
; yet — those happen in 5C/5D. Proposed SDRAM: globals +$38 race_state,
; +$3A track_seg_base (pre-translated), scratch $06011000 (work buffer).
;
; See: disasm/sh2/expansion/collision_track_data.asm for source + convention.
;
        dcb.b   ($303100 - *), $FF      ; Pad to 0x303100
collision_track_data:
        include "sh2/generated/collision_track_data.inc"

; ============================================================================
; VR60 COLLISION BOUNDARY DETECTION: 0x303200 — STATUS: ASSEMBLED ONLY (5C)
; ============================================================================
; object_type_dispatch (68K $7A40, flat-rebuilt 14-entry classifier; trap/oob
; nibbles -> design-intent default $02, proven via object_type_dispatch_b) +
; track_boundary_collision_detection (68K $789C, center + 4 directional probes).
; Inherits the 5B pointer-translation convention; calls collision_track_data
; (index_calc $02303100 / extract_033 $0230317C) + collision_leaf
; (angle_normalize $02302D00 / _p24 $02302D18 / _alt $02302E12). WRAM scratch
; relocated to TRACK_WORK region ($06011000+: workbuf/surf-type/surf-cnt/A4/
; coll-pos). NOT wired into cmd $3F yet; the 68K globals packer is extended
; (globals +$38 race_state, +$3A track_seg_base pre-translated) so inputs exist
; when later dispatched. Reference-model verified (verify_5c.py, 0 mismatch).
;
; See: disasm/sh2/expansion/collision_boundary.asm for source + puzzle/mapping.
;
        dcb.b   ($303200 - *), $FF      ; Pad to 0x303200
collision_boundary:
        include "sh2/generated/collision_boundary.inc"

; ============================================================================
; VR60 COLLISION RESPONSE + SURFACE TRACKING: 0x303410 — ASSEMBLED ONLY (5D)
; ============================================================================
; collision_response_surface_tracking (68K $7700, 412B): 4-iteration binary
; search (1/4-step advance/revert using track_boundary's +$55 bit0 collision
; flag as oracle) + EMA surface-height tracking at 4 probe points (plane_eval_
; signed oracle). Calls track_boundary_collision_detection (5C, $02303250) up to
; 5x and plane_eval_signed (5A, $02302F3A) 4x. Reads COLL_POS scratch ($06011030)
; + SH2-form tile ptrs from entity +$CE/$D2/$D6/$DA. Writes entity +$30/$34/$40/
; $46 (search) and +$5A/$5C/$5E/$32 (EMA). 1/4-step deltas + iter counter stashed
; on the stack across each track_boundary call (it clobbers R0-R12). NOT wired
; into cmd $3F (authoritative-copy question deferred to 5F — render_state_patcher
; is a no-op, so the SH2 entity drives nothing visible; wiring live would change
; an unread entity + interact with A-1 staging). Reference-model verified
; (verify_5d.py, 0 mismatch).
;
; See: disasm/sh2/expansion/collision_response.asm for source + investigation.
;
        dcb.b   ($303410 - *), $FF      ; Pad to 0x303410
collision_response:
        include "sh2/generated/collision_response.inc"

; ============================================================================
; VR60 OBJECT / PROXIMITY COLLISION: 0x303640 — ASSEMBLED ONLY (Phase 5E)
; ============================================================================
; The final additive collision sub-phase — the entity-TABLE layer (player +
; 15 AI), as opposed to the track-boundary layer (5A-5D). Four functions
; (920B): object_collision_detection (68K $AF18, player vs entity-15) +
; zone_check_inner (68K $AE06, 2-pass angle/bounds zone) + position_separation
; (68K $AFFE, push apart) + proximity_zone_loop (68K $877A, 15-entity zone).
;
; SETTLED SDRAM entity-iteration convention: player (entity 0) = $0600F20C;
; AI entity i (1..15) = $06010000 + (i-1)*$100 (stride $100, same as cmd $3F's
; AI loop); WRAM entity-15 ($FF9F00) = SDRAM $06010E00. Evidence: the AI
; staging copies WRAM $FF9100 (entity 1) -> SDRAM $06010000 intact
; (vr60_ai_entity_stage.asm). $C268 (zone_check's table base) is the SAME ptr
; as 5B/5C's track_seg_base (one WRAM longword, scene_camera_init.asm:84) ->
; reuses 5C's pre-translated globals +$3A; NO separate relocation. 5E-specific
; scene-stable read-only globals (object thresholds $C8CE/$C8D0 + zone bounds
; $C8E4-$C8F2) relocate to OBJ_COLL_GLOBALS = $06011050 in TRACK_WORK (the
; staged globals window is full; these are staged once at scene init when wired
; in 5F). Sound $B8 routes via globals +$2C -> COMM6_HI (existing relay).
; directional_collision_probe ($7AD6) EXCLUDED — dead in this build (zero refs).
;
; NOT wired into cmd $3F (additive/deferred, like 5C/5D): the SH2 entity drives
; nothing rendered (render_state_patch is a no-op; on-screen car is the 68K WRAM
; entity). Reference-model verified (verify_5e.py, 0 mismatch).
;
; See: disasm/sh2/expansion/collision_object.asm for source + conventions.
;
        dcb.b   ($303640 - *), $FF      ; Pad to 0x303640
collision_object:
        include "sh2/generated/collision_object.inc"

; ============================================================================
; VR60 5F-1b RENDER-BRIDGE VALIDATION PROBE: 0x3039E0 — DIAGNOSTIC (revertable)
; ============================================================================
; Tiny SH2 routine that clears the descriptor +$00 visibility word on the
; racing display-object block $0600C254 (56 entries, $14 stride; cache-through
; $2600C254 — Run C). It is assembled/selectable but currently DORMANT: cmd $3F
; still selects sh2_render_state_patch, and the normal-1P cmd $3F trigger is
; disabled. Per VR60_PHASE5F1B_PROBE_DIAGNOSIS.md the racing
; render (Slave cmd $02, $06000FA8) reads C128/C178/C254 via entity loop
; $060024DC, NOT C218. If C254 holds the opponent cars they VANISH in racing.
; Run A/B/C selectable by editing two lines in bridge_probe.asm.
; See bridge_probe.asm + VR60_PHASE5F1B_PROBE_DIAGNOSIS.md. Pending visual confirm.
;
        dcb.b   ($3039E0 - *), $FF      ; Pad to 0x3039E0
bridge_probe:
        include "sh2/generated/bridge_probe.inc"

; ============================================================================
; Q-020 MODE-1 CMDINT ISR: 0x303B00 — VALIDATION BUILDS ONLY
; ============================================================================
; Dedicated globals-only two-edge interrupt protocol.  The ordinary mode-0 ROM
; leaves this interval as $FF and retains its stock external vectors/startup.
        ifd     VR60_MODE1_VALIDATION
        dcb.b   ($303B00 - *), $FF
cmd3e_mode1_validation:
        include "sh2/generated/cmd3e_mode1_validation.inc"
        assert  *=$303F1C,"Q-020 mode-1 CMDINT ISR must end at file $303F1C"
        endif

; ============================================================================
; Q-021 MODE-2 CMDINT ISR: 0x303B00 — VALIDATION BUILDS ONLY
; ============================================================================
; Assembled from the reviewed two-edge ISR source with mode-2 constants. The
; mode-1 and mode-2 pairs are mutually exclusive and share this ROM interval.
        ifd     VR60_MODE2_VALIDATION
        dcb.b   ($303B00 - *), $FF
cmd3e_mode2_validation:
        include "sh2/generated/cmd3e_mode2_validation.inc"
        assert  *=$303F20,"Q-021 mode-2 CMDINT ISR must end at file $303F20"
        endif

; ============================================================================
; Q-020 CMDINT PROBE ISR: 0x303B00 — VALIDATION BUILDS ONLY
; ============================================================================
; All 16 Master external-interrupt vector entries select this handler in the
; probe ROM. Ordinary mode 0 leaves the entire allocation as $FF.
        ifd     VR60_Q020_CMDINT_PROBE
        dcb.b   ($303B00 - *), $FF
q020_cmdint_probe_isr:
        include "sh2/generated/q020_cmdint_probe_isr.inc"
        assert  *=$303CC4,"Q-020 CMDINT probe must end at file $303CC4"
        endif

; ============================================================================
; Q-026 PLAYER-PHYSICS CMDINT PRECURSOR: 0x304000 — VALIDATION BUILDS ONLY
; ============================================================================
; The unified external ISR owns $304000-$3046FF.  Core/pool and startup shim
; are generated separately from one linked source so the intervening ROM
; allocation remains asserted $FF padding rather than linker-created zeroes.
        ifd     VR60_Q026_VALIDATION
        dcb.b   ($304000 - *),$FF
q026_external_entry:
        include "sh2/generated/q026_external_isr_core.inc"
        assert  *=$304290,"Q-026 ISR core/pool must end at file $304290"
        dcb.b   ($304600 - *),$FF
q026_init:
        include "sh2/generated/q026_external_isr_init.inc"
        assert  *=$304654,"Q-026 startup shim must end at file $304654"
        dcb.b   ($304700 - *),$FF
        assert  *=$304700,"Q-026 unified ISR allocation must end at file $304700"
        endif

; ============================================================================
; Q-027 MASTER-ONLY STOCK-DISPATCH GATE: 0x304000 — VALIDATION BUILDS ONLY
; ============================================================================
; Core, fixed no-memory park loop, and startup are generated from independently
; linked sections so every unowned byte remains asserted $FF.
        ifd     VR60_Q027_VALIDATION
        dcb.b   ($304000 - *),$FF
q027_external_entry:
        ifd     VR60_Q027_STAGE_CONTROL
        include "sh2/generated/q027_external_isr_control_core.inc"
        else
        include "sh2/generated/q027_external_isr_active_core.inc"
        endif
        assert  *=$304314,"Q-027 ISR core/pool must end at file $304314"
        dcb.b   ($304500 - *),$FF
q027_master_park:
        include "sh2/generated/q027_master_park.inc"
        assert  *=$304504,"Q-027 park loop must end at file $304504"
        dcb.b   ($304600 - *),$FF
q027_init:
        include "sh2/generated/q027_external_isr_init.inc"
        assert  *=$30466C,"Q-027 startup shim must end at file $30466C"
        dcb.b   ($304700 - *),$FF
        assert  *=$304700,"Q-027 unified ISR allocation must end at file $304700"
        endif

; ============================================================================
; REMAINING EXPANSION ROM SPACE (from ~0x303A10)
; ============================================================================
; Pad to $3F0000 (960KB) instead of $400000 (1MB) to avoid PicoDrive
; emulator bug triggered by ROM files > ~0x3F1F40 bytes.
; Still provides ~1013KB expansion space.
        dcb.b   ($3F0000 - *), $FF
