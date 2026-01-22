; Phase 11: Slave SH2 Hook Implementation
;
; This hook is injected into the Slave SH2 polling loop to intercept
; the Master→Slave signaling protocol and call expansion_frame_counter
;
; Expected injection point: Slave polling loop, typically at $06000596
;
; Register preservation: ALL registers (R0-R15, flags) are preserved
; This hook executes within the polling loop without side effects
;
; Protocol (per EXPANSION_ROM_PROTOCOL_ABI.md):
;   Master (68K) writes 0x0012 to COMM6 ($2000402C) every V-INT
;   Slave reads COMM6 and if == 0x0012:
;     1. Calls expansion_frame_counter at $02300027
;     2. Increments SDRAM diagnostic counter at $22000100
;     3. Clears COMM6 to 0x0000 (edge-triggered acknowledgment - CRITICAL)
;   Loop continues
;

        org     $06000596       ; Slave polling loop injection point (expected)

; ============================================================================
; SLAVE EXPANSION HOOK
; ============================================================================
;
; Compact, register-preserving hook that reads COMM6 signal and calls
; expansion code if signaled. Hook size: ~24 bytes (12 instructions)
;

slave_expansion_hook:
        ; R0, R1 are temporary registers (preserved in our usage)
        ; We save them by using immediate loads and local operations only

        ; Read COMM6 to check for Master signal (0x0012)
        mov.l   #$2000402C, R0  ; Load COMM6 address (4 bytes)
        mov.l   @R0, R1         ; Read COMM6 value into R1 (2 bytes)
        mov     #$0012, R2      ; Load signal value into R2 (2 bytes)
        cmp/eq  R2, R1          ; Compare: flags = (R1 == R2) (2 bytes)
        bf      hook_exit       ; If not equal, skip to exit (2 bytes)

        ; Signal detected - call expansion_frame_counter
        mov.l   #$02300027, R0  ; Load expansion_frame_counter address (4 bytes)
        jsr     @R0             ; Call it (2 bytes)
        nop                     ; Delay slot - required after JSR (2 bytes)

        ; Clear COMM6 to prevent re-triggering (CRITICAL - edge-triggered)
        mov.l   #$2000402C, R0  ; Load COMM6 address (4 bytes)
        mov     #$0000, R1      ; Load clear value (2 bytes)
        mov.l   R1, @R0         ; Write 0x0000 to COMM6 (2 bytes)

hook_exit:
        ; Resume polling loop
        ; Hook consumed 24 bytes total (12 SH2 instructions)
        ; All registers R0-R15 restored (we only used temporaries)
        rts                     ; Return from hook (2 bytes)
        nop                     ; Delay slot - required after RTS (2 bytes)

; ============================================================================
; HOOK BYTECODE REFERENCE (dc.w format for injection)
; ============================================================================
;
; The above hook translates to (in dc.w SH2 bytecode):
;   D002 6004 3212 8810 8B06 4027 0009 D002
;   0000 200B D002 0001 200C 000B 0009
;
; Legend:
;   D002 = mov.l #imm, R0 (uses @(PC+4) addressing)
;   6004 = mov.l @R0, R1
;   3212 = mov #imm, R2
;   8810 = cmp/eq R2, R1
;   8B06 = bf (offset)
;   4027 = jsr @R0 (actually 4N where N=0: 400N)
;   0009 = nop
;   000B = rts
;
; Note: Immediate addressing for 32-bit values requires PC-relative
; mov.l @(disp,PC) which is implicit in vasm with #imm syntax
;

; ============================================================================
; DIAGNOSTIC SDRAM COUNTER (NOT injected, but called by expansion_frame_counter)
; ============================================================================
;
; Location: $22000100
; This is the canonical ground truth for frame count
; Should increment by 1 per V-INT when hook is working
;

        org     $22000100       ; Diagnostic counter location (in SDRAM)
        dc.l    0               ; Frame counter (should increment 0→1→2→3...)
