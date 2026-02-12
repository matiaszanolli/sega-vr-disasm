; ============================================================================
; Object Speed Ramp-Up + State Advance
; ROM Range: $00413A-$004168 (46 bytes)
; ============================================================================
; Category: game
; Purpose: Ramps up object speed at $FF6754: increments $C25C by 8 each
;   frame, copies to obj.speed ($06), advances obj.speed_index ($04) by 2,
;   adds $01C0 to obj.field8 ($08). When $C25C reaches $0100 (256):
;   advances $C07C (input_state) by 4 and clears $C8AA (scene_state).
;
; Uses: D0, A2
; RAM:
;   $C25C: speed accumulator (word, +8 per frame)
;   $C07C: input_state (word, advanced by 4)
;   $C8AA: scene_state (word, cleared on completion)
; Object ($FF6754):
;   +$04: speed_index (word, +2 per frame)
;   +$06: speed (word, set from $C25C)
;   +$08: field8 (word, +$01C0 per frame)
; ============================================================================

fn_2200_080:
        lea     $00FF6754,A2                    ; $00413A  A2 → fixed object
        addq.w  #8,($FFFFC25C).w               ; $004140  speed += 8
        move.w  ($FFFFC25C).w,D0               ; $004144  D0 = speed
        move.w  D0,$0006(A2)                    ; $004148  obj.speed = D0
        addq.w  #2,$0004(A2)                    ; $00414C  obj.speed_index += 2
        addi.w  #$01C0,$0008(A2)                ; $004150  obj.field8 += $01C0
        cmpi.w  #$0100,D0                       ; $004156  speed == $0100?
        bne.s   .done                           ; $00415A  no → done
        addq.w  #4,($FFFFC07C).w               ; $00415C  advance input_state
        move.w  #$0000,($FFFFC8AA).w           ; $004160  clear scene_state
.done:
        rts                                     ; $004166
