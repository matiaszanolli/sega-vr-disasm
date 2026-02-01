; ============================================================================
; SH2 Communication Functions ($00E316-$00E3B2)
; ============================================================================
;
; PURPOSE
; -------
; These functions handle communication between the 68000 and SH2 processors
; via the 32X communication registers (COMM0-COMM7).
;
; ARCHITECTURAL BOTTLENECK (CRITICAL)
; -----------------------------------
; These functions implement BLOCKING synchronous communication:
;
;   68K: Send command → BUSY WAIT → Receive response → BUSY WAIT → Continue
;
; This serializes all work through single-threaded blocking waits, causing:
; - ~20 FPS frame rate ceiling
; - 68K at 100% utilization (mostly waiting in blocking loops)
; - Slave SH2 at ~80% utilization but 66% of cycles wasted in idle delay loop
; - Master SH2 nearly idle (60 cycles/frame when expansion hooks disabled)
;
; The root cause is the TST.B/BNE.S loops that spin until COMM registers
; change state. The 68K cannot do other work while waiting.
;
; OPTIMIZATION TARGET
; -------------------
; To improve frame rate, these blocking waits need to be replaced with:
; - Interrupt-driven communication (complex, requires timing changes)
; - Asynchronous command queuing (implemented in expansion ROM at $300000+)
; - Splitting work between Master and Slave SH2
;
; See: analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md
;
; COMM REGISTER MAP ($A15120-$A1512F) - Per 32X Hardware Manual
; -------------------------------------------------------------
; The 32X has 8 COMM registers at 2-byte (word) intervals:
;
; | 68K Address | SH2 Address  | Name  | Width  | VRD Game Usage           |
; |-------------|--------------|-------|--------|--------------------------|
; | $A15120     | $20004020    | COMM0 | Word   | Command flag (hi) + code (lo) |
; | $A15122     | $20004022    | COMM1 | Word   | Status/reserved          |
; | $A15124     | $20004024    | COMM2 | Word   | Parameter word           |
; | $A15126     | $20004026    | COMM3 | Word   | Parameter word           |
; | $A15128     | $20004028    | COMM4 | Word   | Data pointer (hi word)   |
; | $A1512A     | $2000402A    | COMM5 | Word   | Data pointer (lo word)   |
; | $A1512C     | $2000402C    | COMM6 | Word   | Handshake flag           |
; | $A1512E     | $2000402E    | COMM7 | Word   | Master→Slave signal      |
;
; BYTE ACCESS: The game uses byte access (TST.B, MOVE.B) within words:
;   $A15120 = COMM0 high byte (command flag)
;   $A15121 = COMM0 low byte (command code)
;   $A1512C = COMM6 high byte (handshake test)
;
; LONGWORD ACCESS: COMM4/COMM5 are used together as a 32-bit pointer:
;   MOVE.L a0,$A15128 writes to both COMM4 and COMM5
;
; COMMAND CODES
; -------------
; $21 - Unknown
; $22 - Direct command send (sh2_send_cmd)
; $25 - Wait and send (sh2_send_cmd_wait)
; $27 - Command $27 (21 calls/frame)
; $2F - Extended command
;
; REGISTER CONVENTIONS
; --------------------
; A0 - Data pointer (converted to SH2 address space)
; A1 - Secondary data pointer
; D0, D1 - Parameters
;
; Dependencies: 32X adapter initialization
; Related: 68K_SH2_COMMUNICATION.md, ARCHITECTURAL_BOTTLENECK_ANALYSIS.md
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; 32X Communication Registers (per Hardware Manual - 2-byte spacing)
; NOTE: Some names below use byte offsets for code clarity, but map to standard COMM registers
COMM0_HI        equ     $A15120     ; COMM0 high byte - Command flag (68K→SH2)
COMM0_LO        equ     $A15121     ; COMM0 low byte - Command code
COMM1           equ     $A15122     ; COMM1 word - Status/reserved
COMM2           equ     $A15124     ; COMM2 word - Parameter
COMM3           equ     $A15126     ; COMM3 word - Parameter
COMM4           equ     $A15128     ; COMM4 word - Data pointer (hi), also longword base
COMM5           equ     $A1512A     ; COMM5 word - Data pointer (lo)
COMM6           equ     $A1512C     ; COMM6 word - Handshake flag
COMM7           equ     $A1512E     ; COMM7 word - Master→Slave signal (expansion ROM)

; SH2 Address Space Offset
; 68K addresses are converted to SH2 space by adding $02000000
SH2_ADDR_OFFSET equ     $02000000

; Command codes
CMD_DIRECT      equ     $22         ; Direct command send
CMD_WAIT_SEND   equ     $25         ; Wait and send command
CMD_27          equ     $27         ; Frequently used command

; Handshake values
HANDSHAKE_READY equ     $0101       ; Ready for next phase

        org     $00E316

; ============================================================================
; sh2_send_cmd_wait ($00E316) - Wait for Ready, Send Command
; Purpose: Waits for SH2 to be ready, then sends a command with data pointer
; Called by: Various graphics/3D functions
; Parameters:
;   A0 = 68K data pointer (converted to SH2 address space)
; Returns: Nothing (A0 preserved in A1)
;
; BLOCKING: Contains busy-wait loop at $00E316-$00E31C
; This is a PRIMARY BOTTLENECK FUNCTION
; ============================================================================

sh2_send_cmd_wait:
; --- BLOCKING WAIT LOOP ---
; Spins until COMM0 high byte == 0, preventing any other 68K work
.wait_ready:
        tst.b   COMM0_HI                        ; $00E316: $4A39 $00A1 $5120 - Test command flag
        bne.s   .wait_ready                     ; $00E31C: $66F8             - Loop until ready

; Convert 68K address to SH2 address space
        adda.l  #SH2_ADDR_OFFSET,a0             ; $00E31E: $D1FC $0200 $0000 - A0 += $02000000
        move.l  a0,COMM4                        ; $00E324: $23C8 $00A1 $5128 - Write data pointer (COMM4+COMM5)
        move.w  #HANDSHAKE_READY,COMM6          ; $00E32A: $33FC $0101 $00A1 $512C - Signal ready
        move.b  #CMD_WAIT_SEND,COMM0_LO         ; $00E332: $13FC $0025 $00A1 $5121 - Command $25
        move.b  #$01,COMM0_HI                   ; $00E33A: $13FC $0001 $00A1 $5120 - Trigger command
        ; Falls through to sh2_wait_response

; ============================================================================
; sh2_wait_response ($00E342) - Wait for SH2 Response
; Purpose: Blocks until SH2 clears handshake, then sets up next transfer
; Called by: sh2_send_cmd_wait (fall-through), other command functions
; Parameters:
;   A1 = Secondary data pointer
; Returns: Nothing
;
; BLOCKING: Contains busy-wait loop at $00E342-$00E348
; This is a PRIMARY BOTTLENECK FUNCTION
; ============================================================================

sh2_wait_response:
; --- BLOCKING WAIT LOOP ---
; Spins until COMM6 high byte == 0, preventing any other 68K work
.wait_ack:
        tst.b   COMM6                           ; $00E342: $4A39 $00A1 $512C - Test handshake
        bne.s   .wait_ack                       ; $00E348: $66F8             - Loop until cleared

; Set up secondary pointer for next phase
        move.l  a1,COMM4                        ; $00E34A: $23C9 $00A1 $5128 - Write secondary ptr (COMM4+COMM5)
        move.w  #HANDSHAKE_READY,COMM6          ; $00E350: $33FC $0101 $00A1 $512C - Signal ready
        rts                                     ; $00E358: $4E75             - Return

; ============================================================================
; sh2_send_cmd ($00E35A) - Direct Command Send
; Purpose: Sends a command directly with multiple parameters
; Called by: text_render, various graphics functions
; Parameters:
;   A0 = Data pointer
;   A1 = Secondary pointer
;   D0 = Parameter 1 (width/count)
;   D1 = Parameter 2 (height/type)
; Returns: Nothing
;
; BLOCKING: Contains THREE busy-wait loops
; This function has the MOST BLOCKING WAITS of all comm functions
; ============================================================================

sh2_send_cmd:
; --- BLOCKING WAIT 1 ---
.wait_ready:
        tst.b   COMM0_HI                        ; $00E35A: $4A39 $00A1 $5120 - Test command flag
        bne.s   .wait_ready                     ; $00E360: $66F8             - Loop until ready

; Send secondary pointer
        move.l  a1,COMM4                        ; $00E362: $23C9 $00A1 $5128 - Write A1 (COMM4+COMM5)
        move.w  #HANDSHAKE_READY,COMM6          ; $00E368: $33FC $0101 $00A1 $512C - Signal ready
        move.b  #CMD_DIRECT,COMM0_LO            ; $00E370: $13FC $0022 $00A1 $5121 - Command $22
        move.b  #$01,COMM0_HI                   ; $00E378: $13FC $0001 $00A1 $5120 - Trigger command

; --- BLOCKING WAIT 2 ---
.wait_phase1:
        tst.b   COMM6                           ; $00E380: $4A39 $00A1 $512C - Test handshake
        bne.s   .wait_phase1                    ; $00E386: $66F8             - Loop until cleared

; Send parameters D0/D1
        move.w  d0,COMM4                        ; $00E388: $33C0 $00A1 $5128 - Write D0
        move.w  d1,COMM5                        ; $00E38E: $33C1 $00A1 $512A - Write D1
        move.w  #HANDSHAKE_READY,COMM6          ; $00E394: $33FC $0101 $00A1 $512C - Signal ready

; --- BLOCKING WAIT 3 ---
.wait_phase2:
        tst.b   COMM6                           ; $00E39C: $4A39 $00A1 $512C - Test handshake
        bne.s   .wait_phase2                    ; $00E3A2: $66F8             - Loop until cleared

; Send data pointer
        move.l  a0,COMM4                        ; $00E3A4: $23C8 $00A1 $5128 - Write A0 (COMM4+COMM5)
        move.w  #HANDSHAKE_READY,COMM6          ; $00E3AA: $33FC $0101 $00A1 $512C - Signal ready
        rts                                     ; $00E3B2: $4E75             - Return

; ============================================================================
; SUMMARY OF BLOCKING BEHAVIOR
; ============================================================================
;
; Function          | Wait Loops | Called/Frame | Blocked Cycles (est)
; ------------------+------------+--------------+----------------------
; sh2_send_cmd_wait |     1      |     14       | ~1000 per call
; sh2_wait_response |     1      |     14+      | ~1000 per call
; sh2_send_cmd      |     3      |     10+      | ~3000 per call
;
; Total estimated blocked cycles per frame: 50,000+
; At 7.67 MHz, this is ~6.5ms of pure waiting per frame
; Target frame time for 60 FPS: 16.67ms
; Blocking alone consumes ~40% of available frame time
;
; ============================================================================
; OPTIMIZATION STRATEGY (Implemented in expansion ROM)
; ============================================================================
;
; Instead of blocking waits:
; 1. Queue commands to a shared buffer
; 2. Signal Slave SH2 via COMM7 (non-blocking write)
; 3. Master SH2 continues with other work
; 4. Slave processes queued commands in parallel
; 5. Synchronize only at frame boundary
;
; See: disasm/sections/expansion_300000.asm for implementation
;
; ============================================================================
