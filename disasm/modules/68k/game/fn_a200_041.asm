; ============================================================================
; AI State Dispatch (Offset Table + Timer)
; ROM Range: $00BE50-$00BEC4 (116 bytes)
; ============================================================================
; Reads state index from ai_state ($A0EA), dispatches via 15-entry
; jump table. Only handler within this file (entry 0 at $BEAE)
; increments ai_timer; when timer reaches 120, advances state index
; by 4 and resets timer. Preceded by 12-word offset data table.
;
; Uses: D0, D4, D7, A0, A2, A4, A6
; RAM:
;   $A0EA: ai_state (jump table index: 0/4/8/.../56)
;   $A0EC: ai_timer (counts to $0078 = 120)
; ============================================================================

fn_a200_041:
; --- offset data table (12 words) ---
        dc.w    $0000,$0002,$0004,$0008
        dc.w    $000C,$0012,$001A,$0024
        dc.w    $0030,$003E,$004E,$0060
; --- dispatch code ---
        move.w  ($FFFFA0EA).w,d0                ; ai_state (table index)
        movea.l $00BE72(pc,d0.w),a0             ; load handler address
        jmp     (a0)                            ; dispatch
; --- jump table (15 entries) ---
        dc.l    $0088BEAE                        ; entry 0 → timer handler (below)
        dc.l    $0088BEC4                        ; entry 1 → external
        dc.l    $0088BF14                        ; entry 2 → external
        dc.l    $0088BF9E                        ; entry 3 → external
        dc.l    $0088BFDE                        ; entry 4 → external
        dc.l    $0088BF14                        ; entry 5 (= entry 2)
        dc.l    $0088BF9E                        ; entry 6 (= entry 3)
        dc.l    $0088BFDE                        ; entry 7 (= entry 4)
        dc.l    $0088BF14                        ; entry 8 (= entry 2)
        dc.l    $0088BF9E                        ; entry 9 (= entry 3)
        dc.l    $0088BFDE                        ; entry 10 (= entry 4)
        dc.l    $0088BF14                        ; entry 11 (= entry 2)
        dc.l    $0088BF9E                        ; entry 12 (= entry 3)
        dc.l    $0088BFDE                        ; entry 13 (= entry 4)
        dc.l    $0088C028                        ; entry 14 → external
; --- entry 0 handler: timer + state advance ---
        addq.w  #1,($FFFFA0EC).w                ; increment ai_timer
        cmpi.w  #$0078,($FFFFA0EC).w            ; timer reached 120?
        blt.s   .done
        addq.w  #4,($FFFFA0EA).w                ; advance ai_state
        clr.w   ($FFFFA0EC).w                   ; reset timer
.done:
        rts
