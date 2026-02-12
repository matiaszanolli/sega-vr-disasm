; ============================================================================
; Game Frame Orchestrator 013
; ROM Range: $004D1A-$004D98 (126 bytes)
; ============================================================================
; Category: object
; Purpose: Main game frame update — calls rendering + logic subroutines
;   Path A: full update (10 calls + input record + sprite/object update)
;   Path B: minimal update (4 calls + increment)
;   Records controller input to replay buffer
;
; Uses: D0, D1, A0
; RAM:
;   $C8AA: frame_counter
;   $C8C0: controller_ptr
;   $C971: input_mask
;   $C973: input_buttons
;   $C87E: game_state
;   $C886: vint_counter
; Calls:
;   $00212E: fn_200_010 (pre-frame)
;   $00179E: poll_controllers
;   $00B09E: animation_update
;   $00B144: fn_a200_014
;   $00B504: fn_a200_040
;   $00B4DC: fn_a200_039
;   $00B522: fn_a200_041
;   $00593C: sprite_state_process
;   $00B6DA: sprite_update
;   $00B684: object_update
;   $0056F8: fn_4200_031 (tail call via JMP)
; Confidence: high
; ============================================================================

fn_4200_013:
; --- path A: full frame update ---
        dc.w    $4EBA,$D412         ; JSR     $00212E(PC); $004D1A  pre-frame
        dc.w    $4EBA,$CA7E         ; JSR     $00179E(PC); $004D1E  poll_controllers
        dc.w    $4EBA,$637A         ; JSR     $00B09E(PC); $004D22  animation_update
        dc.w    $4EBA,$641C         ; JSR     $00B144(PC); $004D26  fn_a200_014
        dc.w    $4EBA,$67D8         ; JSR     $00B504(PC); $004D2A  fn_a200_040
        dc.w    $4EBA,$67AC         ; JSR     $00B4DC(PC); $004D2E  fn_a200_039
        dc.w    $4EBA,$67EE         ; JSR     $00B522(PC); $004D32  fn_a200_041
        addq.w  #1,($FFFFC8AA).w                ; $004D36  frame_counter++
; --- record controller input to replay buffer ---
        movea.w ($FFFFC8C0).w,A0                ; $004D3A  A0 = controller_ptr
        cmpa.w  #$EF00,A0                       ; $004D3E  buffer full?
        beq.w   .skip_record                    ; $004D42  yes → skip
        move.b  ($FFFFC971).w,D0                ; $004D46  D0 = input_mask
        andi.b  #$5C,D0                         ; $004D4A  isolate d-pad + buttons
        move.b  ($FFFFC973).w,D1                ; $004D4E  D1 = input_buttons
        andi.b  #$03,D1                         ; $004D52  isolate A/B buttons
        dc.w    $8001                           ; $004D56  OR.B D1,D0 — merge buttons
        move.b  D0,(A0)+                        ; $004D58  store to buffer, advance
        move.w  A0,($FFFFC8C0).w                ; $004D5A  update controller_ptr
.skip_record:
        dc.w    $4EBA,$0BDC         ; JSR     $00593C(PC); $004D5E  sprite_state_process
        dc.w    $4EBA,$6976         ; JSR     $00B6DA(PC); $004D62  sprite_update
        dc.w    $4EBA,$691C         ; JSR     $00B684(PC); $004D66  object_update
        addq.w  #4,($FFFFC87E).w                ; $004D6A  game_state += 4
        move.w  #$0054,$00FF0008                ; $004D6E  display list cmd = $54
        dc.w    $4EFA,$0980         ; JMP     $0056F8(PC); $004D76  → fn_4200_031
; --- path B: minimal update ---
        dc.w    $4EBA,$D3B2         ; JSR     $00212E(PC); $004D7A  pre-frame
        dc.w    $4EBA,$CA1E         ; JSR     $00179E(PC); $004D7E  poll_controllers
        dc.w    $4EBA,$631A         ; JSR     $00B09E(PC); $004D82  animation_update
        dc.w    $4EBA,$63BC         ; JSR     $00B144(PC); $004D86  fn_a200_014
        addq.b  #1,($FFFFC886).w                ; $004D8A  vint_counter++
        move.w  #$0054,$00FF0008                ; $004D8E  display list cmd = $54
        rts                                     ; $004D96
