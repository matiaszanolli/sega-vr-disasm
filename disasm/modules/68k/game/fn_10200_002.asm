; ============================================================================
; Name Entry Input Handler
; ROM Range: $01084C-$010974 (296 bytes)
; ============================================================================
; Category: game
; Purpose: Processes directional input for name entry cursor.
;   Handles D-pad left/right (bits 2/3) with auto-repeat,
;   and up/down (bits 0/1) for character set toggle.
;   Maps cursor position through character table at $890974.
;   Auto-repeat: initial delay ($39=57), then accelerates ($19=25 gap).
;
; Entry: D1 = controller input bits
; Uses: D0, D1, D2
; RAM:
;   $A02A: last input direction (byte)
;   $A02B: repeat counter (byte, 0→$0C max)
;   $A02C: input active flag (byte)
;   $A02D: blink timer (byte)
;   $A024: character index (word, result)
;   $A026: repeat delay counter (word)
;   $A028: direction flag (word, 0=down, 1=up)
;   $C8A4: sound effect (byte, set to $A9)
; ============================================================================

fn_10200_002:
        move.w  D1,D2                           ; $01084C  save input
        lsr.w   #8,D2                           ; $01084E  D2 = high byte (direction)
        cmp.b   ($FFFFA02A).w,D2                ; $010850  same direction as last frame?
        bne.w   .new_direction                  ; $010854  no → reset repeat
        addq.b  #1,($FFFFA02B).w                ; $010858  increment repeat counter
        cmpi.b  #$0F,($FFFFA02B).w              ; $01085C  reached max (15)?
        blt.w   .process_input                  ; $010862  no → process
        move.b  #$0C,($FFFFA02B).w              ; $010866  clamp at 12
        move.w  D2,D1                           ; $01086C  force repeat trigger
        bra.w   .process_input                  ; $01086E
.new_direction:
        clr.b   ($FFFFA02B).w                   ; $010872  reset repeat counter
.process_input:
        move.b  D2,($FFFFA02A).w                ; $010876  save current direction
        btst    #2,D1                           ; $01087A  test left button
        beq.s   .check_right                    ; $01087E  not pressed → check right
        move.b  #$01,($FFFFA02C).w              ; $010880  set input active
        move.b  #$00,($FFFFA02D).w              ; $010886  reset blink timer
        move.b  #$A9,($FFFFC8A4).w              ; $01088C  play cursor sound
        tst.w   ($FFFFA026).w                   ; $010892  delay counter active?
        beq.s   .left_start                     ; $010896  no → initialize
        subq.w  #1,($FFFFA026).w                ; $010898  decrement delay
        cmpi.w  #$0033,($FFFFA026).w            ; $01089C  reached threshold (51)?
        bne.w   .calc_index                     ; $0108A2  no → calculate
        move.w  #$0019,($FFFFA026).w            ; $0108A6  set fast repeat (25)
        bra.w   .calc_index                     ; $0108AC
.left_start:
        move.w  #$0039,($FFFFA026).w            ; $0108B0  set initial delay (57)
        bra.w   .calc_index                     ; $0108B6
.check_right:
        btst    #3,D1                           ; $0108BA  test right button
        beq.s   .check_down                     ; $0108BE  not pressed → check down
        move.b  #$01,($FFFFA02C).w              ; $0108C0  set input active
        move.b  #$00,($FFFFA02D).w              ; $0108C6  reset blink timer
        move.b  #$A9,($FFFFC8A4).w              ; $0108CC  play cursor sound
        cmpi.w  #$0039,($FFFFA026).w            ; $0108D2  at max delay?
        bge.s   .right_wrap                     ; $0108D8  yes → wrap around
        addq.w  #1,($FFFFA026).w                ; $0108DA  increment delay
        cmpi.w  #$001A,($FFFFA026).w            ; $0108DE  reached threshold (26)?
        bne.w   .calc_index                     ; $0108E4  no → calculate
        move.w  #$0034,($FFFFA026).w            ; $0108E8  jump to fast region (52)
        bra.w   .calc_index                     ; $0108EE
.right_wrap:
        clr.w   ($FFFFA026).w                   ; $0108F2  wrap to start
        bra.w   .calc_index                     ; $0108F6
.check_down:
        btst    #0,D1                           ; $0108FA  test down button
        beq.s   .check_up                       ; $0108FE  not pressed → check up
        tst.w   ($FFFFA028).w                   ; $010900  already in down mode?
        beq.w   .calc_index                     ; $010904  yes → skip
        move.b  #$01,($FFFFA02C).w              ; $010908  set input active
        move.b  #$00,($FFFFA02D).w              ; $01090E  reset blink timer
        clr.w   ($FFFFA028).w                   ; $010914  direction = down
        move.b  #$A9,($FFFFC8A4).w              ; $010918  play cursor sound
        bra.w   .calc_index                     ; $01091E
.check_up:
        btst    #1,D1                           ; $010922  test up button
        beq.s   .calc_index                     ; $010926  not pressed → calculate
        tst.w   ($FFFFA028).w                   ; $010928  already in up mode?
        bne.w   .calc_index                     ; $01092C  yes → skip
        move.b  #$01,($FFFFA02C).w              ; $010930  set input active
        move.b  #$00,($FFFFA02D).w              ; $010936  reset blink timer
        move.w  #$0001,($FFFFA028).w            ; $01093C  direction = up
        move.b  #$A9,($FFFFC8A4).w              ; $010942  play cursor sound
.calc_index:
        move.w  ($FFFFA026).w,D0                ; $010948  D0 = delay counter
        cmpi.w  #$0019,D0                       ; $01094C  in upper range (>25)?
        bgt.w   .lookup                         ; $010950  yes → use directly
        tst.w   ($FFFFA028).w                   ; $010954  direction flag
        beq.w   .lookup                         ; $010958  down → use directly
        addi.w  #$001A,D0                       ; $01095C  up → offset by 26
.lookup:
        lea     $00890974,A0                    ; $010960  A0 = character table
        move.b  $00(A0,D0.W),D0                 ; $010966  D0 = char at index
        andi.w  #$00FF,D0                       ; $01096A  mask to byte
        move.w  D0,($FFFFA024).w                ; $01096E  store character index
        rts                                     ; $010972
