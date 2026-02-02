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
;   COMM7 = 0x2000402E (Frame sync signal - UNUSED by game)
;
; Signal Values (future use):
;   0x0000 = Idle
;   0x0001 = Frame sync (increment COMM4)
;   0x0016 = Vertex transform (Phase 16)
;
; MEMORY LAYOUT:
;   0x300000-0x300027  Padding (40 bytes)
;   0x300028-0x30003F  Handler entry (even-aligned)
;   0x300040-0x30004F  Reserved
;   0x300050-0x3000FF  Reserved
;   0x300100-0x30015F  func_021_optimized (96 bytes)
;   0x300160-0x3FFFFF  Padding
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
; SLAVE WORK WRAPPER: 0x300200 (SH2 address: 0x02300200)
; ============================================================================
; Slave SH2 main loop - polls COMM7 for work signals from Master.
; Dispatches based on COMM7 value:
;   0x0001 = Frame sync (increment COMM4)
;   0x0016 = Vertex transform (calls slave_test_func, then increments COMM5)
;
; Protocol:
;   1. Master writes COMM7 = work_type when dispatching a command
;   2. Slave detects COMM7 != 0, dispatches to appropriate handler
;   3. Slave clears COMM7, returns to polling
;
; Bytecode layout:
;   0x300200: MOV.L @(56,PC),R1  (D10E) - load COMM7 addr from $30023C
;   0x300202: MOV.W @R1,R0       (6101) - read COMM7  [.poll_loop]
;   0x300204: TST R0,R0          (2008) - test if zero
;   0x300206: BT .poll_loop      (89FC) - loop if zero (-4)
;   0x300208: MOV #1,R2          (E201) - frame sync code
;   0x30020A: CMP/EQ R2,R0       (3020) - compare
;   0x30020C: BT .frame_sync     (8906) - branch if match (+6 → $30021C)
;   0x30020E: MOV #$16,R2        (E216) - vertex transform code
;   0x300210: CMP/EQ R2,R0       (3020) - compare
;   0x300212: BT .vertex_xform   (8909) - branch if match (+9 → $300228)
;   0x300214: MOV #0,R0          (E000) - [.clear_loop] unknown type
;   0x300216: MOV.W R0,@R1       (2011) - clear COMM7
;   0x300218: BRA .poll_loop     (AFF3) - continue polling (-13)
;   0x30021A: NOP                (0009) - delay slot
;   0x30021C: MOV.L @(32,PC),R2  (D208) - [.frame_sync] COMM4 addr from $300240
;   0x30021E: MOV.W @R2,R0       (6020) - read COMM4
;   0x300220: ADD #1,R0          (7001) - increment
;   0x300222: MOV.W R0,@R2       (2021) - write COMM4
;   0x300224: BRA .clear_loop    (AFF6) - go clear signal (-10)
;   0x300226: NOP                (0009) - delay slot
;   0x300228: MOV.L @(28,PC),R3  (D307) - [.vertex_xform] func addr from $300248
;   0x30022A: JSR @R3            (430B) - call slave_test_func
;   0x30022C: NOP                (0009) - delay slot
;   0x30022E: MOV.L @(20,PC),R2  (D205) - COMM5 addr from $300244
;   0x300230: MOV.W @R2,R0       (6020) - read COMM5
;   0x300232: ADD #1,R0          (7001) - increment
;   0x300234: MOV.W R0,@R2       (2021) - write COMM5
;   0x300236: BRA .clear_loop    (AFED) - go clear signal (-19)
;   0x300238: NOP                (0009) - delay slot
;   0x30023A: NOP                (0009) - padding
;   0x30023C: COMM7 address      (2000402E)
;   0x300240: COMM4 address      (20004028)
;   0x300244: COMM5 address      (2000402A)
;   0x300248: func address       (02300280) - slave_test_func
;
slave_work_wrapper:
        dc.w    $D10E           ; $300200: MOV.L @(56,PC),R1 - load COMM7 addr
.poll_loop:
        dc.w    $6101           ; $300202: MOV.W @R1,R0 - read COMM7
        dc.w    $2008           ; $300204: TST R0,R0 - test if zero
        dc.w    $89FC           ; $300206: BT .poll_loop - loop if zero
        ; Work signal received - dispatch based on value
        dc.w    $E201           ; $300208: MOV #1,R2 - frame sync code
        dc.w    $3020           ; $30020A: CMP/EQ R2,R0
        dc.w    $8906           ; $30020C: BT .frame_sync (+6)
        dc.w    $E216           ; $30020E: MOV #$16,R2 - vertex transform code
        dc.w    $3020           ; $300210: CMP/EQ R2,R0
        dc.w    $8909           ; $300212: BT .vertex_transform (+9)
.clear_loop:
        ; Unknown work type or done - clear signal
        dc.w    $E000           ; $300214: MOV #0,R0
        dc.w    $2011           ; $300216: MOV.W R0,@R1 - clear COMM7
        dc.w    $AFF3           ; $300218: BRA .poll_loop (-13)
        dc.w    $0009           ; $30021A: NOP (delay slot)
.frame_sync:
        ; Increment COMM4 (frame counter)
        dc.w    $D208           ; $30021C: MOV.L @(32,PC),R2 - load COMM4 addr
        dc.w    $6020           ; $30021E: MOV.W @R2,R0 - read COMM4
        dc.w    $7001           ; $300220: ADD #1,R0
        dc.w    $2021           ; $300222: MOV.W R0,@R2 - write COMM4
        dc.w    $AFF6           ; $300224: BRA .clear_loop (-10)
        dc.w    $0009           ; $300226: NOP (delay slot)
.vertex_transform:
        ; Call slave_test_func, then increment COMM5
        dc.w    $D307           ; $300228: MOV.L @(28,PC),R3 - load func addr from $300248
        dc.w    $430B           ; $30022A: JSR @R3 - call slave_test_func
        dc.w    $0009           ; $30022C: NOP (delay slot)
        dc.w    $D205           ; $30022E: MOV.L @(20,PC),R2 - load COMM5 addr from $300244
        dc.w    $6020           ; $300230: MOV.W @R2,R0 - read COMM5
        dc.w    $7001           ; $300232: ADD #1,R0
        dc.w    $2021           ; $300234: MOV.W R0,@R2 - write COMM5
        dc.w    $AFED           ; $300236: BRA .clear_loop (-19)
        dc.w    $0009           ; $300238: NOP (delay slot)
        dc.w    $0009           ; $30023A: NOP (padding for alignment)
; Literal pool (4-byte aligned at 0x30023C)
        dc.l    $2000402E       ; $30023C: COMM7 address
        dc.l    $20004028       ; $300240: COMM4 address
        dc.l    $2000402A       ; $300244: COMM5 address
        dc.l    $02300280       ; $300248: slave_test_func address

; ============================================================================
; PADDING TO slave_test_func
; ============================================================================
; Current position: 0x30024C (literal pool ends)
; Pad to 0x300280 for nice alignment
        dcb.b   ($280 - $24C), $FF

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
        dc.l    $02300100       ; $300430: func_021_optimized (func_016 inlined)

; ============================================================================
; CONDITIONAL SWITCH OPTIONS: 0x300440-0x3004FF
; ============================================================================
; These are ALTERNATIVE trampolines for func_021. Use ONE of:
;   - shadow_path_wrapper @ $300400 (always calls original, Slave in parallel)
;   - func_021_conditional @ $300440 (Phase 1: Master always works + signals)
;   - func_021_conditional_v2 @ $300480 (Phase 2: skips Master when Slave ahead)
;
; To switch: change the literal at the trampoline patch point ($022234C8)
;
; ACTIVATION SEQUENCE:
;   1. Start with shadow_path_wrapper - measure COMM6 call pattern
;   2. Enable Slave polling - measure gap (COMM6 - COMM5)
;   3. If gap ≤ 0 consistently → switch to func_021_conditional_v2
;   4. If gap > 0 sometimes → stay on func_021_conditional (safe fallback)
;
; ============================================================================

        dcb.b   ($440 - $434), $FF  ; Pad to 0x300440

; ============================================================================
; func_021_conditional: Phase 1 - Safe Timing Measurement (48 bytes)
; Address: 0x300440 (SH2: 0x02300440)
; ============================================================================
; Master ALWAYS calls original func_021 (guarantees correctness).
; When Slave is idle, ALSO signals new work (parallel execution).
; COMM6 tracks Master calls for gap analysis.
;
; Use this to measure: can Slave keep up with Master?
;
func_021_conditional:
        ; Save return address (we'll call original func_021)
        dc.w    $4F22           ; $300440: STS.L PR,@-R15

        ; Check if Slave is busy
        dc.w    $D00B           ; $300442: MOV.L @(44,PC),R0 - COMM7 addr from $300470
        dc.w    $6101           ; $300444: MOV.W @R0,R1 - read COMM7
        dc.w    $2118           ; $300446: TST R1,R1 - test if zero
        dc.w    $8B07           ; $300448: BF .call_original (+7) - skip signal if busy

        ; Slave idle - capture params and signal (parallel work)
        dc.w    $D209           ; $30044A: MOV.L @(36,PC),R2 - param block from $300474
        dc.w    $22E2           ; $30044C: MOV.L R14,@R2 - save context
        dc.w    $1271           ; $30044E: MOV.L R7,@(4,R2) - save loop counter
        dc.w    $1282           ; $300450: MOV.L R8,@(8,R2) - save data ptr
        dc.w    $1253           ; $300452: MOV.L R5,@(12,R2) - save output ptr
        dc.w    $E116           ; $300454: MOV #$16,R1 - work signal
        dc.w    $2011           ; $300456: MOV.W R1,@R0 - COMM7 = 0x16

.cond1_call_original:
        ; Increment COMM6 (Master call counter) for timing analysis
        dc.w    $D007           ; $300458: MOV.L @(28,PC),R0 - COMM6 addr from $300478
        dc.w    $6101           ; $30045A: MOV.W @R0,R1 - read COMM6
        dc.w    $7101           ; $30045C: ADD #1,R1 - increment
        dc.w    $2011           ; $30045E: MOV.W R1,@R0 - write COMM6

        ; Call original func_021 (Master ALWAYS produces result)
        dc.w    $D006           ; $300460: MOV.L @(24,PC),R0 - orig func from $30047C
        dc.w    $400B           ; $300462: JSR @R0
        dc.w    $0009           ; $300464: NOP (delay slot)

        ; Restore return address and return
        dc.w    $4F26           ; $300466: LDS.L @R15+,PR
        dc.w    $000B           ; $300468: RTS
        dc.w    $0009           ; $30046A: NOP (delay slot)

        ; Padding for 4-byte alignment
        dc.w    $0009           ; $30046C: NOP
        dc.w    $0009           ; $30046E: NOP

; Literal pool for func_021_conditional (4-byte aligned at $300470)
        dc.l    $2000402E       ; $300470: COMM7 address
        dc.l    $2203E000       ; $300474: param block address
        dc.l    $2000402C       ; $300478: COMM6 address
        dc.l    $02300100       ; $30047C: func_021_optimized (func_016 inlined)

; ============================================================================
; func_021_conditional_v2: Phase 2 - Full Skip When Safe (80 bytes)
; Address: 0x300480 (SH2: 0x02300480)
; ============================================================================
; If COMM5 >= COMM6 → Slave ahead → skip Master work, use Slave result
; Else → Slave behind → Master does work, signal Slave if idle
;
; CRITICAL: Only use after Phase 1 confirms Slave can keep up!
;
func_021_conditional_v2:
        ; Save return address
        dc.w    $4F22           ; $300480: STS.L PR,@-R15

        ; Read COMM6 (Master call count) and COMM5 (Slave completions)
        dc.w    $D00F           ; $300482: MOV.L @(60,PC),R0 - COMM6 addr from $3004C0
        dc.w    $6101           ; $300484: MOV.W @R0,R1 - R1 = COMM6
        dc.w    $D00F           ; $300486: MOV.L @(60,PC),R0 - COMM5 addr from $3004C4
        dc.w    $6002           ; $300488: MOV.W @R0,R0 - R0 = COMM5

        ; Is Slave caught up? (COMM5 >= COMM6)
        dc.w    $3012           ; $30048A: CMP/HS R1,R0 - unsigned compare
        dc.w    $8B0E           ; $30048C: BF .master_path (+14) - Slave behind

.slave_ahead:
        ; Slave ahead - signal next work, skip Master computation
        dc.w    $D20C           ; $30048E: MOV.L @(48,PC),R2 - param block from $3004C8
        dc.w    $22E2           ; $300490: MOV.L R14,@R2
        dc.w    $1271           ; $300492: MOV.L R7,@(4,R2)
        dc.w    $1282           ; $300494: MOV.L R8,@(8,R2)
        dc.w    $1253           ; $300496: MOV.L R5,@(12,R2)
        dc.w    $D20B           ; $300498: MOV.L @(44,PC),R2 - COMM7 addr from $3004CC
        dc.w    $E016           ; $30049A: MOV #$16,R0
        dc.w    $2021           ; $30049C: MOV.W R0,@R2 - COMM7 = 0x16
        dc.w    $D006           ; $30049E: MOV.L @(24,PC),R0 - COMM6 addr
        dc.w    $7101           ; $3004A0: ADD #1,R1
        dc.w    $2011           ; $3004A2: MOV.W R1,@R0 - COMM6++
        dc.w    $4F26           ; $3004A4: LDS.L @R15+,PR
        dc.w    $000B           ; $3004A6: RTS - return (Slave result in buffer)
        dc.w    $0009           ; $3004A8: NOP

.master_path:
        ; Slave behind - Master does work
        dc.w    $D005           ; $3004AA: MOV.L @(20,PC),R0 - COMM6 addr
        dc.w    $7101           ; $3004AC: ADD #1,R1
        dc.w    $2011           ; $3004AE: MOV.W R1,@R0 - COMM6++
        dc.w    $D007           ; $3004B0: MOV.L @(28,PC),R0 - orig func from $3004D0
        dc.w    $400B           ; $3004B2: JSR @R0
        dc.w    $0009           ; $3004B4: NOP
        dc.w    $4F26           ; $3004B6: LDS.L @R15+,PR
        dc.w    $000B           ; $3004B8: RTS
        dc.w    $0009           ; $3004BA: NOP
        dc.w    $0009           ; $3004BC: NOP (alignment)
        dc.w    $0009           ; $3004BE: NOP

; Literal pool for func_021_conditional_v2 (4-byte aligned at $3004C0)
        dc.l    $2000402C       ; $3004C0: COMM6 address
        dc.l    $2000402A       ; $3004C4: COMM5 address
        dc.l    $2203E000       ; $3004C8: param block address
        dc.l    $2000402E       ; $3004CC: COMM7 address
        dc.l    $02300100       ; $3004D0: func_021_optimized (func_016 inlined)

; Pad to batch_copy_handler
        dcb.b   ($500 - $4D4), $FF

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
; REMAINING EXPANSION ROM SPACE
; ============================================================================
; Layout summary:
;   $300000-$300027  Padding (40 bytes)
;   $300028-$30003D  handler_frame_sync (22 bytes)
;   $300050-$30007B  master_dispatch_hook (44 bytes)
;   $300100-$30015F  func_021_optimized (96 bytes)
;   $300200-$30024B  slave_work_wrapper (76 bytes)
;   $300280-$3002AB  slave_test_func (44 bytes)
;   $300300-$300325  func_021_original_relocated (36 bytes)
;   $300400-$300433  shadow_path_wrapper (52 bytes)
;   $300440-$30047F  func_021_conditional (64 bytes) - Phase 1
;   $300480-$3004D3  func_021_conditional_v2 (84 bytes) - Phase 2
;   $300500-$300537  batch_copy_handler (56 bytes)
;   $300538-$3FFFFF  Free space (~1MB - 1.3KB = ~1MB)
;
        dcb.b   ($100000 - $538), $FF
