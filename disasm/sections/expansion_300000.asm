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
;   0x0016 = Vertex transform (func_021 parallel processing)
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
; MEMORY LAYOUT:
;   0x300000-0x300027  Padding (40 bytes)
;   0x300028-0x30003F  handler_frame_sync (22 bytes)
;   0x300050-0x30007B  master_dispatch_hook (44 bytes)
;   0x300100-0x30015F  func_021_optimized (96 bytes)
;   0x300200-0x30026F  slave_work_wrapper_v2 (112 bytes, updated for RAM counters)
;   0x300280-0x3002AB  slave_test_func (32 bytes, reduced - counter removed)
;   0x300300-0x300325  func_021_original_relocated (36 bytes)
;   0x300400-0x300450  shadow_path_wrapper (~80 bytes, added per-call barrier)
;   0x300500-0x300537  batch_copy_handler (~56 bytes)
;   0x300600-0x30067F  cmd27_queue_drain (128 bytes)
;   0x300700-0x300727  slave_comm7_idle_check (40 bytes, COMM7 doorbell handler)
;   --- Phase 1 allocations (reserved) ---
;   0x300800-0x300BFF  cmdint_handler (Master SH2 CMDINT ISR, 1KB reserved)
;   0x300C00-0x300FFF  queue_processor (ring buffer drain loop, 1KB reserved)
;   0x301000-0x3FFFFF  Free space (remaining ~1020KB)
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
; FRAME SYNC HANDLER: 0x300028 (EVEN-ALIGNED for SH2 instruction fetch)
; ============================================================================
; Simple handler that increments COMM4 and returns.
; NOTE: Phase 16 dispatch will be added later with hook modifications.
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
; MASTER DISPATCH HOOK: 0x300050 (SH2 address: 0x02300050)
; ============================================================================
; Called by Master SH2 when dispatching a command from 68K.
; Writes COMM7=cmd for all commands EXCEPT 0x16 (vertex transform).
; For cmd 0x16, the func_021 trampoline handles signaling AFTER params are ready.
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
; PADDING TO func_021_optimized
; ============================================================================
; Current position: 0x30006C (hook ends at 0x50 + 28 bytes)
; Pad to 0x300100 for nice alignment
        dcb.b   ($300100 - *), $FF

; ============================================================================
; func_021_optimized: Coordinate Transform + Cull (with func_016 inlined)
; Entry point: 0x300100 (SH2 address: 0x02300100) - 4-BYTE ALIGNED
; ============================================================================
func_021_optimized:
        include "sh2/generated/func_021_optimized.inc"

; ============================================================================
; PADDING TO slave_work_wrapper
; ============================================================================
; Current position: ~0x300160 (func_021_optimized is ~96 bytes)
; Pad to 0x300200 for nice alignment
        dcb.b   ($300200 - *), $FF

; ============================================================================
; SLAVE WORK WRAPPER V2: 0x300200 (SH2 address: 0x02300200)
; ============================================================================
; Slave SH2 main loop - polls COMM7 for work signals from Master/68K.
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
; SLAVE TEST FUNCTION: 0x300280 (SH2 address: 0x02300280)
; ============================================================================
; Reads parameters from shared memory at 0x2203E000, then calls func_021_optimized.
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
; ORIGINAL func_021 (RELOCATED FOR SHADOW PATH — FIXED)
; ============================================================================
; Relocated from ROM $0234C8 to enable shadow path instrumentation.
; FIXED: Replaced PC-relative BSR with absolute MOV.L+JSR because the
; original BSR targets (func_016 at $023368, nested at $02350A) are in
; main ROM, unreachable by BSR from expansion ROM.
;
; Address: 0x300300 (SH2: 0x02300300)
; Size: 52 bytes (26 words, ends at 0x300333)
;
        dcb.b   ($300300 - *), $FF  ; Pad to 0x300300 (auto-sized)
func_021_original_relocated:
        dc.w    $4F22        ; $300300  STS.L PR,@-R15
        dc.w    $D30A        ; $300302  MOV.L @(40,PC),R3 → func_016 addr
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
        dc.w    $0202        ; $30032C  Literal: func_016 = 0x02023368 (high)
        dc.w    $3368        ; $30032E  Literal: func_016 = 0x02023368 (low)
        dc.w    $0202        ; $300330  Literal: nested func = 0x0202350A (high)
        dc.w    $350A        ; $300332  Literal: nested func = 0x0202350A (low)

; ============================================================================
; SHADOW PATH WRAPPER: 0x300400 (SH2: 0x02300400)
; ============================================================================
; Full instrumentation for shadow path (Option 3).
; Called from func_021 jump at $0234C8.
;
; Increments COMM6 (Master call counter), signals Slave via COMM7,
; then calls relocated original func_021. Master uses original results,
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
; BATCH COPY HANDLER: 0x300500 (SH2 address: 0x02300500)
; ============================================================================
; Batch copy optimization for reducing 68K blocking waits.
; Replaces 8 separate sh2_send_cmd_wait calls with a single batch command.
;
; Protocol (command $26 - BATCH_COPY):
;   COMM4 = table address (SH2 space)
;   Table format: [count:16][pad:16][src:32][dst:32][size:32]...
;
; Entry: COMM4 contains pointer to batch table
; Uses: R0-R5, R8
;
; See: analysis/optimization/BATCH_COPY_COMMAND_DESIGN.md
;
        dcb.b   ($300500 - *), $FF  ; Pad to 0x300500 (auto-sized)
batch_copy_handler:
        include "sh2/generated/batch_copy_handler.inc"

; ============================================================================
; PADDING TO cmd27_queue_drain
; ============================================================================
; Current position: 0x300538 (after batch_copy_handler)
; Pad to 0x300600 for nice alignment
        dcb.b   ($300600 - *), $FF

; ============================================================================
; CMD27 QUEUE DRAIN: 0x300600 (SH2 address: 0x02300600)
; ============================================================================
; Async queue processor for cmd $27. Called by slave_work_wrapper when
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
; SLAVE COMM7 IDLE CHECK: 0x300700 (SH2 address: 0x02300700)
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

; --- Phase 1: Master SH2 CMDINT Handler (at 0x300800) ---
; SH2 address: 0x02300800
; CMDINT ISR that processes ring buffer entries from SDRAM.
; See: disasm/sh2/expansion/cmdint_handler.asm for source
cmdint_handler:
        include "sh2/generated/cmdint_handler.inc"

; --- Pad to queue_processor at 0x300C00 ---
        dcb.b   ($C00 - $900), $FF      ; Pad from ~$900 to $C00

; --- Phase 1: Queue Processor (at 0x300C00) ---
; SH2 address: 0x02300C00
; Ring buffer drain loop called by CMDINT handler.
; Processes entries: [cmd_id, param1, param2, param3] × 16-bit words
; See: disasm/sh2/expansion/queue_processor.asm for source
queue_processor:
        include "sh2/generated/queue_processor.inc"

; ============================================================================
; REMAINING EXPANSION ROM SPACE (from 0x301000)
; ============================================================================
; Pad to $3F0000 (960KB) instead of $400000 (1MB) to avoid PicoDrive
; emulator bug triggered by ROM files > ~0x3F1F40 bytes.
; Still provides ~960KB expansion space (99.7% free).
        dcb.b   ($F0000 - $1000), $FF
