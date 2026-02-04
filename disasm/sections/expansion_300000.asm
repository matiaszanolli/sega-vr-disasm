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
;   0x300700-0x3FFFFF  Padding (remaining)
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
handler_frame_sync:
; Layout: 0x300028=mov.l, 0x30002A-2E=nops, 0x300030=literal
; EA = (PC & ~3) + 4 + d*4 = 0x300028 + 4 + d*4 = 0x30002C + d*4
; For literal at 0x300030: d = (0x300030 - 0x30002C) / 4 = 1
        dc.w    $D001                   ; MOV.L @(4,PC),R0 - loads COMM4 addr (d=1)
        dc.w    $0009                   ; NOP (padding for alignment)
        dc.w    $0009                   ; NOP
        dc.w    $0009                   ; NOP
        dc.l    $20004028               ; Literal: COMM4 address (4-byte aligned at 0x300030)
        dc.w    $6101                   ; MOV.W @R0,R1 - read COMM4 (16-bit register!)
        dc.w    $7101                   ; ADD #1,R1
        dc.w    $2011                   ; MOV.W R1,@R0 - write COMM4 (16-bit register!)
        dc.w    $000B                   ; RTS
        dc.w    $0009                   ; NOP (delay slot)

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
; Bytecode layout:
;   0x300050: STS.L PR,@-R15      (4F22) - save return address
;   0x300052: MOV #$16,R1         (E116) - vertex transform code
;   0x300054: CMP/EQ R1,R0        (3010) - is this cmd 0x16?
;   0x300056: BT .do_dispatch     (8901) - skip COMM7 write if 0x16 (+1)
;   0x300058: MOV.L @(20,PC),R2   (D205) - load COMM7 addr from $300070
;   0x30005A: MOV.W R0,@R2        (2021) - COMM7 = cmd
;   .do_dispatch:
;   0x30005C: SHLL2 R0            (4008) - cmd * 4
;   0x30005E: MOV.L @(20,PC),R1   (D105) - load jump table from $300074
;   0x300060: MOV.L @(R0,R1),R0   (001E) - lookup handler
;   0x300062: JSR @R0             (400B) - call handler
;   0x300064: NOP                 (0009) - delay slot
;   0x300066: LDS.L @R15+,PR      (4F26) - restore return addr
;   0x300068: MOV.L @(12,PC),R0   (D003) - load loop addr from $300078
;   0x30006A: JMP @R0             (402B) - return to polling loop
;   0x30006C: NOP                 (0009) - delay slot
;   0x30006E: NOP                 (0009) - padding for 4-byte align
;   0x300070: COMM7 address       (2000402E)
;   0x300074: Jump table          (06000780)
;   0x300078: Loop address        (02020460)
;
master_dispatch_hook:
        dc.w    $4F22           ; $300050: STS.L PR,@-R15
        dc.w    $E116           ; $300052: MOV #$16,R1
        dc.w    $3010           ; $300054: CMP/EQ R1,R0
        dc.w    $8901           ; $300056: BT .do_dispatch (+1)
        dc.w    $D205           ; $300058: MOV.L @(20,PC),R2 - COMM7 addr
        dc.w    $2021           ; $30005A: MOV.W R0,@R2 - write COMM7=cmd
.do_dispatch:
        dc.w    $4008           ; $30005C: SHLL2 R0 - cmd * 4
        dc.w    $D105           ; $30005E: MOV.L @(20,PC),R1 - jump table
        dc.w    $001E           ; $300060: MOV.L @(R0,R1),R0 - lookup
        dc.w    $400B           ; $300062: JSR @R0 - call handler
        dc.w    $0009           ; $300064: NOP (delay slot)
        dc.w    $4F26           ; $300066: LDS.L @R15+,PR
        dc.w    $D003           ; $300068: MOV.L @(12,PC),R0 - loop addr
        dc.w    $402B           ; $30006A: JMP @R0
        dc.w    $0009           ; $30006C: NOP (delay slot)
        dc.w    $0009           ; $30006E: NOP (padding for 4-byte align)
; Literal pool (4-byte aligned at 0x300070)
        dc.l    $2000402E       ; $300070: COMM7 address
        dc.l    $06000780       ; $300074: Original jump table
        dc.l    $02020460       ; $300078: Return to polling loop

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
; Bytecode layout:
;   0x300280: STS.L PR,@-R15    (4F22) - save return address
;   0x300282: MOV.L @(28,PC),R0 (D007) - load param block addr from $3002A0
;   0x300284: MOV.L @R0,R14     (6E02) - R14 = param[0]
;   0x300286: MOV.L @(4,R0),R7  (5701) - R7 = param[1]
;   0x300288: MOV.L @(8,R0),R8  (5802) - R8 = param[2]
;   0x30028A: MOV.L @(12,R0),R5 (5503) - R5 = param[3]
;   0x30028C: MOV.L @(20,PC),R0 (D005) - load func addr from $3002A4
;   0x30028E: JSR @R0           (400B) - call func_021_optimized
;   0x300290: NOP               (0009) - delay slot
;   0x300292: MOV.L @(20,PC),R0 (D005) - load COMM5 addr from $3002A8
;   0x300294: MOV.W @R0,R1      (6101) - read COMM5
;   0x300296: ADD #100,R1       (7164) - add 100 (0x64)
;   0x300298: MOV.W R1,@R0      (2011) - write COMM5
;   0x30029A: LDS.L @R15+,PR    (4F26) - restore return address
;   0x30029C: RTS               (000B) - return
;   0x30029E: NOP               (0009) - delay slot
;   0x3002A0: param block addr  (2203E000) - cache-through SDRAM
;   0x3002A4: func address      (02300100) - func_021_optimized
;   0x3002A8: COMM5 address     (2000402A)
;
slave_test_func:
        dc.w    $4F22           ; $300280: STS.L PR,@-R15
        dc.w    $D007           ; $300282: MOV.L @(28,PC),R0 - param block
        dc.w    $6E02           ; $300284: MOV.L @R0,R14
        dc.w    $5701           ; $300286: MOV.L @(4,R0),R7
        dc.w    $5802           ; $300288: MOV.L @(8,R0),R8
        dc.w    $5503           ; $30028A: MOV.L @(12,R0),R5
        dc.w    $D005           ; $30028C: MOV.L @(20,PC),R0 - func addr
        dc.w    $400B           ; $30028E: JSR @R0
        dc.w    $0009           ; $300290: NOP (delay slot)
        dc.w    $D005           ; $300292: MOV.L @(20,PC),R0 - COMM5 addr
        dc.w    $6101           ; $300294: MOV.W @R0,R1
        dc.w    $7164           ; $300296: ADD #100,R1 (0x64 = 100)
        dc.w    $2011           ; $300298: MOV.W R1,@R0
        dc.w    $4F26           ; $30029A: LDS.L @R15+,PR
        dc.w    $000B           ; $30029C: RTS
        dc.w    $0009           ; $30029E: NOP (delay slot)
; Literal pool (4-byte aligned at 0x3002A0)
        dc.l    $2203E000       ; $3002A0: param block address (cache-through SDRAM)
        dc.l    $02300100       ; $3002A4: func_021_optimized address
        dc.l    $2000402A       ; $3002A8: COMM5 address

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
; Size: 36 bytes
;
        dcb.b   ($300 - $2AC), $FF  ; Pad to 0x300300
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
        dcb.b   ($400 - $326), $FF  ; Pad to 0x300400
shadow_path_wrapper:
        ; Increment COMM6 (Master call counter)
        dc.w    $D00A           ; $300400: MOV.L @(40,PC),R0 - COMM6 addr
        dc.w    $6101           ; $300402: MOV.W @R0,R1 - read COMM6
        dc.w    $7101           ; $300404: ADD #1,R1 - increment
        dc.w    $2011           ; $300406: MOV.W R1,@R0 - write COMM6
        ; Copy parameters to shared memory
        dc.w    $D009           ; $300408: MOV.L @(36,PC),R0 - param block
        dc.w    $20E2           ; $30040A: MOV.L R14,@R0 - save R14
        dc.w    $1071           ; $30040C: MOV.L R7,@(4,R0) - save R7
        dc.w    $1082           ; $30040E: MOV.L R8,@(8,R0) - save R8
        dc.w    $1053           ; $300410: MOV.L R5,@(12,R0) - save R5
        ; Signal Slave via COMM7
        dc.w    $D008           ; $300412: MOV.L @(32,PC),R0 - COMM7 addr
        dc.w    $E116           ; $300414: MOV #$16,R1 - signal value
        dc.w    $2011           ; $300416: MOV.W R1,@R0 - COMM7 = 0x16
        ; Call original func_021 (relocated)
        dc.w    $D008           ; $300418: MOV.L @(32,PC),R0 - original func
        dc.w    $400B           ; $30041A: JSR @R0 - call original
        dc.w    $0009           ; $30041C: NOP (delay slot)
        ; Return to caller
        dc.w    $000B           ; $30041E: RTS
        dc.w    $0009           ; $300420: NOP (delay slot)
        dc.w    $0009           ; $300422: NOP (alignment)
; Literal pool (4-byte aligned at $300424)
        dc.l    $2000402C       ; $300424: COMM6 address
        dc.l    $2203E000       ; $300428: param block (cache-through SDRAM)
        dc.l    $2000402E       ; $30042C: COMM7 address
        dc.l    $02300300       ; $300430: func_021_original_relocated

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
; REMAINING EXPANSION ROM SPACE
; ============================================================================
; cmd27_queue_drain is ~130 bytes, ending around 0x300682
; Pad to end of 1MB expansion space
        dcb.b   ($100000 - $700), $FF
