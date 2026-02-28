; ============================================================================
; Object State Dispatcher (11-Entry Jump Table)
; ROM Range: $0031A6-$003204 (94 bytes)
; ============================================================================
; Category: game
; Purpose: Dispatches via 11-entry longword jump table indexed by
;   dispatch_idx ($C305) as byte. Jump table covers states $00-$28.
;   States $08-$10 share handler at $31DE; states $18-$20 share $322A.
;   State $08 handler (inline): if timer ($C04E) nonzero, loads
;   object_ptr ($C258), sets object type=2, VDP flags $6950=3 and
;   $6940=1, advances state by 4.
;
; Uses: D0, D1, D4, A0, A1, A2, A6
; RAM:
;   $C04E: timer (word)
;   $C258: object_ptr (longword)
;   $C305: dispatch_idx (byte, ×4 for table index)
; ============================================================================

object_state_disp_0031a6:
        moveq   #$00,D0                         ; $0031A6  clear D0
        move.b  ($FFFFC305).w,D0                ; $0031A8  D0 = dispatch_idx
        movea.l $0031B2(PC,D0.W),A1             ; $0031AC  A1 = handler address
        jmp     (A1)                            ; $0031B0  dispatch
; --- jump table (11 longword entries) ---
        dc.l    $00883378                       ; $0031B2  [00] → $003378 (past fn)
        dc.l    $00883272                       ; $0031B6  [04] → $003272 (past fn)
        dc.l    $008831DE                       ; $0031BA  [08] → state 8 handler
        dc.l    $008831DE                       ; $0031BE  [0C] → state 8 handler
        dc.l    $008831DE                       ; $0031C2  [10] → state 8 handler
        dc.l    $008831DE                       ; $0031C6  [14] → state 8 handler
        dc.l    $0088322A                       ; $0031CA  [18] → $00322A (past fn)
        dc.l    $0088322A                       ; $0031CE  [1C] → $00322A (past fn)
        dc.l    $0088322A                       ; $0031D2  [20] → $00322A (past fn)
        dc.l    $00883204                       ; $0031D6  [24] → $003204 (past fn)
        dc.l    $00883250                       ; $0031DA  [28] → $003250 (past fn)
; --- state 8 handler ---
        tst.w   ($FFFFC04E).w                   ; $0031DE  timer active?
        beq.s   load_object_pointer_clear_object_state ; $0031E2  timer off → exit to next fn
        movea.l ($FFFFC258).w,A1                ; $0031E4  A1 = object_ptr
        move.b  #$02,$0000(A1)                  ; $0031E8  set object type = 2
        move.b  #$03,$00FF6950                  ; $0031EE  VDP flag = 3
        move.b  #$01,$00FF6940                  ; $0031F6  VDP flag = 1
        addq.b  #4,($FFFFC305).w                ; $0031FE  advance state by 4
        rts                                     ; $003202

