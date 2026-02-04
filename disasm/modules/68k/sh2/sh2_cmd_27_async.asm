; ============================================================================
; sh2_cmd_27_async.asm - Async Queue-Based cmd $27 Submission
; ============================================================================
;
; PURPOSE
; -------
; Replaces the synchronous 3-phase handshake of sh2_cmd_27 with a single
; queue enqueue + doorbell. Eliminates ~400 cycles of COMM polling per call.
;
; With 21 calls per frame, this saves ~8,400 SH2 cycles and ~8,400 68K cycles
; per frame (~0.7ms total). Not a game-changer, but proves the batching pattern.
;
; USAGE
; -----
; Replace calls to sh2_cmd_27 ($00E3B4) with sh2_cmd_27_enqueue.
; Parameters are identical:
;   A0 = data pointer (68K address, NOT converted to SH2 space)
;   D0.W = width (bytes per row)
;   D1.W = height (number of rows)
;   D2.W = add value (constant to add to each byte)
;
; QUEUE LAYOUT ($FFFB00, 68K Work RAM)
; ------------------------------------
;   +$00: write_idx (word, 0-31)
;   +$02: read_idx  (word, 0-31)
;   +$04: entry[0]  (10 bytes)
;   +$0E: entry[1]  ...
;   ...
;   +$144: entry[31]
;
; Entry format (10 bytes):
;   +0: data_ptr   (long)  - 68K address, SH2 will add $02000000
;   +4: width      (word)
;   +6: height     (word)
;   +8: add_value  (word)
;
; PROTOCOL
; --------
; 1. Write entry to queue[write_idx]
; 2. Increment write_idx (mod 32)
; 3. If queue was empty: ring doorbell (COMM7 = $0027)
; 4. Return immediately (no wait!)
;
; SH2 side (Slave via slave_work_wrapper):
; - Slave polls COMM7 for work signals
; - COMM7 == $27 triggers cmd27_queue_drain
; - Slave clears COMM7 when queue is empty
;
; INITIALIZATION
; --------------
; Call sh2_cmd_27_queue_init once at startup to zero the indices.
;
; ============================================================================

; Queue location in 68K Work RAM
CMD27_QUEUE             equ     $FFFB00
CMD27_QUEUE_WRITE_IDX   equ     $FFFB00
CMD27_QUEUE_READ_IDX    equ     $FFFB02
CMD27_QUEUE_ENTRIES     equ     $FFFB04

; Entry size
CMD27_ENTRY_SIZE        equ     10

; Queue capacity (power of 2 for fast modulo)
CMD27_QUEUE_MASK        equ     31              ; 32 entries, indices 0-31

; COMM7 doorbell - use $27 to match command code
; This integrates with slave_work_wrapper which polls COMM7
COMM7                   equ     $A1512E
DOORBELL_SIGNAL         equ     $0027           ; Matches cmd $27 for queue processing

; ============================================================================
; sh2_cmd_27_queue_init - Initialize queue indices to zero
; ============================================================================
; Call once at startup or when resetting the async system.
; Clobbers: D0
; ============================================================================

sh2_cmd_27_queue_init:
        clr.l   CMD27_QUEUE             ; Clear both write_idx and read_idx
        rts

; ============================================================================
; sh2_cmd_27_enqueue - Async enqueue (replaces sh2_cmd_27)
; ============================================================================
; Parameters:
;   A0 = data pointer (68K address)
;   D0.W = width
;   D1.W = height
;   D2.W = add value
;
; Clobbers: D3, D4, D5, A1, A2
; ============================================================================

sh2_cmd_27_enqueue:
        ; Load queue base and indices
        lea     CMD27_QUEUE,a1          ; A1 = queue base
        move.w  (a1),d3                 ; D3 = write_idx
        move.w  2(a1),d4                ; D4 = read_idx (for empty check)

        ; Calculate entry address: base + 4 + (write_idx * 10)
        ; 10 = 8 + 2, so: idx*10 = idx*8 + idx*2 = (idx<<3) + (idx<<1)
        move.w  d3,d5                   ; D5 = write_idx
        lsl.w   #3,d5                   ; D5 = write_idx * 8
        move.w  d3,a2                   ; A2 = write_idx (temp)
        add.w   a2,a2                   ; A2 = write_idx * 2
        add.w   a2,d5                   ; D5 = write_idx * 10
        lea     CMD27_QUEUE_ENTRIES,a2  ; A2 = &entries[0]
        adda.w  d5,a2                   ; A2 = &entries[write_idx]

        ; Write entry (10 bytes)
        ; NOTE: Store 68K address directly - SH2 handler adds $02000000
        move.l  a0,(a2)+                ; +0: data_ptr (long)
        move.w  d0,(a2)+                ; +4: width (word)
        move.w  d1,(a2)+                ; +6: height (word)
        move.w  d2,(a2)                 ; +8: add_value (word)

        ; Increment write_idx (mod 32)
        addq.w  #1,d3                   ; write_idx++
        andi.w  #CMD27_QUEUE_MASK,d3    ; write_idx &= 31
        move.w  d3,(a1)                 ; Store new write_idx

        ; Ring doorbell if queue was empty (write_idx was == read_idx)
        ; Note: D3 now holds NEW write_idx, D4 holds read_idx
        ; Queue was empty if OLD write_idx == read_idx
        ; OLD write_idx = (D3 - 1) & 31, but simpler: check if D4 == old_write
        ; Actually, we saved D4 = read_idx before incrementing D3.
        ; Queue was empty if: (d3 - 1) & 31 == d4
        ; Simpler approach: save was_empty flag before write_idx++
        ; Let me restructure...

        ; Actually, let's check: queue WAS empty if read_idx == old_write_idx
        ; old_write_idx = (new_write_idx - 1) & 31
        move.w  d3,d5                   ; D5 = new write_idx
        subq.w  #1,d5                   ; D5 = new write_idx - 1
        andi.w  #CMD27_QUEUE_MASK,d5    ; D5 = old write_idx (wrapped)
        cmp.w   d4,d5                   ; old_write_idx == read_idx?
        bne.s   .done                   ; No: queue wasn't empty, skip doorbell

        ; Queue was empty, ring the doorbell
        move.w  #DOORBELL_SIGNAL,COMM7  ; COMM7 = $0027

.done:
        rts

; ============================================================================
; sh2_cmd_27_flush - Wait for queue to drain (optional sync point)
; ============================================================================
; Call at frame boundary to ensure all enqueued commands complete.
; This is a blocking wait - use sparingly.
;
; Clobbers: nothing
; ============================================================================

sh2_cmd_27_flush:
.wait:
        tst.w   COMM7                   ; Is COMM7 == 0?
        bne.s   .wait                   ; No: SH2 still processing, wait
        rts

; ============================================================================
; INTEGRATION NOTES
; ============================================================================
;
; 1. INITIALIZATION
;    Call sh2_cmd_27_queue_init once during game startup, after 32X init.
;
; 2. REPLACEMENT
;    Find all JSR/BSR to $00E3B4 (sh2_cmd_27) and redirect to sh2_cmd_27_enqueue.
;    Or: Patch sh2_cmd_27 itself to jump to enqueue (trampoline).
;
; 3. FRAME SYNC (OPTIONAL)
;    If visual glitches occur, call sh2_cmd_27_flush at frame end:
;      - After all sh2_cmd_27 calls
;      - Before buffer flip / V-blank
;
; 4. SH2 SIDE
;    Slave's slave_work_wrapper handles COMM7 = $27 to call cmd27_queue_drain.
;    See: disasm/sh2/expansion/cmd27_queue_drain.asm
;    See: disasm/sections/expansion_300000.asm (slave_work_wrapper)
;
; 5. FALLBACK
;    Original sh2_cmd_27 at $00E3B4 remains unchanged.
;    Can switch back by redirecting calls if issues arise.
;
; ============================================================================
; PERFORMANCE COMPARISON
; ============================================================================
;
; Original sh2_cmd_27 (per call):
;   68K: ~60 cycles setup + ~400 cycles polling = ~460 cycles
;   SH2: ~400 cycles polling + ~4000 cycles processing = ~4400 cycles
;
; Async sh2_cmd_27_enqueue (per call):
;   68K: ~80 cycles enqueue + 0 polling = ~80 cycles
;   SH2: 0 polling (batched) + ~4000 cycles processing = ~4000 cycles
;
; Per-call savings: ~380 cycles 68K, ~400 cycles SH2
; 21 calls/frame: ~8000 cycles 68K, ~8400 cycles SH2
; Time saved: ~1.0ms 68K + ~0.37ms SH2 = ~1.4ms per frame
;
; ============================================================================
