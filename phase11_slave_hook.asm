; Phase 11: Slave SH2 Hook Implementation (v2 - Phase 16 support)
;
; This hook is injected into the Slave SH2 polling loop to intercept
; the Master→Slave signaling protocol and call expansion handler
;
; Expected injection point: Slave polling loop, typically at $06000596
;
; Protocol:
;   Master writes signal to COMM6 ($2000402C):
;     0x0012 = Frame sync (handler increments COMM4)
;     0x0016 = Vertex transform (Phase 16)
;   Slave detects ANY non-zero COMM6 and calls handler
;   Handler reads COMM6 to determine action, returns
;   Hook clears COMM6 to 0x0000 (edge-triggered acknowledgment)
;
; v2 Changes:
;   - Triggers on ANY non-zero COMM6 (not just 0x0012)
;   - Handler responsible for dispatch based on COMM6 value
;   - Handler entry at 0x02300028 (even-aligned)
;

        org     $06000596       ; Slave polling loop injection point

; ============================================================================
; SLAVE EXPANSION HOOK v2
; ============================================================================
slave_expansion_hook:
        ; Read COMM6 to check for any Master signal
        mov.l   comm6_lit, R0   ; Load COMM6 address
        mov.l   @R0, R1         ; Read COMM6 value into R1

        ; Check if COMM6 is zero (no signal)
        tst     R1, R1          ; Set T if R1 == 0
        bt      hook_exit       ; Branch if T=1 (COMM6 is zero, no signal)

        ; Non-zero signal detected - call handler
        mov.l   handler_lit, R0 ; Load handler address
        jsr     @R0             ; Call handler
        nop                     ; Delay slot

        ; Clear COMM6 to prevent re-triggering (edge-triggered)
        mov.l   comm6_lit2, R0  ; Load COMM6 address
        mov     #0, R1          ; R1 = 0
        mov.l   R1, @R0         ; Clear COMM6

hook_exit:
        rts                     ; Return from hook
        nop                     ; Delay slot

; Literal pool (must be 4-byte aligned)
        .align 4
comm6_lit:
        dc.l    $2000402C       ; COMM6 address
handler_lit:
        dc.l    $02300028       ; Handler address (even-aligned)
comm6_lit2:
        dc.l    $2000402C       ; COMM6 address (duplicate for second use)

; ============================================================================
; HOOK SIZE CALCULATION
; ============================================================================
; Instructions:
;   mov.l @(d,PC),R0   = 2 bytes each (x3 = 6 bytes)
;   mov.l @R0,R1       = 2 bytes
;   tst R1,R1          = 2 bytes
;   bt                 = 2 bytes
;   jsr @R0            = 2 bytes
;   nop                = 2 bytes each (x2 = 4 bytes)
;   mov #0,R1          = 2 bytes
;   mov.l R1,@R0       = 2 bytes
;   rts                = 2 bytes
;   nop                = 2 bytes
; Instructions: 28 bytes
; Literals: 12 bytes (3 x 4-byte literals)
; Total: 40 bytes (may have alignment padding)
;
