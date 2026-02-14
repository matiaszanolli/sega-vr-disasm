; ============================================================================
; Object Collision Detection
; ROM Range: $00AF18-$00AFC2 (170 bytes)
; ============================================================================
; Category: object
; Purpose: Checks collision between two objects (A0 = player, A1 = $9F00).
;   Sums velocities + lateral offsets; if nonzero, skips (already processed).
;   Compares distance at +$32; if too far (>$200), skips.
;   Calls proximity check ($00AE0A); on hit, triggers sound $B8, computes
;   post-collision speeds with 3/4+1/4 weighted average, clamps to $04DC,
;   and swaps if needed so faster object gets higher speed.
;   Sets collision flag $0800 in +$02 if position gap exceeds threshold.
;
; Entry: A0 = player object, A1 = opponent (loaded from $9F00)
; Uses: D0, D1, D2, D3, A0, A1
; RAM:
;   $9F00: obj_table_3 (opponent base)
;   $C8A4: sound_trigger (byte)
;   $C8CE: collision_speed_threshold (word)
;   $C8D0: collision_position_threshold (word)
; Calls:
;   $00AE0A: proximity_check (returns Z=1 if no collision)
;   $00AFFE: collision_speed_apply (external, via BLE.W)
; Object fields:
;   +$02: flags (bit 11 = collision)
;   +$04: velocity
;   +$06: speed
;   +$32: lateral_offset
;   +$6A: accel_x
;   +$88: collision_result
;   +$8C: velocity_x
; ============================================================================

object_collision_detection:
        lea     ($FFFF9F00).w,A1                    ; $00AF18  A1 = opponent object
        clr.w   $0088(A0)                       ; $00AF1C  clear collision_result (player)
        clr.w   $0088(A1)                       ; $00AF20  clear collision_result (opponent)
; --- sum velocities + lateral motion ---
        move.w  $006A(A0),D0                    ; $00AF24  accel_x (player)
        add.w   $006A(A1),D0                    ; $00AF28  + accel_x (opponent)
        add.w   $008C(A0),D0                    ; $00AF2C  + velocity_x (player)
        add.w   $008C(A1),D0                    ; $00AF30  + velocity_x (opponent)
        bne.w   .no_collision                   ; $00AF34  nonzero → already active
; --- distance check ---
        move.w  $0032(A1),D0                    ; $00AF38  lateral_offset (opponent)
        sub.w   $0032(A0),D0                    ; $00AF3C  distance = opp - player
        bpl.s   .dist_positive                  ; $00AF40
        neg.w   D0                              ; $00AF42  absolute value
.dist_positive:
        cmpi.w  #$0200,D0                       ; $00AF44  too far?
        bge.s   .no_collision                   ; $00AF48
; --- proximity check subroutine ---
        jsr     zone_check_inner(pc)    ; $4EBA $FEBE
        beq.w   .no_collision                   ; $00AF4E  Z=1 → no collision
; --- collision detected: trigger sound ---
        move.b  #$B8,($FFFFC8A4).w                  ; $00AF52  sound_trigger = $B8
; --- speed comparison ---
        move.w  $0004(A0),D0                    ; $00AF58  velocity (player)
        sub.w   $0004(A1),D0                    ; $00AF5C  speed difference
        bpl.s   .diff_positive                  ; $00AF60
        neg.w   D0                              ; $00AF62  absolute value
.diff_positive:
        cmp.w   ($FFFFC8CE).w,D0                    ; $00AF64  below speed threshold?
        dc.w    $6F00,$0094         ; ble.w   $00AFFE             ; $00AF68  yes → collision_speed_apply
; --- compute post-collision speeds (weighted average) ---
        move.w  $0006(A0),D0                    ; $00AF6C  speed (player)
        add.w   $0006(A1),D0                    ; $00AF70  + speed (opponent)
        move.w  D0,D2                           ; $00AF74  D2 = sum
        asr.w   #1,D2                           ; $00AF76  D2 = sum/2 (slower obj gets this)
        asr.w   #2,D0                           ; $00AF78  D0 = sum/4
        add.w   D0,D2                           ; $00AF7A  D2 = sum/2 + sum/4 = 3/4 sum
        move.w  D0,D1                           ; $00AF7C  D1 = sum/4
        asr.w   #1,D1                           ; $00AF7E  D1 = sum/8
        add.w   D0,D1                           ; $00AF80  D1 = sum/4 + sum/8 = 3/8 sum
; --- clamp speeds to $04DC ---
        cmpi.w  #$04DC,D1                       ; $00AF82
        ble.s   .d1_ok                          ; $00AF86
        move.w  #$04DC,D1                       ; $00AF88
.d1_ok:
        cmpi.w  #$04DC,D2                       ; $00AF8C
        ble.s   .d2_ok                          ; $00AF90
        move.w  #$04DC,D2                       ; $00AF92
.d2_ok:
; --- assign: faster object gets higher speed ---
        move.w  $0006(A1),D0                    ; $00AF96  opponent speed
        cmp.w   $0006(A0),D0                    ; $00AF9A  compare to player
        ble.s   .assign                         ; $00AF9E  player >= opponent → D1=player, D2=opponent
        exg     d1,d2                   ; $C342
.assign:
        move.w  D2,$0006(A1)                    ; $00AFA2  opponent gets D2
; --- set collision flags if position gap large ---
        move.w  $0004(A0),D3                    ; $00AFA6  velocity (player)
        sub.w   $0004(A1),D3                    ; $00AFAA  gap = player - opponent
        cmp.w   ($FFFFC8D0).w,D3                    ; $00AFAE  exceeds threshold?
        dc.w    $6F0E               ; ble.s   $00AFC2             ; $00AFB2  no → return
        ori.w   #$0800,$0002(A0)                ; $00AFB4  set collision flag (player)
        ori.w   #$0800,$0002(A1)                ; $00AFBA  set collision flag (opponent)
.no_collision:
        rts                                     ; $00AFC0
