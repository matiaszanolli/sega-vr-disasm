; ============================================================================
; sh2_send_cmd_async - Async Command Submission (Non-Blocking)
; Location: Optimization area $89C208+ (68K address space)
; ============================================================================
;
; PURPOSE
; -------
; Replaces blocking sh2_cmd_27, sh2_send_cmd, etc. Writes command to ring
; buffer and triggers CMDINT. 68K returns IMMEDIATELY (NO blocking wait).
;
; This is the CORE of Phase 1 optimization. Instead of:
;   68K: Send cmd → BUSY WAIT → Receive ack → BUSY WAIT → Continue
; We now have:
;   68K: Enqueue cmd → Trigger CMDINT → Continue IMMEDIATELY
;
; The Master SH2 handles the blocking wait in the CMDINT handler, freeing
; the 68K to do useful game logic during SH2 processing.
;
; CALLING CONVENTION (matches original sh2_cmd_27)
; --------------------------------------------------
; Parameters:
;   A0 = Data pointer (68K address, NOT converted to SH2 space)
;   D0 = Parameter 1 (16-bit)
;   D1 = Parameter 2 (16-bit)
;   D2 = Parameter 3 (16-bit)
;   D3 = Command code (8-bit, e.g. $27)
;
; Returns: Nothing
; Clobbers: D4, D5, A1
; Cost: ~40 cycles (vs ~2000 cycles for blocking sh2_cmd_27!)
;
; RING BUFFER LAYOUT (SDRAM $2203F000)
; -------------------------------------
; $2203F000-$2203F1FF: 64 entries × 8 bytes = 512 bytes
;   Each entry: [cmd:16][param1:16][param2:16][param3:16]
; $2203F200: Head pointer (32-bit, 68K write index, 0-63)
; $2203F204: Tail pointer (32-bit, SH2 read index, 0-63)
;
; QUEUE FULL HANDLING
; -------------------
; With 64 entries and max 35 commands/frame, overflow should NEVER happen.
; If it does, we fall back to the original blocking path (safe but slow).
;
; Related: cmdint_handler, queue_processor, sh2_cmd_27
; ============================================================================

; --- 32X System Register Definitions ---
MARS_SYS_INTMASK    equ $A15102     ; Interrupt Control (INTS, INTM)

sh2_send_cmd_async:
        ; Read head pointer
        movea.l #$2203F200,a1               ; A1 = head pointer address (cache-through)
        move.l  (a1),d4                     ; D4 = head index (0-63)

        ; Check if queue full: (head + 1) & 63 == tail?
        move.l  d4,d5                       ; D5 = head
        addq.l  #1,d5                       ; D5 = head + 1
        andi.l  #$3F,d5                     ; D5 = (head + 1) & 63
        movea.l #$2203F204,a1               ; A1 = tail pointer address
        cmp.l   (a1),d5                     ; Compare with tail
        beq.w   .queue_full                 ; If equal, queue is full!

        ; Calculate entry address: $2203F000 + (head * 8)
        move.l  d4,d5                       ; D5 = head
        lsl.l   #3,d5                       ; D5 = head * 8
        movea.l #$2203F000,a1               ; A1 = ring buffer base
        adda.l  d5,a1                       ; A1 = entry address

        ; Write entry: [cmd:16][p1:16][p2:16][p3:16]
        move.b  d3,(a1)+                    ; Command code (low byte)
        clr.b   (a1)+                       ; High byte = 0
        move.w  d0,(a1)+                    ; Param 1
        move.w  d1,(a1)+                    ; Param 2
        move.w  d2,(a1)+                    ; Param 3

        ; Advance head pointer: (head + 1) & 63
        addq.l  #1,d4                       ; head++
        andi.l  #$3F,d4                     ; Wrap at 64
        movea.l #$2203F200,a1
        move.l  d4,(a1)                     ; Store updated head

        ; Trigger CMDINT (fires interrupt on Master SH2)
        move.w  MARS_SYS_INTMASK,d5         ; Read interrupt mask
        or.w    #$0800,d5                   ; Set INTM bit (bit 11)
        move.w  d5,MARS_SYS_INTMASK         ; Write back (triggers CMDINT)

        rts                                 ; Return immediately (NO WAIT!)

.queue_full:
        ; Queue overflow! This should NEVER happen if sized correctly.
        ; For Phase 1 safety, fall back to original blocking function.
        ; This ensures correctness even if something goes wrong.
        jmp     sh2_cmd_27                  ; Use original blocking path

; ============================================================================
; INTEGRATION NOTES
; ============================================================================
;
; To use this function, replace calls to sh2_cmd_27 with:
;
;   ; Before (blocking):
;   bsr     sh2_cmd_27
;
;   ; After (async):
;   jsr     sh2_send_cmd_async
;
; IMPORTANT: Must use JSR (absolute) because this function is in a different
; ROM section. BSR.W has ±32KB range and won't reach from most call sites.
;
; Address of this function in 68K space: $0089C208 (first optimization function)
;
; ============================================================================
