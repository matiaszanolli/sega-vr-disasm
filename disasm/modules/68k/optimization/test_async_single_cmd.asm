; ============================================================================
; test_async_single_cmd - Test Harness for Single Async Command
; Location: Optimization area $89C208+ (68K address space)
; ============================================================================
;
; PURPOSE
; -------
; Phase 1 Step 6: Test harness to verify async command queue works end-to-end.
; Sends a single test command (cmd $27) via the async queue and verifies
; correct operation.
;
; This test function is called once per frame to verify:
; 1. Commands can be enqueued via sh2_send_cmd_async
; 2. CMDINT fires on Master SH2
; 3. Queue processor dequeues and forwards to Slave
; 4. Slave processes command correctly
; 5. Rendering remains correct
;
; INTEGRATION
; -----------
; Called from V-INT handler during Phase 1 testing. Will be removed in Phase 2
; when real call sites are converted to async.
;
; PARAMETERS
; ----------
; Uses test parameters for command $27 (polygon/texture command):
;   A0 = $04000000 (test data pointer)
;   D0 = $0010 (test param1)
;   D1 = $0020 (test param2)
;   D2 = $0030 (test param3)
;   D3 = $27 (command code)
;
; Returns: Nothing
; Clobbers: D0-D5, A0, A1 (via sh2_send_cmd_async)
;
; Related: sh2_send_cmd_async, cmdint_handler, queue_processor
; ============================================================================

test_async_single_cmd:
        ; Set up test parameters for command $27
        movea.l #$04000000,a0               ; Test data pointer
        move.w  #$0010,d0                   ; Test param1
        move.w  #$0020,d1                   ; Test param2
        move.w  #$0030,d2                   ; Test param3
        move.b  #$27,d3                     ; Command $27

        ; Call async submission function (absolute JSR required)
        jsr     sh2_send_cmd_async          ; Enqueue command and return

        rts                                 ; Test complete

; ============================================================================
; VERIFICATION
; ============================================================================
;
; To verify this works:
; 1. Build ROM and boot test (should boot normally)
; 2. Play game for 300 frames
; 3. Check COMM5 counter increments (proof commands processed)
; 4. Visual inspection - rendering should be correct
;
; Expected behavior:
; - One test command queued per frame
; - CMDINT fires once per frame
; - Queue drains successfully (head == tail at frame boundary)
; - No rendering glitches
;
; If test fails:
; - Check CMDINT handler debug counter
; - Check ring buffer head/tail pointers
; - Check for queue overflow (fallback to blocking path)
;
; ============================================================================
