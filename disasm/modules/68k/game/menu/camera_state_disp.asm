; ============================================================================
; Camera State Dispatcher (Data Prefix + Jump Table)
; ROM Range: $013292-$013346 (180 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix (128 bytes of object/sprite descriptors) +
;   state dispatcher. Calls initialization ($00882080), then reads
;   game_state ($C87E) to index a 3-entry PC-relative jump table:
;     State 0 → $00893346 (camera_render_dma_overlay: camera render DMA)
;     State 4 → $008934F0 (camera_menu_orch: camera menu orchestrator)
;     State 8 → $00893824 (camera finalize)
;   After dispatch returns: calls object_update, checks display bit 6,
;   advances game_state if clear, then SH2 scene transition.
;
; Uses: D0, D4, A0, A1
; RAM:
;   $C87E: game_state (word)
;   $C80E: display control (byte, bit 6 checked)
; Calls:
;   $00B684: object_update
;   $00882080: initialization
;   $0088205E: SH2 scene transition
; ============================================================================

camera_state_disp:
; --- data prefix (128 bytes, object/sprite descriptors) ---
        dc.w    $7FFF                           ; $013292  max value sentinel
        dc.w    $7FFF                           ; $013294
        dc.w    $7FFF                           ; $013296
        dc.w    $7FFF                           ; $013298
        dc.w    $7FFF                           ; $01329A
        dc.w    $7FFF                           ; $01329C
        dc.w    $7FFF                           ; $01329E
        dc.w    $7FFF                           ; $0132A0
        dc.w    $7FFF                           ; $0132A2
        dc.w    $7FFF                           ; $0132A4
        dc.w    $7FFF                           ; $0132A6
        dc.w    $7FFF                           ; $0132A8
; --- 5 identical descriptor entries (12 bytes each) ---
        dc.w    $4DC8                           ; $0132AA  entry[0]
        dc.w    $520B                           ; $0132AC
        addq.w  #5,$62D1(A6)                    ; $0132AE  (data: $5A6E $62D1)
        dc.w    $4DC8                           ; $0132B2  entry[1]
        dc.w    $520B                           ; $0132B4
        addq.w  #5,$62D1(A6)                    ; $0132B6  (data: $5A6E $62D1)
        dc.w    $4DC8                           ; $0132BA  entry[2]
        dc.w    $520B                           ; $0132BC
        addq.w  #5,$62D1(A6)                    ; $0132BE  (data: $5A6E $62D1)
        dc.w    $4DC8                           ; $0132C2  entry[3]
        dc.w    $520B                           ; $0132C4
        addq.w  #5,$62D1(A6)                    ; $0132C6  (data: $5A6E $62D1)
        dc.w    $4DC8                           ; $0132CA  entry[4]
        dc.w    $520B                           ; $0132CC
        addq.w  #5,$62D1(A6)                    ; $0132CE  (data: $5A6E $62D1)
; --- 2 descriptor entries with different pattern ---
        move.w  A2,($35EB).W                    ; $0132D2  (data: $31CA $35EB)
        move.w  $466F(A5),D7                    ; $0132D6  (data: $3E2D $466F)
; --- 8 max-value sentinels ---
        dc.w    $7FFF                           ; $0132DA
        dc.w    $7FFF                           ; $0132DC
        dc.w    $7FFF                           ; $0132DE
        dc.w    $7FFF                           ; $0132E0
        dc.w    $7FFF                           ; $0132E2
        dc.w    $7FFF                           ; $0132E4
        dc.w    $7FFF                           ; $0132E6
        dc.w    $7FFF                           ; $0132E8
; --- more descriptor data ---
        move.w  A2,($35EB).W                    ; $0132EA  (data: $31CA $35EB)
        move.w  $466F(A5),D7                    ; $0132EE  (data: $3E2D $466F)
        move.b  D1,(A2)+                        ; $0132F2  (data: $14C1)
        move.b  -(A2),-(A6)                     ; $0132F4  (data: $1D22)
        dc.w    $2984                           ; $0132F6
        dc.w    $35E6                           ; $0132F8
.loc_0068:
        neg.w   D5                              ; $0132FA  (data: $4445)
        subq.b  #8,$6212(A3)                    ; $0132FC  (data: $512B $6212)
        bgt.s   .loc_0068                       ; $013300  (data: $6EF8)
        dc.w    $7FFF                           ; $013302
        btst    D1,(A7)+                        ; $013304  (data: $031F)
        dc.w    $7FFF                           ; $013306
        dc.w    $7FFF                           ; $013308
        move.b  D1,(A2)+                        ; $01330A  (data: $14C1)
        move.b  -(A2),-(A6)                     ; $01330C  (data: $1D22)
        dc.w    $2984                           ; $01330E
        dc.w    $35E6                           ; $013310
; --- executable code ---
        jsr     $00882080                       ; $013312  initialization
        move.w  ($FFFFC87E).w,D0                ; $013318  D0 = game_state
        movea.l $013322(PC,D0.W),A1             ; $01331C  A1 = jump_table[state]
        jmp     (A1)                            ; $013320  dispatch
; --- jump table (3 longword entries) ---
        dc.w    $0089                           ; $013322  target[0] high
        move.w  D6,$0089(A1)                    ; $013324  target[0] low (raw: $3346 → $00893346)
        move.w  -$77(A0,D0.W),(A2)+             ; $013328  target[1] (raw: $34F0 → $008934F0)
        move.w  -(A4),D4                        ; $01332C  target[2] (raw: $3824 → [$00893824])
; --- post-dispatch code (reached by jump targets) ---
        dc.w    $4EBA,$8354                     ; $01332E  bsr.w object_update ($00B684)
        btst    #6,($FFFFC80E).w                ; $013332  display bit 6 set?
        bne.s   .done                           ; $013338  yes → done (no advance)
        addq.w  #4,($FFFFC87E).w                ; $01333A  advance game_state
.done:
        jsr     $0088205E                       ; $01333E  SH2 scene transition
        rts                                     ; $013344
