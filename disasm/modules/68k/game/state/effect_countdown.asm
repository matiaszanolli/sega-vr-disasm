; ============================================================================
; Effect Countdown
; ROM Range: $00AC3E-$00ACBE (128 bytes)
; ============================================================================
; Manages an effect countdown timer at ($C8AE). When timer expires, clears
; 4 RAM entries. Then checks multiple conditions (game state, flags, entity
; slot availability, entity countdown) before triggering an effect.
;
; Entry: A0 = object/entity pointer
; Uses: D0, A1
; Fields accessed:
;   A0+$AC: Entity effect countdown (decremented)
;   A0+$AE: Entity slot index
; RAM:
;   ($C8AE).W: Effect duration timer
;   ($C026).W: Effect active flag (set to $FFFF on expiry)
;   ($C319).W: Game state (require & $3F == $0D)
;   ($C30E).W: Flag byte (require & $21 == 0, bit 1 set on trigger)
;   ($C05C).W: Slot table base pointer
;   ($C312).W: Busy flag (require == 0)
;   ($C8AA).W: Cleared on trigger
;   ($C08E).W: Value copied to ($C07A).W
;   ($C8A5).W: Set to $90 on trigger
; ============================================================================

effect_countdown:
        ; --- Timer management ---
        tst.w    ($FFFFC8AE).w          ; $4A78 $C8AE — check effect timer
        beq.s   .check_state            ; If zero, skip to state check
        subq.w  #1,($FFFFC8AE).w        ; $5378 $C8AE — decrement timer
        bne.s   .check_state            ; If not yet zero, skip clear
        ; Timer just reached zero: clear 4 entries and flag
        lea     $00FF66DC,a1            ; RAM entry base
        clr.w   (a1)                    ; Clear entry 0
        clr.w   $14(a1)                 ; Clear entry 1
        clr.w   $28(a1)                 ; Clear entry 2
        clr.w   $3C(a1)                 ; Clear entry 3
        move.w  #$FFFF,($FFFFC026).w    ; $31FC $FFFF $C026 — set expiry flag

        ; --- Check game state ---
.check_state:
        move.b  ($FFFFC319).w,d0        ; $1038 $C319 — load game state
        andi.b  #$3F,d0                 ; Mask to state number
        cmpi.b  #$0D,d0                 ; Race mode?
        bne.s   .return                 ; If not race mode, exit

        ; --- Check flags ---
        move.b  ($FFFFC30E).w,d0        ; $1038 $C30E — load flags
        andi.b  #$21,d0                 ; Check bits 0 and 5
        bne.s   .return                 ; If any set, exit

        ; --- Check entity slot availability ---
        lea     ($FFFFC05C).w,a1        ; $43F8 $C05C — slot table
        move.w  $AE(a0),d0              ; Load slot index
        add.w   d0,d0                   ; Word offset
        tst.w    (a1,d0.w)              ; $4A71 $0000 — check slot
        bne.s   .return                 ; If occupied, exit

        ; --- Check entity countdown ---
        tst.w   $AC(a0)                 ; Entity effect countdown
        ble.s   .return                 ; If <= 0, exit
        tst.b    ($FFFFC312).w          ; $4A38 $C312 — busy flag
        bne.s   .return                 ; If busy, exit

        ; --- All conditions passed: trigger effect ---
        clr.w    ($FFFFC8AA).w          ; $4278 $C8AA — clear trigger register
        subq.w  #1,$AC(a0)              ; Decrement entity countdown
        dc.w    $33BC,$0001,$0000,$0068  ; MOVE.W #$0001,$00000068 - write to system register
        andi.b  #$02,d0                 ; Mask slot parity bit
        move.w  ($FFFFC08E).w,($FFFFC07A).w; $31F8 $C08E $C07A — copy effect parameter
        move.b  #$90,($FFFFC8A5).w      ; $11FC $0090 $C8A5 — set effect type
        bset    #1,($FFFFC30E).w        ; $08F8 $0001 $C30E — set active flag
.return:
        rts
