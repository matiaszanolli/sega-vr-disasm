; ============================================================================
; State Dispatcher (5-Entry Jump Table + 6 Subroutines)
; ROM Range: $00C30A-$00C368 (94 bytes)
; ============================================================================
; Category: game
; Purpose: Dispatches via 5-entry longword jump table indexed by
;   state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2,
;   init ($0021CA), saves $C86C, forces $FF00 → $C86C. If $C81C
;   bit 0 clear → calls sfx_queue_process ($88BE). Restores $C86C,
;   calls sprite_input_check, increments scene_counter, advances
;   state by 4, writes $10 to SH2 COMM.
;
; Uses: D0, D1, D2, A0, A1, A6
; RAM:
;   $C81C: scene_flags (byte, bit 0)
;   $C86C: controller_state (word, saved/restored)
;   $C87E: state_dispatch_idx (word)
;   $C886: scene_counter (byte)
; Calls:
;   $0021CA: init handler
;   $0028C2: VDPSyncSH2
;   $0058C8: sprite_input_check
;   $0088BE: sfx_queue_process
; ============================================================================

state_disp_00c30a:
        move.w  ($FFFFC87E).w,D0               ; $00C30A  D0 = state_dispatch_idx
        movea.l $00C314(PC,D0.W),A1             ; $00C30E  A1 = handler address
        jmp     (A1)                            ; $00C312  dispatch
; --- jump table (5 longword entries) ---
        dc.l    $0088C328                       ; $00C314  [00] → state 0 handler
        dc.l    $0088C368                       ; $00C318  [04] → $00C368 (past fn)
        dc.l    $0088C390                       ; $00C31C  [08] → $00C390 (past fn)
        dc.l    $0088C3FC                       ; $00C320  [0C] → $00C3FC (past fn)
        dc.l    $0088C45E                       ; $00C324  [10] → $00C45E (past fn)
; --- state 0 handler ---
        jsr     $008828C2                       ; $00C328  VDPSyncSH2
        jsr     $008821CA                       ; $00C32E  init handler
        move.w  ($FFFFC86C).w,-(A7)             ; $00C334  save controller_state
        move.w  #$FF00,($FFFFC86C).w            ; $00C338  force $FF00
        btst    #0,($FFFFC81C).w                ; $00C33E  scene bit 0 set?
        bne.s   .skip_sfx                       ; $00C344  yes → skip
        jsr     $008888BE                       ; $00C346  sfx_queue_process
.skip_sfx:
        move.w  (A7)+,($FFFFC86C).w             ; $00C34C  restore controller_state
        jsr     $008858C8                       ; $00C350  sprite_input_check
        addq.b  #1,($FFFFC886).w                ; $00C356  scene_counter++
        addq.w  #4,($FFFFC87E).w                ; $00C35A  advance state
        move.w  #$0010,$00FF0008                ; $00C35E  SH2 COMM = $10
        rts                                     ; $00C366

