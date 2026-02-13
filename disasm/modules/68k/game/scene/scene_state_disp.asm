; ============================================================================
; Scene State Dispatcher (Data Prefix + 4-Entry Jump Table)
; ROM Range: $00C44C-$00C4A4 (88 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 9-word parameter table (7 offsets + 2 × $1000).
;   Calls sfx_queue_process, then dispatches via 4-entry longword jump
;   table indexed by sub_state ($C8C4). State 0 handler: calls
;   VDPSyncSH2, init_handler ($0025B0), sprite_setup ($006D9C),
;   increments scene counter ($C886), advances sub_state by 4,
;   writes $10 to SH2 COMM.
;
; Uses: D0, D2, A1, A2, A4, A6
; RAM:
;   $C886: scene counter (byte, +1)
;   $C8C4: sub_state (byte, dispatch index)
; Calls:
;   $0021CA: sfx_queue_process
;   $0025B0: init_handler
;   $0028C2: VDPSyncSH2
;   $006D9C: sprite_setup
; ============================================================================

scene_state_disp:
; --- data prefix: 9-word parameter table ---
        dc.w    $0089                           ; $00C44C  offset[0] = $0089
        dc.w    $0117                           ; $00C44E  offset[1] = $0117
        dc.w    $016A                           ; $00C450  offset[2] = $016A
        dc.w    $01E0                           ; $00C452  offset[3] = $01E0
        dc.w    $025E                           ; $00C454  offset[4] = $025E
        dc.w    $02E2                           ; $00C456  offset[5] = $02E2
        dc.w    $034D                           ; $00C458  offset[6] = $034D
        dc.w    $1000                           ; $00C45A  scale = $1000
        dc.w    $1000                           ; $00C45C  scale = $1000
; --- code ---
        jsr     $008821CA                       ; $00C45E  sfx_queue_process
        moveq   #$00,D0                         ; $00C464  clear high bits
        move.b  ($FFFFC8C4).w,D0               ; $00C466  D0 = sub_state
        movea.l $00C470(PC,D0.W),A1            ; $00C46A  A1 = handler address
        jmp     (A1)                            ; $00C46E  dispatch
; --- jump table (4 longword entries) ---
        dc.l    $0088C480                       ; $00C470  [0] → state 0 handler
        dc.l    $0088C4A4                       ; $00C474  [4] → $00C4A4 (past fn)
        dc.l    $0088C4C2                       ; $00C478  [8] → $00C4C2 (past fn)
        dc.l    $0088C53C                       ; $00C47C  [C] → $00C53C (past fn)
; --- state 0 handler ---
        jsr     $008828C2                       ; $00C480  VDPSyncSH2
        jsr     $008825B0                       ; $00C486  init_handler
        jsr     $00886D9C                       ; $00C48C  sprite_setup
        addq.b  #1,($FFFFC886).w               ; $00C492  scene counter++
        addq.b  #4,($FFFFC8C4).w               ; $00C496  advance sub_state
        move.w  #$0010,$00FF0008               ; $00C49A  SH2 COMM = $10
        rts                                     ; $00C4A2
