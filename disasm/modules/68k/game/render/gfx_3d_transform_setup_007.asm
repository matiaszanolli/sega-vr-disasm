; ============================================================================
; 3D Transform Setup 007
; ROM Range: $0082FA-$008368 (110 bytes)
; ============================================================================
; Category: game
; Purpose: Sets up 3D transformation parameters for rendering
;   Calls matrix/vector routines, computes composite index from state words
;   Checks depth threshold ($60000000) for visibility
;
; Entry: A3 (clobbered), A4 = output pointer
; Uses: D0, D1, D2, D5, D6, A1, A2, A3
; RAM:
;   $C806: transform_src
;   $C270: vector_buf_a
;   $C274: vector_buf_b
;   $FDAA: matrix_base
;   $C89C: race_substate
;   $C8A0: race_state
;   $C8C8: vint_state
;   $C8CC: race_substate_b
; Calls:
;   $00B3CE: matrix_multiply
;   $00B386: vector_transform
; Confidence: medium
; ============================================================================

gfx_3d_transform_setup_007:
; --- path A: transform using vector_buf_a ---
        lea     ($FFFFC806).w,A1                ; $0082FA  A1 → transform_src
        lea     ($FFFFC270).w,A2                ; $0082FE  A2 → vector_buf_a
        dc.w    $4EBA,$30CA         ; JSR     $00B3CE(PC); $008302  matrix_multiply
        moveq   #$00,D0                         ; $008306  D0 = 0 (transform mode A)
        lea     ($FFFFC270).w,A1                ; $008308  A1 → vector_buf_a
        dc.w    $4EBA,$3078         ; JSR     $00B386(PC); $00830C  vector_transform
        move.l  ($FFFFC270).w,D5                ; $008310  D5 = transform result A
        moveq   #$04,D6                         ; $008314  D6 = 4 (offset A)
        bra.s   .compute_index                  ; $008316
; --- path B: transform using vector_buf_b ---
        lea     ($FFFFC806).w,A1                ; $008318  A1 → transform_src
        lea     ($FFFFC274).w,A2                ; $00831C  A2 → vector_buf_b
        dc.w    $4EBA,$30AC         ; JSR     $00B3CE(PC); $008320  matrix_multiply
        moveq   #$02,D0                         ; $008324  D0 = 2 (transform mode B)
        lea     ($FFFFC274).w,A1                ; $008326  A1 → vector_buf_b
        dc.w    $4EBA,$305A         ; JSR     $00B386(PC); $00832A  vector_transform
        move.l  ($FFFFC274).w,D5                ; $00832E  D5 = transform result B
        moveq   #$08,D6                         ; $008332  D6 = 8 (offset B)
.compute_index:
        lea     ($FFFFFDAA).w,A3                ; $008334  A3 → matrix_base
        move.w  ($FFFFC89C).w,D1                ; $008338  D1 = race_substate
        lsl.w   #5,D1                           ; $00833C  D1 *= 32
        add.w   ($FFFFC8A0).w,D1                ; $00833E  D1 += race_state
        move.w  ($FFFFC8C8).w,D2                ; $008342  D2 = vint_state
        lsl.w   #3,D2                           ; $008346  D2 *= 8
        add.w   ($FFFFC8CC).w,D2                ; $008348  D2 += race_substate_b
        dc.w    $D242                           ; $00834C  ADD.W D2,D1
        dc.w    $D246                           ; $00834E  ADD.W D6,D1
        lea     $00(A3,D1.W),A3                 ; $008350  A3 += composite index
        cmpi.l  #$60000000,D5                   ; $008354  depth < $60000000?
        dc.w    $6D0C               ; BLT.S   $008368    ; $00835A  yes → skip (next fn)
        move.l  #$DDDD0DDD,(A4)                 ; $00835C  write sentinel to output
        moveq   #$01,D0                         ; $008362  D0 = 1 (visible)
        moveq   #$00,D1                         ; $008364  D1 = 0
        rts                                     ; $008366
