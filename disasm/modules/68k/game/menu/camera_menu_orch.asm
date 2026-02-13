; ============================================================================
; Camera Menu Orchestrator (Data Prefix)
; ROM Range: $0134C8-$0135C4 (252 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix (40 bytes) + camera menu orchestrator.
;   DMA transfer + object_update + sprite_update, then reads P1 ($C86C)
;   and P2 ($C86E) controllers via camera_menu_input_handler (camera input handler).
;   If selection state ($A022) == 1: enable display flags + SH2 transition,
;     set action_state ($A028) = 2.
;   If selection state > 1: dispatch via handler table at $8936AA with
;     mode index from $A019 and D2=1 flag.
;   Action state machine: state 1 checks bit 6, state 2 checks bit 7
;   of $C80E to detect SH2 completion.
;   Clears $A022, display mode $0018.
;
; Uses: D0, D1, D2, A0
; RAM:
;   $A019: camera mode index (byte)
;   $A022: selection state (word)
;   $A028: action state (word, 0/1/2)
;   $C80E: display control (byte, bits 6/7)
;   $C809: display enable A (byte)
;   $C80A: display enable B (byte)
;   $C802: display enable C (byte)
;   $C86C: controller P1 data (word)
;   $C86E: controller P2 data (word)
;   $C87E: game_state (word)
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E52C: dma_transfer
;   $0135C4: camera_menu_input_handler (camera input handler)
;   $0088179E: controller_poll
;   $0088205E: SH2 scene transition
;   $0088FB36: SH2 completion check
; ============================================================================

camera_menu_orch:
; --- data prefix (40 bytes) ---
        dc.w    $0400                           ; $0134C8
        sub.b   ($0400).W,D0                    ; $0134CA  (data: $9038 $0400)
        and.b   ($0400).W,D0                    ; $0134CE  (data: $C038 $0400)
        dc.w    $F038                           ; $0134D2
        dc.w    $0401                           ; $0134D4
        move.l  ($0401).W,D0                    ; $0134D6  (data: $2038 $0401)
        addq.b  #8,($0401).W                    ; $0134DA  (data: $5038 $0401)
        cmp.b   ($FFFF9C00).w,D0                ; $0134DE  (data: $B038 $9C00)
        dc.w    $A8A3                           ; $0134E2
        dc.w    $B546                           ; $0134E4
        muls    -$3238(A1),D0                   ; $0134E6  (data: $C1E9 $CDC8)
        dc.w    $D20B                           ; $0134EA
        add.w   -$1D2F(A6),D5                   ; $0134EC  (data: $DA6E $E2D1)
; --- executable code ---
        clr.w   D0                              ; $0134F0  mode = 0
        dc.w    $4EBA,$B038                     ; $0134F2  bsr.w dma_transfer ($00E52C)
        dc.w    $4EBA,$818C                     ; $0134F6  bsr.w object_update ($00B684)
        dc.w    $4EBA,$81DE                     ; $0134FA  bsr.w sprite_update ($00B6DA)
        cmpi.w  #$0001,($FFFFA028).w            ; $0134FE  action_state == 1?
        beq.w   .sh2_check_bit6                 ; $013504  yes → check SH2
        cmpi.w  #$0002,($FFFFA028).w            ; $013508  action_state == 2?
        beq.w   .sh2_check_bit7                 ; $01350E  yes → check SH2
        jsr     $0088179E                       ; $013512  poll controllers
        move.w  ($FFFFC86C).w,D1                ; $013518  D1 = P1 controller
        dc.w    $6100,$00A6                     ; $01351C  bsr.w camera_menu_input_handler ($0135C4)
        move.w  ($FFFFC86E).w,D1                ; $013520  D1 = P2 controller
        dc.w    $6100,$009E                     ; $013524  bsr.w camera_menu_input_handler ($0135C4)
        tst.w   ($FFFFA022).w                   ; $013528  selection state active?
        beq.w   .revert_state                   ; $01352C  no → revert
        cmpi.w  #$0001,($FFFFA022).w            ; $013530  state == 1 (confirm)?
        bne.w   .dispatch_handler               ; $013536  no → dispatch
        move.b  #$01,($FFFFC809).w              ; $01353A  enable display A
        move.b  #$01,($FFFFC80A).w              ; $013540  enable display B
        bset    #7,($FFFFC80E).w                ; $013546  set display control
        move.b  #$01,($FFFFC802).w              ; $01354C  enable display C
        jsr     $0088205E                       ; $013552  SH2 scene transition
        move.w  #$0002,($FFFFA028).w            ; $013558  action_state = 2
        bra.w   .set_display                    ; $01355E
.dispatch_handler:
        clr.w   D0                              ; $013562  D0 = 0
        lea     $008936AA,A0                    ; $013564  A0 = handler table
        clr.w   D2                              ; $01356A
        move.b  ($FFFFA019).w,D2                ; $01356C  D2 = mode index
        dc.w    $D442                           ; $013570  add.w d2,d2 — D2 × 2
        dc.w    $D442                           ; $013572  add.w d2,d2 — D2 × 4
        movea.l $00(A0,D2.W),A0                 ; $013574  A0 = handler[mode]
        move.w  #$0001,D2                       ; $013578  D2 = 1 (select flag)
        jsr     (A0)                            ; $01357C  call handler
        bra.w   .set_display                    ; $01357E
.sh2_check_bit6:
        jsr     $0088FB36                       ; $013582  SH2 completion check
        btst    #6,($FFFFC80E).w                ; $013588  display bit 6 set?
        bne.s   .revert_state                   ; $01358E  yes → revert
        clr.w   ($FFFFA028).w                   ; $013590  clear action_state
        bra.w   .revert_state                   ; $013594
.sh2_check_bit7:
        jsr     $0088FB36                       ; $013598  SH2 completion check
        btst    #7,($FFFFC80E).w                ; $01359E  display bit 7 set?
        bne.s   .revert_state                   ; $0135A4  yes → revert
        clr.w   ($FFFFA028).w                   ; $0135A6  clear action_state
        addq.w  #4,($FFFFC87E).w                ; $0135AA  advance game_state
        bra.w   .set_display                    ; $0135AE
.revert_state:
        subq.w  #4,($FFFFC87E).w                ; $0135B2  revert game_state
.set_display:
        clr.w   ($FFFFA022).w                   ; $0135B6  clear selection state
        move.w  #$0018,$00FF0008                ; $0135BA  display mode = $0018
        rts                                     ; $0135C2
