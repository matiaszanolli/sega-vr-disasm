; ============================================================================
; Ring Buffer Initialization ($TBD)
; ============================================================================
;
; PURPOSE
; -------
; Initializes the async command queue ring buffer in SDRAM.
; Must be called during boot after SDRAM is available.
;
; RING BUFFER LAYOUT (Cache-Through SDRAM)
; -----------------------------------------
; $2203F000-$2203F1FF: Ring buffer entries (64 × 8 bytes = 512 bytes)
; $2203F200: Head pointer (32-bit, 68K write index)
; $2203F204: Tail pointer (32-bit, Master SH2 read index)
;
; Each entry format: [cmd:16][param1:16][param2:16][param3:16] = 8 bytes
;
; CALLING CONVENTION
; ------------------
; Called from: adapter_init (after SH2 ready signal)
; Parameters: None
; Returns: Nothing
; Clobbers: A0
;
; CRITICAL
; --------
; This MUST be called before any async command submission.
; Both CPUs rely on head/tail pointers being zero at startup.
;
; Related: sh2_send_cmd_async, cmdint_handler, queue_processor
; ============================================================================

ring_buffer_init:
        ; Zero head and tail pointers
        ; Note: We don't need to zero the ring buffer entries themselves,
        ; only the pointers. Uninitialized entry data is harmless since
        ; entries are only read when head != tail.

        movea.l #$2203F200,a0       ; Head pointer address (cache-through SDRAM)
        clr.l   (a0)+               ; Head = 0
        clr.l   (a0)                ; Tail = 0 (A0 now points to $2203F204)

        ; Initialize FPS counter RAM variables (10 bytes at $FFFFE600-$FFFFE609)
        clr.w   $FFFFE600           ; fps_vint_tick = 0
        clr.w   $FFFFE602           ; fps_value = 0
        clr.l   $FFFFE604           ; fps_last_c964 = 0
        clr.w   $FFFFE608           ; fps_canary = 0

        rts                         ; Return to caller

; ============================================================================
; INTEGRATION NOTES
; ============================================================================
;
; To integrate into adapter_init.asm:
;
; 1. Add after SH2 ready signal detection (after COMM3 polling loop)
; 2. Before any SH2 command submissions
;
; Example integration point in adapter_init:
;
;   .wait_sh2_ready:
;       tst.w   COMM3               ; Wait for SH2 ready signal
;       beq.s   .wait_sh2_ready
;
;       ; --- ADD HERE ---
;       bsr.s   ring_buffer_init    ; Initialize async command queue
;
;       ; Continue with adapter initialization...
;
; ============================================================================
