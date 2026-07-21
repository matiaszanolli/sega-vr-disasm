; ============================================================================
; Ring Buffer Initialization ($TBD)
; ============================================================================
;
; PURPOSE
; -------
; ACTIVE LEGACY NO-OP / INVALID DESIGN. adapter_init still calls this routine
; for byte identity, but the 68000 cannot address SH2 SDRAM and $2203Fxxx is
; a cartridge-ROM alias. These CLR writes do not initialize a shared queue.
;
; HISTORICAL INVALID RING BUFFER LAYOUT
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
; Do not mistake the existing boot call for working initialization. A future
; queue needs DREQ/COMM-based producer transport; changing the literal to
; $2603F200 would still not make it writable by the 68000.
;
; Related: sh2_send_cmd_async, cmdint_handler, queue_processor
; ============================================================================

ring_buffer_init:
        ; Zero head and tail pointers
        ; Note: We don't need to zero the ring buffer entries themselves,
        ; only the pointers. Uninitialized entry data is harmless since
        ; entries are only read when head != tail.

        movea.l #$2203F200,a0       ; INVALID ROM alias; writes below are no-ops
        clr.l   (a0)+               ; Head = 0
        clr.l   (a0)                ; Tail = 0 (A0 now points to $2203F204)

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
