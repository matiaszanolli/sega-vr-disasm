; ============================================================================
; Input State Dispatcher (4-Entry Jump Table + Init)
; ROM Range: $00456C-$0045CE (98 bytes)
; ============================================================================
; Category: game
; Purpose: Dispatches via 4-entry longword jump table indexed by
;   input_state ($C819) × 4. State 0: initializes sprite block at
;   $FF69E0 (type=7, $1AE, pattern $222EDB1A). Sets position $0402C000
;   (or $04038000 if A0=$9000). Increments state, advances $C07C by 4.
;
; Uses: D0, A0, A1, A2, A6
; RAM:
;   $C07C: state_dispatch_idx (word)
;   $C819: input_state (byte)
;   $C816: player_flags (byte)
; ============================================================================

input_state_disp:
        moveq   #$00,D0                         ; $00456C  clear D0
        move.b  ($FFFFC819).w,D0                ; $00456E  D0 = input_state
        lsl.w   #2,D0                           ; $004572  D0 × 4
        movea.l $00457A(PC,D0.W),A1             ; $004574  A1 = handler address
        jmp     (A1)                            ; $004578  dispatch
; --- jump table (4 longword entries) ---
        dc.l    $00884636                       ; $00457A  [00] → $004636 (past fn)
        dc.l    $0088458A                       ; $00457E  [04] → inline handler
        dc.l    $008845CE                       ; $004582  [08] → $0045CE (past fn)
        dc.l    $00884630                       ; $004586  [0C] → $004630 (past fn)
; --- state 0 handler ---
        lea     $00FF69E0,A2                    ; $00458A  A2 → sprite block
        move.b  #$07,(A2)                       ; $004590  type = 7
        move.w  #$01AE,$0002(A2)                ; $004594  param = $1AE
        move.l  #$222EDB1A,$0008(A2)            ; $00459A  tile pattern
        move.b  #$00,($FFFFC816).w              ; $0045A2  player_flags = 0
        move.l  #$0402C000,$0004(A2)            ; $0045A8  position (default)
        cmpa.w  #$9000,A0                       ; $0045B0  A0 == $9000?
        beq.s   .advance                        ; $0045B4  yes → skip
        move.b  #$01,($FFFFC816).w              ; $0045B6  player_flags = 1
        move.l  #$04038000,$0004(A2)            ; $0045BC  position (alternate)
.advance:
        addq.b  #1,($FFFFC819).w                ; $0045C4  input_state++
        addq.w  #4,($FFFFC07C).w                ; $0045C8  advance dispatch
        rts                                     ; $0045CC
