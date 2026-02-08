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
;   COMM4 = 0x20004028 (Slave work counter)
;   COMM5 = 0x2000402A (Vertex transform counter)
;   COMM7 = 0x2000402E (Slave work signal)
;
; Signal Values (COMM7):
;   0x0000 = Idle
;   0x0001 = Frame sync (increment COMM4)
;   0x0016 = Vertex transform (Phase 16)
;   0x0027 = Queue drain (cmd $27 async processing)
;
; MEMORY LAYOUT:
;   0x300000-0x300027  Padding (40 bytes)
;   0x300028-0x30003F  handler_frame_sync (22 bytes)
;   0x300050-0x30007B  master_dispatch_hook (44 bytes)
;   0x300100-0x30015F  func_021_optimized (96 bytes)
;   0x300200-0x30026F  slave_work_wrapper_v2 (112 bytes)
;   0x300280-0x3002AB  slave_test_func (44 bytes)
;   0x300300-0x300325  func_021_original_relocated (36 bytes)
;   0x300400-0x300433  shadow_path_wrapper (52 bytes)
;   0x300500-0x300537  batch_copy_handler (~56 bytes)
;   0x300600-0x30067F  cmd27_queue_drain (128 bytes)
;   --- Phase 1 allocations (reserved) ---
;   0x300800-0x300BFF  cmdint_handler (Master SH2 CMDINT ISR, 1KB reserved)
;   0x300C00-0x300FFF  queue_processor (ring buffer drain loop, 1KB reserved)
;   0x301000-0x3FFFFF  Free space (remaining ~1020KB)
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
        dcb.b   ($50 - $3E), $FF

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
; Current position: 0x30007C (hook ends at 0x50 + 44 bytes)
; Pad to 0x300100 for nice alignment
        dcb.b   ($100 - $7C), $FF

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
        dcb.b   ($200 - $160), $FF

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
        dcb.b   ($280 - $270), $FF

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
; ORIGINAL func_021 (RELOCATED FOR SHADOW PATH)
; ============================================================================
; Relocated from ROM $0234C8 to enable shadow path instrumentation.
; Original 36 bytes preserved byte-for-byte for correct rendering.
;
; Shadow wrapper at $0234C8 calls this after instrumenting COMM6/COMM7.
; Slave works in parallel using func_021_optimized while Master uses this.
;
; Address: 0x300300 (SH2: 0x02300300)
; Size: 36 bytes (ends at 0x300326)
;
        dcb.b   ($300 - $2AC), $FF  ; Pad from 0x3002AC to 0x300300 (84 bytes)
func_021_original_relocated:
        dc.w    $4F22        ; $300300  STS.L PR,@-R15
        dc.w    $BF4D        ; $300302  BSR (func_016)
        dc.w    $0009        ; $300304  NOP
        dc.w    $2F76        ; $300306  MOV.L R7,@-R15
        dc.w    $2F86        ; $300308  MOV.L R8,@-R15
        dc.w    $B01A        ; $30030A  BSR (nested func)
        dc.w    $4F22        ; $30030C  STS.L PR,@-R15
        dc.w    $68F6        ; $30030E  MOV.L @R15+,R8
        dc.w    $67F6        ; $300310  MOV.L @R15+,R7
        dc.w    $8581        ; $300312  MOV.B R0,@($1,R5)
        dc.w    $C801        ; $300314  TST #1,R0
        dc.w    $8F01        ; $300316  BF/S +1
        dc.w    $7810        ; $300318  ADD #$10,R8
        dc.w    $7804        ; $30031A  ADD #$04,R8
        dc.w    $4710        ; $30031C  DT R7
        dc.w    $8BF2        ; $30031E  BF -12
        dc.w    $4F26        ; $300320  LDS.L @R15+,PR
        dc.w    $000B        ; $300322  RTS
        dc.w    $0009        ; $300324  NOP

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
        dcb.b   ($400 - $326), $FF  ; Pad from 0x300326 to 0x300400 (218 bytes)
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
        dcb.b   ($500 - $434), $FF  ; Pad to 0x300500
batch_copy_handler:
        include "sh2/generated/batch_copy_handler.inc"

; ============================================================================
; PADDING TO cmd27_queue_drain
; ============================================================================
; Current position: 0x300538 (after batch_copy_handler)
; Pad to 0x300600 for nice alignment
        dcb.b   ($600 - $538), $FF

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
; PHASE 1: CMDINT HANDLER AND QUEUE PROCESSOR
; ============================================================================
; Pad from end of cmd27_queue_drain (~0x300682) to Phase 1 allocation at 0x300800
        dcb.b   ($800 - $700), $FF

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
        dcb.b   ($100000 - $1000), $FF
