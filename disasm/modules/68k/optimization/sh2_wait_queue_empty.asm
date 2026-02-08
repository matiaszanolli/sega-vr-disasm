; ============================================================================
; sh2_wait_queue_empty - Block Until All Commands Processed
; Location: Optimization area $89C208+ (68K address space)
; ============================================================================
;
; PURPOSE
; -------
; Ensures all queued commands have been processed by waiting until the
; ring buffer is empty (head == tail).
;
; CRITICAL: This MUST be called at frame boundaries before advancing to
; the next frame. Without this, race conditions occur where the 68K queues
; frame N+1 commands while the SH2 is still processing frame N commands,
; leading to COMM register corruption and rendering glitches.
;
; WHEN TO CALL
; ------------
; - Option 1 (conservative): At end of V-INT handler, before RTE
; - Option 2 (aggressive): Just before frame buffer swap command
; - Option 3 (optimal): After all rendering commands queued, before
;   starting next frame's game logic
;
; For Phase 1, we use Option 1 (safest).
;
; CALLING CONVENTION
; ------------------
; Parameters: None
; Returns: Nothing
; Clobbers: D0, A0, A1
; Cost: Variable (depends on queue drain time)
;
; BLOCKING BEHAVIOR
; -----------------
; This function BLOCKS in a poll loop. This is INTENTIONAL and SAFE because:
; 1. Called at frame boundary when no other work can be done
; 2. Master SH2 is processing commands (queue draining)
; 3. Alternative is corrupted rendering (unacceptable)
;
; The blocking wait is MUCH shorter than original (sum of all command waits),
; because the Master SH2 processes commands concurrently while the 68K was
; doing game logic.
;
; Related: sh2_send_cmd_async, cmdint_handler, queue_processor
; ============================================================================

sh2_wait_queue_empty:
        movea.l #$2203F200,a0               ; A0 = head pointer address
        movea.l #$2203F204,a1               ; A1 = tail pointer address

.wait:
        move.l  (a0),d0                     ; D0 = head
        cmp.l   (a1),d0                     ; Compare head vs tail
        bne.s   .wait                       ; Loop until head == tail (queue empty)

        rts                                 ; Return when queue is empty

; ============================================================================
; INTEGRATION NOTES
; ============================================================================
;
; To integrate into V-INT handler, add this call at the frame boundary:
;
;   v_int_handler:
;       ; ... (V-INT work) ...
;       ; --- Phase 1: Ensure all commands processed ---
;       jsr     sh2_wait_queue_empty
;       rte
;
; Address of this function in 68K space: $0089C208 + offset
;
; ============================================================================
